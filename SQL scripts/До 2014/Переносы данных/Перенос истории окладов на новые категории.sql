/****** Script for SelectTopNRows command from SSMS  ******/

INSERT INTO [dbo].[PKCategorySalary]([SalarySize],[DateBegin],[DateEnd],[idPKCategory],[idPrikaz])
SELECT [SalarySize],[DateBegin],[DateEnd],subPKCategory.[id],[idPrikaz]
  FROM [Kadr].[dbo].[PKCategorySalary]
  INNER JOIN
	[dbo].[PKCategory]
	ON [PKCategorySalary].idPKCategory=[PKCategory].id
  INNER JOIN
	[dbo].[PKCategory] subPKCategory
	ON subPKCategory.idPKGroup=[PKCategory].idPKGroup
	AND subPKCategory.PKCategoryNumber=[PKCategory].PKCategoryNumber
	AND subPKCategory.PKSubCategoryNumber=[PKCategory].PKSubCategoryNumber
	--AND subPKCategory=[PKCategorySalary]
  WHERE subPKCategory.[PKSubSubCategoryNumber] is not null
	AND [PKCategory].[PKSubSubCategoryNumber] is null
	AND [DateEnd] IS NOT NULL

 