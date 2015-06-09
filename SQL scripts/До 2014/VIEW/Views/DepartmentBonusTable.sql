use Kadr
GO

--CREATE type dbo.DepListParam AS TABLE(idDepartment integer)


go

--select * from [dbo].[GetDepartmentBonus](143, '1.02.2011','28.02.2011',1) 
alter FUNCTION [dbo].[GetTableDepartmentBonus] 
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
	HasEnvironmentBonus		BIT		
	
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
    idDepartment	INT NULL
	)
	
	INSERT INTO @DepTable	--������� �����
		SELECT @idDepartment
		
	IF (@WithSubDeps = 1)	--���� � �����������
		INSERT INTO @DepTable
		SELECT idDepartment
		FROM [dbo].[GetSubDepartments](@idDepartment)
		
--��������� ��������� �������, � ������� ������ ���� ����������� ������ � �������
	DECLARE @StaffTable Table
	(
		idPost		INT,
		idPlanStaff INT,
		idFactStaff INT,
		idEmployee  INT,
		StaffCount	 NUMERIC(8,2),
		StaffCountWithoutReplacement			DECIMAL(8,2),	--���-�� ������ ��� ���������
		idReplacementReason	INT						--������� ���������	 	
	)

	INSERT INTO @StaffTable(idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, StaffCountWithoutReplacement, idReplacementReason)
	SELECT idPost, idPlanStaff, idFactStaff, idEmployee, StaffCount, StaffCountWithoutReplacement, idReplacementReason
	FROM dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff, @DepTable as Deps
	WHERE PeriodStaff.idDepartment=Deps.idDepartment
		

	INSERT INTO @Result(ReportMainObjectName, EmployeeName, BonusLevel, BonusCount, idFactStaff, SeverKoeff, RayonKoeff,
			TypeWorkName, StaffCount, DepartmentName, PostName, idPlanStaff, NDFLKoeff, 
			BonusTypeName, idBonusType, FinancingSourceName, PKCategoryName,
			PeriodBegin, PeriodEnd, StaffCountWithoutReplacement, idReplacementReason, 
			HasEnvironmentBonus)
	SELECT Department.DepartmentName, AllBonus.EmployeeName, AllBonus.BonusLevel, AllBonus.BonusCount, 
			AllBonus.idFactStaff, AllBonus.SeverKoeff, AllBonus.RayonKoeff, 
			WorkType.TypeWorkShortName+ISNULL(' ('+FactStaffReplacementReason.ReplacementReasonShortName+')',''), AllBonus.StaffCount, 
			Department.DepartmentSmallName, Post.PostShortName, PlanStaff.id, 13, 
			ISNULL(BonusType.BonusTypeShortName,'������� �����'), BonusType.id, FinancingSourceName,
			CONVERT(VARCHAR(3),GroupNumber)+' '+CONVERT(VARCHAR(3),PKCategoryNumber),
			@PeriodBegin, @PeriodEnd, StaffCountWithoutReplacement, idReplacementReason, 
			HasEnvironmentBonus
	FROM
	
	(SELECT Employee.LastName+' '+CONVERT(VARCHAR(1),Employee.FirstName)+'. '+CONVERT(VARCHAR(1),Employee.Otch)+'.' EmployeeName,'���������' BonusLevel, 
		BonusCount, Staff.idPlanStaff, Staff.idFactStaff, SeverKoeff, RayonKoeff, idBonusType, StaffCount as StaffCount,
		StaffCountWithoutReplacement, idReplacementReason
	FROM @BonusTable as Bonus, dbo.BonusEmployee, dbo.Employee, @StaffTable as Staff
	
	WHERE  Bonus.id=BonusEmployee.idBonus
		AND BonusEmployee.idEmployee=Employee.id
		AND Staff.idEmployee=BonusEmployee.idEmployee
		
		
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
		
		INNER JOIN dbo.PlanStaff ON AllBonus.idPlanStaff=PlanStaff.id
		INNER JOIN dbo.Department ON PlanStaff.idDepartment=Department.id
		INNER JOIN dbo.Post ON PlanStaff.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.PKCategory ON Post.idPKCategory=PKCategory.id
		INNER JOIN dbo.PKGroup ON PKCategory.idPKGroup=PKGroup.id
		INNER JOIN dbo.FinancingSource ON PlanStaff.idFinancingSource=FinancingSource.id
		LEFT JOIN dbo.BonusType ON AllBonus.idBonusType=BonusType.id
		LEFT JOIN dbo.FactStaff ON AllBonus.idFactStaff=FactStaff.id
		LEFT JOIN dbo.WorkType ON FactStaff.idTypeWork=WorkType.id
		LEFT JOIN dbo.FactStaffReplacementReason
			ON AllBonus.idReplacementReason=FactStaffReplacementReason.id
	ORDER BY Department.DepartmentSmallName, Category.OrderBy, PKGroup.GroupNumber desc, 
		PKCategory.PKCategoryNumber desc, Post.PostShortName, FinancingSource.OrderBy, EmployeeName, AllBonus.idBonusType


		
	-- �����
	UPDATE @Result
	SET Salary = SalarySize*StaffCount
	FROM @Result as res, dbo.PlanStaffsWithSalaries
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






