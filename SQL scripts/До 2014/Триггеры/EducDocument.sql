USE [Kadr]
GO
/****** Object:  Trigger [dbo].[FactStaffReplacementUpdateRegister]    Script Date: 10/28/2010 10:04:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[FactStaffReplacementUpdateRegister]
   ON dbo.EducDocument 
   FOR INSERT, UPDATE 
AS
BEGIN
	IF EXISTS(SELECT PlanStaff.id, PlanStaff.StaffCount, SUM(FactStaff.StaffCount) AS FactStaffCount 
			FROM INSERTED, dbo.FactStaff, dbo.PlanStaff
					WHERE INSERTED.idPlanStaff=FactStaff.idPlanStaff
						AND FactStaff.idPlanStaff=PlanStaff.id  
						AND INSERTED.idEndPrikaz IS NULL		--ТЕКУЩАЯ СТАВКА ОТКРЫТА
						AND FactStaff.idEndPrikaz IS NULL		--СТАВКИ ОТКРЫТЫ
						AND PlanStaff.idEndPrikaz IS NULL		--ШТАТНОЕ ОТКРЫТО
						AND FactStaff.IsReplacement=0	--не совмещение
						AND INSERTED.IsReplacement=0	--не совмещение
			GROUP BY PlanStaff.id,PlanStaff.StaffCount
			HAVING SUM(FactStaff.StaffCount)>PlanStaff.StaffCount
	)			
	BEGIN
		  RAISERROR('Ошибка! Вы пытаетесь добавить ставку в запись штатного расписания, в которой уже заняты все ставки.', 16,1)
		  ROLLBACK TRAN 
	END
END
