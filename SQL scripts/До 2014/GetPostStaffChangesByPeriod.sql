USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFactStaffChangesByPeriod]    Script Date: 12/30/2011 13:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].[GetPostStaffChangesByPeriod](141,'20.01.2011','20.02.2011',1)where idPlanStaff=1066
CREATE FUNCTION [dbo].[GetPostStaffChangesByPeriod] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT
)
RETURNS @Result TABLE
   (
    TypeWorkName			VARCHAR(50) NULL,
    PKCategoryName			VARCHAR(50),
    FinancingSourceName		VARCHAR(50),
    PostName				VARCHAR(150) NULL,
    EmployeeName			VARCHAR(150) NULL,
    StaffCount				DECIMAL(10,2),
	DepartmentName			VARCHAR(150),
	PeriodBegin				DATETIME,
	PeriodEnd				DATETIME,
	--idReplacementReason	INT,						--причина замещения	 			
	CategoryName			VARCHAR(50),
	OperationName			VARCHAR(50),
	OperationDate			DATETIME,
	OperationPrikazName		VARCHAR(50),
	idPlanStaff				INT,
	SalarySize				money
	
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
	RETURN

	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

	INSERT INTO @Result
	select FactStaffChanges.*, Salary.SalarySize
		from [dbo].[GetFactStaffChangesByPeriod](@idDepartment,@PeriodBegin,@PeriodEnd,@WithSubDeps)FactStaffChanges
		INNER JOIN
		[dbo].[GetSalaryByPeriod](@PeriodBegin,@PeriodEnd)Salary
		ON FactStaffChanges.idPlanStaff=Salary.idPlanStaff
		
	RETURN
	

		  
		  
RETURN
END
