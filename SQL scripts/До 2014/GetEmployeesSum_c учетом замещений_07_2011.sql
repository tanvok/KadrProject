USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetEmployeesSum]    Script Date: 07/15/2011 13:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from Employee where LastName like 'Солдатенков%'
--select * from dbo.GetStaffByPeriod('08.02.2011','30.03.2011') where idEmployee=366
--select * from FactStaffWithHistory where idEmployee=366

--select * from [dbo].[GetEmployeesSum](366,'08.02.2011','30.03.2011') 

ALTER FUNCTION [dbo].[GetEmployeesSum] 
(
@idEmployee INT,
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME
)
RETURNS @Result TABLE
   (
    ReportMainObjectName	VARCHAR(50),
    TypeWorkName			VARCHAR(50) NULL,
    PKCategoryName			VARCHAR(50),
    FinancingSourceName		VARCHAR(50),
    BonusTypeName			VARCHAR(50),
    PostName				VARCHAR(150) NULL,
    EmployeeName			VARCHAR(150) NULL,
    ReplacedEmployeeName	VARCHAR(150) NULL,	--ФИО замещаемого
    BonusLevel				VARCHAR(50)  NULL,
    BonusCount				VARCHAR(50) NULL,
    BonusSum				DECIMAL(8,2),
    AllBonusSum				DECIMAL(8,2),
    StaffCount				DECIMAL(8,2),
    Salary					DECIMAL(8,2),
    idFactStaff				INT,
    idPlanStaff				INT,
    SeverKoeff				INT,
    RayonKoeff				INT,
    NDFLKoeff				INT,
	DepartmentName			VARCHAR(50),
	idBonusType				INT,
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	StaffCountWithoutReplacement			DECIMAL(8,2),	--кол-во ставок без замещений
	idReplacementReason	INT,						--причина замещения	 			
	HasEnvironmentBonus		BIT,
	CategoryName			VARCHAR(50)
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

--объявляем временную таблицу, в которую внесем все надбавки за период
	DECLARE @BonusTable Table
	(
		id INT,
		BonusCount numeric(8,2),
		idBonusType INT
	)

	INSERT INTO @BonusTable(id, BonusCount, idBonusType)
	SELECT idBonus, BonusCount, idBonusType 
	FROM [dbo].[GetBonusByPeriod](@PeriodBegin, @PeriodEnd) as PeriodBonus, dbo.Bonus
	WHERE PeriodBonus.idBonus=Bonus.id


--объявляем временную таблицу, в которую внесем всех сотрудников отдела в периоде
	DECLARE @StaffTable Table
	(
		idDepartment INT,
		idFinancingSource	INT,
		idTypeWork			INT,
		idPost		INT,
		idPlanStaff INT,
		idFactStaff INT,
		idEmployee  INT,
		StaffCount	 NUMERIC(8,2),
		StaffCountWithoutReplacement			DECIMAL(8,2),	--кол-во ставок без замещений
		idReplacementReason	INT,								--причина замещения	 	
		IsMain			BIT							--признак основной должности (та, у которой либо ставка выше, либо основной вид работы
	)

	INSERT INTO @StaffTable(idDepartment, idFinancingSource, idTypeWork, idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, 
		StaffCountWithoutReplacement, idReplacementReason, IsMain)
	SELECT DISTINCT PeriodStaff.idDepartment, idFinancingSource, idTypeWork, idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, 
		StaffCountWithoutReplacement, idReplacementReason, IsMain
	FROM dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff
	WHERE PeriodStaff.idEmployee=@idEmployee


	INSERT INTO @Result(ReportMainObjectName, EmployeeName,BonusLevel,BonusCount, idFactStaff, SeverKoeff, RayonKoeff,
			TypeWorkName, StaffCount, DepartmentName, PostName, idPlanStaff, NDFLKoeff, 
			BonusTypeName, idBonusType, StaffCountWithoutReplacement, PeriodBegin, PeriodEnd, 
			FinancingSourceName, PKCategoryName, HasEnvironmentBonus, CategoryName)
	SELECT Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.',
			Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.' EmployeeName,   AllBonus.BonusLevel, AllBonus.BonusCount, 
			AllBonus.idFactStaff, Employee.SeverKoeff, Employee.RayonKoeff, 
			WorkType.TypeWorkShortName+ISNULL(' ('+FactStaffReplacementReason.ReplacementReasonShortName+')',''), AllBonus.StaffCount, 
			Department.DepartmentSmallName, Post.PostShortName, PlanStaff.idPlanStaff, 13, 
			ISNULL(BonusType.BonusTypeShortName, 'Базовый оклад'), BonusType.id, AllBonus.StaffCountWithoutReplacement,
			@PeriodBegin, @PeriodEnd, FinancingSourceName,
			CONVERT(VARCHAR(3),GroupNumber)+' '+CONVERT(VARCHAR(3),PKCategoryNumber), 
			HasEnvironmentBonus, CategorySmallName
	FROM
	
	(SELECT DISTINCT 'Сотрудник' BonusLevel, BonusCount, Staff.idFactStaff, idBonusType, StaffCountWithoutReplacement, idReplacementReason, Staff.idPlanStaff, StaffCount
	FROM @BonusTable as Bonus, dbo.BonusEmployee, @StaffTable as Staff
	
	WHERE  Bonus.id=BonusEmployee.idBonus
		AND BonusEmployee.idEmployee=@idEmployee
					AND Staff.IsMain=1

		
	UNION
	SELECT DISTINCT 'Распределение штатов', 
		BonusCount, Staff.idFactStaff, idBonusType, StaffCountWithoutReplacement, idReplacementReason, Staff.idPlanStaff , StaffCount
	FROM @BonusTable as Bonus, @StaffTable as Staff, dbo.BonusFactStaff
	
	WHERE Bonus.id=BonusFactStaff.idBonus
		AND Staff.idFactStaff=BonusFactStaff.idFactStaff

	UNION
	SELECT DISTINCT 'Штатное расписание', 
		BonusCount, Staff.idFactStaff, idBonusType, StaffCountWithoutReplacement, idReplacementReason, Staff.idPlanStaff , StaffCount
	FROM @BonusTable as Bonus, @StaffTable as Staff, dbo.BonusPlanStaff
	
	WHERE Bonus.id=BonusPlanStaff.idBonus
		AND BonusPlanStaff.idPlanStaff=Staff.idPlanStaff
		
	UNION
	SELECT DISTINCT 'Должность', 
		BonusCount, Staff.idFactStaff, idBonusType, StaffCountWithoutReplacement, idReplacementReason, Staff.idPlanStaff , StaffCount
	FROM @BonusTable as Bonus, @StaffTable as Staff, dbo.BonusPost
	
	WHERE Bonus.id=BonusPost.idBonus
		AND BonusPost.idPost=Staff.idPost
		
	UNION
	SELECT DISTINCT 'Оклад', 
		null, Staff.idFactStaff, null, StaffCountWithoutReplacement, idReplacementReason, Staff.idPlanStaff, StaffCount 
	FROM @StaffTable as Staff
	
		)AllBonus
			
		INNER JOIN dbo.Employee ON Employee.id=@idEmployee	
		INNER JOIN @StaffTable PlanStaff ON AllBonus.idPlanStaff=PlanStaff.idPlanStaff 
			AND (AllBonus.idFactStaff=PlanStaff.idFactStaff )
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.PKCategory ON Post.idPKCategory=PKCategory.id
		INNER JOIN dbo.PKGroup ON PKCategory.idPKGroup=PKGroup.id
		INNER JOIN dbo.FinancingSource ON PlanStaff.idFinancingSource=FinancingSource.id
		LEFT JOIN dbo.BonusType ON AllBonus.idBonusType=BonusType.id
		--LEFT JOIN dbo.FactStaffWithHistory FactStaff ON AllBonus.idFactStaff=FactStaff.id
		LEFT JOIN dbo.WorkType ON PlanStaff.idTypeWork=WorkType.id
		LEFT JOIN dbo.FactStaffReplacementReason
			ON AllBonus.idReplacementReason=FactStaffReplacementReason.id

			
		--dbo.FactStaff, dbo.WorkType, dbo.PlanStaff, dbo.Department, 
		--dbo.Post, dbo.Category, dbo.PKCategory, dbo.PKGroup, dbo.BonusType,
		--dbo.Employee, dbo.FinancingSource
	--WHERE AllBonus.idFactStaff=FactStaff.id
	--	AND FactStaff.idTypeWork=WorkType.id
	--	AND FactStaff.idPlanStaff=PlanStaff.id
	--	AND PlanStaff.idDepartment=Department.id
	--	AND PlanStaff.idPost=Post.id
	--	AND PlanStaff.idCategory=Category.id
	--	AND Post.idPKCategory=PKCategory.id
	--	AND PKCategory.idPKGroup=PKGroup.id
	--	AND AllBonus.idBonusType=BonusType.id
	--	AND Employee.id=idEmployee
	--	AND PlanStaff.idFinancingSource=FinancingSource.id
	ORDER BY --Department.DepartmentSmallName, 
		Category.OrderBy, PKGroup.GroupNumber desc, 
		PKCategory.PKCategoryNumber desc, EmployeeName


		

	
		
	--размер оклада (независимо от ставки)
	UPDATE @Result
	SET Salary = SalarySize
	FROM @Result as res, [dbo].[GetSalaryByPeriod](@PeriodBegin,@PeriodEnd) PlanStaffsWithSalaries
	WHERE  res.idPlanStaff=PlanStaffsWithSalaries.idPlanStaff
			
			

	-- проценты
	UPDATE @Result
	SET BonusSum = CONVERT(DECIMAL(10,2),BonusCount)*Salary/100, 
		AllBonusSum=CONVERT(DECIMAL(10,2),BonusCount)*Salary/100
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND idBonusMeasure=1	--проценты

	--рубли
	UPDATE @Result
	SET BonusSum = BonusCount, AllBonusSum = BonusCount
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND idBonusMeasure<>1	--не проценты


	-- в зависимости от ставки
	UPDATE @Result
	SET BonusSum = CONVERT(DECIMAL(8,2),BonusSum*StaffCount)
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND IsStaffRateable=1	--зависит от ставки
			
		
	-- не начисляются северные
	UPDATE @Result
	SET SeverKoeff=0, RayonKoeff=0
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND BonusType.HasEnvironmentBonus=0

	UPDATE @Result 
	SET BonusSum = Salary*StaffCount
	WHERE idBonusType is null
	
	UPDATE @Result
	SET AllBonusSum = BonusSum, BonusCount=BonusCount+' '+BonusMeasure.Sign
	FROM @Result as res, dbo.BonusType, dbo.BonusMeasure
	WHERE  res.idBonusType = BonusType.id
		AND BonusType.idBonusMeasure=BonusMeasure.id

	UPDATE @Result
	SET StaffCountWithoutReplacement=0
	WHERE	idBonusType IS NOT NULL

/*
	--если cеверные накручиваются
	UPDATE @Result
	SET AllBonusSum = CONVERT(DECIMAL(8,2), BonusSum*(100+SeverKoeff+RayonKoeff)/100)
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND HasEnvironmentBonus=1	--северные*/
			
		
 
		
RETURN
END


