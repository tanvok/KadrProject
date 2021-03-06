USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDepartments]    Script Date: 09/15/2011 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetSubDepartmentsWithManagers](19) 
--возвращает подотделы переданного отдела (вместе с переданным отделом) с ФИО менеджеров
alter FUNCTION [dbo].[GetSubDepartmentsWithManagers] 
(
@idManagerDepartment INT
)
RETURNS @Result TABLE
   (
    idDepartment	INT NULL,
	idManagerDepartment		INT,
	idManagerPlanStaff	INT,
    IsMain			BIT
   ) 
AS
BEGIN
	DECLARE @idCurrManagerPlanStaff INT

	--выбираем менеджера для главного отдела
	SELECT @idCurrManagerPlanStaff=[dbo].[GetDepartmentsManager](@idManagerDepartment)
	
	--выбираем непосредственно подчиненные отделы (подчиняются непосредственно отделу)
	INSERT INTO @Result
		SELECT id, idManagerDepartment, ISNULL(idManagerPlanStaff,@idCurrManagerPlanStaff), 0 
			FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		UNION 
		SELECT @idManagerDepartment, @idManagerDepartment, @idCurrManagerPlanStaff, 1
		
		
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	SELECT @idCurrManagerPlanStaff=ISNULL(idManagerPlanStaff, @idCurrManagerPlanStaff) FROM @Result
			WHERE idDepartment=@idManagerDepartment	
	--выбираем вложенные отделы
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @Result
		VALUES(null, @idManagerDepartment, @idCurrManagerPlanStaff, 0)
		
		INSERT INTO @Result
		SELECT id, idManagerDepartment, ISNULL(idManagerPlanStaff,@idCurrManagerPlanStaff), 0
			FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		
		SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
		SELECT @idCurrManagerPlanStaff=ISNULL(idManagerPlanStaff, @idCurrManagerPlanStaff) FROM @Result
			WHERE idDepartment=@idManagerDepartment
	END
	
	DELETE FROM @Result
	WHERE idDepartment IS NULL

RETURN
END

go


go

--select * from [dbo].[GetSubDepartments](1,0) 
--возвращает подотделы переданного отдела (вместе с переданным отделом)
ALTER FUNCTION [dbo].[GetSubDepartments] 
(
@idManagerDepartment INT
)
RETURNS @Result TABLE
   (
    idDepartment	INT NULL,
	idManagerDepartment		INT,
    IsMain			BIT
   ) 
AS
BEGIN
	
	--выбираем непосредственно подчиненные отделы (подчиняются непосредственно отделу)
	INSERT INTO @Result
		SELECT id, idManagerDepartment, 0 
			FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		UNION 
		SELECT @idManagerDepartment, @idManagerDepartment, 1
			
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
		
	--выбираем вложенные отделы
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @Result
		VALUES(null, @idManagerDepartment, 0)
		
		INSERT INTO @Result
		SELECT id, idManagerDepartment, 0
			FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		
		SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	END
	
	DELETE FROM @Result
	WHERE idDepartment IS NULL
		
RETURN
END



