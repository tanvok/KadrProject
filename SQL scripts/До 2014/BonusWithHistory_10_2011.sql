USE [Kadr]
GO

/****** Object:  View [dbo].[FactStaffWithHistory]    Script Date: 10/22/2011 13:34:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--select * from [BonusWithHistory] where id = 10554 

ALTER VIEW [dbo].[BonusWithHistory]
AS
--�������� ��������� ��������� - ������� ����� �� Bonus (������ ����� ������ � ������ ��������, 
--���� ����� �� ���������� ��������� (���� ����� ����))
SELECT Bonus.id, Bonus.BonusCount, CONVERT(date,ISNULL(BonusChangesHistory.DateChange, Bonus.DateBegin)) DateBegin, 
	Bonus.DateEnd, Bonus.idBonusType, Bonus.idPrikaz, Bonus.idEndPrikaz, Bonus.Comment
FROM 
	dbo.Bonus LEFT JOIN
	dbo.BonusChangesHistory ON dbo.Bonus.id=dbo.BonusChangesHistory.idBonus
	--���������, ����� ��������� ���� ��������� (�.�. ��� �� �������� ���������� �� ��� ������ ������� ���������)
		AND  BonusChangesHistory.id NOT IN 
			(SELECT idPrevBonusChange FROM dbo.BonusChangesHistory WHERE idPrevBonusChange IS NOT NULL)
	--�������� ���������� ���������
	--LEFT JOIN dbo.BonusChangesHistory PrevChange ON dbo.Bonus.id=PrevChange.idBonus
	--	AND PrevChange.id=BonusChangesHistory.idPrevBonusChange
	
			
--�������� ������ ��������� - ���� ���������� ����� �� ��������, ��������� �� ������� ���������
UNION
SELECT Bonus.id, BonusChangesHistory.PrevBonusCount, CONVERT(date,Bonus.DateBegin) DateBegin, 
	CONVERT(date,BonusChangesHistory.DateChange-1) as DateEnd, Bonus.idBonusType, BonusChangesHistory.idPrevPrikaz, 
	ISNULL(NextChange.idPrevPrikaz, Bonus.idEndPrikaz), Bonus.Comment
FROM 
	dbo.Bonus
	INNER JOIN dbo.BonusChangesHistory ON dbo.Bonus.id=dbo.BonusChangesHistory.idBonus
--���������, ����� ��������� ���� ������ (�.�. ��� ���� ��� �����������)
		AND BonusChangesHistory.idPrevBonusChange IS NULL  
	--�������� ��������� �� ��� ��������� (���� ����)
	LEFT JOIN dbo.BonusChangesHistory NextChange ON dbo.Bonus.id=NextChange.idBonus
		AND NextChange.idPrevBonusChange=BonusChangesHistory.id
		
--�������� "����������" ���������	
UNION
SELECT Bonus.id, BonusChangesHistory.PrevBonusCount, CONVERT(date,PrevChange.DateChange) DateBegin, 
	CONVERT(date,BonusChangesHistory.DateChange-1) as DateEnd, Bonus.idBonusType, BonusChangesHistory.idPrevPrikaz, 
	ISNULL(NextChange.idPrevPrikaz,Bonus.idPrikaz) idEndPrikaz, Bonus.Comment
FROM 
	dbo.Bonus
	INNER JOIN dbo.BonusChangesHistory ON dbo.Bonus.id=dbo.BonusChangesHistory.idBonus
	--�������� ���������� ���������
	INNER JOIN dbo.BonusChangesHistory PrevChange ON dbo.Bonus.id=PrevChange.idBonus
		AND PrevChange.id=BonusChangesHistory.idPrevBonusChange
	--�������� ��������� �� ��� ��������� (���� ����)
	LEFT JOIN dbo.BonusChangesHistory NextChange ON dbo.Bonus.id=NextChange.idBonus
		AND NextChange.idPrevBonusChange=BonusChangesHistory.id



GO


