/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [dbo].[FactStaff]
  inner join dbo.PlanStaff on [FactStaff].idPlanStaff=PlanStaff.id
  inner join dbo.Dep on PlanStaff.idDepartment=Dep.id
  and [FactStaff].idFundingCenter=Dep.idFundingCenter


  update [dbo].[FactStaff]
  set idFundingCenter=null
  FROM [dbo].[FactStaff]
  inner join dbo.PlanStaff on [FactStaff].idPlanStaff=PlanStaff.id
  inner join dbo.Dep on PlanStaff.idDepartment=Dep.id
  and [FactStaff].idFundingCenter=Dep.idFundingCenter