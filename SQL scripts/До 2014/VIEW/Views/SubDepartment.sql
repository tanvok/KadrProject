USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDepartments]    Script Date: 05/11/2011 10:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].GetSubDepartmentStaffCounts(1) 
--select * from [dbo].GetSubDepartmentStaffCounts(2)
ALTER FUNCTION [dbo].[GetSubDepartments] 
(
@idManagerDepartment INT
)
RETURNS @Result TABLE
   (
    idDepartment	INT NULL,
	idManagerDepartment		INT
   ) 
AS
BEGIN
	
	INSERT INTO @Result
		SELECT id, idManagerDepartment FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @Result
		VALUES(null, @idManagerDepartment)
		
		INSERT INTO @Result
		SELECT id, idManagerDepartment FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		
		SELECT @idManagerDepartment = MIN(idDepartment) FROM @Result
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @Result)
	END
	
	DELETE FROM @Result
	WHERE idDepartment IS NULL

RETURN
END





