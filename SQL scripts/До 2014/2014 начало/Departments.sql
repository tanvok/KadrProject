USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDepartmentsWithPeriod]    Script Date: 22.01.2014 11:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetSubDepartmentsWithPeriod](1,'08.01.2013','09.09.2013')  order by DepTreeIndex
--возвращает подотделы переданного отдела (вместе с переданным отделом)
ALTER FUNCTION [dbo].[GetSubDepartmentsWithPeriod] 
(
@idManagerDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL
)
RETURNS @Result TABLE
   (
    idDepartment	INT NULL,
	idManagerDepartment		INT,
    IsMain			BIT,
	[DepartmentName] VARCHAR(200),
	[DepartmentSmallName] VARCHAR(50),
	DepNumber				INT,
	DepTreeIndex			VARCHAR(30)
   ) 
AS
BEGIN
	
	DECLARE  @DepTable Table
	(
		[idDepartment]		INT,
		[idManagerDepartment]			INT,
		[DepartmentName] VARCHAR(200),
		[DepartmentSmallName] VARCHAR(50)
	)

	INSERT INTO @DepTable([idDepartment],[idManagerDepartment], DepartmentName,DepartmentSmallName)
	SELECT [idDepartment],[idManagerDepartment], DepartmentName,DepartmentSmallName
	FROM [dbo].[GetDepartmentByPeriod](@PeriodBegin, @PeriodEnd)

	--выбираем непосредственно подчиненные отделы (подчиняются непосредственно отделу)
	INSERT INTO @Result
		SELECT [idDepartment], idManagerDepartment, 0, DepartmentName,DepartmentSmallName, 
			row_number() over(order by DepartmentName),  '1'
			FROM @DepTable WHERE idManagerDepartment=@idManagerDepartment
		UNION 
		SELECT @idManagerDepartment, @idManagerDepartment, 1, DepartmentName,DepartmentSmallName, 0, '0'
			FROM @DepTable WHERE [idDepartment]=@idManagerDepartment
			
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	
	UPDATE @Result
	SET DepNumber=80+DepNumber
	WHERE DepNumber BETWEEN 10 AND 20

	--выбираем вложенные отделы
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @Result
		VALUES(null, @idManagerDepartment, 0,'','',0,'')
		
		INSERT INTO @Result
		SELECT deps.[idDepartment], deps.idManagerDepartment, 0, deps.DepartmentName,deps.DepartmentSmallName
			, row_number() over(order by deps.DepartmentName), CONCAT(mainDep.DepTreeIndex,'.', CONVERT(VARCHAR(2),mainDep.DepNumber)) DepTreeIndex
			FROM @DepTable deps  
				INNER JOIN @Result mainDep ON deps.idManagerDepartment=mainDep.idDepartment  
			WHERE deps.idManagerDepartment=@idManagerDepartment 
		
		UPDATE @Result
		SET DepNumber=80+DepNumber
		WHERE DepNumber BETWEEN 10 AND 20

		SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	END
	
	DELETE FROM @Result
	WHERE idDepartment IS NULL

	UPDATE @Result
		SET DepTreeIndex = DepTreeIndex+'.'+CONVERT(VARCHAR(2),DepNumber)

		
RETURN
END










GO

--select * from [dbo].[GetSubDepartmentsWithManagersWithPeriod](1,'01.01.2013','09.09.2013')   order by DepTreeIndex
--возвращает подотделы переданного отдела (вместе с переданным отделом) с ФИО менеджеров
ALTER FUNCTION [dbo].[GetSubDepartmentsWithManagersWithPeriod] 
(
@idManagerDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL
)
RETURNS @Result TABLE
   (
    idDepartment	INT NULL,
	idManagerDepartment		INT,
	idManagerPlanStaff	INT,
    IsMain			BIT,
	[DepartmentName] VARCHAR(200),
	[DepartmentSmallName] VARCHAR(50),
	DepNumber				INT,
	DepTreeIndex			VARCHAR(30)
   ) 
AS
BEGIN
	DECLARE  @DepTable Table
	(
		[idDepartment]		INT,
		[idManagerDepartment]			INT,
		idManagerPlanStaff INT,
		[DepartmentName] VARCHAR(200),
		[DepartmentSmallName] VARCHAR(50)
	)

	INSERT INTO @DepTable([idDepartment],[idManagerDepartment], idManagerPlanStaff, DepartmentName,DepartmentSmallName)
	SELECT [idDepartment],[idManagerDepartment], idManagerPlanStaff, DepartmentName,DepartmentSmallName
	FROM [dbo].[GetDepartmentByPeriod](@PeriodBegin, @PeriodEnd)

	DECLARE @idCurrManagerPlanStaff INT

	--выбираем менеджера для главного отдела
	SELECT @idCurrManagerPlanStaff=[dbo].[GetDepartmentsManager](@idManagerDepartment)
	
	--выбираем непосредственно подчиненные отделы (подчиняются непосредственно отделу)
	INSERT INTO @Result
		SELECT [idDepartment], idManagerDepartment, ISNULL(idManagerPlanStaff,@idCurrManagerPlanStaff), 
			0, DepartmentName,DepartmentSmallName, 
			row_number() over(order by DepartmentName),  '1'
			FROM @DepTable WHERE idManagerDepartment=@idManagerDepartment
		UNION 
		SELECT @idManagerDepartment, @idManagerDepartment, @idCurrManagerPlanStaff, 
			1, DepartmentName,DepartmentSmallName, 0, '0'
			FROM @DepTable WHERE [idDepartment]=@idManagerDepartment
		
	UPDATE @Result
	SET DepNumber=80+DepNumber
	WHERE DepNumber BETWEEN 10 AND 20
		
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	SELECT @idCurrManagerPlanStaff=ISNULL(idManagerPlanStaff, @idCurrManagerPlanStaff) FROM @Result
			WHERE idDepartment=@idManagerDepartment	
	--выбираем вложенные отделы
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @Result
		VALUES(null, @idManagerDepartment, @idCurrManagerPlanStaff, 0,'','',0,'')
		
		INSERT INTO @Result
		SELECT deps.idDepartment, deps.idManagerDepartment, ISNULL(deps.idManagerPlanStaff,@idCurrManagerPlanStaff), 0, deps.DepartmentName,deps.DepartmentSmallName
			, row_number() over(order by deps.DepartmentName), CONCAT(mainDep.DepTreeIndex,'.', CONVERT(VARCHAR(2),mainDep.DepNumber)) DepTreeIndex
			FROM @DepTable deps
				INNER JOIN @Result mainDep ON deps.idManagerDepartment=mainDep.idDepartment  
			WHERE deps.idManagerDepartment=@idManagerDepartment 
		
		UPDATE @Result
		SET DepNumber=80+DepNumber
		WHERE DepNumber BETWEEN 10 AND 20

		SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
		SELECT @idCurrManagerPlanStaff=ISNULL(idManagerPlanStaff, @idCurrManagerPlanStaff) FROM @Result
			WHERE idDepartment=@idManagerDepartment
	END
	
	DELETE FROM @Result
	WHERE idDepartment IS NULL

	UPDATE @Result
		SET DepTreeIndex = DepTreeIndex+'.'+CONVERT(VARCHAR(2),DepNumber)
RETURN
END





GO
--SELECT * from [dbo].[GetDepartmentDataForReports](25, '1.02.2013','02.28.2013',1,-1) 
--функция выбирает данные отдела для отчета по надбавкам или просто отчета 
--Настройки: @WithSubDeps - с зависимыми отделами, @idBonusReport - код отчета для получения остальных настроек отчета
ALTER FUNCTION [dbo].[GetDepartmentDataForReports] 
(
@idDepartment INT,
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL,
@WithSubDeps BIT,
@idBonusReport		 INT
)
RETURNS @DepTable TABLE
   (
	idDepartment	INT NULL,
	idManagerPlanStaff	INT,
	DirectionManagerName	VARCHAR(70),
    IsMain			BIT  ,
	[DepartmentName] VARCHAR(200),
	[DepartmentSmallName] VARCHAR(50),
	DepTreeIndex			VARCHAR(30)
   ) 
AS
BEGIN
	
	--заполняем отделы с менеджерами
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND WithManagers = 1)	
	BEGIN
		IF (@WithSubDeps = 1)	--подотделы
			INSERT INTO @DepTable
				SELECT idDepartment, idManagerPlanStaff, null, IsMain, DepartmentName,DepartmentSmallName, DepTreeIndex
				FROM [dbo].GetSubDepartmentsWithManagersWithPeriod(@idDepartment, @PeriodBegin, @PeriodEnd)	--с менеджерами
		ELSE	--текущий отдел
			INSERT INTO @DepTable	
				SELECT @idDepartment, [dbo].[GetDepartmentsManager](@idDepartment), null, 1, DepartmentName,DepartmentSmallName, '1'
				FROM [dbo].[Department]
				WHERE [id]=@idDepartment
			
		UPDATE 	@DepTable
		SET DirectionManagerName=EmployeeSmallName
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
			SELECT idDepartment, null, null, IsMain, DepartmentName,DepartmentSmallName, DepTreeIndex
			FROM [dbo].GetSubDepartmentsWithPeriod(@idDepartment, @PeriodBegin, @PeriodEnd)	--без менеджеров
		ELSE	--текущий отдел
		INSERT INTO @DepTable	--текущий отдел
			SELECT @idDepartment, null, null, 1, DepartmentName,DepartmentSmallName, '1'
			FROM [dbo].[Department]
				WHERE [id]=@idDepartment
	END
	RETURN
END