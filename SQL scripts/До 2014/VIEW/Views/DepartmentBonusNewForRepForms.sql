USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDepartmentBonus]    Script Date: 05/11/2011 10:28:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetDepartmentBonus](19, '1.02.2011','15.03.2011',1) 143
ALTER FUNCTION [dbo].[GetDepartmentBonus] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
    ReportMainObjectName	VARCHAR(150),
    TypeWorkName			VARCHAR(50) NULL,
    PKCategoryName			VARCHAR(50),
    FinancingSourceName		VARCHAR(50),
    BonusTypeName			VARCHAR(50),
    PostName				VARCHAR(150) NULL,
    EmployeeName			VARCHAR(150) NULL,
    BonusLevel				VARCHAR(50)  NULL,
    BonusCount				VARCHAR(50) NULL,
    BonusSum				DECIMAL(10,2),
    AllBonusSum				DECIMAL(10,2),
    StaffCount				DECIMAL(10,2),
    Salary					DECIMAL(10,2),
    idFactStaff				INT,
    idPlanStaff				INT,
    SeverKoeff				INT,
    RayonKoeff				INT,
    NDFLKoeff				INT,
	DepartmentName			VARCHAR(150),
	idBonusType				INT,
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	StaffCountWithoutReplacement			DECIMAL(10,2),	--���-�� ������ ��� ���������
	idReplacementReason	INT,						--������� ���������	 			
	HasEnvironmentBonus		BIT,
	HasIndivSalary			BIT,
	GlobalPrikazName		VARCHAR(50),
	BonusSuperTypeName		VARCHAR(50),
	CategoryName			VARCHAR(50),
	idCategory				INT,
	WorkSuperTypeName		VARCHAR(50),
	DirectionManagerName	VARCHAR(70)
	
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)
	
--��������� ��������� �������, � ������� ������ ��� �������� �� ������
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


	--DECLARE @WithSubDeps BIT
	--SET @WithSubDeps = 1
	
--��������� ��������� �������, � ������� ������ ��� ������, �� ������� ����� ������� ������
	DECLARE @DepTable Table
	(
    idDepartment	INT NULL,
	idManagerPlanStaff	INT,
	DirectionManagerName	VARCHAR(70)
	)
	
	INSERT INTO @DepTable	--������� �����
		SELECT @idDepartment, [dbo].[GetDepartmentsManager](@idDepartment), null
		
	--���������
	IF (@WithSubDeps = 1)	
		INSERT INTO @DepTable
		SELECT idDepartment, idManagerPlanStaff, null
		FROM [dbo].[GetSubDepartments](@idDepartment)
		
	UPDATE 	@DepTable
	SET DirectionManagerName=Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.'
	FROM @DepTable as Deps, dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff, dbo.FactStaff, dbo.Employee
	WHERE PeriodStaff.idPlanStaff=Deps.idManagerPlanStaff
		AND PeriodStaff.idFactStaff=FactStaff.id
		AND FactStaff.idEmployee=Employee.id

--��������� ��������� �������, � ������� ������ ���� ����������� ������ � �������
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
		StaffCountWithoutReplacement			DECIMAL(8,2),	--���-�� ������ ��� ���������
		idReplacementReason	INT,								--������� ���������	 	
		IsMain			BIT,							--������� �������� ��������� (��, � ������� ���� ������ ����, ���� �������� ��� ������
		DirectionManagerName	VARCHAR(70)
	)

	INSERT INTO @StaffTable(idDepartment, idFinancingSource, idTypeWork, idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, 
		StaffCountWithoutReplacement, idReplacementReason, IsMain, DirectionManagerName)
	SELECT PeriodStaff.idDepartment, idFinancingSource, idTypeWork, idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, 
		StaffCountWithoutReplacement, idReplacementReason, IsMain, DirectionManagerName
	FROM dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff, @DepTable as Deps
	WHERE PeriodStaff.idDepartment=Deps.idDepartment
		

	INSERT INTO @Result(ReportMainObjectName, EmployeeName, BonusLevel, BonusCount, idFactStaff, SeverKoeff, RayonKoeff,
			TypeWorkName, StaffCount, DepartmentName, PostName, idPlanStaff, NDFLKoeff, 
			BonusTypeName, idBonusType, FinancingSourceName, PKCategoryName,
			PeriodBegin, PeriodEnd, StaffCountWithoutReplacement, idReplacementReason, 
			HasEnvironmentBonus, GlobalPrikazName, BonusSuperTypeName, CategoryName, idCategory, WorkSuperTypeName,
			DirectionManagerName)
	SELECT Department.DepartmentName, AllBonus.EmployeeName, AllBonus.BonusLevel, AllBonus.BonusCount, 
			AllBonus.idFactStaff, ISNULL(50, AllBonus.SeverKoeff) ,ISNULL(30, AllBonus.RayonKoeff), 
			WorkType.TypeWorkShortName+ISNULL(' ('+FactStaffReplacementReason.ReplacementReasonShortName+')',''), AllBonus.StaffCount, 
			Department.DepartmentSmallName, Post.PostShortName, PlanStaff.idPlanStaff, 13, 
			ISNULL(BonusType.BonusTypeShortName,'������� �����'), BonusType.id, FinancingSourceName,
			CONVERT(VARCHAR(3),GroupNumber)+' '+CONVERT(VARCHAR(3),PKCategoryNumber),
			@PeriodBegin, @PeriodEnd, AllBonus.StaffCountWithoutReplacement, AllBonus.idReplacementReason, 
			HasEnvironmentBonus, ISNULL(CONVERT(VARCHAR(10), GlobalPrikaz.DateBegin,103),'') +' � '+ ISNULL(GlobalPrikaz.PrikazNumber,'') GlobalPrikazName,
			BonusSuperType.BonusSuperTypeName, CategorySmallName, Post.idCategory,
			ISNULL(WorkSuperTypeShortName,'���.'), DirectionManagerName
	FROM
	
	(SELECT DISTINCT Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.' EmployeeName,'���������' BonusLevel, 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount as StaffCount,
		StaffCountWithoutReplacement, idReplacementReason
	FROM @BonusTable as Bonus, dbo.BonusEmployee, dbo.Employee, @StaffTable as Staff
	
	WHERE  Bonus.id=BonusEmployee.idBonus
		AND BonusEmployee.idEmployee=Employee.id
		AND Staff.idEmployee=BonusEmployee.idEmployee
		AND Staff.IsMain=1
		
		
	UNION
	SELECT Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.', '������������� ������', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, idReplacementReason 
	FROM @BonusTable as Bonus, dbo.BonusFactStaff, @StaffTable as Staff, dbo.Employee
	
	WHERE Bonus.id=BonusFactStaff.idBonus
		AND BonusFactStaff.idFactStaff=Staff.idFactStaff
		AND Staff.idEmployee=Employee.ID

	UNION
	SELECT ISNULL(Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.', '��������'), '������� ����������', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, idReplacementReason
	FROM @BonusTable as Bonus, dbo.BonusPlanStaff, 
		@StaffTable as Staff left join dbo.Employee on Staff.idEmployee=Employee.ID
	
	WHERE Bonus.id=BonusPlanStaff.idBonus
		AND BonusPlanStaff.idPlanStaff=Staff.idPlanStaff
		
	UNION
	SELECT ISNULL(Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.', '��������'),'���������', 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount,
		StaffCountWithoutReplacement, idReplacementReason 
	FROM @BonusTable as Bonus, dbo.BonusPost, @StaffTable as Staff left join dbo.Employee on Staff.idEmployee=Employee.ID
	
	WHERE Bonus.id=BonusPost.idBonus
		AND BonusPost.idPost=Staff.idPost
		
	UNION	--�����
	SELECT ISNULL(Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.', '��������'),'�����', 
		null as BonusCount, Staff.idPlanStaff, Staff.idFactStaff, ISNULL(SeverKoeff, 50), ISNULL(RayonKoeff, 30), null, StaffCount,
		StaffCountWithoutReplacement, idReplacementReason
	FROM @StaffTable as Staff 
		left join dbo.Employee on Staff.idEmployee=Employee.ID)AllBonus
		
		INNER JOIN @StaffTable PlanStaff ON AllBonus.idPlanStaff=PlanStaff.idPlanStaff 
			AND (AllBonus.idFactStaff=PlanStaff.idFactStaff or (AllBonus.idFactStaff IS NULL AND PlanStaff.idFactStaff IS NULL))
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.PKCategory ON Post.idPKCategory=PKCategory.id
		INNER JOIN dbo.PKGroup ON PKCategory.idPKGroup=PKGroup.id
		INNER JOIN dbo.FinancingSource ON PlanStaff.idFinancingSource=FinancingSource.id
		LEFT JOIN dbo.GlobalPrikaz ON Post.idGlobalPrikaz=GlobalPrikaz.id
		LEFT JOIN dbo.BonusType ON AllBonus.idBonusType=BonusType.id
		LEFT JOIN dbo.BonusSuperType ON BonusType.idBonusSuperType=BonusSuperType.id
		--LEFT JOIN dbo.FactStaffWithHistory FactStaff ON AllBonus.idFactStaff=FactStaff.id
		LEFT JOIN dbo.WorkType ON PlanStaff.idTypeWork=WorkType.id
		LEFT JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
		LEFT JOIN dbo.FactStaffReplacementReason
			ON AllBonus.idReplacementReason=FactStaffReplacementReason.id
	ORDER BY Department.DepartmentSmallName, Category.OrderBy, PKGroup.GroupNumber desc, 
		PKCategory.PKCategoryNumber desc, Post.PostShortName, FinancingSource.OrderBy, EmployeeName, AllBonus.idBonusType


	
	UPDATE @Result
	SET BonusSuperTypeName='�� ���������'
	WHERE BonusLevel='���������'
	
	UPDATE @Result
	SET BonusSuperTypeName='�����'
	WHERE BonusLevel='�����'
			
	-- �����
	UPDATE @Result
	SET Salary = SalarySize*StaffCount, HasIndivSalary=IsIndividual
	FROM @Result as res, [dbo].[GetSalaryByPeriod](@PeriodBegin,@PeriodEnd) PlanStaffsWithSalaries
	WHERE  res.idPlanStaff=PlanStaffsWithSalaries.idPlanStaff
			
			

	-- ��������
	UPDATE @Result
	SET BonusSum = CONVERT(DECIMAL(10,2),BonusCount)*Salary/100
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND idBonusMeasure=1	--��������

	--�����
	UPDATE @Result
	SET BonusSum = BonusCount
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND idBonusMeasure<>1	--��������

	--������ �������� ��� �� ������� (����� �� �������������)
	UPDATE @Result
	SET StaffCountWithoutReplacement=0
	FROM @Result as res
	WHERE  res.idBonusType is not null

	-- � ����������� �� ������
	UPDATE @Result
	SET BonusSum = CONVERT(DECIMAL(8,2),BonusSum*StaffCount)
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND IsStaffRateable=1	--��������

	/*--�������� ����������
	UPDATE @Result
	SET StaffCountWithoutReplacement = 0, TypeWorkName=TypeWorkName+' ('+FactStaffReplacementReason.ReplacementReasonShortName+')'
	FROM @Result as res, dbo.FactStaffReplacement, dbo.FactStaffReplacementReason
	WHERE res.idFactStaff= FactStaffReplacement.idFactStaff
		AND FactStaffReplacement.idReplacementReason=FactStaffReplacementReason.id*/

	UPDATE @Result 
	SET BonusSum = Salary
	WHERE idBonusType is null
	
	
	UPDATE @Result
	SET PKCategoryName = PKCategoryName + '*'
	WHERE HasIndivSalary=1
	
		-- �� ����������� ��������
	UPDATE @Result
	SET SeverKoeff=0, RayonKoeff=0
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND BonusType.HasEnvironmentBonus=0


	/*
	--�������� �� �������������
	UPDATE @Result
	SET AllBonusSum = BonusSum, BonusCount=BonusCount+' '+BonusMeasure.Sign
	FROM @Result as res, dbo.BonusType, dbo.BonusMeasure
	WHERE  res.idBonusType = BonusType.id
		AND BonusType.idBonusMeasure=BonusMeasure.id


	--���� c������� �������������
	UPDATE @Result
	SET AllBonusSum = CONVERT(DECIMAL(8,2), BonusSum*(100+SeverKoeff+RayonKoeff)/100)
	FROM @Result as res, dbo.BonusType
	WHERE  res.idBonusType = BonusType.id
			AND HasEnvironmentBonus=1	--��������
	*/		

		

RETURN
END






