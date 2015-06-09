insert into [dbo].[BonusReportColumns]([idBonusReport],[idBonusType],[BonusOrderNumber])
select 5,idBonusType,BonusOrderNumber
from [GetReportBonusOrder](5)
where idBonusType>0

delete 
--select *
from
[dbo].[BonusReportColumns]
where [idBonusReport]=5 and [idBonusType]=24

delete 
--select *
from
[dbo].[BonusReportColumns]
where [idBonusReport]=5 and [idBonusType]=66


GO

--select * from [GetReportBonusOrder](5) ord inner join BonusType on BonusType.id=ord.idBonusType order by BonusOrderNumber
--������� ��������� ������ ��������� �������� � �� ������������������ ��� ����������� ������
--������� ����� (����������� ������ -1)
ALTER FUNCTION [dbo].[GetReportBonusOrder] 
(
@idBonusReport INT
)
RETURNS @Result TABLE
   (
	idBonusType			INT,	
	BonusOrderNumber	INT,
	[OnlyExtrabudgetary]  BIT
   ) 
AS
BEGIN
	--���� ������������������ �������� ������������ �� ��������� (�.�. ��� ���� � �������)
	--��������� �� �������� �� �������� ��������
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND DefaultBonusOrder=1)
		INSERT INTO @Result
			SELECT id, (SELECT COUNT(*) FROM dbo.BonusType bonType 
							WHERE bonType.BonusTypeShortName<=BonusType.BonusTypeShortName)	,0
			FROM dbo.BonusType
	--���� �� �� ���������, ����� �������� �� dbo.BonusReportColumns	
	ELSE
		INSERT INTO @Result
			SELECT idBonusType, BonusOrderNumber, [OnlyExtrabudgetary]	
			FROM dbo.BonusReportColumns
			WHERE idBonusReport=@idBonusReport
	
	--��������� ����� (����������� -1)
	--���� �����������, ��� ����� �������
	IF EXISTS(SELECT 'TRUE' FROM dbo.BonusReport WHERE id=@idBonusReport AND SalaryFirst=1)
		INSERT INTO @Result
			VALUES(-1, -1, 0)
	--����� �������, ��� � �����	
	ELSE
		INSERT INTO @Result
			SELECT -1, (SELECT MAX(BonusOrderNumber)+1 FROM @Result), 0
			
	/*--���� ��� ����� � ���������� �� ����������, ��������� ��� �����������
	IF (@idBonusReport=2)
	BEGIN
		INSERT INTO @Result
			SELECT 63, (SELECT MAX(BonusOrderNumber)+1 FROM @Result)
	END*/

RETURN
END





--select *
update 
[dbo].[BonusReportColumns]
set OnlyExtrabudgetary=1
where [idBonusReport]=5 and [idBonusType]=51


--select *
update 
[dbo].[BonusReportColumns]
set OnlyExtrabudgetary=1
where [idBonusReport]=5 and [idBonusType]=46


--select *
update 
[dbo].[BonusReportColumns]
set OnlyExtrabudgetary=1
where [idBonusReport]=5 and [idBonusType]=22

--select *
update 
[dbo].[BonusReportColumns]
set OnlyExtrabudgetary=1
where [idBonusReport]=5 and [idBonusType]=86

--select *
update 
[dbo].[BonusReportColumns]
set OnlyExtrabudgetary=1
where [idBonusReport]=5 and [idBonusType]=38

