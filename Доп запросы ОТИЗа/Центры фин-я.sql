/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [Kadr].[dbo].[FactStaff]
  inner join
  dbo.PlanStaff on [FactStaff].idPlanStaff=PlanStaff.id
  inner join dbo.Dep
  on PlanStaff.idDepartment=Dep.id


  update [FactStaff]
  set idFundingCenter=Dep.idFundingCenter
 -- SELECT *
   FROM [Kadr].[dbo].[FactStaff]
  inner join
  dbo.PlanStaff on [FactStaff].idPlanStaff=PlanStaff.id
  inner join dbo.Dep
  on PlanStaff.idDepartment=Dep.id
  where [FactStaff].idFundingCenter<>Dep.idFundingCenter
  and ([FactStaff].DateEnd is null or [FactStaff].DateEnd>=GETDATE())