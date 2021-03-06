USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBonusByPeriod]    Script Date: 10/25/2011 11:12:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select * from [dbo].[GetBonusByPeriod]('08.10.2011','30.11.2011') where idBonus=10554
--возвращает все надбавки за период (если есть история, то берет последнюю за период)
ALTER FUNCTION [dbo].[GetBonusByPeriod] 
(
@PeriodBegin	DATETIME,
@PeriodEnd	DATETIME
)
RETURNS @Result TABLE
   (
    idBonus	INT,
    BonusCount	NUMERIC(8,2)
   ) 
AS
BEGIN
	IF (@PeriodBegin>@PeriodEnd)
		RETURN
		
	SET @PeriodBegin=CONVERT(date,@PeriodBegin,103)
	SET @PeriodEnd=CONVERT(date,@PeriodEnd,103)

	INSERT INTO @Result(idBonus, BonusCount)
	SELECT Bonus.id, BonusCount
	FROM dbo.BonusWithHistory as Bonus
	INNER JOIN
	(SELECT Bonus.id, MAX(DateBegin) DateBegin
	FROM dbo.BonusWithHistory as Bonus	
	WHERE (CONVERT(date,Bonus.DateBegin)<=@PeriodBegin AND (CONVERT(date,Bonus.DateEnd)>=@PeriodBegin OR Bonus.DateEnd IS NULL))
		OR (CONVERT(date,Bonus.DateBegin)>=@PeriodBegin AND CONVERT(date,Bonus.DateBegin)<=@PeriodEnd)
	GROUP BY Bonus.id) BonusMaxDates
	ON Bonus.id=BonusMaxDates.id AND CONVERT(date,Bonus.DateBegin)=BonusMaxDates.DateBegin
				
		
		
 
		
RETURN
END

