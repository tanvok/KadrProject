USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStaffCountForHour]    Script Date: 12/03/2012 10:19:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select  [dbo].GetStaffCountForHour(12,345) 
--Вычисляем кол-во ставок для заданного кол-ва часов
ALTER FUNCTION [dbo].[GetStaffCountForHour] 
(
@idPlanStaff INT,
@HourCount		numeric(10,2)
)
RETURNS numeric(10,2)
AS
BEGIN
	DECLARE @StaffCount DECIMAL(10,2)
    SELECT @StaffCount=@HourCount/TimeNorm.NormHoursCount
	 FROM dbo.PlanStaffCurrent PlanStaff  
		INNER JOIN dbo.DepartmentTimeNormCurrent TimeNorm 
			ON PlanStaff.idDepartment=TimeNorm.idDepartment
				AND PlanStaff.idFinancingSource=TimeNorm.idFinancingSource
	WHERE PlanStaff.id=@idPlanStaff		

RETURN @StaffCount
END






