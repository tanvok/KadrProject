USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFactStaffForTimeSheet]    Script Date: 23.04.2015 10:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET STATISTICS TIME ON
--select * from [dbo].[GetFactStaffForTimeSheet_optimize]('1.01.2015','31.01.2015')where  idDepartment=604    21 
/*ALTER FUNCTION [dbo].[GetFactStaffForTimeSheet_optimize] 
(
@PeriodBegin	DATE=NULL,
@PeriodEnd	DATE=NULL
)
RETURNS @Result TABLE
   (
    idFactStaff		INT NOT NULL,
    StaffCount	numeric(4,2) NOT NULL,
    idDepartment	INT NOT NULL,
    IsReplacement	BIT NOT NULL,
	idTypeWork		INT,
	idPost		 INT,
	idPlanStaff  INT,
	idEmployee   INT,
	idFinancingSource	INT,
	idOKVED     INT,
	isMain		BIT,
	daysCount	INT,
	DateBegin	DATE,
	DateEnd		DATE,
	OtpDateBegin DATE,
	OtpDateEnd  DATE,
	idOtpusk	INT,
	OtpDateBegin2 DATE,
	OtpDateEnd2  DATE,
	idOtpusk2	INT
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
	RETURN
	
	INSERT INTO @Result
	SELECT DISTINCT FactStaff.id, FactStaff.StaffCount, idDepartment,WorkType.IsReplacement, FactStaff.idTypeWork, idPost,
	idPlanStaff, idEmployee, idFinancingSource, FactStaff.idOKVED, 0, 
	DATEDIFF(dd, IIF(FactStaff.DateBegin BETWEEN @PeriodBegin AND @PeriodEnd,FactStaff.DateBegin,@PeriodBegin),  
				IIF(FactStaff.DateEnd BETWEEN @PeriodBegin AND @PeriodEnd, FactStaff.DateEnd,@PeriodEnd)) + 1,
	 FactStaff.DateBegin, FactStaff.DateEnd, null, null, null
	FROM  
		(SELECT FactStaff.id, FactStaff.StaffCount, MIN(FactStaff.idTypeWork) idTypeWork, 
			idPlanStaff, idEmployee, FactStaff.idOKVED, 0 isMain, DATEDIFF(dd, @PeriodBegin, @PeriodEnd) + 1 daysCount,
			MIN(FactStaff.DateBegin) DateBegin, ISNULL(MAX(FactStaff.DateEnd),'01.12.2200') DateEnd
			FROM dbo.FactStaffWithHistory FactStaff
			WHERE ((FactStaff.DateBegin<=@PeriodBegin AND (FactStaff.DateEnd>=@PeriodBegin OR FactStaff.DateEnd IS NULL))
								OR (FactStaff.DateBegin>=@PeriodBegin AND FactStaff.DateBegin<=@PeriodEnd))
					AND FactStaff.idTypeWork<>16
			GROUP BY id, FactStaff.StaffCount, FactStaff.idOKVED, idPlanStaff, idEmployee
		) as FactStaff INNER JOIN
		dbo.PlanStaffCurrent PlanStaff ON FactStaff.idPlanStaff=PlanStaff.id
		INNER JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id
		LEFT JOIN [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk] ON 
			[OK_Otpusk].[isMaternity]=1 AND [OK_Otpusk].idFactStaff=FactStaff.id
		LEFT JOIN [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk2] ON 
			[OK_Otpusk2].[isMaternity]=1 AND [OK_Otpusk2].idFactStaff=FactStaff.id
				AND ([OK_Otpusk].idOtpusk<>[OK_Otpusk2].idOtpusk OR [OK_Otpusk].idOtpusk IS NULL)



	/*UPDATE @Result
	SET daysCount=DATEDIFF(dd, DateBegin, @PeriodEnd) + 1
	WHERE DateBegin BETWEEN @PeriodBegin AND @PeriodEnd

	UPDATE @Result
	SET daysCount=DATEDIFF(dd, @PeriodBegin, DateEnd) + 1
	WHERE DateEnd BETWEEN @PeriodBegin AND @PeriodEnd*/
/*
	DECLARE @IntCount INT
	SET @IntCount=1
	WHILE @IntCount<3
	BEGIN

		--учитываем отпуска по беременности и родам
		UPDATE @Result
		SET OtpDateBegin=[OK_Otpusk].[DateBegin],OtpDateEnd=[OK_Otpusk].[DateEnd], idOtpusk=[OK_Otpusk].idOtpusk
		FROM [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk]
		INNER JOIN @Result res
		ON [OK_Otpusk].idFactStaff=res.idFactStaff
		WHERE 

		UPDATE @Result
		SET daysCount=0, OtpDateBegin=NULL, OtpDateEnd=NULL
		WHERE OtpDateBegin <= @PeriodBegin AND @PeriodEnd <= OtpDateEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, OtpDateBegin, @PeriodEnd) -1, OtpDateBegin=NULL
		WHERE OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd AND NOT OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, @PeriodBegin, OtpDateEnd) -1, OtpDateEnd=NULL
		WHERE OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd AND NOT OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, OtpDateEnd, OtpDateEnd) -1, OtpDateBegin=NULL, OtpDateEnd=NULL
		WHERE OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd AND OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd

		SET @IntCount = @IntCount+1

	END*/

	
RETURN
END
*/

--DROP FUNCTION [dbo].[GetFactStaffForTimeSheet_optimize] 

--select * from [dbo].[GetFactStaffForTimeSheet_optimize]('1.01.2015','31.01.2015')where  idDepartment=604    21 
CREATE FUNCTION [dbo].[GetFactStaffForTimeSheet_optimize] 
(
@PeriodBegin	DATE=NULL,
@PeriodEnd	DATE=NULL
)
RETURNS  TABLE
   
AS
RETURN (SELECT DISTINCT FactStaff.id, FactStaff.StaffCount, idDepartment,WorkType.IsReplacement, FactStaff.idTypeWork, idPost,
	idPlanStaff, idEmployee, idFinancingSource, FactStaff.idOKVED, 0 ISMain, 
	DATEDIFF(dd, IIF(FactStaff.DateBegin BETWEEN @PeriodBegin AND @PeriodEnd,FactStaff.DateBegin,@PeriodBegin),  
				IIF(FactStaff.DateEnd BETWEEN @PeriodBegin AND @PeriodEnd, FactStaff.DateEnd,@PeriodEnd)) + 1 daysCount,
	 FactStaff.DateBegin, FactStaff.DateEnd
	FROM  
		(SELECT FactStaff.id, FactStaff.StaffCount, MIN(FactStaff.idTypeWork) idTypeWork, 
			idPlanStaff, idEmployee, FactStaff.idOKVED, 0 isMain, DATEDIFF(dd, @PeriodBegin, @PeriodEnd) + 1 daysCount,
			MIN(FactStaff.DateBegin) DateBegin, ISNULL(MAX(FactStaff.DateEnd),'01.12.2200') DateEnd
			FROM dbo.FactStaffWithHistory FactStaff
			WHERE ((FactStaff.DateBegin<=@PeriodBegin AND (FactStaff.DateEnd>=@PeriodBegin OR FactStaff.DateEnd IS NULL))
								OR (FactStaff.DateBegin>=@PeriodBegin AND FactStaff.DateBegin<=@PeriodEnd))
					AND FactStaff.idTypeWork<>16
			GROUP BY id, FactStaff.StaffCount, FactStaff.idOKVED, idPlanStaff, idEmployee
		) as FactStaff INNER JOIN
		dbo.PlanStaffCurrent PlanStaff ON FactStaff.idPlanStaff=PlanStaff.id
		INNER JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id
		LEFT JOIN [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk] ON 
			[OK_Otpusk].[isMaternity]=1 AND [OK_Otpusk].idFactStaff=FactStaff.id
		LEFT JOIN [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk2] ON 
			[OK_Otpusk2].[isMaternity]=1 AND [OK_Otpusk2].idFactStaff=FactStaff.id
				AND ([OK_Otpusk].idOtpusk<>[OK_Otpusk2].idOtpusk OR [OK_Otpusk].idOtpusk IS NULL)
)


	/*UPDATE @Result
	SET daysCount=DATEDIFF(dd, DateBegin, @PeriodEnd) + 1
	WHERE DateBegin BETWEEN @PeriodBegin AND @PeriodEnd

	UPDATE @Result
	SET daysCount=DATEDIFF(dd, @PeriodBegin, DateEnd) + 1
	WHERE DateEnd BETWEEN @PeriodBegin AND @PeriodEnd*/
/*
	DECLARE @IntCount INT
	SET @IntCount=1
	WHILE @IntCount<3
	BEGIN

		--учитываем отпуска по беременности и родам
		UPDATE @Result
		SET OtpDateBegin=[OK_Otpusk].[DateBegin],OtpDateEnd=[OK_Otpusk].[DateEnd], idOtpusk=[OK_Otpusk].idOtpusk
		FROM [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) [OK_Otpusk]
		INNER JOIN @Result res
		ON [OK_Otpusk].idFactStaff=res.idFactStaff
		WHERE 

		UPDATE @Result
		SET daysCount=0, OtpDateBegin=NULL, OtpDateEnd=NULL
		WHERE OtpDateBegin <= @PeriodBegin AND @PeriodEnd <= OtpDateEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, OtpDateBegin, @PeriodEnd) -1, OtpDateBegin=NULL
		WHERE OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd AND NOT OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, @PeriodBegin, OtpDateEnd) -1, OtpDateEnd=NULL
		WHERE OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd AND NOT OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd

		UPDATE @Result
		SET daysCount=daysCount-DATEDIFF(dd, OtpDateEnd, OtpDateEnd) -1, OtpDateBegin=NULL, OtpDateEnd=NULL
		WHERE OtpDateEnd BETWEEN @PeriodBegin AND @PeriodEnd AND OtpDateBegin BETWEEN @PeriodBegin AND @PeriodEnd

		SET @IntCount = @IntCount+1

	END*/

	


/*
GO

--select * from [dbo].[GetStaffByPeriodWithHistory]('09.02.2011','12.02.2011') WHERE idDepartment=143 idPlanStaff=172
--select * from [GetStaffByPeriodWithHistory]('19.09.2010','19.09.2010')
ALTER FUNCTION [dbo].[GetStaffByPeriodWithHistory] 
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
		idTypeWork			INT
   
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

	--Указываем занятые ставки
	INSERT INTO @Result(idPost, idPlanStaff, idFactStaff, idEmployee, idDepartment, StaffCount, StaffCountWithoutReplacement, IsMain, IsReplacement, idFinancingSource, idTypeWork)
	SELECT idPost, PlanStaff.idPlanStaff, FactStaff.idFactStaff, idEmployee, idDepartment, FactStaff.StaffCount, FactStaff.StaffCount, WorkType.IsMain, WorkType.IsReplacement, PlanStaff.idFinancingSource, idTypeWork
	FROM [dbo].[GetPlanStaffByPeriod](@PeriodBegin, @PeriodEnd)  PlanStaff, [dbo].[GetFactStaffByPeriodWithHistory](@PeriodBegin, @PeriodEnd) FactStaff, dbo.WorkType 
	WHERE PlanStaff.idPlanStaff=FactStaff.idPlanStaff
		AND FactStaff.idTypeWork=WorkType.id
			
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
	INSERT INTO @Result(idPost, idPlanStaff, idFactStaff, idEmployee, idDepartment, StaffCount, StaffCountWithoutReplacement, IsMain, idFinancingSource)
	SELECT PlanStaff.idPost, PlanStaff.idPlanStaff, null, null, PlanStaff.idDepartment, 
		PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0), 
		PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0), 0, 
		PlanStaff.idFinancingSource
	FROM [dbo].[GetPlanStaffByPeriod](@PeriodBegin, @PeriodEnd) as PlanStaff 
		 LEFT JOIN @Result staff ON PlanStaff.idPlanStaff=staff.idPlanStaff
		 
	GROUP BY PlanStaff.idPost, PlanStaff.idPlanStaff, PlanStaff.idDepartment, PlanStaff.StaffCount, PlanStaff.idFinancingSource
	HAVING PlanStaff.StaffCount-ISNULL(SUM(staff.StaffCountWithoutReplacement),0)>0
	
	--UPDATE @Result
	
 
		
RETURN
END


*/


