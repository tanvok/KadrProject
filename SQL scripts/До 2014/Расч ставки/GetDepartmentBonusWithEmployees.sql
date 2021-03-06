USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDepartmentBonusWithEmployees]    Script Date: 24.09.2013 11:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetDepartmentBonusWithEmployees](1, '1.09.2013','28.09.2013',1,1)where idPlanStaff=1066
ALTER FUNCTION [dbo].[GetDepartmentBonusWithEmployees] 
(
@idDepartment INT,
@PeriodBegin	DATE=NULL,
@PeriodEnd	DATE=NULL,
@WithSubDeps BIT,
@idBonusReport		 INT
)
RETURNS @Result TABLE
   (
    ReportMainObjectName	VARCHAR(200),
    TypeWorkName			VARCHAR(50) NULL,
    PKCategoryName			VARCHAR(50),
    FinancingSourceName		VARCHAR(50),
    BonusTypeName			VARCHAR(50),
    PostName				VARCHAR(150) NULL,
    EmployeeName			VARCHAR(150) NULL,
    ReplacedEmployeeName	VARCHAR(150) NULL,	--ФИО замещаемого
    BonusLevel				VARCHAR(50)  NULL,
    BonusCount				VARCHAR(50) NULL,	--размер надбавки (м.б. задан в %, в руб...)
    BonusSum				DECIMAL(14,2),		--итоговая сумма надбавки (уже с учетом оклада и ставки)
    AllBonusSum			DECIMAL(14,2),		--реальная сумма надбавки (учитывается для расчета итоговых сумм - учитывает замещения, но не учитывает тех, кого замещают)
    StaffCount				DECIMAL(14,4),
    Salary					DECIMAL(14,2),
    idFactStaff				INT,
    idPlanStaff				INT,
    SeverKoeff				INT,
    RayonKoeff				INT,
    NDFLKoeff				INT,
	DepartmentName			VARCHAR(150),
	idBonusType				INT,
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	StaffCountWithoutReplacement NUMERIC(14,4),	--кол-во ставок без замещений (т.е. если замещение, то эта ставка будет равна 0)
	StaffCountReal	NUMERIC(14,4),				--реальная ставка (т.е. если человека замещают на х ставки, то для замещаемого реальная ставка будет у-х, где у - его ставка  
	idReplacementReason	INT,						--причина замещения	 			
	HasEnvironmentBonus		BIT,
	HasIndivSalary			BIT,
	GlobalPrikazName		VARCHAR(50),
	GlobalPrikazFullName	VARCHAR(50),
	BonusSuperTypeName		VARCHAR(50),
	CategoryName			VARCHAR(50),
	idCategory				INT,
	WorkSuperTypeName		VARCHAR(50),
	DirectionManagerName	VARCHAR(70),
	BonusOrderNumber		INT,
	PostFullName			VARCHAR(150),
	DepartmentFullName		VARCHAR(200),
	DateBegin		VARCHAR(10),		--дата принятия на работу (первоначальная)
	DateEnd			VARCHAR(10),
	ForVacancy				BIT,
	ForEmployee				BIT,
    MatOtpusk VARCHAR(10),
    BonusTypeFullName			VARCHAR(50),
    HourCount NUMERIC(10,2),
    FinancingSourceFullName		VARCHAR(50),
	PostComment VARCHAR(150),
	SalaryKoeff  NUMERIC(14,2),
	PKCategoryFullName VARCHAR(50),
	CategoryOrderBy INT,
	FinancingSourceOrderBy INT,
	ManagerBit  BIT,
	PostTypeName VARCHAR(50),
	PostCode VARCHAR(20),
	BonusFinancingSourceName VARCHAR(50),
	idEmployee INT,
	[idlaborcontrakt] INT,
	EmployeeSmallName VARCHAR(60),
	RankName VARCHAR(50),
	DegreeName VARCHAR(50),
	PrikazDateEnd  VARCHAR(10),
	CalcStaffCount DECIMAL(14,4), --нерасчетное кол-во ставок
	CalcStaffCountWithoutReplacement DECIMAL(14,4)
   ) 

AS
BEGIN
INSERT INTO @Result(ReportMainObjectName, EmployeeName, BonusLevel, BonusCount, idFactStaff, SeverKoeff, RayonKoeff,
			TypeWorkName, StaffCount, DepartmentName, PostName, idPlanStaff, NDFLKoeff, 
			BonusTypeName, BonusTypeFullName, idBonusType, FinancingSourceName, PKCategoryName,
			PeriodBegin, PeriodEnd, StaffCountWithoutReplacement, StaffCountReal, idReplacementReason, 
			HasEnvironmentBonus, GlobalPrikazName, GlobalPrikazFullName, 
			BonusSuperTypeName, CategoryName, idCategory, WorkSuperTypeName,
			DirectionManagerName, ReplacedEmployeeName, BonusOrderNumber, 
			PostFullName, DepartmentFullName,
			DateBegin,DateEnd,BonusSum,AllBonusSum,	
			ForVacancy,ForEmployee, MatOtpusk, HourCount, FinancingSourceFullName, PostComment, SalaryKoeff, PKCategoryFullName,
			CategoryOrderBy,FinancingSourceOrderBy, ManagerBit, PostTypeName, PostCode, Salary, HasIndivSalary,
			BonusFinancingSourceName, idEmployee, [idlaborcontrakt], EmployeeSmallName, RankName, DegreeName, PrikazDateEnd,
			CalcStaffCount,CalcStaffCountWithoutReplacement)
SELECT ReportMainObjectName, EmployeeName, BonusLevel, BonusCount, idFactStaff, SeverKoeff, RayonKoeff,
			TypeWorkName, StaffCount, DepartmentName, PostName, idPlanStaff, NDFLKoeff, 
			BonusTypeName, BonusTypeFullName, idBonusType, FinancingSourceName, PKCategoryName,
			PeriodBegin, PeriodEnd, StaffCountWithoutReplacement, StaffCountReal, idReplacementReason, 
			HasEnvironmentBonus, GlobalPrikazName, GlobalPrikazFullName, 
			BonusSuperTypeName, CategoryName, idCategory, WorkSuperTypeName,
			DirectionManagerName, ReplacedEmployeeName, BonusOrderNumber, 
			PostFullName, DepartmentFullName,
			Employees.DateBegin,Employees.DateEnd,BonusSum,AllBonusSum,	
			ForVacancy,ForEmployee, MatOtpusk, HourCount, FinancingSourceFullName, PostComment, SalaryKoeff, PKCategoryFullName,
			CategoryOrderBy,FinancingSourceOrderBy, ManagerBit, PostTypeName, PostCode, Salary, HasIndivSalary,
			BonusFinancingSourceName, Employees.idEmployee, [idlaborcontrakt], EmployeeSmallName, 
			EmpRank.RankName, EmpDegree.DegreeName, CONVERT(VARCHAR(10),[Prikaz].[DateEnd],104) PrikazDateEnd,
			CalcStaffCount,CalcStaffCountWithoutReplacement
	FROM  [dbo].[GetDepartmentBonusWithSettings](@idDepartment,@PeriodBegin,@PeriodEnd,@WithSubDeps,@idBonusReport, -1)Employees
	LEFT JOIN
		[dbo].[GetRankForEmployees](@PeriodBegin,@PeriodEnd) EmpRank ON Employees.[idEmployee]=EmpRank.[idEmployee]
	LEFT JOIN
		[dbo].[GetDegreesForEmployees](@PeriodBegin,@PeriodEnd) EmpDegree ON Employees.[idEmployee]=EmpDegree.[idEmployee]
	LEFT JOIN
		[dbo].[Prikaz] ON Employees.[idlaborcontrakt]=[Prikaz].id
	
RETURN
END