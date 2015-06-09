USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDepartments]    Script Date: 05/11/2011 10:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [dbo].[GetSubDepartments](19) 
--select   [dbo].[GetDepartmentsManager](309)
--select   [dbo].[GetDepartmentsManager](19)
--��������� ��������� �� �����������
create FUNCTION [dbo].[GetDepartmentsManager] 
(
@idDepartment INT
)
RETURNS INT
AS
BEGIN
	DECLARE @idManagerPlanStaff INT
	SELECT @idManagerPlanStaff=idManagerPlanStaff FROM dbo.Department WHERE id=@idDepartment
	
	--���� "�����" - ����� ���� ��� ���� ��������
	WHILE (@idManagerPlanStaff IS NULL AND @idDepartment IS NOT NULL)
	BEGIN
		SELECT @idManagerPlanStaff=idManagerPlanStaff FROM dbo.Department WHERE id=@idDepartment
		SELECT @idDepartment = idManagerDepartment FROM dbo.Department WHERE id=@idDepartment
	END
				

RETURN @idManagerPlanStaff
END





