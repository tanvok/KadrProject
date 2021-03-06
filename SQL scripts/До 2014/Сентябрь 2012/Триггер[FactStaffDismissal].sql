USE [Kadr]
GO
/****** Object:  Trigger [dbo].[FactStaffInsertFundingDepartment]    Script Date: 09/12/2012 15:11:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--при увольнении сотрудника, если у него есть совместители, 
--отменяет им совмещение (указывает им дату окончания совмещения и признак совмещения сбрасывает)
alter TRIGGER [dbo].[FactStaffDismissal]
 ON [dbo].[FactStaff]
  FOR UPDATE
AS
UPDATE dbo.FactStaff
SET IsReplacement=0
FROM INSERTED INNER JOIN dbo.FactStaffReplacement
	ON INSERTED.id=FactStaffReplacement.idReplacedFactStaff INNER JOIN
	dbo.FactStaff ON FactStaffReplacement.idFactStaff=FactStaff.id
	WHERE INSERTED.DateEnd IS NOT NULL AND FactStaffReplacement.DateEnd IS NULL

UPDATE dbo.FactStaffReplacement
SET DateEnd=Inserted.DateEnd
FROM INSERTED INNER JOIN dbo.FactStaffReplacement
	ON INSERTED.id=FactStaffReplacement.idReplacedFactStaff or 
		INSERTED.id=FactStaffReplacement.idFactStaff
	WHERE INSERTED.DateEnd IS NOT NULL AND FactStaffReplacement.DateEnd IS NULL

go
--при указании Даты окончания замещения, сбрасывает флаг замещения для сотрудника
ALTER TRIGGER [dbo].[FactStaffReplacementCancel]
 ON [dbo].[FactStaffReplacement]
  FOR UPDATE
AS
UPDATE dbo.FactStaff
SET IsReplacement=0
FROM INSERTED FactStaffReplacement INNER JOIN
	dbo.FactStaff ON FactStaffReplacement.idFactStaff=FactStaff.id
	WHERE FactStaffReplacement.DateEnd IS NOT NULL AND (FactStaffReplacement.DateEnd<>FactStaff.DateEnd) 
		AND IsReplacement=1





