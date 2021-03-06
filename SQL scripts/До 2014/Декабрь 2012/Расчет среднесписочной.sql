USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAverageNumEmpl]    Script Date: 27.12.2012 12:51:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetAverageNumEmpl](2012, 323, 0)
ALTER FUNCTION [dbo].[GetAverageNumEmpl] 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
	DepartmentSmallName		VARCHAR(50),
	CategorySmallName		VARCHAR(50), 
	PostShortName		VARCHAR(50),
	IsSubDep		BIT NOT NULL,
	TypeWorkName	VARCHAR(50),
	TimeSheetYear	INT,
	TimeSheetMonth	INT,
	TimeSheetMonthName VARCHAR(50),
	StaffAverage	FLOAT,
	FreeStaffAverage FLOAT,
	CategoryOrderBy	INT,
	FinancingSourceName VARCHAR(50),
	FinancingSourceOrderBy INT,
	TimeSheetHourCount NUMERIC(12,2)  
   ) 
AS
BEGIN
	
	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
    IsSubDep		BIT,
    DepartmentName  VARCHAR(50)
	)
	DECLARE @DepName VARCHAR(50)
	SELECT @DepName=DepartmentSmallName
	FROM dbo.Department
	WHERE Department.id=@idDepartment
	
	INSERT INTO @DepTable	--текущий отдел
		SELECT @idDepartment, 0, @DepName
		
	IF (@WithSubDeps = 1)	--если с подотделами
		INSERT INTO @DepTable
		SELECT idDepartment, 0, @DepName
		FROM [dbo].[GetSubDepartments](@idDepartment)
		WHERE IsMain=0
	
 
	
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
	SELECT DepartmentName, CategorySmallName, PostShortName, IsSubDep, WorkSuperTypeShortName, TimeSheetYear, TimeSheetMonth, MonthName,
		SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		SUM(TimeSheetFSWorkingDays.StaffCount*(TimeSheetWorkingDayCount-WorkingDaysCount))/TimeSheetWorkingDayCount,
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy,
		ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount
	FROM 
		(SELECT * FROM dbo.TimeSheet WHERE id=@idTimeSheet)TimeSheet 
		INNER JOIN	dbo.TimeSheetFSWorkingDays ON @idTimeSheet=TimeSheetFSWorkingDays.idTimeSheet AND TimeSheetFSWorkingDays.IsClosed=1
		INNER JOIN	[dbo].[GetFactStaffForTimeSheet](@DateBegin,@DateEnd) PeriodStaff 
			ON TimeSheetFSWorkingDays.idFactStaff=PeriodStaff.idFactStaff
				AND TimeSheetFSWorkingDays.StaffCount=PeriodStaff.StaffCount
		INNER JOIN	dbo.FactStaffCurrent FactStaff ON TimeSheetFSWorkingDays.idFactStaff=FactStaff.id
		INNER JOIN  dbo.WorkType ON PeriodStaff.idTypeWork=WorkType.id
		INNER JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
		INNER JOIN dbo.Months ON Months.MonthNumber=TimeSheet.TimeSheetMonth
		INNER JOIN @DepTable DepList
			ON PeriodStaff.idDepartment=DepList.idDepartment
		INNER JOIN dbo.Post ON PeriodStaff.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.FinancingSource ON FinancingSource.id=PeriodStaff.idFinancingSource
	WHERE 
		WorkType.idWorkSuperType<>4

	GROUP BY DepartmentName, CategorySmallName, PostShortName, IsSubDep, WorkSuperTypeShortName, 
		TimeSheetYear, TimeSheetMonth, TimeSheetWorkingDayCount, MonthName, 
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy, TimeSheetWorkingHourCount
	ORDER BY IsSubDep, TimeSheetMonth, WorkSuperTypeShortName, Category.OrderBy
 
 
 
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd

END
		
RETURN
END

