USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBonusByPeriodWithHistory]    Script Date: 10/25/2011 14:03:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select * from [dbo].[GetBonusByPeriodWithHistory]('08.10.2010','30.10.2010')  where idBonus=10554
--выдает список надбавок за период вместе с историей
ALTER FUNCTION [dbo].[GetBonusByPeriodWithHistory] 
(
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME
)
RETURNS @Result TABLE
   (
    idBonus	INT,
    DateBegin DATETIME,
    DateEnd DATETIME,
    idPrikaz	INT,
    idEndPrikaz INT,
    BonusCount	NUMERIC(8,2)
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN
		
	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

	INSERT INTO @Result(idBonus, DateBegin, DateEnd, BonusCount, idPrikaz, idEndPrikaz)
	SELECT Bonus.id, DateBegin, DateEnd, BonusCount, idPrikaz, idEndPrikaz
	FROM dbo.BonusWithHistory as Bonus	
	WHERE (CONVERT(date,Bonus.DateBegin)<=@PeriodBegin AND (CONVERT(date,Bonus.DateEnd)>=@PeriodBegin OR Bonus.DateEnd IS NULL))
		OR (CONVERT(date,Bonus.DateBegin)>=@PeriodBegin AND CONVERT(date,Bonus.DateBegin)<=@PeriodEnd)
		
 
		
RETURN
END

