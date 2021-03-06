USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAverageSums]    Script Date: 10.04.2014 11:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--
--select TimeSheetMonth, Department.[DepartmentName], Post.PostName, Employee.EmployeeName, StaffAverage,TimeSheetHourCount,PersonCount
-- from [dbo].[GetAverageSums](2014, 1, 1)aver inner join
--dbo.Employee ON aver.idEmployee=Employee.id inner join
--dbo.FactStaff on aver.idFactStaff=FactStaff.id inner join
--dbo.PlanStaff on FactStaff.idPlanStaff=PlanStaff.id inner join
--dbo.Post on aver.idPost=Post.id inner join
--dbo.Department on PlanStaff.idDepartment=Department.id
--order by  TimeSheetMonth, Employee.EmployeeName


ALTER FUNCTION [dbo].[GetAverageSums] 
(
@Year	INT,
@idDepartment	INT,
@WithSubDeps BIT
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
	idEmployee INT
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
		SELECT idDepartment, 0, @DepName
			FROM dbo.[GetDepartmentDataForReports](@idDepartment, '01.01.'+CONVERT(VARCHAR(4),@Year) , DATEADD(dd,-1,'01.01.'+CONVERT(VARCHAR(4),@Year+1)), @WithSubDeps,-1)	
	

	
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
	INSERT INTO @Result(DepartmentName,IsSubDep,TimeSheetYear,TimeSheetMonth,
		StaffAverage,FreeStaffAverage,TimeSheetHourCount,PersonCount, idTypeWork,
		idPost, idFactStaff, idFinancingSource,idEmployee)
	SELECT DepartmentName, IsSubDep, TimeSheetYear, TimeSheetMonth, 
		SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		SUM(TimeSheetFSWorkingDays.StaffCount*(TimeSheetWorkingDayCount-WorkingDaysCount))/TimeSheetWorkingDayCount,
		ISNULL(TimeSheetWorkingHourCount,0)*SUM(TimeSheetFSWorkingDays.StaffCount*WorkingDaysCount)/TimeSheetWorkingDayCount,
		/*MAX(CONVERT(FLOAT,PeriodStaff.daysCount)/CONVERT(FLOAT,@TimeSheetWorkingDayCount))*/1,PeriodStaff.idTypeWork,
		idPost, PeriodStaff.idFactStaff, idFinancingSource, FactStaff.idEmployee		  
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
		idPost, PeriodStaff.idFactStaff, idFinancingSource, FactStaff.idEmployee
 
	UPDATE @Result
	SET PersonCount=0
	FROM @Result res
	GROUP BY idEmployee 
	HAVING 

	FETCH NEXT FROM TimeSheetCursor INTO @idTimeSheet, @DateBegin, @DateEnd, @TimeSheetWorkingDayCount

END
		
RETURN
END


