/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [Kadr].[dbo].[BonusHistory]
  inner join
[dbo].[BonusFactStaff] ON [BonusHistory].idBonus=[BonusFactStaff].idBonus
  inner join
[dbo].[FactStaff] ON [BonusFactStaff].idFactStaff=[FactStaff].id
inner join
[dbo].[PlanStaffCurrent] ON [FactStaff].idPlanStaff=[PlanStaffCurrent].id
inner join dbo.Post ON [PlanStaffCurrent].idPost=Post.id
  where [BonusHistory].[idBeginPrikaz]=13531
  and Post.idCategory=1
  and [BonusHistory].idFinancingSource<>[PlanStaffCurrent].idFinancingSource



  update [BonusHistory]
  set idFinancingSource=2
  FROM [dbo].[BonusHistory]
  inner join
[dbo].[BonusFactStaff] ON [BonusHistory].idBonus=[BonusFactStaff].idBonus
  inner join
[dbo].[FactStaff] ON [BonusFactStaff].idFactStaff=[FactStaff].id
inner join
[dbo].[PlanStaffCurrent] ON [FactStaff].idPlanStaff=[PlanStaffCurrent].id
 inner join dbo.Post ON [PlanStaffCurrent].idPost=Post.id
  where [BonusHistory].[idBeginPrikaz]=13531
  and Post.idCategory=1




