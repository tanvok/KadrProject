USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPostStaffChangesByPeriod]    Script Date: 01/18/2012 09:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].[GetPostStaffChangesByPeriod](1,'20.01.2011','20.02.2012',1) order by DepartmentName OperationDate where idPlanStaff=1066
--Процедура возвращает все изменения в штатном расписании, произошедшие за период
ALTER FUNCTION [dbo].[GetPostStaffChangesByPeriod] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
	DepartmentName			VARCHAR(150),
	OperationName			VARCHAR(50),
 	OperationDate			date,
    StaffCount				DECIMAL(10,2),
    FinancingSourceName		VARCHAR(50),
    PostName				VARCHAR(150) NULL,
	CategoryName			VARCHAR(50),
    PKCategoryName			VARCHAR(50),
	SalarySize				DECIMAL(10,2),
	OperationPrikazName		VARCHAR(50),
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	--idReplacementReason	INT,						--причина замещения	 			
	idPlanStaff				INT,
	PredStaffCount			DECIMAL(10,2)
	
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
    idDepartment	INT NULL,
    IsMain			BIT
	)
	
		
	IF (@WithSubDeps = 1)	--если с подотделами
		INSERT INTO @DepTable
		SELECT idDepartment, IsMain
		FROM [dbo].[GetSubDepartments](@idDepartment)
		
	ELSE
		INSERT INTO @DepTable	--текущий отдел
			SELECT @idDepartment, 1


	INSERT INTO @Result
	select Department.DepartmentSmallName, OperationName, CONVERT(date, OperationDate),
		StaffCount, FinancingSourceName, PostName,
		CategorySmallName, CONVERT(VARCHAR(3),GroupNumber)+' '+CONVERT(VARCHAR(3),PKCategoryNumber) PKCategoryName, SalarySize, 
		PrikazName+' от '+CONVERT(VARCHAR(10),CONVERT(Date,DatePrikaz)) OperationPrikazName, 
		@PeriodBegin, @PeriodEnd, PlanStaffHistory.id, PredStaffCount
		from 
		@DepTable deps 
		INNER JOIN dbo.Department ON deps.idDepartment=Department.id
		INNER JOIN (SELECT PlanStaffWithHistory.id, PlanStaffWithHistory.idDepartment,  
					(PlanStaffWithHistory.StaffCount-ISNULL(PredPlanStaffHistoryChanges.StaffCount,0)) as StaffCount,
					PlanStaffWithHistory.idPost, PlanStaffWithHistory.idBeginPrikaz idOperationPrikaz,
					PlanStaffWithHistory.idFinancingSource, PlanStaffWithHistory.DateBegin OperationDate,
					PredPlanStaffHistoryChanges.StaffCount PredStaffCount, 
					'Добавление' OperationName --добавление ставок
				FROM dbo.PlanStaffWithHistory  
					LEFT JOIN
					dbo.PlanStaffWithHistory AS PredPlanStaffHistoryChanges ON PlanStaffWithHistory.id=PredPlanStaffHistoryChanges.id--PlanStaff 
						AND PlanStaffWithHistory.DateBegin >
							PredPlanStaffHistoryChanges.DateBegin
						AND PredPlanStaffHistoryChanges.DateBegin =
							(SELECT MAX(PrevPlanStaffHistoryChanges.DateBegin) FROM dbo.PlanStaffWithHistory PrevPlanStaffHistoryChanges 
								WHERE PrevPlanStaffHistoryChanges.id=PlanStaffWithHistory.id
									AND PrevPlanStaffHistoryChanges.DateBegin<PlanStaffWithHistory.DateBegin)
				WHERE 
					PlanStaffWithHistory.DateBegin >= @PeriodBegin AND PlanStaffWithHistory.DateBegin <= @PeriodEnd
			UNION
				--отмена ставок
				SELECT PlanStaffWithHistory.id, PlanStaffWithHistory.idDepartment,  
					(PredPlanStaffHistoryChanges.StaffCount) as StaffCount,
					PlanStaffWithHistory.idPost, PlanStaffWithHistory.idEndPrikaz idOperationPrikaz,
					PlanStaffWithHistory.idFinancingSource, PlanStaffWithHistory.DateEnd OperationDate,
					PredPlanStaffHistoryChanges.StaffCount PredStaffCount, 'Вывод штатов' OperationName --добавление ставок
				FROM dbo.PlanStaff PlanStaffWithHistory
				INNER JOIN
					dbo.PlanStaffWithHistory AS PredPlanStaffHistoryChanges 
						ON PlanStaffWithHistory.id=PredPlanStaffHistoryChanges.id 
						AND PredPlanStaffHistoryChanges.DateBegin = 
							(SELECT MAX(PlanStaffWithHistory.DateBegin) 
								FROM dbo.PlanStaffWithHistory WHERE PlanStaffWithHistory.id=PredPlanStaffHistoryChanges.id) 
				WHERE 
					PlanStaffWithHistory.DateEnd >= @PeriodBegin AND PlanStaffWithHistory.DateEnd <= @PeriodEnd)PlanStaffHistory
			ON deps.idDepartment=PlanStaffHistory.idDepartment	
		INNER JOIN dbo.Post ON PlanStaffHistory.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.PKCategory ON Post.idPKCategory=PKCategory.id
		INNER JOIN dbo.PKGroup ON PKCategory.idPKGroup=PKGroup.id
		INNER JOIN dbo.FinancingSource ON PlanStaffHistory.idFinancingSource=FinancingSource.id
		INNER JOIN dbo.Prikaz ON PlanStaffHistory.idOperationPrikaz=Prikaz.id
		LEFT JOIN
		[dbo].[GetSalaryByPeriod](@PeriodBegin,@PeriodEnd)Salary
		ON PlanStaffHistory.id=Salary.idPlanStaff		
		
		UPDATE @Result
		SET OperationName='Уменьшение', StaffCount=-StaffCount
		WHERE StaffCount<0
		
		UPDATE @Result
		SET OperationName='Ввод штатов'
		WHERE PredStaffCount IS NULL

	RETURN
	

		  
		  
RETURN
END
