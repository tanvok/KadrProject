USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDepartmentBonusForT3]    Script Date: 03.04.2013 14:38:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SELECT * from [dbo].[GetDepartmentBonusForT3](109, '1.01.2012','2.01.2012',1,4) where BonusTypeName is null
--функция выбора надбавок для формирования отчета по форме Т3 на уровне отдела 
--Настройки: @WithSubDeps - с зависимыми отделами
--обозначение оклада -1
--последовательность столбцов надбавок фиксированное
ALTER FUNCTION [dbo].[GetDepartmentBonusForT3] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT,
@idBonusReport INT
)
RETURNS @Result TABLE
   (
    --TypeWorkName			VARCHAR(50) NULL,
	DepartmentName			VARCHAR(200),
    PKCategoryName			VARCHAR(50),
    FinancingSourceName		VARCHAR(50),
	FinancingSourceLowName	VARCHAR(50),
    PostName				VARCHAR(150) NULL,
    StaffCount				DECIMAL(10,4),
    Salary					DECIMAL(10,2),
    idFactStaff				INT,
    idPlanStaff				INT,
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	StaffCountWithoutReplacement NUMERIC(8,4),	--кол-во ставок без замещений (т.е. если замещение, то эта ставка будет равна 0)
	StaffCountReal			NUMERIC(8,4),				--реальная ставка (т.е. если человека замещают на х ставки, то для замещаемого реальная ставка будет у-х, где у - его ставка  
	idReplacementReason		INT,						--причина замещения	 			
	HasEnvironmentBonus		BIT,
	HasIndivSalary			BIT,
	CategoryName			VARCHAR(50),
	idCategory				INT,
    --FinancingSourceFullName		VARCHAR(50),
	CategoryOrderBy INT,
	FinancingSourceOrderBy INT,
	ManagerBit  BIT,
	BonusSum1				DECIMAL(10,2),
	BonusSum2				DECIMAL(10,2),
	BonusSum3				DECIMAL(10,2),
	BonusSum4				DECIMAL(10,2),
	BonusSum5				DECIMAL(10,2),
	BonusSum6				DECIMAL(10,2),
	BonusSum7				DECIMAL(10,2),
	BonusSum8				DECIMAL(10,2),
	DirectionManagerName	VARCHAR(70)

   ) 
AS
BEGIN
	--если период задан некорректно, выходим
	IF (@PeriodBegin>@PeriodEnd)
		RETURN

	--если такого отчета нет, выходим
	IF NOT EXISTS (SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport)
		RETURN
		
	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)
		
	--объявляем временную таблицу, в которую внесем все надбавки за период
	DECLARE @BonusTable Table
	(
		id INT,
		BonusCount numeric(8,2),
		idBonusType INT,	
		BonusOrderNumber	INT,
		IsStaffRateable	BIT,
		idBonusMeasure INT
	)

	
	--выбираем все надбавки за период
	INSERT INTO @BonusTable(id, BonusCount, idBonusType, BonusOrderNumber, IsStaffRateable, idBonusMeasure)
	SELECT idBonus, PeriodBonus.BonusCount, Bonus.idBonusType, BonusOrderNumber, [BonusType].IsStaffRateable, [BonusType].idBonusMeasure
	FROM [dbo].[GetBonusByPeriod](@PeriodBegin, @PeriodEnd) as PeriodBonus 
		INNER JOIN dbo.Bonus ON PeriodBonus.idBonus=Bonus.id
		INNER JOIN [dbo].[GetReportBonusOrder](@idBonusReport) bonusOrder ON bonusOrder.idBonusType=Bonus.idBonusType
		INNER JOIN [dbo].[BonusType] ON Bonus.idBonusType=[BonusType].id

--объявляем временную таблицу, в которую внесем все ОТДЕЛЫ, по которым нужно вывести данные
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
	idManagerPlanStaff	INT,
	DirectionManagerName	VARCHAR(70)
	)
	
	--заполняем отделы с менеджерами
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND WithManagers = 1)	
	BEGIN
			
		
		IF (@WithSubDeps = 1)	--подотделы
			INSERT INTO @DepTable
				SELECT idDepartment, idManagerPlanStaff, null
				FROM [dbo].[GetSubDepartmentsWithManagers](@idDepartment)	--с менеджерами
		ELSE	--текущий отдел
			INSERT INTO @DepTable	
				SELECT @idDepartment, [dbo].[GetDepartmentsManager](@idDepartment), null
			
		UPDATE 	@DepTable
		SET DirectionManagerName=Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.'
		FROM @DepTable as Deps
			INNER JOIN dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff ON PeriodStaff.idPlanStaff=Deps.idManagerPlanStaff
			INNER JOIN dbo.FactStaff ON PeriodStaff.idFactStaff=FactStaff.id
			INNER JOIN dbo.Employee ON FactStaff.idEmployee=Employee.id
	END
	--без менеджеров
	ELSE	
	BEGIN
		IF (@WithSubDeps = 1)	--подотделы
			INSERT INTO @DepTable
			SELECT idDepartment, null, null
			FROM [dbo].[GetSubDepartments](@idDepartment)	--без менеджеров
		ELSE	--текущий отдел
		INSERT INTO @DepTable	--текущий отдел
			SELECT @idDepartment, null, null	
	END

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
		StaffCount	 NUMERIC(8,4),
		StaffCountWithoutReplacement NUMERIC(8,4),	--кол-во ставок без замещений (т.е. если замещение, то эта ставка будет равна 0)
		StaffCountReal	NUMERIC(8,4),				--реальная ставка (т.е. если человека замещают на х ставки, то для замещаемого реальная ставка будет у-х, где у - его ставка  
		idReplacementReason	INT,								--причина замещения	 	
		IsMain			BIT,							--признак основной должности (та, у которой либо ставка выше, либо основной вид работы
		DateBegin		DATETIME,		--дата принятия на работу (первоначальная)
		DateEnd			DATETIME,		--дата увольнения (если он уволен в данный период)
		HourCount NUMERIC(10,2),
		Salary					DECIMAL(10,2),
		HasIndivSalary  BIT,
		idSalaryKoeff INT,
		DirectionManagerName VARCHAR(70)

	)
	--выбираем свех сотрудников одела за период
	INSERT INTO @StaffTable(idDepartment, idFinancingSource, idTypeWork, idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, 
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason, IsMain, 
		DateBegin, DateEnd, HourCount, Salary, HasIndivSalary, idSalaryKoeff, DirectionManagerName)
	SELECT PeriodStaff.idDepartment, idFinancingSource, PeriodStaff.idTypeWork, idPost, PeriodStaff.idPlanStaff, 
		idFactStaff, PeriodStaff.idEmployee, PeriodStaff.StaffCount, 
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason, IsMain, 
		FactStaff.DateBegin,FactStaff.DateEnd,PeriodStaff.HourCount, SalarySize*ISNULL(SalaryKoeff.[SalaryKoeffc],1), IsIndividual, PeriodStaff.idSalaryKoeff, DirectionManagerName
	FROM dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff 
		INNER JOIN @DepTable as Deps ON PeriodStaff.idDepartment=Deps.idDepartment
		LEFT JOIN [dbo].[GetSalaryByPeriod](@PeriodBegin,@PeriodEnd) PlanStaffsWithSalaries ON PeriodStaff.idPlanStaff=PlanStaffsWithSalaries.idPlanStaff
		LEFT JOIN dbo.[FactStaffMain] FactStaff ON PeriodStaff.idFactStaff=FactStaff.id
		LEFT JOIN [dbo].[SalaryKoeff] ON PeriodStaff.idSalaryKoeff=[SalaryKoeff].id
		
	--Обнуляем DateEnd, если он не в периоде
	UPDATE @StaffTable
	SET DateEnd=NULL
	WHERE DateEnd NOT BETWEEN @PeriodBegin	AND @PeriodEnd
	
	--Удаляем замещения, если это указано в параметрах отчета
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND WithReplacements=0)
		DELETE FROM @StaffTable 
			WHERE idReplacementReason is not null
		

--объявляем временную таблицу для надбавок и их связи с сотрудником
	DECLARE @BonusFactStaff TABLE
   (
		idPlanStaff INT,
		idFactStaff INT,
		StaffCount	 NUMERIC(8,4),
		StaffCountWithoutReplacement NUMERIC(8,4),	--кол-во ставок без замещений (т.е. если замещение, то эта ставка будет равна 0)
		StaffCountReal	NUMERIC(8,4),				--реальная ставка (т.е. если человека замещают на х ставки, то для замещаемого реальная ставка будет у-х, где у - его ставка  
		idReplacementReason	INT,								--причина замещения	 	
		DateBegin		DATETIME,		--дата принятия на работу (первоначальная)
		DateEnd			DATETIME,		--дата увольнения (если он уволен в данный период)
		BonusLevel				VARCHAR(50)  NULL,
		BonusCount				VARCHAR(50) NULL,	--размер надбавки (м.б. задан в %, в руб...)
		BonusSum				DECIMAL(10,2),		--итоговая сумма надбавки (уже с учетом оклада и ставки)
		--AllBonusSum			DECIMAL(10,2),		--реальная сумма надбавки (учитывается для расчета итоговых сумм - учитывает замещения, но не учитывает тех, кого замещают)
		SeverKoeff				INT,
		RayonKoeff				INT,
		idBonusType				INT,
		--HasEnvironmentBonus		BIT,
		ForVacancy				BIT,
		ForEmployee				BIT,
		IsStaffRateable	BIT,
		idBonusMeasure INT,
		Salary DECIMAL(10,2),
		IsVacancy BIT,
		BonusOrderNumber INT
   ) 
   	--итоговый запрос, объединяющий надбавки и сотрудников за период
	INSERT INTO @BonusFactStaff(idPlanStaff, idFactStaff, StaffCount, StaffCountWithoutReplacement, StaffCountReal, 
		idReplacementReason, DateBegin, DateEnd, BonusLevel, BonusCount, BonusSum,	
		SeverKoeff, RayonKoeff, idBonusType, ForVacancy, ForEmployee, IsStaffRateable, idBonusMeasure, Salary, IsVacancy, BonusOrderNumber)
	SELECT idPlanStaff, idFactStaff, StaffCount, StaffCountWithoutReplacement, StaffCountReal, 
		idReplacementReason, DateBegin, DateEnd, BonusLevel, SUM(BonusCount), 0,	
		SeverKoeff, RayonKoeff, idBonusType, ForVacancy, ForEmployee, IsStaffRateable, idBonusMeasure, Salary, IsVacancy, BonusOrderNumber
	FROM
	
	(
	--выбираем надбавки сотрудника (Employee)
	SELECT DISTINCT 'Сотрудник' BonusLevel, 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount as StaffCount,
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason,
		Staff.DateBegin,Staff.DateEnd, 
		NULL ForVacancy,NULL ForEmployee, IsStaffRateable, idBonusMeasure, Staff.Salary, 0 as IsVacancy, BonusOrderNumber
	FROM @BonusTable as Bonus 
		INNER JOIN dbo.BonusEmployee ON Bonus.id=BonusEmployee.idBonus
		INNER JOIN dbo.Employee ON BonusEmployee.idEmployee=Employee.id
		INNER JOIN @StaffTable as Staff ON Staff.idEmployee=BonusEmployee.idEmployee
			AND Staff.IsMain=1
		
		
	--выбираем надбавки записи штатного расписания (FactStaff)	
	UNION
	SELECT 'Распределение штатов', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason,
		Staff.DateBegin,Staff.DateEnd, 
		NULL ForVacancy,NULL ForEmployee, IsStaffRateable, idBonusMeasure, Staff.Salary, 0 as IsVacancy, BonusOrderNumber
	FROM @BonusTable as Bonus
		INNER JOIN  dbo.BonusFactStaff ON Bonus.id=BonusFactStaff.idBonus	
		INNER JOIN @StaffTable as Staff ON BonusFactStaff.idFactStaff=Staff.idFactStaff	
		INNER JOIN dbo.Employee ON Staff.idEmployee=Employee.ID --BonusFactStaff.idEmployee=Employee.id	WHERE 
		
	--выбираем надбавки штатной единицы (planStaff)
	UNION
	SELECT 'Штатное расписание', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason,
		Staff.DateBegin,Staff.DateEnd, 
		ForVacancy, ForEmployee, IsStaffRateable, idBonusMeasure, Staff.Salary, ISNULL(Employee.ID-Employee.ID,1) as IsVacancy, BonusOrderNumber
	FROM @BonusTable as Bonus, dbo.BonusPlanStaff, 
		@StaffTable as Staff left join dbo.Employee on Staff.idEmployee=Employee.ID
	WHERE Bonus.id=BonusPlanStaff.idBonus
		AND BonusPlanStaff.idPlanStaff=Staff.idPlanStaff
	
	--выбираем надбавки должности (Post)	
	UNION
	SELECT 'Должность', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason ,
		Staff.DateBegin,Staff.DateEnd, 
		NULL ForVacancy,NULL ForEmployee, IsStaffRateable, idBonusMeasure, Staff.Salary, ISNULL(Employee.ID-Employee.ID,1) as IsVacancy, BonusOrderNumber
	FROM @BonusTable as Bonus, dbo.BonusPost, @StaffTable as Staff left join dbo.Employee on Staff.idEmployee=Employee.ID
	WHERE Bonus.id=BonusPost.idBonus
		AND BonusPost.idPost=Staff.idPost
	/*
	--выбираем оклад	
	UNION	
	SELECT ISNULL(Employee.LastName+' '+Employee.FirstName+' '+Employee.Otch, 'Вакансия'),'Оклад', 
		null as BonusCount, Staff.idPlanStaff, Staff.idFactStaff, ISNULL(SeverKoeff, 50), ISNULL(RayonKoeff, 30), -1, StaffCount,
		StaffCountWithoutReplacement, StaffCountReal, idReplacementReason,
		Staff.DateBegin,Staff.DateEnd, 
		NULL ForVacancy,NULL ForEmployee, 0, 0
	FROM @StaffTable as Staff 
		left join dbo.Employee on Staff.idEmployee=Employee.ID*/)AllBonus
		
	GROUP BY  idPlanStaff, idFactStaff, StaffCount, StaffCountWithoutReplacement, StaffCountReal, 
		idReplacementReason, DateBegin, DateEnd, BonusLevel, 
		SeverKoeff, RayonKoeff, idBonusType, ForVacancy, ForEmployee, IsStaffRateable, idBonusMeasure, Salary, IsVacancy, BonusOrderNumber


	-- проценты
	UPDATE @BonusFactStaff
	SET BonusSum = CONVERT(DECIMAL(10,2),BonusCount)*Salary/100
	FROM @BonusFactStaff as res
	WHERE idBonusMeasure=1	--проценты

	--рубли
	UPDATE @BonusFactStaff
	SET BonusSum = BonusCount
	FROM @BonusFactStaff as res
	WHERE  idBonusMeasure<>1	--не проценты


	-- в зависимости от ставки
	UPDATE @BonusFactStaff
	SET BonusSum = CONVERT(DECIMAL(8,2),BonusSum*StaffCount)
	FROM @BonusFactStaff as res
	WHERE  IsStaffRateable=1	--зависит от ставки
			
	
	
	--Удаляем надбавки не для сотрудников
	DELETE FROM  @BonusFactStaff 
	WHERE ForEmployee=0 AND IsVacancy=0
	
	--Удаляем надбавки не для "вакансий"
	DELETE FROM  @BonusFactStaff 
	WHERE ForVacancy=0 AND IsVacancy=1




	--итоговый запрос, объединяющий надбавки и сотрудников за период
	INSERT INTO @Result(DepartmentName, PKCategoryName, FinancingSourceName, FinancingSourceLowName, PostName, StaffCount, Salary, idFactStaff, idPlanStaff,
	PeriodBegin, PeriodEnd, StaffCountWithoutReplacement, StaffCountReal, idReplacementReason, --HasEnvironmentBonus,
	HasIndivSalary, CategoryName, idCategory, 
 	CategoryOrderBy, FinancingSourceOrderBy, ManagerBit,
	BonusSum1, BonusSum2, BonusSum3, BonusSum4, BonusSum5, BonusSum6, BonusSum7, BonusSum8, DirectionManagerName)
	SELECT Department.DepartmentName,
			CONVERT(VARCHAR(3),GroupNumber)+' '+CONVERT(VARCHAR(3),PKCategoryNumber)+' '+CONVERT(VARCHAR(3),PKSubCategoryNumber)+' '+ISNULL(CONVERT(VARCHAR(3),[SalaryKoeff].PKSubSubCategoryNumber),''),
			FinancingSourceName, LOWER(FinancingSourceName), [PostName],
			PlanStaff.StaffCount, PlanStaff.Salary, PlanStaff.idFactStaff,  PlanStaff.idPlanStaff, 
			@PeriodBegin, @PeriodEnd, PlanStaff.StaffCountWithoutReplacement, PlanStaff.StaffCountReal, PlanStaff.idReplacementReason, 
			--PlanStaff.HasEnvironmentBonus, 
			PlanStaff.HasIndivSalary,
			CategorySmallName, Post.idCategory,
			Category.OrderBy,FinancingSource.OrderBy, Post.ManagerBit,
			Bonus1.BonusSum, Bonus2.BonusSum, Bonus3.BonusSum, Bonus4.BonusSum, 
			Bonus5.BonusSum, Bonus6.BonusSum, Bonus7.BonusSum, Bonus8.BonusSum, PlanStaff.DirectionManagerName
	FROM
		@StaffTable PlanStaff
	-- ON 
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.PKCategory ON Post.idPKCategory=PKCategory.id
		INNER JOIN dbo.PKGroup ON PKCategory.idPKGroup=PKGroup.id
		INNER JOIN dbo.FinancingSource ON PlanStaff.idFinancingSource=FinancingSource.id
		LEFT JOIN [dbo].[SalaryKoeff] ON PlanStaff.idSalaryKoeff=[SalaryKoeff].id
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=1)Bonus1
			ON Bonus1.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus1.idFactStaff=PlanStaff.idFactStaff or (Bonus1.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=2)Bonus2
			ON Bonus2.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus2.idFactStaff=PlanStaff.idFactStaff or (Bonus2.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=3)Bonus3
			ON Bonus3.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus3.idFactStaff=PlanStaff.idFactStaff or (Bonus3.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=4)Bonus4
			ON Bonus4.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus4.idFactStaff=PlanStaff.idFactStaff or (Bonus4.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=5)Bonus5
			ON Bonus5.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus5.idFactStaff=PlanStaff.idFactStaff or (Bonus5.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=6)Bonus6
			ON Bonus6.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus6.idFactStaff=PlanStaff.idFactStaff or (Bonus6.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=7)Bonus7
			ON Bonus7.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus7.idFactStaff=PlanStaff.idFactStaff or (Bonus7.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		LEFT JOIN (SELECT * FROM @BonusFactStaff WHERE BonusOrderNumber=8)Bonus8
			ON Bonus8.idPlanStaff=PlanStaff.idPlanStaff 
				AND (Bonus8.idFactStaff=PlanStaff.idFactStaff or (Bonus8.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))

	--для индивидуальных окладов ПКГ отмечаем звездочкой
	UPDATE @Result
	SET PKCategoryName = PKCategoryName + '*'
	WHERE HasIndivSalary=1
	
	/*-- не начисляются северные
	UPDATE @Result
	SET SeverKoeff=0, RayonKoeff=0
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND BonusType.HasEnvironmentBonus=0

	--ставку обнуляем для не окладов (чтобы не суммировалась)
	UPDATE @Result
	SET StaffCountWithoutReplacement=0, StaffCount=0
	FROM @Result as res
	WHERE  res.idBonusType is not null*/


		

RETURN
END




