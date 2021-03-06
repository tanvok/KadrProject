USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStaffByPeriod]    Script Date: 07/01/2011 13:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetStaffByPeriod]('1.02.2011','15.03.2011') WHERE idDepartment=143 idPlanStaff=172
--select * from [GetStaffByPeriod]('19.09.2010','19.09.2010')
ALTER FUNCTION [dbo].[GetStaffByPeriod] 
(
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME
)
RETURNS @Result TABLE
   (
		idDepartment INT,
		idPost		 INT,
		idPlanStaff  INT,
		idFactStaff  INT,
		idEmployee   INT,
		StaffCount	 NUMERIC(7,2),
		StaffCountWithoutReplacement NUMERIC(7,2),	--кол-во ставок без замещений
		idReplacementReason	INT,					--причина замещения
		IsMain			BIT,							--признак основной должности (та, у которой либо ставка выше, либо основной вид работы
		IsReplacement	BIT,
		idFinancingSource	INT,
		idTypeWork			INT,
		SeverKoeff		INT,
		RayonKoeff		INT
   
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

	--Указываем занятые ставки
	INSERT INTO @Result(idPost, idPlanStaff, idFactStaff, idEmployee, 
		idDepartment, StaffCount, StaffCountWithoutReplacement, IsMain, 
		IsReplacement, idFinancingSource, idTypeWork, SeverKoeff, RayonKoeff)
	SELECT idPost, PlanStaff.idPlanStaff, FactStaff.idFactStaff, idEmployee, 
		idDepartment, FactStaff.StaffCount, FactStaff.StaffCount, WorkType.IsMain, 
		WorkType.IsReplacement, PlanStaff.idFinancingSource, idTypeWork, PlanStaff.SeverKoeff, PlanStaff.RayonKoeff
	FROM [dbo].[GetPlanStaffByPeriod](@PeriodBegin, @PeriodEnd)  PlanStaff
		INNER JOIN [dbo].[GetFactStaffByPeriod](@PeriodBegin, @PeriodEnd) FactStaff 
			ON PlanStaff.idPlanStaff=FactStaff.idPlanStaff
		INNER JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id

			
	--отмечаем замещающих (обнуляем ставку)
	UPDATE @Result
	SET StaffCountWithoutReplacement = 0, idReplacementReason=FactStaffReplacement.idReplacementReason
	FROM @Result as res, dbo.FactStaffReplacement
	WHERE res.idFactStaff= FactStaffReplacement.idFactStaff
	
	UPDATE  @Result  
	SET IsMain=1
	FROM @Result as Result
	WHERE idEmployee NOT IN (SELECT idEmployee FROM @Result WHERE IsMain=1)
		AND idFactStaff=
		(SELECT MIN(idFactStaff) FROM @Result as res
			WHERE res.idEmployee=Result.idEmployee
				AND res.StaffCount=(SELECT MAX(StaffCount) FROM @Result as resl 
									WHERE resl.idEmployee=res.idEmployee))
				
	--заполняем вакансии	
	INSERT INTO @Result(idPost, idPlanStaff, idFactStaff, idEmployee, idDepartment, 
		StaffCount, StaffCountWithoutReplacement, IsMain, idFinancingSource,
		PlanStaff.SeverKoeff, PlanStaff.RayonKoeff)
	SELECT PlanStaff.idPost, PlanStaff.idPlanStaff, null, null, PlanStaff.idDepartment, 
		PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0), 
		PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0), 0, 
		PlanStaff.idFinancingSource, PlanStaff.SeverKoeff, PlanStaff.RayonKoeff
	FROM [dbo].[GetPlanStaffByPeriod](@PeriodBegin, @PeriodEnd) as PlanStaff
		 LEFT JOIN @Result staff ON PlanStaff.idPlanStaff=staff.idPlanStaff
		 
	GROUP BY PlanStaff.idPost, PlanStaff.idPlanStaff, PlanStaff.idDepartment, 
		PlanStaff.StaffCount, PlanStaff.idFinancingSource, PlanStaff.SeverKoeff, PlanStaff.RayonKoeff
	HAVING PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0)>0
	
	--UPDATE @Result
	
 
		
RETURN
END











