/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[idPKGroup]
      ,[PKCategoryNumber]
      ,[PKSubCategoryNumber]
  FROM [Kadr].[dbo].[PKCategory]
  where [id] not in (select [idPKCategory] from [dbo].[PKCategorySalary] group by [idPKCategory] having COUNT(*)>1)
  and id>20

SELECT TOP 1000 [id]
      ,[idPKGroup]
      ,[PKCategoryNumber]
      ,[PKSubCategoryNumber]
  FROM [Kadr].[dbo].[PKCategory] 

select * from [dbo].[PKCategorySalary]
where [idPKCategory]=14
and DateEnd is not null 
89
insert into [dbo].[PKCategorySalary]([SalarySize],[DateBegin],[DateEnd],[idPKCategory], [idPrikaz])
select [SalarySize],[DateBegin],[DateEnd],91, [idPrikaz]
from [dbo].[PKCategorySalary]
where [idPKCategory]=14
and DateEnd is not null


