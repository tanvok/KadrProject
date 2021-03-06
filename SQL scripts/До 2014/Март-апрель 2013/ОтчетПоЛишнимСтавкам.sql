USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetRecruitedFactStaffByPeriod]    Script Date: 23.03.2013 11:12:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].[GetStaffsErrorsByPeriod](1,'20.01.2012','20.10.2012',1)where idPlanStaff=1066
--Возвращает все переполнения ставок за период
ALTER FUNCTION [dbo].[GetStaffsErrorsByPeriod] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
    DepartmentName VARCHAR(200), 
	PostName VARCHAR(150),
	idDepartment INT,
	idPlanStaff INT,
	BeginPlanStaffCount NUMERIC(6,4),
	BeginFactStaffCount NUMERIC(6,4),
	EndPlanStaffCount  NUMERIC(6,4),
	EndFactStaffCount  NUMERIC(6,4)
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
	RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)
	
	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL
	)
	
	IF (@WithSubDeps = 1)	--подотделы
		INSERT INTO @DepTable
		SELECT idDepartment
		FROM [dbo].[GetSubDepartments](@idDepartment)	--без менеджеров
	ELSE	--текущий отдел
	INSERT INTO @DepTable	--текущий отдел
		SELECT @idDepartment	




	INSERT INTO @Result
	SELECT ISNULL(BeginPeriodData.DepartmentName, EndPeriodData.DepartmentName) DepartmentName, 
			ISNULL(BeginPeriodData.PostName, EndPeriodData.PostName) PostName,
			ISNULL(BeginPeriodData.idDepartment, EndPeriodData.idDepartment) idDepartment,
			ISNULL(BeginPeriodData.idPlanStaff, EndPeriodData.idPlanStaff) idPlanStaff,
			BeginPeriodData.StaffCount as BeginPlanStaffCount,
			BeginPeriodData.FactStaffCount as BeginFactStaffCount,
			EndPeriodData.StaffCount as EndPlanStaffCount,
			EndPeriodData.FactStaffCount as EndFactStaffCount
	FROM  						
	(SELECT Department.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.idPlanStaff, PlanStaff.StaffCount, SUM(FactStaff.StaffCount) FactStaffCount
		FROM 
		@DepTable deps INNER JOIN
		[dbo].[GetPlanStaffByPeriod](@PeriodBegin,@PeriodBegin) PlanStaff ON deps.idDepartment=PlanStaff.idDepartment
		INNER JOIN 
		[dbo].[GetFactStaffByPeriod](@PeriodBegin,@PeriodBegin)FactStaff
		ON PlanStaff.idPlanStaff=FactStaff.idPlanStaff  
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id  
		GROUP BY Department.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.idPlanStaff, PlanStaff.StaffCount
		HAVING PlanStaff.StaffCount<SUM(FactStaff.StaffCount) )BeginPeriodData
	FULL JOIN
	(SELECT Department.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.idPlanStaff, PlanStaff.StaffCount, SUM(FactStaff.StaffCount) FactStaffCount
		FROM 
		@DepTable deps INNER JOIN
		[dbo].[GetPlanStaffByPeriod](@PeriodEnd,@PeriodEnd) PlanStaff ON deps.idDepartment=PlanStaff.idDepartment
		INNER JOIN 
		[dbo].[GetFactStaffByPeriod](@PeriodEnd,@PeriodEnd)FactStaff
		ON PlanStaff.idPlanStaff=FactStaff.idPlanStaff 
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id 
		GROUP BY Department.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.idPlanStaff, PlanStaff.StaffCount
		HAVING PlanStaff.StaffCount<SUM(FactStaff.StaffCount) )EndPeriodData	
	ON BeginPeriodData.idPlanStaff=EndPeriodData.idPlanStaff
		  
RETURN
END





