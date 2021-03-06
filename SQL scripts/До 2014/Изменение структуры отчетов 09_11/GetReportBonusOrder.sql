USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStaffByPeriod]    Script Date: 10/04/2011 09:56:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [GetReportBonusOrder](2) ord inner join BonusType on BonusType.id=ord.idBonusType order by BonusOrderNumber
--Функция возращает список выводимых надбавок и их последовательность для переданного отчета
--включая оклад (обозначение оклада -1)
alter FUNCTION [dbo].[GetReportBonusOrder] 
(
@idBonusReport INT
)
RETURNS @Result TABLE
   (
	idBonusType			INT,	
	BonusOrderNumber	INT
   ) 
AS
BEGIN
	--если последовательность столбцов используется по умолчанию (т.е. как идет в таблице)
	--сортируем по алфавиту по названию надбавки
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND DefaultBonusOrder=1)
		INSERT INTO @Result
			SELECT id, (SELECT COUNT(*) FROM dbo.BonusType bonType 
							WHERE bonType.BonusTypeShortName<=BonusType.BonusTypeShortName)	
			FROM dbo.BonusType
	--если не по умолчанию, берем значения из dbo.BonusReportColumns	
	ELSE
		INSERT INTO @Result
			SELECT idBonusType, BonusOrderNumber	
			FROM dbo.BonusReportColumns
			WHERE idBonusReport=@idBonusReport
	
	--добавляем оклад (обозначение -1)
	--если установлено, что оклад вначале
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND SalaryFirst=1)
		INSERT INTO @Result
			VALUES(-1, -1)
	--иначе считаем, что в конце	
	ELSE
		INSERT INTO @Result
			SELECT -1, (SELECT MAX(BonusOrderNumber)+1 FROM @Result)
			
	/*--если это отчет с надбавками по должностям, добавляем еще секретность
	IF (@idBonusReport=2)
	BEGIN
		INSERT INTO @Result
			SELECT 63, (SELECT MAX(BonusOrderNumber)+1 FROM @Result)
	END*/

RETURN
END













