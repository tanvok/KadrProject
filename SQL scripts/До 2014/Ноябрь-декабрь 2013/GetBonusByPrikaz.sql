USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBonusByPeriod]    Script Date: 28.11.2013 11:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select * from [dbo].[GetBonusByPrikaz]('10.08.2013','11.30.2013',10421) where idBonus=10554
--возвращает все надбавки за период (если есть история, то берет последнюю за период)
ALTER FUNCTION [dbo].[GetBonusByPrikaz] 
(
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME,
@idPrikaz	INT
)
RETURNS  TABLE

AS
RETURN (
	SELECT Bonus.id idBonus, BonusCount, idFinancingSource,idBonusType,
		Bonus.[DateBegin], [DateEnd]
	FROM dbo.BonusWithHistory as Bonus
	--INNER JOIN dbo.Bonus ON BonusHistory.id=Bonus.id
	WHERE [idPrikaz]=@idPrikaz)


