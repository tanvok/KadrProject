USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStaffErrorsByPeriod]    Script Date: 09.07.2014 10:43:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].[GetStaffErrorsByPeriod](1,'7.08.2014','7.12.2014',1)where idPlanStaff=1066
--Возвращает все переполнения ставок за период
ALTER FUNCTION [dbo].[GetStaffErrorsByPeriod] 
(
@idDepartment INT,
@PeriodBegin	DATE=NULL,
@PeriodEnd	DATE=NULL,
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
	
	--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
	DepartmentName VARCHAR(200)
	)
	
	INSERT INTO @DepTable	
	SELECT idDepartment, DepartmentName
			FROM dbo.[GetDepartmentDataForReports](@idDepartment, @PeriodBegin, @PeriodEnd, @WithSubDeps,-1)


	INSERT INTO @Result
	SELECT ISNULL(BeginPeriodData.DepartmentName, EndPeriodData.DepartmentName) DepartmentName, 
			ISNULL(BeginPeriodData.PostName, EndPeriodData.PostName) PostName,
			ISNULL(BeginPeriodData.idDepartment, EndPeriodData.idDepartment) idDepartment,
			ISNULL(BeginPeriodData.id, EndPeriodData.id) idPlanStaff,
			BeginPeriodData.StaffCount as BeginPlanStaffCount,
			BeginPeriodData.FactStaffCount as BeginFactStaffCount,
			EndPeriodData.StaffCount as EndPlanStaffCount,
			EndPeriodData.FactStaffCount as EndFactStaffCount
	FROM  						
	(SELECT deps.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.id, CurrentPlanStaff.StaffCount, SUM(FactStaff.StaffCount) FactStaffCount
		FROM 
		@DepTable deps INNER JOIN
		[dbo].[PlanStaffCurrent] PlanStaff ON deps.idDepartment=PlanStaff.idDepartment
		INNER JOIN 
		[dbo].[GetFactStaffByPeriod](@PeriodBegin,@PeriodBegin)FactStaff
		ON PlanStaff.id=FactStaff.idPlanStaff AND FactStaff.IsReplacement=0 AND
			idFactStaff NOT IN (SELECT [idFactStaff] FROM [dbo].[FactStaffReplacement] WHERE [DateEnd] > @PeriodBegin)
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id 
		LEFT JOIN
		[dbo].[GetPlanStaffByPeriod](@PeriodBegin,@PeriodBegin) CurrentPlanStaff ON PlanStaff.id=CurrentPlanStaff.idPlanStaff 
		GROUP BY deps.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.id, CurrentPlanStaff.StaffCount
		HAVING ISNULL(CurrentPlanStaff.StaffCount,0)<SUM(FactStaff.StaffCount) )BeginPeriodData
	FULL JOIN
	(SELECT deps.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.id, CurrentPlanStaff.StaffCount, SUM(FactStaff.StaffCount) FactStaffCount
		FROM 
		@DepTable deps INNER JOIN
		[dbo].[PlanStaffCurrent] PlanStaff ON deps.idDepartment=PlanStaff.idDepartment
		INNER JOIN 
		[dbo].[GetFactStaffByPeriod](@PeriodEnd,@PeriodEnd)FactStaff
		ON PlanStaff.id=FactStaff.idPlanStaff AND FactStaff.IsReplacement=0 AND
			idFactStaff NOT IN (SELECT [idFactStaff] FROM [dbo].[FactStaffReplacement] WHERE [DateEnd] > @PeriodBegin)
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id 
		LEFT JOIN
		[dbo].[GetPlanStaffByPeriod](@PeriodBegin,@PeriodBegin) CurrentPlanStaff ON PlanStaff.id=CurrentPlanStaff.idPlanStaff 
		GROUP BY deps.DepartmentName, Post.PostName, PlanStaff.idDepartment, PlanStaff.id, CurrentPlanStaff.StaffCount
		HAVING ISNULL(CurrentPlanStaff.StaffCount,0)<SUM(FactStaff.StaffCount) )EndPeriodData	
	ON BeginPeriodData.id=EndPeriodData.id
		  
RETURN
END





