USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDepartmentStaff]    Script Date: 28.08.2013 11:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetDepartmentStaff](1, '30.07.2013','30.08.2013',1) where DepartmentName  like '%ремонту%' 
ALTER FUNCTION [dbo].[GetDepartmentStaff] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
    PostName				VARCHAR(150) NULL,
    PKCategoryName			VARCHAR(150) NULL,
    CategoryName			VARCHAR(50)  NULL,
    FinancingSourceName		VARCHAR(50)  NULL,
    factStaffCount			decimal(12,4) NULL,
    EmplName				VARCHAR(150) NULL,
    TypeWorkName			VARCHAR(150) NULL,
    DepartmentName			VARCHAR(200) NULL,
    PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	StaffCountWithoutReplacement			DECIMAL(12,4),
	idPlanStaff				INT,
    EmplFullName				VARCHAR(250) NULL,
    EmplSid					VARBINARY(85),
    idEmployee int,
    idPost		INT,
    ManagerBit BIT,
    idFactStaff INT,
    EmployeeLogin		NVARCHAR(128),
    DepartmentGUID UNIQUEIDENTIFIER,
    EmployeeGUID UNIQUEIDENTIFIER,
    IsMain BIT,
    MatOtpusk VARCHAR(10),
	idDepartment int
	
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
		FROM [dbo].GetSubDepartmentsWithPeriod(@idDepartment, @PeriodBegin, @PeriodEnd)
	ELSE
		INSERT INTO @DepTable	--текущий отдел
			SELECT @idDepartment, 1
	
		
			
	INSERT INTO @Result
	SELECT PostName, PKCategory.PKCategoryFullName as PKCategoryName,
		CategorySmallName, FinancingSourceName, PeriodStaff.StaffCount, 
		ISNULL(EmployeeSmallName,'Вакансия') as EmplName,
		WorkType.TypeWorkShortName + IsNull(' ('+FactStaffReplacementReason.ReplacementReasonShortName+')', '') TypeWorkName, 
		Department.DepartmentName,@PeriodBegin, @PeriodEnd, 
		StaffCountWithoutReplacement, PeriodStaff.idPlanStaff,
		ISNULL(EmployeeName,'Вакансия'), 
		EmployeeSid, Employee.id, Post.id, Post.ManagerBit, PeriodStaff.idFactStaff, EmployeeLogin
		, DepartmentGUID, GUID, WorkType.IsMain, otpusk.otpTypeShortName,
		Deps.idDepartment
	FROM  
		  dbo.GetStaffByPeriod(@PeriodBegin,@PeriodEnd) as PeriodStaff INNER JOIN
		  @DepTable as Deps ON PeriodStaff.idDepartment=Deps.idDepartment INNER JOIN
		  dbo.Post ON PeriodStaff.idPost=Post.id inner join
		  dbo.Department ON Deps.idDepartment=Department.id INNER JOIN 
		  dbo.FullPKCategory PKCategory ON Post.idPKCategory=PKCategory.id INNER JOIN
		  dbo.FinancingSource ON PeriodStaff.idFinancingSource = dbo.FinancingSource.id INNER JOIN
          dbo.Category ON Post.idCategory = dbo.Category.id LEFT JOIN
          dbo.WorkType ON PeriodStaff.idTypeWork = dbo.WorkType.id LEFT JOIN
          dbo.Employee ON PeriodStaff.idEmployee = dbo.Employee.id LEFT JOIN
          dbo.FactStaffReplacementReason ON PeriodStaff.idReplacementReason=FactStaffReplacementReason.id LEFT JOIN
          [dbo].[GetOtpuskByPeriod](@PeriodBegin,@PeriodEnd) otpusk 
			ON PeriodStaff.idFactStaff=otpusk.idFactStaff AND otpusk.isMaternity=1 LEFT JOIN 
		  [dbo].[SalaryKoeff] ON PeriodStaff.idSalaryKoeff=[SalaryKoeff].id
	order by Deps.Ismain desc, Department.DepartmentName, FinancingSource.OrderBy, Category.OrderBy, PKCategoryName desc, PostName, EmplName
	
	UPDATE @Result
	SET PKCategoryName=PKCategoryName+'*'
	WHERE idPlanStaff IN (SELECT idPlanStaff FROM dbo.GetIndivSalaryByPeriod(@PeriodBegin,@PeriodEnd))
RETURN
END

