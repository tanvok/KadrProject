USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFactStaffForTimeSheet]    Script Date: 06.05.2015 14:25:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SET STATISTICS TIME ON

--select TimeSheetMonth, Department.[DepartmentName], Post.PostName, Employee.EmployeeName, StaffAverage,TimeSheetHourCount,PersonCount
-- from [dbo].[GetAverageSums](2014, 1, 1)aver inner join
--dbo.Employee ON aver.idEmployee=Employee.id inner join
--dbo.FactStaff on aver.idFactStaff=FactStaff.id inner join
--dbo.PlanStaff on FactStaff.idPlanStaff=PlanStaff.id inner join
--dbo.Post on aver.idPost=Post.id inner join
--dbo.Department on PlanStaff.idDepartment=Department.id
--order by  TimeSheetMonth, Employee.EmployeeName

--select distinct newAver.*, oldAver.StaffAverage, oldAver.FreeStaffAverage, oldAver.TimeSheetHourCount, oldAver.PersonCount from 
--[dbo].[GetAverageSums](2015,1,1, 1,3)newAver
--inner join [dbo].[OldGetAverageSums](2015,1,1, 1,3) oldAver
--ON newAver.idEmployee=oldAver.idEmployee and 
--newAver.idFactStaff=oldAver.idFactStaff and 
--newAver.idTypeWork=oldAver.idTypeWork and 
--newAver.TimeSheetYear=oldAver.TimeSheetYear and 
--newAver.TimeSheetMonth=oldAver.TimeSheetMonth and 
----newAver.idTypeWork=oldAver.idTypeWork and 
--newAver.idTypeWork=oldAver.idTypeWork and 
--newAver.StaffAverage<>oldAver.StaffAverage
--order by newAver.idFactStaff,newAver.idEmployee
go
ALTER FUNCTION [dbo].[GetAverageSums] 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT,
@MonthBegin  INT=1,
@MonthEnd	 INT=12
)
RETURNS @Result TABLE
   (
	DepartmentName  VARCHAR(50),
	IsSubDep		BIT NOT NULL,
	TimeSheetYear	INT,
	TimeSheetMonth	INT,
	StaffAverage	FLOAT,
	FreeStaffAverage FLOAT,
	TimeSheetHourCount NUMERIC(12,2),
	PersonCount   FLOAT,
	idTypeWork INT,
	idPost INT,
	idFactStaff INT,
	idFinancingSource INT,
	idEmployee INT,
	[idOKVED] INT
   ) 
AS
BEGIN
	
	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
    IsSubDep		BIT,
    DepartmentName  VARCHAR(50),
	idOKVED INT
	)
	DECLARE @DepName VARCHAR(50)
	SELECT @DepName=DepartmentSmallName
	FROM dbo.Department
	WHERE Department.id=@idDepartment
	
	DECLARE @DateEndString DATE
	IF (@MonthEnd>11)
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.01.'+CONVERT(VARCHAR(4),@Year+1),103))
	ELSE
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.'+CONVERT(VARCHAR(2), @MonthEnd+1)+'.'++CONVERT(VARCHAR(4),@Year),103))

	INSERT INTO @DepTable	--текущий отдел
		SELECT idDepartment, 0, @DepName, idOKVED
			FROM dbo.[GetDepartmentDataForReports](@idDepartment, '01.'+CONVERT(VARCHAR(2), @MonthBegin)+'.'+CONVERT(VARCHAR(4),@Year) , @DateEndString, @WithSubDeps,-1)	
	
	DECLARE TimeSheetCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT TimeSheet.id,
	CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103) DateBegin,
	DATEADD(dd, -1, DATEADD(mm, 1, CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103))) DateEnd,
	TimeSheetWorkingDayCount
	FROM dbo.TimeSheet
	WHERE TimeSheet.TimeSheetYear=@Year
		AND TimeSheet.TimeSheetMonth BETWEEN @MonthBegin AND @MonthEnd
		AND TimeSheet.IsFilled=1 
	ORDER BY TimeSheetMonth

	OPEN TimeSheetCursor

	DECLARE @DateBegin DATETIME
	DECLARE @DateEnd DATETIME
	DECLARE @idTimeSheet INT
	DECLARE @TimeSheetWorkingDayCount INT
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO @Result(DepartmentName,IsSubDep,TimeSheetYear,TimeSheetMonth,
		StaffAverage,FreeStaffAverage,TimeSheetHourCount,PersonCount, idTypeWork,
		idPost, idFactStaff, idFinancingSource,idEmployee, [idOKVED])
	SELECT DepartmentName, IsSubDep, TimeSheetYear, TimeSheetMonth, 
		SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		SUM(TimeSheetFSWorkingDays.StaffCount*(TimeSheetWorkingDayCount-WorkingDaysCount))/TimeSheetWorkingDayCount,
		ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		/*MAX(CONVERT(FLOAT,PeriodStaff.daysCount)/CONVERT(FLOAT,@TimeSheetWorkingDayCount))*/1,PeriodStaff.idTypeWork,
		idPost, PeriodStaff.idFactStaff, idFinancingSource, PeriodStaff.idEmployee, ISNULL(PeriodStaff.[idOKVED], DepList.idOKVED)		  
	FROM 
		(SELECT * FROM dbo.TimeSheet WHERE id=@idTimeSheet)TimeSheet 
		INNER JOIN	dbo.TimeSheetFSWorkingDays ON @idTimeSheet=TimeSheetFSWorkingDays.idTimeSheet AND TimeSheetFSWorkingDays.IsClosed=1 AND WorkingDaysCount>0
		INNER JOIN	
		(SELECT FactStaff.id idFactStaff, FactStaff.StaffCount, MIN(FactStaff.idTypeWork) idTypeWork, 
			idPlanStaff, idEmployee, FactStaff.idOKVED 
			FROM dbo.FactStaffWithHistory FactStaff
			WHERE ((FactStaff.DateBegin<=@DateBegin AND (FactStaff.DateEnd>=@DateBegin OR FactStaff.DateEnd IS NULL))
								OR (FactStaff.DateBegin>=@DateBegin AND FactStaff.DateBegin<=@DateEnd))
					AND FactStaff.idTypeWork<>16
			GROUP BY FactStaff.id, FactStaff.StaffCount,
			idPlanStaff, idEmployee, FactStaff.idOKVED
		) as PeriodStaff 
			ON TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff
				AND TimeSheetFSWorkingDays.StaffCount=PeriodStaff.StaffCount
		--INNER JOIN	dbo.FactStaffCurrent FactStaff ON TimeSheetFSWorkingDays.idFactStaff=FactStaff.id
		INNER JOIN dbo.PlanStaffCurrent PlanStaff ON PeriodStaff.idPlanStaff=PlanStaff.id
		INNER JOIN @DepTable DepList
			ON PlanStaff.idDepartment=DepList.idDepartment
	--WHERE PeriodStaff.daysCount>0
	GROUP BY DepartmentName, IsSubDep, 
		TimeSheetYear, TimeSheetMonth, TimeSheetWorkingDayCount, TimeSheetWorkingHourCount, PeriodStaff.idTypeWork,
		idPost, PeriodStaff.idFactStaff, idFinancingSource, PeriodStaff.idEmployee, PeriodStaff.[idOKVED], DepList.idOKVED
 
	UPDATE @Result
	SET PersonCount=0
	FROM @Result res
	LEFT JOIN (SELECT idEmployee, MAX(idFactStaff)idFactStaff
		FROM @Result
		WHERE StaffAverage>0
		GROUP BY idEmployee
		HAVING COUNT(idFactStaff)>1)MaxFactStaff
		ON res.idEmployee=MaxFactStaff.idEmployee
	WHERE (res.idFactStaff<MaxFactStaff.idFactStaff
			OR StaffAverage=0)
	 

	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

END
		
RETURN
END





/*
--select * from [dbo].[GetAverageSums]('1.01.2015','31.01.2015') order by idFactStaff where  idDepartment=604    21 
CREATE FUNCTION [dbo].GetAverageSums 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT,
@MonthBegin  INT=1,
@MonthEnd	 INT=12
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
	TimeSheetYear	INT,
	TimeSheetMonth	INT
   ) 
AS
BEGIN
		--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
    IsSubDep		BIT,
    DepartmentName  VARCHAR(50),
	idOKVED INT
	)

	DECLARE @DepName VARCHAR(50)
	SELECT @DepName=DepartmentSmallName
	FROM dbo.Department
	WHERE Department.id=@idDepartment
	
	DECLARE @DateEndString DATE
	IF (@MonthEnd>11)
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.01.'+CONVERT(VARCHAR(4),@Year+1),103))
	ELSE
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.'+CONVERT(VARCHAR(2), @MonthEnd+1)+'.'++CONVERT(VARCHAR(4),@Year),103))

	INSERT INTO @DepTable	--текущий отдел
		SELECT idDepartment, 0, @DepName, idOKVED
			FROM dbo.[GetDepartmentDataForReports](@idDepartment, '01.'+CONVERT(VARCHAR(2), @MonthBegin)+'.'+CONVERT(VARCHAR(4),@Year) , @DateEndString, @WithSubDeps,-1)	
	
	--выбираем все табели за указанный период
	DECLARE TimeSheetCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT TimeSheet.id,
	CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103) DateBegin,
	DATEADD(dd, -1, DATEADD(mm, 1, CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103))) DateEnd,
	TimeSheetWorkingDayCount
	FROM dbo.TimeSheet
	WHERE TimeSheet.TimeSheetYear=@Year
		AND TimeSheet.TimeSheetMonth BETWEEN @MonthBegin AND @MonthEnd
		AND TimeSheet.IsFilled=1 
	ORDER BY TimeSheetMonth

	OPEN TimeSheetCursor

	DECLARE @DateBegin DATETIME
	DECLARE @DateEnd DATETIME
	DECLARE @idTimeSheet INT
	DECLARE @TimeSheetWorkingDayCount INT
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO @Result(TimeSheetYear,TimeSheetMonth,
		idTypeWork,
		idPost, idFactStaff, idFinancingSource,idEmployee, [idOKVED])
	SELECT DISTINCT FactStaff.id, FactStaff.StaffCount, idDepartment,WorkType.IsReplacement, FactStaff.idTypeWork, idPost,
	idPlanStaff, idEmployee, idFinancingSource, FactStaff.idOKVED, 0 ISMain, 
	DATEDIFF(dd, IIF(FactStaff.DateBegin BETWEEN @PeriodBegin AND @PeriodEnd,FactStaff.DateBegin,@PeriodBegin),  
				IIF(FactStaff.DateEnd BETWEEN @PeriodBegin AND @PeriodEnd, FactStaff.DateEnd,@PeriodEnd)) + 1 daysCount,
	 FactStaff.DateBegin, FactStaff.DateEnd, null, null, null
	FROM  (SELECT FactStaff.id, FactStaff.StaffCount, MIN(FactStaff.idTypeWork) idTypeWork, 
			idPlanStaff, idEmployee, FactStaff.idOKVED, 0 isMain, DATEDIFF(dd, @PeriodBegin, @PeriodEnd) + 1 daysCount,
			MIN(FactStaff.DateBegin) DateBegin, ISNULL(MAX(FactStaff.DateEnd),'01.12.2200') DateEnd
			FROM dbo.FactStaffWithHistory FactStaff
			WHERE ((FactStaff.DateBegin<=@PeriodBegin AND (FactStaff.DateEnd>=@PeriodBegin OR FactStaff.DateEnd IS NULL))
								OR (FactStaff.DateBegin>=@PeriodBegin AND FactStaff.DateBegin<=@PeriodEnd))
					AND FactStaff.idTypeWork<>16
			GROUP BY id, FactStaff.StaffCount, FactStaff.idOKVED, idPlanStaff, idEmployee
		) as FactStaff 
		INNER JOIN dbo.PlanStaffCurrent PlanStaff ON FactStaff.idPlanStaff=PlanStaff.id
		INNER JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id 

	UPDATE @Result
	SET daysCount=DATEDIFF(dd, DateBegin, @PeriodEnd) + 1
	WHERE DateBegin BETWEEN @PeriodBegin AND @PeriodEnd

	UPDATE @Result
	SET daysCount=DATEDIFF(dd, @PeriodBegin, DateEnd) + 1
	WHERE DateEnd BETWEEN @PeriodBegin AND @PeriodEnd

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
		WHERE [idotpuskvid] IN (SELECT [idotpuskvid] FROM [dbo].[OK_Otpuskvid] WHERE [isMaternity]=1)
		AND (res.idOtpusk<>[OK_Otpusk].idOtpusk OR res.idOtpusk IS NULL)

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

	END

	
 
	 

	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

END
	

RETURN
END
*/

go
/*
--select * from [dbo].[GetFactStaffForTimeSheet]('1.01.2015','31.01.2015') order by idFactStaff where  idDepartment=604    21 
ALTER FUNCTION [dbo].[GetFactStaffForTimeSheet] 
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
	idOtpusk	INT
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
	RETURN
	
	INSERT INTO @Result
	SELECT DISTINCT FactStaff.id, FactStaff.StaffCount, idDepartment,WorkType.IsReplacement, FactStaff.idTypeWork, idPost,
	idPlanStaff, idEmployee, idFinancingSource, FactStaff.idOKVED, 0 ISMain, 
	DATEDIFF(dd, IIF(FactStaff.DateBegin BETWEEN @PeriodBegin AND @PeriodEnd,FactStaff.DateBegin,@PeriodBegin),  
				IIF(FactStaff.DateEnd BETWEEN @PeriodBegin AND @PeriodEnd, FactStaff.DateEnd,@PeriodEnd)) + 1 daysCount,
	 FactStaff.DateBegin, FactStaff.DateEnd, null, null, null
	FROM  (SELECT FactStaff.id, FactStaff.StaffCount, MIN(FactStaff.idTypeWork) idTypeWork, 
			idPlanStaff, idEmployee, FactStaff.idOKVED, 0 isMain, DATEDIFF(dd, @PeriodBegin, @PeriodEnd) + 1 daysCount,
			MIN(FactStaff.DateBegin) DateBegin, ISNULL(MAX(FactStaff.DateEnd),'01.12.2200') DateEnd
			FROM dbo.FactStaffWithHistory FactStaff
			WHERE ((FactStaff.DateBegin<=@PeriodBegin AND (FactStaff.DateEnd>=@PeriodBegin OR FactStaff.DateEnd IS NULL))
								OR (FactStaff.DateBegin>=@PeriodBegin AND FactStaff.DateBegin<=@PeriodEnd))
					AND FactStaff.idTypeWork<>16
			GROUP BY id, FactStaff.StaffCount, FactStaff.idOKVED, idPlanStaff, idEmployee
		) as FactStaff 
		INNER JOIN dbo.PlanStaffCurrent PlanStaff ON FactStaff.idPlanStaff=PlanStaff.id
		INNER JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id 

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
		WHERE  [isMaternity]=1
		AND (res.idOtpusk<>[OK_Otpusk].idOtpusk OR res.idOtpusk IS NULL)

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

	END

	
RETURN
END

*/
go

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




--select * from [dbo].[OldGetAverageSums](2015,1,1, 1,3)
CREATE FUNCTION [dbo].[OldGetAverageSums] 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT,
@MonthBegin  INT=1,
@MonthEnd	 INT=12
)
RETURNS @Result TABLE
   (
	DepartmentName  VARCHAR(50),
	IsSubDep		BIT NOT NULL,
	TimeSheetYear	INT,
	TimeSheetMonth	INT,
	StaffAverage	FLOAT,
	FreeStaffAverage FLOAT,
	TimeSheetHourCount NUMERIC(12,2),
	PersonCount   FLOAT,
	idTypeWork INT,
	idPost INT,
	idFactStaff INT,
	idFinancingSource INT,
	idEmployee INT,
	[idOKVED] INT
   ) 
AS
BEGIN
	
	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
    IsSubDep		BIT,
    DepartmentName  VARCHAR(50),
	idOKVED INT
	)
	DECLARE @DepName VARCHAR(50)
	SELECT @DepName=DepartmentSmallName
	FROM dbo.Department
	WHERE Department.id=@idDepartment
	
	DECLARE @DateEndString DATE
	IF (@MonthEnd>11)
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.01.'+CONVERT(VARCHAR(4),@Year+1),103))
	ELSE
		SET @DateEndString=DATEADD(dd,-1,CONVERT(DATE,'01.'+CONVERT(VARCHAR(2), @MonthEnd+1)+'.'++CONVERT(VARCHAR(4),@Year),103))

	INSERT INTO @DepTable	--текущий отдел
		SELECT idDepartment, 0, @DepName, idOKVED
			FROM dbo.[GetDepartmentDataForReports](@idDepartment, '01.'+CONVERT(VARCHAR(2), @MonthBegin)+'.'+CONVERT(VARCHAR(4),@Year) , @DateEndString, @WithSubDeps,-1)	
	
	DECLARE TimeSheetCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT TimeSheet.id,
	CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103) DateBegin,
	DATEADD(dd, -1, DATEADD(mm, 1, CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103))) DateEnd,
	TimeSheetWorkingDayCount
	FROM dbo.TimeSheet
	WHERE TimeSheet.TimeSheetYear=@Year
		AND TimeSheet.TimeSheetMonth BETWEEN @MonthBegin AND @MonthEnd
		AND TimeSheet.IsFilled=1 
	ORDER BY TimeSheetMonth

	OPEN TimeSheetCursor

	DECLARE @DateBegin DATETIME
	DECLARE @DateEnd DATETIME
	DECLARE @idTimeSheet INT
	DECLARE @TimeSheetWorkingDayCount INT
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO @Result(DepartmentName,IsSubDep,TimeSheetYear,TimeSheetMonth,
		StaffAverage,FreeStaffAverage,TimeSheetHourCount,PersonCount, idTypeWork,
		idPost, idFactStaff, idFinancingSource,idEmployee, [idOKVED])
	SELECT DepartmentName, IsSubDep, TimeSheetYear, TimeSheetMonth, 
		SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		SUM(TimeSheetFSWorkingDays.StaffCount*(TimeSheetWorkingDayCount-WorkingDaysCount))/TimeSheetWorkingDayCount,
		ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		/*MAX(CONVERT(FLOAT,PeriodStaff.daysCount)/CONVERT(FLOAT,@TimeSheetWorkingDayCount))*/1,PeriodStaff.idTypeWork,
		idPost, PeriodStaff.idFactStaff, idFinancingSource, FactStaff.idEmployee, ISNULL(PeriodStaff.[idOKVED], DepList.idOKVED)		  
	FROM 
		(SELECT * FROM dbo.TimeSheet WHERE id=@idTimeSheet)TimeSheet 
		INNER JOIN	dbo.TimeSheetFSWorkingDays ON @idTimeSheet=TimeSheetFSWorkingDays.idTimeSheet AND TimeSheetFSWorkingDays.IsClosed=1
		INNER JOIN	[dbo].[GetFactStaffForTimeSheet](@DateBegin,@DateEnd) PeriodStaff 
			ON TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff
				AND TimeSheetFSWorkingDays.StaffCount=PeriodStaff.StaffCount
		INNER JOIN	dbo.FactStaffCurrent FactStaff ON TimeSheetFSWorkingDays.idFactStaff=FactStaff.id
		INNER JOIN @DepTable DepList
			ON PeriodStaff.idDepartment=DepList.idDepartment
	WHERE PeriodStaff.daysCount>0
	GROUP BY DepartmentName, IsSubDep, 
		TimeSheetYear, TimeSheetMonth, TimeSheetWorkingDayCount, TimeSheetWorkingHourCount, PeriodStaff.idTypeWork,
		idPost, PeriodStaff.idFactStaff, idFinancingSource, FactStaff.idEmployee, PeriodStaff.[idOKVED], DepList.idOKVED
 
	UPDATE @Result
	SET PersonCount=0
	FROM @Result res
	LEFT JOIN (SELECT idEmployee, MAX(idFactStaff)idFactStaff
		FROM @Result
		WHERE StaffAverage>0
		GROUP BY idEmployee
		HAVING COUNT(idFactStaff)>1)MaxFactStaff
		ON res.idEmployee=MaxFactStaff.idEmployee
	WHERE (res.idFactStaff<MaxFactStaff.idFactStaff
			OR StaffAverage=0)
	 

	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

END
		
RETURN
END



*/


