
--------***----��������������� ������-------***-----
CREATE SCHEMA [ShemaTabel] AUTHORIZATION [UGTU\tvokueva]
GO
 Create Role tab;

--------------------------------------


GO

CREATE TABLE [ShemaTabel].[ApproverType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ApproverTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [ApproverTypePrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [SostavitelTypeNameSostavitelTypeUnique] UNIQUE NONCLUSTERED 
(
	[ApproverTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


go
alter table ShemaTabel.ApproverType
add ApproveNumber int


GO

CREATE TABLE [ShemaTabel].[DayStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DayStatusName] [varchar](5) NOT NULL,
	[DayStatusFullName] [varchar](100) NOT NULL,
 CONSTRAINT [DayStatusPrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DayStatusFullNameDayStatusUnique] UNIQUE NONCLUSTERED 
(
	[DayStatusFullName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DayStatusNameDayStatusUnique] UNIQUE NONCLUSTERED 
(
	[DayStatusName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

CREATE TABLE [ShemaTabel].[Approver](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateBegin] [datetime] NOT NULL,
	[DateEnd] [datetime] NULL,
	[ForAllDepartments] [bit] NOT NULL,
	[idApproverType] [int] NOT NULL,
	[idFactStaff] [int] NOT NULL,
 CONSTRAINT [ApproverPrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ShemaTabel].[Approver]  WITH CHECK ADD  CONSTRAINT [ApproverTypeApproverForeign] FOREIGN KEY([idApproverType])
REFERENCES [ShemaTabel].[ApproverType] ([id])
GO

ALTER TABLE [ShemaTabel].[Approver] CHECK CONSTRAINT [ApproverTypeApproverForeign]
GO

ALTER TABLE [ShemaTabel].[Approver]  WITH CHECK ADD  CONSTRAINT [KadrovikFactStaffForeign] FOREIGN KEY([idFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO

ALTER TABLE [ShemaTabel].[Approver] CHECK CONSTRAINT [KadrovikFactStaffForeign]
GO

ALTER TABLE [ShemaTabel].[Approver]  WITH CHECK ADD  CONSTRAINT [CheckApproverDateBegin] CHECK  (([DateBegin]<=[DateEnd] OR [DateEnd] IS NULL))
GO

ALTER TABLE [ShemaTabel].[Approver] CHECK CONSTRAINT [CheckApproverDateBegin]
GO



GO

CREATE TABLE [ShemaTabel].[RepeatRate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DaysRepeat] [int] NOT NULL,
 CONSTRAINT [RepeatRatePrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [RepeatRateDaysRepeatUnique] UNIQUE NONCLUSTERED 
(
	[DaysRepeat] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

CREATE TABLE [ShemaTabel].[WorkShedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NameShedule] [varchar](50) NOT NULL,
 CONSTRAINT [ShedulePrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [SheduleNameSheduleUniqeu] UNIQUE NONCLUSTERED 
(
	[NameShedule] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



GO

CREATE TABLE [ShemaTabel].[WorkSheduleEvent](
	[idEventSuperType] [int] NOT NULL,
	[KolHourMPS] [float] NOT NULL,
	[KolHourMNS] [float] NOT NULL,
	[KolHourGPS] [float] NOT NULL,
	[KolHourGNS] [float] NOT NULL,
	[idShedule] [int] NOT NULL,
	[idRepeatRate] [int] NOT NULL,
	[Data_Agr] [date] NULL,
 CONSTRAINT [ShemaTabelWorkSheduleEventPrimary] PRIMARY KEY CLUSTERED 
(
	[idEventSuperType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent]  WITH CHECK ADD  CONSTRAINT [WorkSheduleEventRepeatRateForeign] FOREIGN KEY([idRepeatRate])
REFERENCES [ShemaTabel].[RepeatRate] ([id])
GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent] CHECK CONSTRAINT [WorkSheduleEventRepeatRateForeign]
GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent]  WITH CHECK ADD  CONSTRAINT [WorkSheduleEventSheduleForeign] FOREIGN KEY([idShedule])
REFERENCES [ShemaTabel].[WorkShedule] ([id])
GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent] CHECK CONSTRAINT [WorkSheduleEventSheduleForeign]
GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent]  WITH CHECK ADD  CONSTRAINT [WorkSheduleEventSuperTypeEventForeign] FOREIGN KEY([idEventSuperType])
REFERENCES [ShemaTabel].[EventSuperType] ([id])
GO

ALTER TABLE [ShemaTabel].[WorkSheduleEvent] CHECK CONSTRAINT [WorkSheduleEventSuperTypeEventForeign]
GO



GO

CREATE TABLE [ShemaTabel].[EventSuperType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idDayStatus] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[FirstEventDate] [datetime] NOT NULL,
	[ViewDay] [varchar](15) NOT NULL,
 CONSTRAINT [EventSuperTypePrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [ShemaTabel].[EventSuperType]  WITH CHECK ADD  CONSTRAINT [EventSuperTypeDayStatusForeign] FOREIGN KEY([idDayStatus])
REFERENCES [ShemaTabel].[DayStatus] ([id])
GO

ALTER TABLE [ShemaTabel].[EventSuperType] CHECK CONSTRAINT [EventSuperTypeDayStatusForeign]
GO

ALTER TABLE [ShemaTabel].[EventSuperType]  WITH CHECK ADD  CONSTRAINT [CheckEventSuperTypeDateBegin] CHECK  (([BeginDate]<=[EndDate] OR [EndDate] IS NULL))
GO

ALTER TABLE [ShemaTabel].[EventSuperType] CHECK CONSTRAINT [CheckEventSuperTypeDateBegin]
GO


GO

CREATE TABLE [ShemaTabel].[EmployeeEvent](
	[idEventSuperType] [int] NOT NULL,
	[idFactStaff] [int] NOT NULL,
 CONSTRAINT [ShemaTabelEmployeeEventPrimary] PRIMARY KEY CLUSTERED 
(
	[idEventSuperType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ShemaTabel].[EmployeeEvent]  WITH CHECK ADD  CONSTRAINT [EmployeeEventFactStaffForeign] FOREIGN KEY([idFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO

ALTER TABLE [ShemaTabel].[EmployeeEvent] CHECK CONSTRAINT [EmployeeEventFactStaffForeign]
GO

ALTER TABLE [ShemaTabel].[EmployeeEvent]  WITH CHECK ADD  CONSTRAINT [EmployeeEventSuperTypeEventForeign] FOREIGN KEY([idEventSuperType])
REFERENCES [ShemaTabel].[EventSuperType] ([id])
GO

ALTER TABLE [ShemaTabel].[EmployeeEvent] CHECK CONSTRAINT [EmployeeEventSuperTypeEventForeign]
GO


GO

CREATE TABLE [ShemaTabel].[TimeSheet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idDepartment] [int] NOT NULL,
	[idCreater] [int] NOT NULL,
	[DateBeginPeriod] [date] NOT NULL,
	[DateEndPeriod] [date] NOT NULL,
	[DateComposition] [datetime] NOT NULL,
 CONSTRAINT [TablePrimary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DateAndDepartmentUnique] UNIQUE NONCLUSTERED 
(
	[idDepartment] ASC,
	[DateBeginPeriod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ShemaTabel].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [TabelApproverForeign] FOREIGN KEY([idCreater])
REFERENCES [ShemaTabel].[Approver] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheet] CHECK CONSTRAINT [TabelApproverForeign]
GO

ALTER TABLE [ShemaTabel].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [TabelDepartmentForeign] FOREIGN KEY([idDepartment])
REFERENCES [dbo].[Department] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheet] CHECK CONSTRAINT [TabelDepartmentForeign]
GO

ALTER TABLE [ShemaTabel].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [CheckTabelDateBegin] CHECK  (([DateBeginPeriod]<=[DateEndPeriod]))
GO

ALTER TABLE [ShemaTabel].[TimeSheet] CHECK CONSTRAINT [CheckTabelDateBegin]
GO


GO

CREATE TABLE [ShemaTabel].[TimeSheetRecord](
	[IDTimeSheetRecord] [int] IDENTITY(1,1) NOT NULL,
	[RecordDate] [datetime] NOT NULL,
	[JobTimeCount] [float] NOT NULL,
	[idTimeSheet] [int] NOT NULL,
	[idDayStatus] [int] NOT NULL,
	[idFactStaff] [int] NOT NULL,
 CONSTRAINT [TimeSheetRecordTablePrimary] PRIMARY KEY CLUSTERED 
(
	[IDTimeSheetRecord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DateIDTabelIdFactStaffUnique] UNIQUE NONCLUSTERED 
(
	[RecordDate] ASC,
	[idTimeSheet] ASC,
	[idFactStaff] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord]  WITH CHECK ADD  CONSTRAINT [TimeSheetRecordTimeSheetForeign] FOREIGN KEY([idTimeSheet])
REFERENCES [ShemaTabel].[TimeSheet] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord] CHECK CONSTRAINT [TimeSheetRecordTimeSheetForeign]
GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord]  WITH CHECK ADD  CONSTRAINT [ZapisTabelDayStatusForeign] FOREIGN KEY([idDayStatus])
REFERENCES [ShemaTabel].[DayStatus] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord] CHECK CONSTRAINT [ZapisTabelDayStatusForeign]
GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord]  WITH CHECK ADD  CONSTRAINT [ZapisTabelFactStaffForeign] FOREIGN KEY([idFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheetRecord] CHECK CONSTRAINT [ZapisTabelFactStaffForeign]
GO





GO
CREATE TABLE ShemaTabel.Exception --����������
(id INT IDENTITY not null
CONSTRAINT ExceptionPrimary PRIMARY KEY,
ExceptionName VARCHAR(50) NOT NULL unique,
DateException Date not null,
idDayStatus INT not null,
idEventSuperType INT not null,
idPrikaz INT not null,
CONSTRAINT ExceptionDayStatusForeign FOREIGN KEY (idDayStatus)
            REFERENCES ShemaTabel.DayStatus, --������� ����
CONSTRAINT ExceptionSuperTypeEventForeign FOREIGN KEY (idEventSuperType)
            REFERENCES ShemaTabel.EventSuperType, --������� ����
CONSTRAINT ExceptionPrikazForeign FOREIGN KEY (idPrikaz)
            REFERENCES Prikaz --������� ����
);

GO

GO

CREATE TABLE [ShemaTabel].[TimeSheetApproval](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idApprover] [int] NOT NULL,
	[idTimeSheet] [int] NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[Result] [bit] NOT NULL,
	[Comment] [varchar](1000) NULL,
 CONSTRAINT [PK_TimeSheetApproval] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [ShemaTabel].[TimeSheetApproval]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetApproval_Approver] FOREIGN KEY([idApprover])
REFERENCES [ShemaTabel].[Approver] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheetApproval] CHECK CONSTRAINT [FK_TimeSheetApproval_Approver]
GO

ALTER TABLE [ShemaTabel].[TimeSheetApproval]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetApproval_TimeSheet] FOREIGN KEY([idTimeSheet])
REFERENCES [ShemaTabel].[TimeSheet] ([id])
GO

ALTER TABLE [ShemaTabel].[TimeSheetApproval] CHECK CONSTRAINT [FK_TimeSheetApproval_TimeSheet]
GO








------------------------------------------
GO
ALTER TABLE PlanStaff
ADD IDShedule INT 
GO
ALTER TABLE PlanStaff  --������� ������� ���� � ������� ���� ������
WITH NOCHECK
ADD CONSTRAINT PlanStaffWorkSheduleForeign
FOREIGN KEY (IDShedule) REFERENCES ShemaTabel.WorkShedule (id)
---------------------------------
-----------*** ���������� ��������� �������***----------------------------
---------------------------------------------------
/*INSERT INTO PrikazSuperType(PrikazSuperTypeName)
VALUES ('�� ����������')
INSERT INTO PrikazSuperType(PrikazSuperTypeName)
VALUES ('�� �����')
INSERT INTO PrikazSuperType(PrikazSuperTypeName)
VALUES ('�� �����������')
---------------------------------------
INSERT INTO PrikazType(PrikazTypeName,idPrikazSuperType)
VALUES ('�� ��������� ������������ ������',1)
INSERT INTO PrikazType(PrikazTypeName,idPrikazSuperType)
VALUES ('�� ������� ������',1)
INSERT INTO PrikazType(PrikazTypeName,idPrikazSuperType)
VALUES ('�� ������������',1)
INSERT INTO PrikazType(PrikazTypeName,idPrikazSuperType)
VALUES ('�� ������ ��� ���������� �/�',1)
INSERT INTO PrikazType(PrikazTypeName,idPrikazSuperType)
VALUES ('� �������� ��������� ���',3)
-------------------------------------
INSERT INTO Prikaz(PrikazName,DateBegin,DatePrikaz,idPrikazType)
VALUES ('� �������� ��������� ��� 9 ��� 2011','2011-05-09 00:00:00.000','2011-05-03 00:00:00.000',5)
INSERT INTO Prikaz(PrikazName,DateBegin,DatePrikaz,idPrikazType)
VALUES ('�� ����������� � ������������','2011-04-18 00:00:00.000','2011-04-10 00:00:00.000',3)
INSERT INTO Prikaz(PrikazName,DateBegin,DatePrikaz,idPrikazType)
VALUES ('� �������������� �������� ������� ���������','2011-03-09 00:00:00.000','2011-03-01 00:00:00.000',2)
--------------------------------------
INSERT INTO PKGroup(GroupNumber,GroupName)
VALUES (1,'������')
INSERT INTO PKGroup(GroupNumber,GroupName)
VALUES (2,'�������')
INSERT INTO PKGroup(GroupNumber,GroupName)
VALUES (5,'�������')
------------------------------------
INSERT INTO PKCategory(idPKGroup,PKCategoryNumber)
VALUES (1,1)
INSERT INTO PKCategory(idPKGroup,PKCategoryNumber)
VALUES (3,2)
--------------------------------------
INSERT INTO Category(id, CategoryName, CategorySmallName ,OrderBy,IsPPS)
VALUES (1,'1� ���������','1�',1,0)
INSERT INTO Category(id, CategoryName, CategorySmallName ,OrderBy,IsPPS)
VALUES (2,'2� ���������','2�',2,1)
-----------------------------------
--------------------------------------
INSERT INTO EducDocumentType(DocTypeName)
VALUES ('������ � ������ ���������������� �����������')
INSERT INTO EducDocumentType(DocTypeName)
VALUES ('������ � ������ ����������������� �����������')
INSERT INTO EducDocumentType(DocTypeName)
VALUES ('����������')
---------------------------------
INSERT INTO EducDocument(idEducDocType,DocSeries,DocNumber,DocDate)
VALUES (1,'A11',5367,'2002-01-06 00:00:00.000')
INSERT INTO EducDocument(idEducDocType,DocSeries,DocNumber,DocDate)
VALUES (1,'A13',5353,'2006-03-07 00:00:00.000')
INSERT INTO EducDocument(idEducDocType,DocSeries,DocNumber,DocDate)
VALUES (2,'C35',62752,'2007-09-08 00:00:00.000')
-------------------------------------
INSERT INTO BonusSuperType(BonusSuperTypeName)
VALUES ('�� ��������� ������')
INSERT INTO BonusSuperType(BonusSuperTypeName)
VALUES ('�� ������� �����')
---------------------------------------
INSERT INTO BonusMeasure(MeasureName,Sign)
VALUES ('�������','%')
INSERT INTO BonusMeasure(MeasureName,Sign)
VALUES ('����','/')
INSERT INTO BonusMeasure(MeasureName,Sign)
VALUES ('�����','���')
--------------------------------------
INSERT INTO BonusType(BonusTypeName,BonusTypeShortName,idBonusSuperType,idBonusMeasure,HasEnvironmentBonus,IsStaffRateable)
VALUES ('�� ������ � �������� � �����������','���',1,3,0,1)
INSERT INTO BonusType(BonusTypeName,BonusTypeShortName,idBonusSuperType,idBonusMeasure,HasEnvironmentBonus,IsStaffRateable)
VALUES ('�� ������������ �����','��',2,1,1,1)
INSERT INTO BonusType(BonusTypeName,BonusTypeShortName,idBonusSuperType,idBonusMeasure,HasEnvironmentBonus,IsStaffRateable)
VALUES ('�� ������ � ������ �����','��',2,1,1,0)
--------------------------------------
INSERT INTO PKCategorySalary(SalarySize,DateBegin,DateEnd,idPKCategory)
VALUES (1000,'2010-01-04 00:00:00.000',null,1)
INSERT INTO PKCategorySalary(SalarySize,DateBegin,DateEnd,idPKCategory)
VALUES (2000,'2009-07-12 00:00:00.000',null,1)
----------------------------------
INSERT INTO Degree(id, DegreeName,DegreeShortName,DegreeAbbrev,DegreeOrder)
VALUES (1,'������ ����','������','��',1)
INSERT INTO Degree(id,DegreeName,DegreeShortName,DegreeAbbrev,DegreeOrder)
VALUES (2,'�������� ����','��������','��',2)
-----------------------------------
INSERT INTO DepartmentType(DepartmentTypeName)
VALUES ('�����')
INSERT INTO DepartmentType(DepartmentTypeName)
VALUES ('������')
------------------------------------
INSERT INTO GlobalPrikaz(PrikazName, DateBegin, PrikazNumber)
VALUES ('������', '2011-01-04 00:00:00.000',1)
INSERT INTO GlobalPrikaz(PrikazName, DateBegin, PrikazNumber)
VALUES ('���������', '2010-01-04 00:00:00.000',2)
-----------------------------------------
INSERT INTO Grazd(grazdName,KadrID)
VALUES ('����������',1)
INSERT INTO Grazd(grazdName,KadrID)
VALUES ('����������',2)
INSERT INTO Grazd(grazdName,KadrID)
VALUES ('���������',3)
------------------------------------------
INSERT INTO SemPol(sempolName,KadrID)
VALUES ('�����',1)
INSERT INTO SemPol(sempolName,KadrID)
VALUES ('�� �����',1)
----------------------------------------
INSERT INTO ScienceType(ScienceTypeName,ScienceTypeAbbrev,ScienceTypeShortName)
VALUES ('����������','�','���')
INSERT INTO ScienceType(ScienceTypeName,ScienceTypeAbbrev,ScienceTypeShortName)
VALUES ('�����������','�','���')
-------------------------------------
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('������ ����','������',0,1,1,1)
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('���������','���.',0,1,1,1)
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('����������� ����������','���.���.',1,1,1,1)
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('������','���',1,1,1,2)
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('������� �������������','��.��.',1,1,1,2)
INSERT INTO Post(PostName,PostShortName,ManagerBit,idGlobalPrikaz,idPKCategory,idCategory)
VALUES ('�������','���.',1,1,1,2)
-----------------------------------------
INSERT INTO Rank(RankName,KadrID,RankOrder)
VALUES ('������',1,1)
INSERT INTO Rank(RankName,KadrID,RankOrder)
VALUES ('������',2,1)
----------------------------------------
INSERT INTO WorkSuperType(WorkSuperTypeName,WorkSuperTypeShortName)
VALUES ('��������','���')
INSERT INTO WorkSuperType(WorkSuperTypeName,WorkSuperTypeShortName)
VALUES ('����������������','����')
--------------------------------------
INSERT INTO WorkType(TypeWorkName,TypeWorkShortName,IsReplacement,IsMain,idWorkSuperType)
VALUES ('�������','����',1,0,2)
INSERT INTO WorkType(TypeWorkName,TypeWorkShortName,IsReplacement,IsMain,idWorkSuperType)
VALUES ('����������','�����',1,1,2)
---------------------------------------
INSERT INTO Department(DepartmentName,DepartmentSmallName,idDepartmentType,dateCreate,idBeginPrikaz)
VALUES ('����� ����������','��',1,'2000-01-05 00:00:00.000',1)
INSERT INTO Department(DepartmentName,DepartmentSmallName,idDepartmentType,dateCreate,idBeginPrikaz)
VALUES ('�������������-�������������� �����','���',1,'2000-01-05 00:00:00.000',1)
INSERT INTO Department(DepartmentName,DepartmentSmallName,idDepartmentType,dateCreate,idBeginPrikaz)
VALUES ('������������� �����','��',1,'2000-01-05 00:00:00.000',1)
INSERT INTO Department(DepartmentName,DepartmentSmallName,idDepartmentType,dateCreate,idBeginPrikaz)
VALUES ('������� ���','���',1,'2000-01-05 00:00:00.000',1)
--------------------------------------
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (3,4,4,1,'2009-01-05 00:00:00.000',1)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (1,4,2,1,'2009-01-05 00:00:00.000',1)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (2,5,4,1,'2009-01-05 00:00:00.000',1)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (1,5,2,1,'2009-01-05 00:00:00.000',1)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (3,7,5,1,'2009-01-05 00:00:00.000',2)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (1,7,2,1,'2009-01-05 00:00:00.000',1)
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (3,6,6,1,'2009-01-05 00:00:00.000',2)-----------------------------------------------------
INSERT INTO PlanStaff(StaffCount,idDepartment,idPost,idBeginPrikaz,DateBegin,IDShedule)
VALUES (1,6,2,1,'2009-01-05 00:00:00.000',1)
-----------------------------
INSERT INTO FinancingSource(FinancingSourceName,OrderBy)
VALUES ('������',1)
INSERT INTO FinancingSource(FinancingSourceName,OrderBy)
VALUES ('���������',1)
------------------------------
INSERT INTO Bonus(BonusCount,DateBegin,idBonusType,idPrikaz,idEndPrikaz)
VALUES (300,'2009-01-05 00:00:00.000',1,1,1)
INSERT INTO Bonus(BonusCount,DateBegin,idBonusType,idPrikaz,idEndPrikaz)
VALUES (200,'2010-01-05 00:00:00.000',1,1,1)
---------------------------------
INSERT INTO BonusPost(idBonus,idPost)
VALUES (2,6)
INSERT INTO BonusPost(idBonus,idPost)
VALUES (1,3)
------------------------
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1002,'������','����', '��������', '1978-01-05 00:00:00.000','�.����',0, 1, 1, 50,20,'6F9619FF-8B86-D011-B42D-00C04FC964FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1003,'������','����', '��������', '1973-01-05 00:00:00.000','�.����',0, 1, 1, 50,20,'6F9619FF-8B86-D014-B48D-00C04FC933FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1004,'��������','���������', '��������', '1981-09-03 00:00:00.000','�.����',1, 1, 2, 30,20,'6F9619FF-8C65-E011-B48D-00A14FC542EF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1005,'�������','�����', '����������', '1985-11-16 00:00:00.000','�.���������',1, 1, 1, 50,20,'3F9789FF-2E61-E514-C48A-00B14FC748EC')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1006,'������','��������', '�����', '1974-02-28 00:00:00.000','�.����',0, 2, 1, 20,20,'4B9386FF-6B61-E514-B48B-00B14BC849EA')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1007,'�������','���������', '���������', '1985-11-14 00:00:00.000','�.����',0, 2, 1, 20,20,'4B8886FF-6B61-E514-B88B-00B14FC888EC')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1008,'���������','�������', '����������', '1973-01-15 00:00:00.000','�.����',1, 1, 1, 50,20,'6F9292FF-8B81-D014-B48D-18C04FC673FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1009, '������������','������','����������', '1988-06-13 00:00:00.000','�.����',0, 1, 1, 50,20,'6F8339FF-6B86-D893-B48D-00C04FC933FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1010,'���������','�������', '��������', '1982-01-05 00:00:00.000','�.����',0, 1, 1, 50,20,'6F9000FF-8B86-D000-B48D-00C04FC000FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1011,'�����','����', '����������', '1989-07-27 00:00:00.000','�.����',1, 1, 1, 50,20,'6F9444FF-4B86-D440-B44D-00C04FC000FF')
INSERT INTO Employee(itab_n,FirstName,LastName,Otch,BirthDate,BirthPlace,SexBit,idGrazd,idSemPol,SeverKoeff,RayonKoeff,GUID)
VALUES (1012,'�������','�������', '���������', '1979-01-18 00:00:00.000','�.����',0, 1, 1, 50,20,'6F9565FF-8B86-D098-B48D-00C04FC989FF')
---------------------------------------------------
---------------------------------------------------
INSERT INTO BonusEmployee(idBonus,idEmployee)
VALUES (2,3)
INSERT INTO BonusEmployee(idBonus,idEmployee)
VALUES (1,6)
----------------------------------------
INSERT INTO EmployeeDegree(idEducDocument,degreeDate,DissertCouncil,diplWhere,idDegree,idScienceType,idEmployee)
VALUES (1,'2001-04-17 00:00:00.000','������ �.�.,�������� �.�','��� ��.����������',1,1,6)
INSERT INTO EmployeeDegree(idEducDocument,degreeDate,DissertCouncil,diplWhere,idDegree,idScienceType,idEmployee)
VALUES (2,'2008-09-12 00:00:00.000','������� �.�.,������������� �.�','������',2,2,7)
-----------------------------------------
---------------------------------------------------------------------------------------   -----
INSERT INTO EmployeeRank(idEducDocument,idEmployee,idRank,rankWhere)
VALUES (1,6,1,'����')
INSERT INTO EmployeeRank(idEducDocument,idEmployee,idRank,rankWhere)
VALUES (2,7,2,'����')
-------------------------------------------
INSERT INTO OKBufferEmployeeDegree(itab_n,degreeDate,DissertCouncil,dokSer,dokNum,diplDate,diplWhere,idDegree,idScienceType)
VALUES (1003,'2001-04-17 00:00:00.000','������ �.�.,�������� �.�','A11','5367','1998-07-28 00:00:00.000','��� ��.����������',1,1)
--------------------------------------------
INSERT INTO OKBufferEmployeeRank(idRank,dokSer,dokNum,rankDate,rankWhere,itab_n)
VALUES (1,'A11','5367','2010-03-05 00:00:00.000','����',1003)
INSERT INTO OKBufferEmployeeRank(idRank,dokSer,dokNum,rankDate,rankWhere,itab_n)
VALUES (1,'A13','5353','2008-07-05 00:00:00.000','����',1004)
--------------------------------------------
INSERT INTO PlanStaffSalary(SalarySize,DateBegin,idPlanStaff)
VALUES (400,'2008-07-05 00:00:00.000',6)
INSERT INTO PlanStaffSalary(SalarySize,DateBegin,idPlanStaff)
VALUES (500,'2008-07-05 00:00:00.000',10)
INSERT INTO PlanStaffSalary(SalarySize,DateBegin,idPlanStaff)
VALUES (600,'2008-07-05 00:00:00.000',12)
-------------------------------------------
INSERT INTO TimeSheet(TimeSheetMonth,TimeSheetYear,TimeSheetAllDayCount,TimeSheetWorkingDayCount,IsClosed,IsFilled)
VALUES (02,2011,28,19,1,0)
INSERT INTO TimeSheet(TimeSheetMonth,TimeSheetYear,TimeSheetAllDayCount,TimeSheetWorkingDayCount,IsClosed,IsFilled)
VALUES (03,2011,31,22,1,0)
-----------------------------------------
INSERT INTO TimeSheetScheduleType(ScheduleTypeName)
VALUES ('5������')
INSERT INTO TimeSheetScheduleType(ScheduleTypeName)
VALUES ('6������')
----------------------------
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (1,1,1,1,'2008-06-05 00:00:00.000',1,6)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (7,1,1,1,'2008-06-05 00:00:00.000',1,8)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (6,1,1,0.5,'2008-06-05 00:00:00.000',1,10)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (9,1,1,1,'2008-06-05 00:00:00.000',1,15)

INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (10,1,1,1,'2008-06-05 00:00:00.000',1,14)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (2,1,1,1,'2008-06-05 00:00:00.000',1,13)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (3,1,1,1,'2008-06-05 00:00:00.000',1,11)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (4,1,1,1,'2008-06-05 00:00:00.000',1,12)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (5,1,1,1,'2008-06-05 00:00:00.000',1,12)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (11,1,1,1,'2008-06-05 00:00:00.000',1,14)
INSERT INTO FactStaff(idEmployee,idTypeWork,idBeginPrikaz,StaffCount,DateBegin,IsReplacement,idPlanStaff)
VALUES (12,1,1,1,'2008-06-05 00:00:00.000',1,13)
*/
----------���������� ����������� ������ ���-------------
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '��'
GO
EXEC AddDayStatus  '�'
GO
EXEC AddDayStatus  '��'
-----------���������� ����������� ������� ����������---------
GO
EXEC AddRepeatRate  '7'
GO
EXEC AddRepeatRate '14'  
-----------���������� ����������� ����� ������---------------
GO
EXEC AddWorkShedule '����������� ������� ������'
GO
EXEC AddWorkShedule '������������ ������� ������' 
-----------���������� ����������� ��� ����������� --------------
GO
EXEC AddSostavitelType '���������'
GO
EXEC AddSostavitelType '��������� ��'
GO
EXEC AddSostavitelType '�������� ��������'
-----------���������� ������� � ������� ������� ������
--���
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-02 00:00:00.000','���')
--����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-03 00:00:00.000','���')
--����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-04 00:00:00.000','���')
--����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-05 00:00:00.000','���')
--����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-06 00:00:00.000','���')
--���
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (2,'2011-05-07 00:00:00.000','���')
--����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (2,'2011-05-08 00:00:00.000','���')
----�������--
--��� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-02 00:00:00.000','���')
--���� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-03 00:00:00.000','���')
---���� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-04 00:00:00.000','���')
--���� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-05 00:00:00.000','���')
--��� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-06 00:00:00.000','���')
--��� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (1,'2011-05-07 00:00:00.000','���')
---���� 6��
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,
FirstEventDate,ViewDay)
VALUES (2,'2011-05-08 00:00:00.000','���')


----***��� ���������� ������� ������� �� ������ **----
---�����������----
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,1,7.2,7.5,8,8,1)
---�������--
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,2,7.2,7.5,8,8,1)
---�����-------
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,3,7.2,7.5,8,8,1)
---�������----
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,4,7.2,7.5,8,8,1)
---�������----
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,5,7.2,6,8,8,1)
---�������----
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,6,0,0,0,0,1)
---������������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (1,7,0,0,0,0,1)

----***��� ����������� ������� ������� �� ������ **----
---����������! ��� ���� (� � �) ��� = ���
---�����������-----
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,8,6,6.2,6.6,7,1)
---�������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,9,6,6.2,6.6,7,1)
---�����---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,10,6,6.2,6.6,7,1)
---�������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,11,6,6.2,6.6,7,1)
---�������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,12,6,6.2,6.6,7,1)
---�������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,13,6,5,6.6,5,1)
---�����������---
INSERT INTO ShemaTabel.WorkSheduleEvent(IDShedule,
IDSuperTypeEvent,KolHourGNS,KolHourGPS,KolHourMNS,
KolHourMPS,IDRepeatRate)
VALUES (2,14,0,0,0,0,1)
------------------------------------
/*���������� ������������ ����� � ���������� ��������� ��������:
1, 2, 3, 4 � 5 ������ - ���������� ��������;
7 ������ - ��������� ��������;
23 ������� - ���� ��������� ���������;
8 ����� - ������������� ������� ����;
1 ��� - �������� ����� � �����;
9 ��� - ���� ������;
12 ���� - ���� ������;
4 ������ - ���� ��������� ��������.
(����� ������ � ���. ������������ ������ �� 29.12.2004 N 201-��)
��� ���������� ��������� � ���������� ������������ ���� �������� ���� ����������� �� ��������� ����� ������������ ������� ����.
*/
-----------
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-03-08 00:00:00.000','���')--8 �����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-01 00:00:00.000','���') --���������� ��������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-02 00:00:00.000','���')--���������� ��������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-03 00:00:00.000','���')--���������� ��������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-04 00:00:00.000','���')--���������� ��������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-05 00:00:00.000','���')--���������� ��������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-01-07 00:00:00.000','���')--���������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-02-23 00:00:00.000','���')--23 �������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-05-01 00:00:00.000','���')--�������� ����� � �����
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-05-09 00:00:00.000','���')--���� ������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-06-12 00:00:00.000','���')--���� ������
INSERT INTO ShemaTabel.SuperTypeEvent(IDDayStatus,FirstEventDate,ViewDay)
VALUES (2,'2009-11-04 00:00:00.000','���')--���� ��������� ��������
-----------
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('8 �����','2009-03-08',2,15,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������� ��������','2009-01-01',2,16,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������� ��������','2009-01-02',2,17,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������� ��������','2009-01-03',2,18,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������� ��������','2009-01-04',2,19,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������� ��������','2009-01-05',2,20,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���������','2009-01-07',2,21,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���� ��������� ���������','2009-02-23',2,22,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('�������� ����� � �����','2009-05-01',2,23,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���� ������','2009-05-09',2,24,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���� ������','2009-06-12',2,25,1)
INSERT INTO ShemaTabel.Exception(NameException,DateException,IDDayStatus,IDSuperTypeEvent,idPrikaz)
VALUES ('���� ��������� ��������','2009-11-04',2,26,1)
-----------���������� �������������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,9,2 ---��������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,7,2 -----��������� 7 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,8,2 -----��������� 5 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,10,2 -----��������� 6 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,11,2 -----��������� 4 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,3,2 -----��������� 7 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,2,2 -----��������� 5 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,4,2 -----��������� 6 ������
go
EXEC AddSostavitel '2010-02-08 00:00:00.000',null,0,1,2 -----��������� 4 ������
-------------------***
------------ *** ������� *** ---------------------
go
create nonclustered index NindexAssertTabelSostavitel
ON ShemaTabel.AssertTabel (IDSostavitel ASC)
go
create nonclustered index NindexAssertTabelTabel
ON ShemaTabel.AssertTabel (IDTabel ASC)
------------------------------------------------
go
create nonclustered index NindexEmployeeEventFactStaff
ON ShemaTabel.EmployeeEvent (IDFactStaff ASC)
go
create nonclustered index NindexEmployeeEventSuperTypeEvent
ON ShemaTabel.EmployeeEvent (IDSuperTypeEvent ASC)
------------------------------------------------
go
create nonclustered index NindexExceptionDayStatus
ON ShemaTabel.Exception (IDDayStatus ASC)
go
create nonclustered index NindexExceptionSuperTypeEvent
ON ShemaTabel.Exception (IDSuperTypeEvent ASC)
go
create nonclustered index NindexExceptionPrikaz
ON ShemaTabel.Exception (IDPrikaz ASC)
-----------------------------------------------
go
create nonclustered index NindexSostavitelFactStaff
ON ShemaTabel.Sostavitel (IDFactStaff ASC)
go
create nonclustered index NindexSostavitelSostavitelType
ON ShemaTabel.Sostavitel (IDSostavitelType ASC)
-----------------------------------------------
go
create nonclustered index NindexSuperTypeEventDayStatus
ON ShemaTabel.SuperTypeEvent (IDDayStatus ASC)
----------------------------------------------
go
create nonclustered index NindexTabelDepartment
ON ShemaTabel.Tabel (IDDepartment ASC)
go
create nonclustered index NindexTabelSostavitel
ON ShemaTabel.Tabel (IDSostavitel ASC)
-----------------------------------------------
go
create nonclustered index NindexWorkSheduleEventSuperTypeEvent
ON ShemaTabel.WorkSheduleEvent (IDSuperTypeEvent ASC)
go
create nonclustered index NindexWorkSheduleEventRepeatRate
ON ShemaTabel.WorkSheduleEvent (IDRepeatRate ASC)
go
create nonclustered index NindexWorkSheduleEventShedule
ON ShemaTabel.WorkSheduleEvent (IDShedule ASC)
------------------------------------------------
go
create nonclustered index NindexZapisTabelTabel
ON ShemaTabel.ZapisTabel(IDTabel ASC)
go
create nonclustered index NindexZapisTabelFactStaff
ON ShemaTabel.ZapisTabel(IDFactStaff ASC)