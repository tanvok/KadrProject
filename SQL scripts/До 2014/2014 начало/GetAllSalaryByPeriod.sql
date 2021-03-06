USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSalaryByPeriod]    Script Date: 14.04.2014 13:51:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
select idPlanStaff, MAX(SalarySize), MIN (SalarySize) from [dbo].[GetAllSalaryByPeriod]('1.01.2014','2.02.2014') 
--WHERE IsIndividual=1
GROUP BY idPlanStaff
HAVING COUNT(SalarySize)>1

select * from [dbo].[GetSalaryByPeriod]('1.01.2014','2.02.2014') 
select * from [dbo].[GetAllSalaryByPeriod]('1.01.2014','2.02.2014') where idPlanStaff=164

select idPlanStaff, MAX(SalarySize), MIN (SalarySize) from [dbo].[GetSalaryByPeriod]('1.01.2014','2.02.2014') 
GROUP BY idPlanStaff
HAVING COUNT(SalarySize)>1

ALTER FUNCTION [dbo].[GetAllSalaryByPeriod] 
(
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME
)
RETURNS  TABLE

AS

RETURN	(SELECT  DISTINCT   PlanStaff.id as idPlanStaff, ISNULL(PlanStaffSalary.SalarySize, PKCategorySalary.SalarySize) as SalarySize,
		CONVERT(BIT,PlanStaffSalary.idPlanStaff) IsIndividual, PKCategory.idSalaryKoeff as idCatSalaryKoeff, PlanStaffSalary.DateBegin, PlanStaffSalary.DateEnd
	FROM         
		PlanStaffWithHistory as PlanStaff INNER JOIN
		 dbo.Post ON PlanStaff.idPost=Post.id	
			 INNER JOIN
		  dbo.PKCategory ON Post.idPKCategory = dbo.PKCategory.id INNER JOIN
		  (SELECT * FROM dbo.PKCategorySalary 
				  WHERE ((PKCategorySalary.DateBegin<=@PeriodBegin AND (PKCategorySalary.DateEnd>=@PeriodBegin OR PKCategorySalary.DateEnd IS NULL))
						OR (PKCategorySalary.DateBegin>=@PeriodBegin AND PKCategorySalary.DateBegin<=@PeriodEnd)))PKCategorySalary	
				ON dbo.PKCategory.id = PKCategorySalary.idPKCategory
		LEFT JOIN
		  (SELECT * FROM 
			  dbo.PlanStaffSalary 
					WHERE ((PlanStaffSalary.DateBegin<=@PeriodBegin AND (PlanStaffSalary.DateEnd>=@PeriodBegin OR PlanStaffSalary.DateEnd IS NULL))
						OR (PlanStaffSalary.DateBegin>=@PeriodBegin AND PlanStaffSalary.DateBegin<=@PeriodEnd)))PlanStaffSalary
			ON PlanStaff.id = PlanStaffSalary.idPlanStaff)	  






