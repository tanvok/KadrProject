USE [Kadr]
GO
/****** Object:  Trigger [dbo].[PlanStaffHistoryChangesDateChange]    Script Date: 10/26/2011 09:49:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--триггер-проверка на то, чтобы дата изменения надбавки соответствовала ее дате начала и отмены 
alter TRIGGER dbo.BonusChangesHistory_DateChange
 ON dbo.BonusChangesHistory
  FOR UPDATE, INSERT
AS


IF EXISTS(SELECT INSERTED.idBonus FROM
			dbo.Bonus INNER JOIN INSERTED
			ON Bonus.id=INSERTED.idBonus 
			WHERE (DateChange<DateBegin OR DateChange>DateEnd)
)			
BEGIN
      RAISERROR('Ошибка! Указана дата изменения раньше даты назначения или позже даты отмены.', 16,1)
      ROLLBACK TRAN 
END


go
--триггер-проверка на то, чтобы код предыдущего изменения соответствовал вставляемому
create TRIGGER dbo.BonusChangesHistory_PrevChange
 ON dbo.BonusChangesHistory
  FOR UPDATE, INSERT
AS


IF EXISTS(SELECT INSERTED.idBonus FROM
			dbo.BonusChangesHistory PrevBonusChange INNER JOIN INSERTED
			ON PrevBonusChange.id=INSERTED.idPrevBonusChange 
			WHERE PrevBonusChange.idBonus<>INSERTED.idBonus 
)			
BEGIN
      RAISERROR('Ошибка в программе! Задано неверное предыдущее изменение.', 16,1)
      ROLLBACK TRAN 
END

