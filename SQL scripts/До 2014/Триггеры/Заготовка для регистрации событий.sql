USE [Kadr]
GO
/****** Object:  Trigger [dbo].[PlanStaffInsertRegister]    Script Date: 12/23/2010 11:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[TimeSheetFSWorkingDaysInsertRegister]
   ON dbo.TimeSheetFSWorkingDays
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @name varchar(102)
select @name=RTRIM(idTimeSheet)+' '+RTRIM(idFactStaff)+' '+RTRIM(WorkingDaysCount)+ ' '+RTRIM(IsClosed) from inserted
    -- Insert statements for trigger here
exec dbo.AuditLogEvent 1,18,@name
END



GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[TimeSheetFSWorkingDaysUpdateRegister]
   ON  [dbo].TimeSheetFSWorkingDays
   AFTER update
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

declare @name varchar(100)
select @name=RTRIM(idTimeSheet)+' '+RTRIM(idFactStaff)+' '+RTRIM(WorkingDaysCount)+ ' '+RTRIM(IsClosed) from inserted
    -- Insert statements for trigger here
exec dbo.AuditLogEvent 3,17,@name
END



GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[TimeSheetFSWorkingDaysDeleteRegister]
   ON  [dbo].TimeSheetFSWorkingDays
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @name varchar(102)

select @name=RTRIM(idTimeSheet)+' '+RTRIM(idFactStaff)+' '+RTRIM(WorkingDaysCount)+ ' '+RTRIM(IsClosed) from deleted
    -- Insert statements for trigger here
exec dbo.AuditLogEvent 2,17,@name
END

