USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFundingDepAverageNumEmpl]    Script Date: 12.05.2015 16:24:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetFundingDepAverageNumEmpl](2015,0)

--Возвращает среднесп численность для центров финансирования
ALTER FUNCTION [dbo].[GetFundingDepAverageNumEmpl] 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT,
@MonthBegin  INT=1,
@MonthEnd	 INT=12
)
RETURNS @Result TABLE
   (
	DepartmentSmallName		VARCHAR(50),
	TypeWorkName	VARCHAR(50),
	TimeSheetYear	INT,
	TimeSheetMonth	INT,
	TimeSheetMonthName VARCHAR(50),
	StaffAverage	FLOAT,
	TimeSheetHourCount NUMERIC(12,2) ,
	PersonCount   FLOAT,
	idSuperTypeWork  INT,
	idEmployee	INT
   ) 
AS
BEGIN
DECLARE @PeriodBegin	DATE,
		@PeriodEnd	DATE
		
SET @PeriodBegin=CONVERT(date,'01.01.'+CONVERT(VARCHAR(4),@Year))
SET @PeriodEnd=CONVERT(date,DATEADD(dd,-1,'01.01.'+CONVERT(VARCHAR(4),@Year+1)))

	/*--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
    DepartmentName  VARCHAR(50)
	)
	
	IF (@idDepartment < 2)
		INSERT INTO @DepTable	
			SELECT idDepartment, DepartmentSmallName
			FROM [dbo].[GetDepartmentsForPeriod](@PeriodBegin,@PeriodEnd)
	ELSE
		INSERT INTO @DepTable	
			SELECT @idDepartment, DepartmentSmallName
			FROM [dbo].Department
			WHERE Department.id=@idDepartment*/
		
		

	DECLARE TimeSheetCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT TimeSheet.id,
	CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103) DateBegin,
	DATEADD(dd, -1, DATEADD(mm, 1, CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103))) DateEnd,
	TimeSheetWorkingDayCount
	FROM dbo.TimeSheet
	WHERE TimeSheet.TimeSheetYear=@Year
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
	INSERT INTO @Result(DepartmentSmallName,TypeWorkName,TimeSheetYear,TimeSheetMonth,TimeSheetMonthName,StaffAverage,
		TimeSheetHourCount,PersonCount,idSuperTypeWork, idEmployee)
	SELECT FundingCenter.FundingCenterName, WorkSuperType.WorkSuperTypeShortName,
	TimeSheetYear, TimeSheetMonth, Months.MonthName, 
	SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
	ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount, 
	MAX(CONVERT(FLOAT,PeriodStaff.daysCount)/CONVERT(FLOAT,@TimeSheetWorkingDayCount)), WorkType.idWorkSuperType, FactStaff.idEmployee
	FROM 
	(SELECT * FROM dbo.TimeSheet WHERE id=@idTimeSheet)TimeSheet 
	INNER JOIN	dbo.TimeSheetFSWorkingDays ON @idTimeSheet=TimeSheetFSWorkingDays.idTimeSheet 
		AND TimeSheetFSWorkingDays.IsClosed=1                 
	INNER JOIN	[dbo].[GetFactStaffForTimeSheet](@DateBegin,@DateEnd) PeriodStaff 
		ON TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff 
			AND TimeSheetFSWorkingDays.StaffCount=PeriodStaff.StaffCount
	INNER JOIN	dbo.FactStaffCurrent FactStaff ON TimeSheetFSWorkingDays.idFactStaff=FactStaff.id
	INNER JOIN dbo.WorkType ON PeriodStaff.idTypeWork=WorkType.id
	INNER JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
	INNER JOIN dbo.Months ON Months.MonthNumber=TimeSheet.TimeSheetMonth
	INNER JOIN dbo.PlanStaff ON FactStaff.idPlanStaff=PlanStaff.id
	INNER JOIN dbo.Dep deps
		ON PlanStaff.idDepartment=deps.id
	INNER JOIN dbo.FundingCenter
		ON FundingCenter.id=ISNULL(factStaff.idFundingCenter,deps.idFundingCenter)

	WHERE WorkType.idWorkSuperType<>4	
	GROUP BY FundingCenter.FundingCenterName, WorkSuperType.WorkSuperTypeShortName,
	TimeSheetYear, Months.MonthName, TimeSheetWorkingDayCount, TimeSheetWorkingHourCount,
	TimeSheetMonth, WorkType.idWorkSuperType, FactStaff.idEmployee


	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

END
		--редактируем всех в соответствии с тем, что надо выводить
	/*UPDATE @Result
	SET StaffAverage=PersonCount
	WHERE idSuperTypeWork=1*/
	
	INSERT INTO @Result(DepartmentSmallName,TypeWorkName,TimeSheetYear,TimeSheetMonth,TimeSheetMonthName,StaffAverage,
		TimeSheetHourCount,PersonCount,idSuperTypeWork)
	SELECT DepartmentSmallName,TypeWorkName + '  (ф.л.)',TimeSheetYear,TimeSheetMonth,TimeSheetMonthName,PersonCount,
		TimeSheetHourCount,PersonCount,idSuperTypeWork
	FROM @Result
	WHERE idSuperTypeWork BETWEEN 1 AND 3	
	
RETURN
END

