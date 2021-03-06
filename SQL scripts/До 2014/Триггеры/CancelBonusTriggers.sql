USE [Kadr]
GO
/****** Object:  Trigger [dbo].[FactStaffOneMainStaff]    Script Date: 10/19/2010 10:20:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--если увольняется сотрудник, то нужно отменить все его надбавки (с даты увольнения)
create TRIGGER [dbo].[FactStaffCancelBonus]
 ON [dbo].[FactStaff]
  FOR UPDATE, INSERT
AS



UPDATE dbo.Bonus
SET DateEnd=INSERTED.DateEnd
FROM INSERTED, Bonus, dbo.BonusFactStaff
WHERE INSERTED.DateEnd IS NOT NULL
	AND (Bonus.DateEnd IS NULL OR Bonus.DateEnd>INSERTED.DateEnd)	--либо даты отмены нет, либо она позже даты увольнения
	AND Bonus.id=BonusFactStaff.idBonus
	AND INSERTED.id=BonusFactStaff.idFactStaff



GO
--если штат отменяется, то нужно отменить все его надбавки (с даты увольнения)
create TRIGGER [dbo].[PlanStaffCancelBonus]
 ON [dbo].[PlanStaff]
  FOR UPDATE, INSERT
AS



UPDATE dbo.Bonus
SET DateEnd=Prikaz.DateBegin
FROM INSERTED, Bonus, dbo.BonusPlanStaff, Prikaz
WHERE INSERTED.idEndPrikaz IS NOT NULL
	AND (Bonus.DateEnd IS NULL OR Bonus.DateEnd>Prikaz.DateBegin)	--либо даты отмены нет, либо она позже даты увольнения
	AND Bonus.id=BonusPlanStaff.idBonus
	AND INSERTED.id=BonusPlanStaff.idPlanStaff
	AND INSERTED.idEndPrikaz=Prikaz.id


