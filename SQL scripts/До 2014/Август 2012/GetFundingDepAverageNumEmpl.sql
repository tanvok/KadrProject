USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAverageNumEmpl]    Script Date: 08/07/2012 09:42:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetFundingDepAverageNumEmpl](2012,1)

--Возвращает среднесп численность для центров финансирования
alter FUNCTION [dbo].[GetFundingDepAverageNumEmpl] 
(
@Year	INT,
@idDepartment INT
)
RETURNS @Result TABLE
   (
	DepartmentSmallName		VARCHAR(50),
	TypeWorkName	VARCHAR(50),
	TimeSheetYear	INT,
	TimeSheetMonth	INT,
	TimeSheetMonthName VARCHAR(50),
	StaffAverage	FLOAT,
	TimeSheetHourCount NUMERIC(12,2)  
   ) 
AS
BEGIN
DECLARE @PeriodBegin	DATETIME,
		@PeriodEnd	DATETIME
		
SET @PeriodBegin=CONVERT(date,'01.01.'+CONVERT(VARCHAR(4),@Year))
SET @PeriodEnd=CONVERT(date,'31.12.'+CONVERT(VARCHAR(4),@Year))

	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ
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
			WHERE Department.id=@idDepartment
		
		

	DECLARE TimeSheetCursor CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT TimeSheet.id,
	CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103) DateBegin,
	DATEADD(dd, -1, DATEADD(mm, 1, CONVERT(date, '01.'+CONVERT(VARCHAR(2),TimeSheet.TimeSheetMonth)+'.'+CONVERT(VARCHAR(4),TimeSheet.TimeSheetYear),103))) DateEnd 
	FROM dbo.TimeSheet
	WHERE TimeSheet.TimeSheetYear=@Year
		AND TimeSheet.IsFilled=1 
	ORDER BY TimeSheetMonth

	OPEN TimeSheetCursor

	DECLARE @DateBegin DATETIME
	DECLARE @DateEnd DATETIME
	DECLARE @idTimeSheet INT
FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd

WHILE @@FETCH_STATUS = 0
BEGIN
	
		
	INSERT INTO @Result
	SELECT DepartmentName, WorkSuperType.WorkSuperTypeShortName,
	TimeSheetYear, TimeSheetMonth, Months.MonthName, 
	SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
	ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount
	FROM 
	(SELECT * FROM dbo.TimeSheet WHERE id=@idTimeSheet)TimeSheet 
	INNER JOIN	dbo.TimeSheetFSWorkingDays ON TimeSheetFSWorkingDays.idTimeSheet=@idTimeSheet 
	INNER JOIN	[dbo].[GetFactStaffForTimeSheet](@DateBegin,@DateEnd) PeriodStaff 
		ON TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff
	INNER JOIN	dbo.FactStaff ON TimeSheetFSWorkingDays.idFactStaff=FactStaff.id
	INNER JOIN  dbo.WorkType ON PeriodStaff.idTypeWork=WorkType.id
	INNER JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
	INNER JOIN dbo.Months ON Months.MonthNumber=TimeSheet.TimeSheetMonth
	INNER JOIN @DepTable deps
		ON FactStaff.idFundingDepartment=deps.idDepartment
	GROUP BY DepartmentName, WorkSuperType.WorkSuperTypeShortName,
	TimeSheetYear, Months.MonthName, TimeSheetWorkingDayCount, TimeSheetWorkingHourCount,
	TimeSheetMonth
	

	
	
	/*DepartmentName, CategorySmallName, PostShortName, IsSubDep, WorkSuperTypeShortName, TimeSheetYear, TimeSheetMonth, MonthName,
		SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		SUM(TimeSheetFSWorkingDays.StaffCount*(TimeSheetWorkingDayCount-WorkingDaysCount))/TimeSheetWorkingDayCount,
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy,
		ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount
	FROM dbo.TimeSheet, dbo.TimeSheetFSWorkingDays, dbo.WorkType,
		[dbo].[GetFactStaffForTimeSheet](@DateBegin, @DateEnd) PeriodStaff, dbo.Months, 
		@DepTable as DepList,dbo.FactStaffCurrent FactStaff,
		dbo.Category, dbo.Post, dbo.WorkSuperType, dbo.FinancingSource
	WHERE TimeSheet.id=@idTimeSheet
		AND Months.MonthNumber=TimeSheet.TimeSheetMonth
		AND TimeSheet.id=TimeSheetFSWorkingDays.idTimeSheet
		AND TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff 
			AND TimeSheetFSWorkingDays.StaffCount=PeriodStaff.StaffCount
		AND PeriodStaff.idDepartment=DepList.idDepartment
		AND Post.idCategory=Category.id
		AND PeriodStaff.idPost=Post.id
		AND FactStaff.idTypeWork=WorkType.id
		AND PeriodStaff.idFactStaff=FactStaff.id
		AND WorkType.idWorkSuperType=WorkSuperType.id
		AND TimeSheetFSWorkingDays.IsClosed=1
		AND FinancingSource.id=PeriodStaff.idFinancingSource
		AND WorkType.idWorkSuperType<>4

	GROUP BY DepartmentName, CategorySmallName, PostShortName, IsSubDep, WorkSuperTypeShortName, 
		TimeSheetYear, TimeSheetMonth, TimeSheetWorkingDayCount, MonthName, 
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy, TimeSheetWorkingHourCount
	ORDER BY IsSubDep, TimeSheetMonth, WorkSuperTypeShortName, Category.OrderBy
 */
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd

END
		
RETURN
END

