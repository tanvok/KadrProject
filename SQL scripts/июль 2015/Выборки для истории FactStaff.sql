--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT Salary.idPlanStaff, FactStaffHistory.*
--FROM
--(SELECT [idFactStaff]
      
--  FROM [Kadr].[dbo].[FactStaffHistory]

--  GROUP BY [idFactStaff]
--  HAVING COUNT(id)>1) FactStaffHistory
--  INNER JOIN dbo.FactStaff ON FactStaff.id=FactStaffHistory.idFactStaff
--  INNER JOIN
--  (SELECT idPlanStaff 
--  FROM
--  [dbo].[GetAllSalaryByPeriod]('1.1.2014', '1.1.2015')
--  GROUP BY idPlanStaff
--  HAVING COUNT(SalarySize)>1
--  ) Salary
--  ON  FactStaff.idPlanStaff=Salary.idPlanStaff
--  ORDER BY Salary.idPlanStaff, FactStaffHistory.idFactStaff
 
  
  
--  SELECT *
      
--  FROM [Kadr].[dbo].[FactStaffHistory]
-- WHERE [idFactStaff]=16532

   
--  SELECT *
      
--  FROM [dbo].[FactStaff]
-- WHERE [id]=16532


DECLARE @idEmployee INT=826772,
@PeriodBegin	DATE='1.7.2015',
@PeriodEnd	DATE='18.7.2015'


 	SELECT DISTINCT PeriodStaff.idDepartment, idFinancingSource, [FactStaffWithHistory].idTypeWork, idPost, 
		PeriodStaff.idPlanStaff, FactStaff.id, [FactStaff].idEmployee, [FactStaffWithHistory].StaffCount, 
		IIF([FactStaffWithHistory].IsReplacement=1, 0, [FactStaffWithHistory].StaffCount) StaffCountWithoutReplacement, 
		idReplacementReason, ISNULL(SalaryKoeff.SalaryKoeffc,1)SalaryKoeff, SalarySize*ISNULL(SalaryKoeff.SalaryKoeffc,1) SalarySize, SalaryKoeff.PKSubSubCategoryNumber,
		[FactStaffWithHistory].CalcStaffCount, 
		IIF([FactStaffWithHistory].IsReplacement=1, 0, [FactStaffWithHistory].CalcStaffCount) CalcStaffCountWithoutReplacement, 
		FactStaff.DateBegin, FactStaff.DateEnd, [FactStaffWithHistory].HourCount,
		[FactStaffWithHistory].DateBegin, [FactStaffWithHistory].[DateEnd],
		PlanStaffsWithSalaries.DateBegin SalBeg, PlanStaffsWithSalaries.DateEnd SalEnd
	FROM dbo.GetPlanStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff
		INNER JOIN [dbo].[FactStaffWithHistory] ON PeriodStaff.idPlanStaff=[FactStaffWithHistory].idPlanStaff
		INNER JOIN dbo.[FactStaffMain] FactStaff ON [FactStaffWithHistory].id=FactStaff.id
		INNER JOIN [dbo].[GetAllSalaryByPeriod](@PeriodBegin,@PeriodEnd) PlanStaffsWithSalaries
			ON  PeriodStaff.idPlanStaff=PlanStaffsWithSalaries.idPlanStaff
				AND ((PlanStaffsWithSalaries.DateBegin<=[FactStaffWithHistory].DateBegin AND (PlanStaffsWithSalaries.DateEnd>=[FactStaffWithHistory].DateBegin OR PlanStaffsWithSalaries.DateEnd IS NULL))
						OR (PlanStaffsWithSalaries.DateBegin>=[FactStaffWithHistory].DateBegin AND (PlanStaffsWithSalaries.DateBegin<=[FactStaffWithHistory].DateEnd OR [FactStaffWithHistory].DateEnd IS NULL)))
		LEFT JOIN [dbo].[SalaryKoeff] ON [FactStaffWithHistory].idSalaryKoeff=[SalaryKoeff].id	
		LEFT JOIN dbo.FactStaffReplacement
				ON [FactStaffWithHistory].id=FactStaffReplacement.idFactStaff
			AND (FactStaffReplacement.[DateEnd]>@PeriodBegin OR FactStaffReplacement.[DateEnd] IS NULL) AND [FactStaffWithHistory].IsReplacement=1
	WHERE [FactStaffWithHistory].idEmployee=@idEmployee
		AND (([FactStaffWithHistory].DateBegin<=@PeriodBegin AND ([FactStaffWithHistory].DateEnd>=@PeriodBegin OR [FactStaffWithHistory].DateEnd IS NULL))
			OR ([FactStaffWithHistory].DateBegin>=@PeriodBegin AND [FactStaffWithHistory].DateBegin<=@PeriodEnd))

