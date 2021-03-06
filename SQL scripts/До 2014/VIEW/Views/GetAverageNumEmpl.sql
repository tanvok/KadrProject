USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStaffByPeriod]    Script Date: 12/22/2010 09:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].Months
AS
SELECT 1 as MonthNumber, 'Январь' as MonthName
UNION
SELECT 2, 'Февраль'
UNION
SELECT 3, 'Март'
UNION
SELECT 4, 'Апрель'
UNION
SELECT 5, 'Май'
UNION
SELECT 6, 'Июнь'
UNION
SELECT 7, 'Июль'
UNION
SELECT 8, 'Август'
UNION
SELECT 9, 'Сентябрь'
UNION
SELECT 10, 'Октябрь'
UNION
SELECT 11, 'Ноябрь'
UNION
SELECT 12, 'Декабрь'

GO

GO

--select * from [dbo].[GetAverageNumEmpl](2011, 64, 1)
--select * from [dbo].[GetFactStaffForTimeSheet]('1.1.2011', '31.1.2011') where idDepartment=18 order by idEmployee


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
	FinancingSourceOrderBy INT  
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
	
	INSERT INTO @DepTable	--текущий отдел
		SELECT @idDepartment, 0, DepartmentSmallName
		FROM Department
		WHERE id=@idDepartment
		
	IF (@WithSubDeps = 1)	--если с подотделами
		INSERT INTO @DepTable
		SELECT idDepartment, 1, 'Подчиненные отделы'
		FROM [dbo].[GetSubDepartments](@idDepartment)
		
	
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
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy
	FROM TimeSheet, dbo.TimeSheetFSWorkingDays, dbo.WorkType,
		[dbo].[GetFactStaffForTimeSheet](@DateBegin, @DateEnd) PeriodStaff, Months, 
		@DepTable as DepList,dbo.FactStaff,
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
		Category.OrderBy, FinancingSourceName, FinancingSource.OrderBy
	ORDER BY IsSubDep, TimeSheetMonth, WorkSuperTypeShortName, Category.OrderBy
 
	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd

END
		
RETURN
END

go


