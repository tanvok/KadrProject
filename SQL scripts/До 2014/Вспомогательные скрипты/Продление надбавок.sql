/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [id]
      ,[idBonus]
      ,[idBeginPrikaz]
      ,[BonusCount]
      ,[DateBegin]
      ,[idFinancingSource]
  FROM [Kadr].[dbo].[BonusHistory]
  where [idBonus] in (select * from [dbo].[BonusHistory]
	where [idBeginPrikaz]=10421) and
	[idBonus] in (select [idBonus] from [dbo].[BonusHistory]
	where [idBeginPrikaz]=9111)


insert into [dbo].[BonusHistory]
select  distinct [idBonus],10421,MAX([BonusCount]), '2013-09-01', 2
from [dbo].[BonusHistory]
where [idBeginPrikaz]=9111
AND [idBonus] not in (select [idBonus] from [dbo].[BonusHistory]
	where [idBeginPrikaz]=10421 ) 
and idBonus in (SELECT id from Bonus where [idBonusType]=3 )
GROUP BY  [idBonus]