/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[PrikazName]
      ,[DatePrikaz]
      ,[idPrikazType]
      ,[DateBegin]
      ,[DateEnd]
      ,[resume]
  FROM [Kadr].[dbo].[Prikaz]
  where [PrikazName]='23-ОТ'
  
  
  select *
   from [dbo].[BonusHistory] inner join
   dbo.Bonus ON Bonus.id=[BonusHistory].idBonus
   where [idBeginPrikaz]=7215 and idBonusType!=99

   update [dbo].[BonusHistory] 
   set [idBeginPrikaz]=18293
   where [idBeginPrikaz]=7215 
