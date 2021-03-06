USE Kadr
GO
/****** Object:  StoredProcedure [dbo].[AppendGrup]    Script Date: 01/25/2012 15:16:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
update dbo.Bonus
set idEndPrikaz=null, DateEnd=null
where id in (select Bonus.id FROM dbo.Bonus INNER JOIN dbo.BonusFactStaff ON Bonus.id=BonusFactStaff.idBonus AND BonusFactStaff.idFactStaff=276
		WHERE DateEnd='15.01.2012')
delete 
--select *
from dbo.FactStaff
where idPlanStaff=1886
update dbo.FactStaff
set idEndPrikaz=null, DateEnd=null
where id=276*/
		
--Переводит сотрудника с одной должности на другую с сохранением прежних параметров (ставки... вплоть до надбавок)
--[dbo].TransferFactStaff 276,1886,2776,'16.01.2012',1
alter     PROCEDURE [dbo].TransferFactStaff
@idOldFactStaff INT,	 
@idNewPlanStaff INT,
@idTransferPrikaz INT,
@TransferData DATETIME,
@TransferWithBonus BIT	--
AS

SET @TransferData=CONVERT(date,@TransferData,103)

--BEGIN TRANSACTION;
BEGIN TRY
	
	--записываем надбавки, которые нужно будет перенести
	IF (@TransferWithBonus=1)
	BEGIN
	--курсор с надбавками для переноса
		DECLARE BonusCursor CURSOR LOCAL STATIC READ_ONLY FOR 
		SELECT id, DateEnd, idEndPrikaz
		FROM dbo.Bonus INNER JOIN dbo.BonusFactStaff ON Bonus.id=BonusFactStaff.idBonus AND BonusFactStaff.idFactStaff=@idOldFactStaff
		WHERE DateEnd IS NULL OR DateEnd>@TransferData
		
		--По одной добавляем надбавки
		OPEN BonusCursor
	END


	--"увольняем" и автоматически отменяются надбавки
	UPDATE dbo.FactStaff
	SET idEndPrikaz=@idTransferPrikaz, DateEnd=@TransferData-1
	WHERE id=@idOldFactStaff
	
	--добавляем новую запись в FactStaff
	DECLARE @idNewFactStaff INT

	INSERT INTO dbo.FactStaff(idPlanStaff,idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idTimeSheetSheduleType)
	SELECT @idNewPlanStaff,idEmployee,idTypeWork,@idTransferPrikaz,StaffCount,@TransferData,IsReplacement,idTimeSheetSheduleType
	FROM dbo.FactStaff
	WHERE id=@idOldFactStaff
	
	SET @idNewFactStaff=@@IDENTITY
	
	--переносим надбавки
	IF (@TransferWithBonus=1)
	BEGIN
		DECLARE @idBonus INT
		DECLARE @DateEnd DATETIME
		DECLARE @idEndPrikaz INT
		DECLARE @idNewBonus INT

		--По одной добавляем надбавки
		FETCH NEXT FROM BonusCursor INTO @idBonus, @DateEnd, @idEndPrikaz
		--SELECT @idBonus, @DateEnd, @idEndPrikaz
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			INSERT INTO dbo.Bonus(DateEnd,idBonusType,idEndPrikaz,Comment,idIntermediateEndPrikaz)
			SELECT @DateEnd,idBonusType,@idEndPrikaz,Comment,idIntermediateEndPrikaz
			FROM dbo.Bonus
			WHERE id=@idBonus
			
			SET @idNewBonus=@@IDENTITY
			
			INSERT INTO dbo.BonusHistory(idBonus,idBeginPrikaz,BonusCount,DateBegin)
			SELECT @idNewBonus,@idTransferPrikaz,BonusCount,@TransferData
			FROM dbo.BonusHistory
			WHERE id=(SELECT MAX(id) FROM dbo.BonusHistory
					WHERE idBonus=@idBonus AND DateBegin=(SELECT MAX(DateBegin) FROM dbo.BonusHistory WHERE idBonus=@idBonus))
			
			INSERT INTO dbo.BonusFactStaff(idBonus,idFactStaff)
			VALUES(@idNewBonus,@idNewFactStaff)
			
			
			FETCH NEXT FROM BonusCursor INTO @idBonus, @DateEnd, @idEndPrikaz
		END
		
	END


	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000)
		SELECT @Message=ERROR_MESSAGE()

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		RAISERROR(@Message, 16,1)
	END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;



return 0






