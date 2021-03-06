USE [Kadr]
GO
/****** Object:  Trigger [dbo].[FactStaffNotMoreStaffs]    Script Date: 02/17/2011 09:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter TRIGGER FactStaffChangesHistoryDateChange
 ON dbo.FactStaffChangesHistory
  FOR UPDATE, INSERT
AS


IF EXISTS(SELECT 'TRUE' FROM
			dbo.FactStaff, INSERTED
			WHERE FactStaff.id=INSERTED.idFactStaff AND 
				(DateChange<DateBegin OR DateChange>DateEnd)
)			
BEGIN
      RAISERROR('Ошибка! Указана дата изменения раньше даты принятия на работу или позже даты увольнения.', 16,1)
      ROLLBACK TRAN 
END


go
alter TRIGGER PlanStaffHistoryChangesDateChange
 ON dbo.PlanStaffHistoryChanges
  FOR UPDATE, INSERT
AS


IF EXISTS(SELECT 'TRUE' FROM
			dbo.PlanStaff, INSERTED
			WHERE PlanStaff.id=INSERTED.idPlanStaff AND 
				(DateChange<DateBegin OR DateChange>DateEnd)
)			
BEGIN
      RAISERROR('Ошибка! Указана дата изменения раньше даты назначения или позже даты отмены.', 16,1)
      ROLLBACK TRAN 
END

