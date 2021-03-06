
GO
/****** Object:  User [UGTU\ibibikova]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\ibibikova] FOR LOGIN [UGTU\ibibikova] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UGTU\nbudina]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\nbudina] FOR LOGIN [UGTU\nbudina] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UGTU\nshiryaeva]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\nshiryaeva] FOR LOGIN [UGTU\nshiryaeva] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UGTU\sbashkirov]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\sbashkirov] FOR LOGIN [UGTU\sbashkirov] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UGTU\tvokueva]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\tvokueva] FOR LOGIN [UGTU\tvokueva] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UGTU\ugluhova]    Script Date: 09/22/2010 10:21:42 ******/
CREATE USER [UGTU\ugluhova] FOR LOGIN [UGTU\ugluhova] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[SemPol]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SemPol](
	[id] [int]   NOT NULL,
	[sempolName] [varchar](100) NOT NULL,
	[KadrID] [int] NULL,
 CONSTRAINT [PK_SemPol] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_SemPol] UNIQUE NONCLUSTERED 
(
	[sempolName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DepartmentType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentType](
	[id] [int]   NOT NULL,
	[DepartmentTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DepartmentType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_DepartmentType] UNIQUE NONCLUSTERED 
(
	[DepartmentTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Degree]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Degree](
	[id] [int] NOT NULL,
	[DegreeName] [varchar](100) NOT NULL,
	[DegreeShortName] [varchar](50) NOT NULL,
	[DegreeAbbrev] [varchar](50) NOT NULL,
	[DegreeOrder] [int] NOT NULL,
 CONSTRAINT [PK_Degree] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Degree] UNIQUE NONCLUSTERED 
(
	[DegreeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Degree_1] UNIQUE NONCLUSTERED 
(
	[DegreeAbbrev] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Degree_2] UNIQUE NONCLUSTERED 
(
	[DegreeAbbrev] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[CategorySmallName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Category] UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Category_1] UNIQUE NONCLUSTERED 
(
	[CategorySmallName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[0post]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[0post](
	[id] [float] NULL,
	[DOL] [nvarchar](255) NULL,
	[PRIM] [nvarchar](255) NULL,
	[F4] [float] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'0post'
GO
/****** Object:  Table [dbo].[Rank]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rank](
	[id] [int]   NOT NULL,
	[RankName] [varchar](100) NOT NULL,
	[KadrID] [int] NULL,
	[RankOrder] [int] NOT NULL,
 CONSTRAINT [PK_Rank] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ZRank] UNIQUE NONCLUSTERED 
(
	[RankName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalPrikaz]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalPrikaz](
	[id] [int]   NOT NULL,
	[PrikazName] [varchar](50) NOT NULL,
	[DateBegin] [datetime] NULL,
 CONSTRAINT [PK_GP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_GlobalPrikaz] UNIQUE NONCLUSTERED 
(
	[PrikazName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPrikaz'
GO
/****** Object:  Table [dbo].[BonusMeasure]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BonusMeasure](
	[id] [int]   NOT NULL,
	[MeasureName] [varchar](50) NOT NULL,
	[Sign] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Measure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_BonusMeasure] UNIQUE NONCLUSTERED 
(
	[MeasureName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grazd]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grazd](
	[id] [int]   NOT NULL,
	[grazdName] [varchar](100) NULL,
	[KadrID] [int] NULL,
 CONSTRAINT [PK_Grazd] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Grazd] UNIQUE NONCLUSTERED 
(
	[grazdName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactStaffReplacementReason]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactStaffReplacementReason](
	[id] [int]   NOT NULL,
	[ReplacementReasonName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ReplacementType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ReplacementType] UNIQUE NONCLUSTERED 
(
	[ReplacementReasonName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[EmployeeView]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmployeeView]
AS
SELECT     
	Employee.*,
	LastName+' '+FirstName+' '+Otch as EmployeeName,
	LastName+' '+CONVERT(VARCHAR(1),FirstName)+'.'+CONVERT(VARCHAR(1),Otch)+'.' as EmployeeFIO
FROM    dbo.Employee
GO
/****** Object:  Table [dbo].[BonusSuperType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BonusSuperType](
	[id] [int]   NOT NULL,
	[BonusSuperTypeName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_BonusSuperType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_BonusSuperType] UNIQUE NONCLUSTERED 
(
	[BonusSuperTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorkType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkType](
	[id] [int]   NOT NULL,
	[TypeWorkName] [varchar](50) NOT NULL,
	[IsReplacement] [bit] NOT NULL,
 CONSTRAINT [PK_TypeWork] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_TypeWork] UNIQUE NONCLUSTERED 
(
	[TypeWorkName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ScienceType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScienceType](
	[id] [int]   NOT NULL,
	[ScienceTypeName] [varchar](200) NOT NULL,
	[ScienceTypeAbbrev] [varchar](50) NOT NULL,
	[ScienceTypeShortName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_VidNauk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ScienceType] UNIQUE NONCLUSTERED 
(
	[ScienceTypeAbbrev] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ScienceType_1] UNIQUE NONCLUSTERED 
(
	[ScienceTypeShortName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_VidNauk] UNIQUE NONCLUSTERED 
(
	[ScienceTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrikazSuperType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrikazSuperType](
	[id] [int]   NOT NULL,
	[PrikazSuperTypeName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PrikazSuperType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PrikazSuperType] UNIQUE NONCLUSTERED 
(
	[PrikazSuperTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Audit_Object]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit_Object](
	[ObjectID] [int] NOT NULL,
	[ObjectName] [varchar](50) NOT NULL,
	[ObjectTable] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Audit_Object] PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Audit_OperationType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit_OperationType](
	[OperationTypeID] [int] NOT NULL,
	[OperationName] [varchar](50) NOT NULL,
	[OperationSQL] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Audit_OperationType] PRIMARY KEY CLUSTERED 
(
	[OperationTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FinancingSource]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FinancingSource](
	[id] [int]   NOT NULL,
	[FinancingSourceName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FinancingSource] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_FinancingSource] UNIQUE NONCLUSTERED 
(
	[FinancingSourceName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EducDocumentType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EducDocumentType](
	[id] [int]   NOT NULL,
	[DocTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EducDocumentType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EducDocumentType] UNIQUE NONCLUSTERED 
(
	[DocTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PKGroup]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PKGroup](
	[id] [int]   NOT NULL,
	[GroupNumber] [int] NOT NULL,
	[GroupName] [varchar](50) NULL,
 CONSTRAINT [PK_PKGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PKGroup] UNIQUE NONCLUSTERED 
(
	[GroupNumber] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PKCategory]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PKCategory](
	[id] [int]   NOT NULL,
	[idPKGroup] [int] NOT NULL,
	[PKCategoryNumber] [int] NOT NULL,
 CONSTRAINT [PK_PKCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PKCategory] UNIQUE NONCLUSTERED 
(
	[idPKGroup] ASC,
	[PKCategoryNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PKCategorySalary]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PKCategorySalary](
	[id] [int]   NOT NULL,
	[SalarySize] [money] NOT NULL,
	[DateBegin] [datetime] NOT NULL,
	[DateEnd] [datetime] NULL,
	[idPKCategory] [int] NOT NULL,
 CONSTRAINT [PK_Salary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PKCategorySalary] UNIQUE NONCLUSTERED 
(
	[idPKCategory] ASC,
	[DateBegin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[id] [int]   NOT NULL,
	[PostName] [varchar](150) NULL,
	[ManagerBit] [bit] NOT NULL,
	[idGlobalPrikaz] [int] NOT NULL,
	[idPKCategory] [int] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrikazType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrikazType](
	[id] [int]   NOT NULL,
	[PrikazTypeName] [varchar](100) NOT NULL,
	[idPrikazSuperType] [int] NOT NULL,
 CONSTRAINT [PK_PrikazType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PrikazType] UNIQUE NONCLUSTERED 
(
	[PrikazTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Prikaz]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prikaz](
	[id] [int]   NOT NULL,
	[PrikazName] [varchar](50) NOT NULL,
	[DateBegin] [datetime] NULL,
	[DatePrikaz] [datetime] NULL,
	[idPrikazType] [int] NULL,
 CONSTRAINT [PK_Prikaz] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanStaff](
	[id] [int]   NOT NULL,
	[StaffCount] [numeric](4, 2) NOT NULL,
	[idCategory] [int] NOT NULL,
	[idDepartment] [int] NOT NULL,
	[idPost] [int] NOT NULL,
	[idBeginPrikaz] [int] NOT NULL,
	[idEndPrikaz] [int] NULL,
	[idFinancingSource] [int] NULL,
 CONSTRAINT [PK_PlanStaff] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int]   NOT NULL,
	[itab_n] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Otch] [varchar](50) NULL,
	[BirthDate] [datetime] NULL,
	[BirthPlace] [varchar](200) NULL,
	[SexBit] [bit] NOT NULL,
	[idGrazd] [int] NULL,
	[idSemPol] [int] NULL,
	[SeverKoeff] [int] NOT NULL,
	[RayonKoeff] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Employee] UNIQUE NONCLUSTERED 
(
	[FirstName] ASC,
	[LastName] ASC,
	[Otch] ASC,
	[BirthDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactStaff]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactStaff](
	[id] [int]   NOT NULL,
	[idPlanStaff] [int] NOT NULL,
	[idEmployee] [int] NOT NULL,
	[idTypeWork] [int] NOT NULL,
	[idBeginPrikaz] [int] NOT NULL,
	[idEndPrikaz] [int] NULL,
	[StaffCount] [numeric](3, 2) NOT NULL,
	[DateBegin] [datetime] NULL,
	[DateEnd] [datetime] NULL,
 CONSTRAINT [PK_FactStaff] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BonusType]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BonusType](
	[id] [int]   NOT NULL,
	[BonusTypeName] [varchar](50) NOT NULL,
	[idBonusSuperType] [int] NOT NULL,
	[idBonusMeasure] [int] NULL,
 CONSTRAINT [PK_TypeBonus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_TypeBonus] UNIQUE NONCLUSTERED 
(
	[BonusTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Bonus]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus](
	[id] [int]   NOT NULL,
	[BonusCount] [numeric](8, 2) NOT NULL,
	[DateBegin] [datetime] NULL,
	[DateEnd] [datetime] NULL,
	[idBonusType] [int] NOT NULL,
	[idPrikaz] [int] NULL,
 CONSTRAINT [PK_Bonus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[id] [int]   NOT NULL,
	[DepartmentName] [varchar](200) NOT NULL,
	[DepartmentSmallName] [varchar](50) NULL,
	[idDepartmentType] [int] NULL,
	[idManagerDepartment] [int] NULL,
	[KadrID] [int] NULL,
	[dateCreate] [datetime] NULL,
	[dateExit] [datetime] NULL,
	[idManagerPlanStaff] [int] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Department] UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EducDocument]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EducDocument](
	[id] [int]   NOT NULL,
	[idEducDocType] [int] NOT NULL,
	[DocSeries] [varchar](15) NULL,
	[DocNumber] [varchar](50) NULL,
	[DocDate] [datetime] NULL,
 CONSTRAINT [PK_EdicDocument] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EducDocument] UNIQUE NONCLUSTERED 
(
	[idEducDocType] ASC,
	[DocNumber] ASC,
	[DocSeries] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeDegree]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeDegree](
	[id] [int]   NOT NULL,
	[degreeDate] [datetime] NULL,
	[DissertCouncil] [varchar](200) NULL,
	[diplWhere] [varchar](200) NULL,
	[idDegree] [int] NOT NULL,
	[idScienceType] [int] NOT NULL,
	[idEmployee] [int] NOT NULL,
	[idEducDocument] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeDegree] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EmployeeDegree] UNIQUE NONCLUSTERED 
(
	[idEmployee] ASC,
	[idEducDocument] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EmployeeDegree_1] UNIQUE NONCLUSTERED 
(
	[idDegree] ASC,
	[idEmployee] ASC,
	[idScienceType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OKBufferEmployeeDegree]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OKBufferEmployeeDegree](
	[id] [int]   NOT NULL,
	[itab_n] [int] NULL,
	[degreeDate] [datetime] NULL,
	[DissertCouncil] [varchar](200) NULL,
	[dokSer] [varchar](100) NULL,
	[dokNum] [varchar](100) NULL,
	[diplDate] [datetime] NULL,
	[diplWhere] [varchar](200) NULL,
	[idDegree] [int] NOT NULL,
	[idScienceType] [int] NOT NULL,
 CONSTRAINT [PK_OKBufferEmployeeDegree] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_OKBufferEmployeeDegree_1] UNIQUE NONCLUSTERED 
(
	[itab_n] ASC,
	[idDegree] ASC,
	[idScienceType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeRank]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeRank](
	[id] [int]   NOT NULL,
	[idEmployee] [int] NOT NULL,
	[idRank] [int] NULL,
	[idEducDocument] [int] NOT NULL,
	[rankWhere] [varchar](200) NULL,
 CONSTRAINT [PK_EmployeeZvanye] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EmployeeRank] UNIQUE NONCLUSTERED 
(
	[idEmployee] ASC,
	[idEducDocument] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_EmployeeZvanye] UNIQUE NONCLUSTERED 
(
	[idEmployee] ASC,
	[idRank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BonusEmployee]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonusEmployee](
	[idBonus] [int] NOT NULL,
	[idEmployee] [int] NOT NULL,
 CONSTRAINT [PK_BonusEmployee] PRIMARY KEY CLUSTERED 
(
	[idBonus] ASC,
	[idEmployee] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactStaffReplacement]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactStaffReplacement](
	[id] [int]   NOT NULL,
	[idReplacementReason] [int] NOT NULL,
	[idFactStaff] [int] NOT NULL,
	[idReplacedFactStaff] [int] NOT NULL,
 CONSTRAINT [PK_FactStaffReplacement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_FactStaffReplacement] UNIQUE NONCLUSTERED 
(
	[idFactStaff] ASC,
	[idReplacedFactStaff] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BonusFactStaff]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonusFactStaff](
	[idBonus] [int] NOT NULL,
	[idFactStaff] [int] NOT NULL,
 CONSTRAINT [PK_BonusFactStaff] PRIMARY KEY CLUSTERED 
(
	[idBonus] ASC,
	[idFactStaff] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BonusPlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonusPlanStaff](
	[idBonus] [int] NOT NULL,
	[idPlanPost] [int] NOT NULL,
 CONSTRAINT [PK_BonusPlanStaff] PRIMARY KEY CLUSTERED 
(
	[idBonus] ASC,
	[idPlanPost] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanStaffSalary]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanStaffSalary](
	[id] [int]   NOT NULL,
	[SalarySize] [money] NOT NULL,
	[DateBegin] [datetime] NOT NULL,
	[DateEnd] [datetime] NULL,
	[idPlanStaff] [int] NOT NULL,
 CONSTRAINT [PK_PlanStaffSalary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PlanStaffSalary] UNIQUE NONCLUSTERED 
(
	[idPlanStaff] ASC,
	[DateBegin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BonusPost]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonusPost](
	[idPost] [int] NOT NULL,
	[idBonus] [int] NOT NULL,
 CONSTRAINT [PK_BonusPost] PRIMARY KEY CLUSTERED 
(
	[idPost] ASC,
	[idBonus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audit_Event]    Script Date: 09/22/2010 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit_Event](
	[OperationTypeID] [int] NOT NULL,
	[ObjectID] [int] NOT NULL,
	[AuditDateTime] [datetime] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[DepEmplCount]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DepEmplCount]
AS
SELECT     PlanStaff.idDepartment as idDepartment, 
	RTRIM(PKGroup.GroupNumber)+' '+RTRIM(PKCategory.PKCategoryNumber) AS PKCatName,
	SUM(dbo.PlanStaff.StaffCount) as planCount, SUM(FactStaffCount.factCount) as factCount
FROM  --dbo.Department CROSS JOIN      
			dbo.PKGroup INNER JOIN
             dbo.PKCategory ON dbo.PKCategory.idPKGroup = dbo.PKGroup.id LEFT JOIN
             dbo.Post ON dbo.Post.idPKCategory = dbo.PKCategory.id LEFT JOIN
             dbo.PlanStaff ON dbo.PlanStaff.idPost = dbo.Post.id --AND PlanStaff.idDepartment=Department.id 
             LEFT JOIN
			 (SELECT FactStaff.idPlanStaff, SUM(dbo.FactStaff.StaffCount) as factCount 
				FROM dbo.FactStaff 
				WHERE FactStaff.idEndPrikaz IS NULL
					AND FactStaff.id NOT IN (SELECT idFactStaff FROM dbo.FactStaffReplacement)
					GROUP BY FactStaff.idPlanStaff)FactStaffCount
				ON dbo.PlanStaff.id = FactStaffCount.idPlanStaff 
			--LEFT JOIN
			--[dbo].GetSubDepartmentStaffCounts(PlanStaff.idDepartment) SubDepsStaffCount
			--ON SubDepsStaffCount.idPKCategory=PKCategory.id
WHERE PlanStaff.idEndPrikaz IS NULL
	--ИСКЛЮЧАЕМ СОВМЕСТИТЕЛЕЙ - ОНИ НЕ ЗАНИМАЮТ ОТДЕЛЬНОЙ СТАВКИ
	--and PlanStaff.idDepartment is not null
GROUP BY PlanStaff.idDepartment, dbo.PKGroup.GroupNumber, dbo.PKCategory.PKCategoryNumber
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "FactStaff"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlanStaff"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 191
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Post"
            Begin Extent = 
               Top = 6
               Left = 449
               Bottom = 150
               Right = 609
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PKCategory"
            Begin Extent = 
               Top = 41
               Left = 709
               Bottom = 161
               Right = 892
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PKGroup"
            Begin Extent = 
               Top = 181
               Left = 515
               Bottom = 285
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DepEmplCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DepEmplCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DepEmplCount'
GO
/****** Object:  View [dbo].[PlanStaffsWithSalaries]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PlanStaffsWithSalaries]
AS
SELECT     dbo.PlanStaff.id, dbo.PlanStaff.StaffCount, dbo.PlanStaff.idCategory, dbo.PlanStaff.idDepartment, dbo.PlanStaff.idPost, dbo.PlanStaff.idBeginPrikaz, 
                      dbo.PlanStaff.idEndPrikaz, dbo.PlanStaff.idFinancingSource, dbo.PlanStaffSalary.SalarySize
FROM         dbo.PlanStaff INNER JOIN
                      dbo.PlanStaffSalary ON dbo.PlanStaff.id = dbo.PlanStaffSalary.idPlanStaff INNER JOIN
                      dbo.PKCategory ON dbo.PlanStaff.id = dbo.PKCategory.id INNER JOIN
                      dbo.PKCategorySalary ON dbo.PKCategory.id = dbo.PKCategorySalary.idPKCategory
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PlanStaff"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlanStaffSalary"
            Begin Extent = 
               Top = 96
               Left = 246
               Bottom = 253
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PKCategory"
            Begin Extent = 
               Top = 17
               Left = 435
               Bottom = 117
               Right = 610
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PKCategorySalary"
            Begin Extent = 
               Top = 6
               Left = 655
               Bottom = 148
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PlanStaffsWithSalaries'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PlanStaffsWithSalaries'
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDepartmentStaffCounts]    Script Date: 09/22/2010 10:21:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].GetSubDepartmentStaffCounts(1) 
--select * from [dbo].GetSubDepartmentStaffCounts(2)
CREATE FUNCTION [dbo].[GetSubDepartmentStaffCounts] 
(
@idManagerDepartment INT
)
RETURNS @Result TABLE
   (
    idPKCategory		INT NULL,
    planStaffCount     decimal(6,2)    NULL,
    factStaffCount	   decimal(6,2)         	   NULL
   ) 
AS
BEGIN
	
	DECLARE @SubDeps Table
	(
		idDepartment 			INT,
		idManagerDepartment		INT
	)
	
	INSERT INTO @SubDeps
		SELECT id, idManagerDepartment FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
	SELECT @idManagerDepartment = MIN(idDepartment) FROM @SubDeps
		WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @SubDeps)
	WHILE @idManagerDepartment IS NOT NULL
	BEGIN
		INSERT INTO @SubDeps
		VALUES(-1, @idManagerDepartment)
		
		INSERT INTO @SubDeps
		SELECT id, idManagerDepartment FROM dbo.Department WHERE idManagerDepartment=@idManagerDepartment
		
		SELECT @idManagerDepartment = MIN(idDepartment) FROM @SubDeps
			WHERE idDepartment NOT IN (SELECT idManagerDepartment FROM @SubDeps)
	END
	
	INSERT INTO @Result(idPKCategory,planStaffCount,factStaffCount)
		SELECT     
			idPKCategory,
			SUM(PlanStaff.StaffCount) as planCount, SUM(FactStaffCount.factCount) as factCount
		FROM  --dbo.Department CROSS JOIN      
					dbo.PKGroup INNER JOIN
					 dbo.PKCategory ON dbo.PKCategory.idPKGroup = dbo.PKGroup.id LEFT JOIN
					 dbo.Post ON dbo.Post.idPKCategory = dbo.PKCategory.id LEFT JOIN
					 (SELECT * FROM dbo.PlanStaff WHERE idDepartment IN
						(SELECT idDepartment FROM @SubDeps))PlanStaff 
					 ON PlanStaff.idPost = dbo.Post.id --AND PlanStaff.idDepartment=Department.id 
					 LEFT JOIN
					 (SELECT FactStaff.idPlanStaff, SUM(dbo.FactStaff.StaffCount) as factCount 
						FROM dbo.FactStaff 
						WHERE FactStaff.idEndPrikaz IS NULL
							AND FactStaff.id NOT IN (SELECT idFactStaff FROM dbo.FactStaffReplacement)
							GROUP BY FactStaff.idPlanStaff)FactStaffCount
						ON PlanStaff.id = FactStaffCount.idPlanStaff 
		WHERE PlanStaff.idEndPrikaz IS NULL
			--ИСКЛЮЧАЕМ СОВМЕСТИТЕЛЕЙ - ОНИ НЕ ЗАНИМАЮТ ОТДЕЛЬНОЙ СТАВКИ
		GROUP BY idPKCategory

RETURN
END
GO
/****** Object:  View [dbo].[pkCategorySalaryView]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pkCategorySalaryView]
AS
SELECT distinct    
	pkCategory.*,
	PKCategorySalary.SalarySize,
	DateBegin
FROM dbo.pkCategory,  dbo.PKCategorySalary 
where  pkCategory.id= PKCategorySalary.idPKCategory 
and   DateEnd is null
GO
/****** Object:  View [dbo].[PrikazView]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PrikazView]
AS
SELECT     
	Prikaz.*,
	PrikazName+' от '+CONVERT(VARCHAR(10),DatePrikaz,104) as PrikazLongName
FROM    dbo.Prikaz
GO
/****** Object:  View [dbo].[AuditView]    Script Date: 09/22/2010 10:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AuditView]
AS
SELECT     TOP (100) PERCENT dbo.Audit_Event.AuditDateTime, dbo.Audit_Event.UserName, dbo.Audit_Event.Description, dbo.Audit_Object.ObjectName, 
                      dbo.Audit_Object.ObjectTable, dbo.Audit_OperationType.OperationName, dbo.Audit_OperationType.OperationSQL
FROM         dbo.Audit_Event INNER JOIN
                      dbo.Audit_Object ON dbo.Audit_Event.ObjectID = dbo.Audit_Object.ObjectID INNER JOIN
                      dbo.Audit_OperationType ON dbo.Audit_Event.OperationTypeID = dbo.Audit_OperationType.OperationTypeID
ORDER BY dbo.Audit_Event.AuditDateTime DESC
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Audit_Event"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Audit_Object"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 110
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Audit_OperationType"
            Begin Extent = 
               Top = 6
               Left = 446
               Bottom = 110
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AuditView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AuditView'
GO
/****** Object:  StoredProcedure [dbo].[AuditLogEvent]    Script Date: 09/22/2010 10:21:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[AuditLogEvent]
@OperationTypeID int, @ObjectID int, @Description varchar(500)=''
AS
BEGIN
  INSERT INTO Audit_Event(OperationTypeID, ObjectID, Description) VALUES (@OperationTypeID, @ObjectID, @Description)
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDepartmentStaffCounts]    Script Date: 09/22/2010 10:21:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].GetDepartmentStaffCounts(1) 
--select * from [dbo].GetDepartmentStaffCounts(300)
--select * from [dbo].GetDepartmentStaffCounts(186)
CREATE FUNCTION [dbo].[GetDepartmentStaffCounts] 
(
@idDepartment INT
)
RETURNS @Result TABLE
   (
    PKCatName				VARCHAR(150) NULL,
    planStaffCount			decimal(6,2)    NULL,
    factStaffCount			decimal(6,2)         	   NULL,
    subPlanStaffCount		decimal(6,2)    NULL,
    subFactStaffCount		decimal(6,2)         	   NULL
   ) 
AS
BEGIN
	INSERT INTO @Result(PKCatName, planStaffCount, factStaffCount, subPlanStaffCount, subFactStaffCount)
	SELECT 	
		RTRIM(PKGroup.GroupNumber)+' '+RTRIM(PKCategory.PKCategoryNumber) AS PKCatName,
		ISNULL(SUM(PlanStaff.StaffCount),0) as planCount, ISNULL(SUM(FactStaffCount.factCount),0) as factCount,
		ISNULL(SubDepsStaffCount.planStaffCount,0) AS subPlanCount,
		ISNULL(SubDepsStaffCount.factStaffCount,0) AS subFactCount

FROM  --dbo.Department CROSS JOIN      
			dbo.PKGroup INNER JOIN
             dbo.PKCategory ON dbo.PKCategory.idPKGroup = dbo.PKGroup.id LEFT JOIN
             dbo.Post ON dbo.Post.idPKCategory = dbo.PKCategory.id LEFT JOIN
             (SELECT * FROM dbo.PlanStaff WHERE idDepartment=@idDepartment)PlanStaff 
				ON PlanStaff.idPost = dbo.Post.id --AND PlanStaff.idDepartment=Department.id 
             LEFT JOIN
			 (SELECT FactStaff.idPlanStaff, SUM(dbo.FactStaff.StaffCount) as factCount 
				FROM dbo.FactStaff 
				WHERE FactStaff.idEndPrikaz IS NULL
					AND FactStaff.id NOT IN (SELECT idFactStaff FROM dbo.FactStaffReplacement)
					GROUP BY FactStaff.idPlanStaff)FactStaffCount
				ON PlanStaff.id = FactStaffCount.idPlanStaff 
		
			LEFT JOIN
			[dbo].GetSubDepartmentStaffCounts(@idDepartment) SubDepsStaffCount
			ON SubDepsStaffCount.idPKCategory=PKCategory.id
WHERE PlanStaff.idEndPrikaz IS NULL
	--ИСКЛЮЧАЕМ СОВМЕСТИТЕЛЕЙ - ОНИ НЕ ЗАНИМАЮТ ОТДЕЛЬНОЙ СТАВКИ
	--and PlanStaff.idDepartment is not null
GROUP BY dbo.PKGroup.GroupNumber, dbo.PKCategory.PKCategoryNumber,
	SubDepsStaffCount.planStaffCount, SubDepsStaffCount.factStaffCount
	

RETURN
END
GO
/****** Object:  Default [DF_Audit_Event_AuditDateTime]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Audit_Event] ADD  CONSTRAINT [DF_Audit_Event_AuditDateTime]  DEFAULT (getdate()) FOR [AuditDateTime]
GO
/****** Object:  Default [DF_Audit_Event_UserName]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Audit_Event] ADD  CONSTRAINT [DF_Audit_Event_UserName]  DEFAULT (suser_sname()) FOR [UserName]
GO
/****** Object:  Default [DF_Employee_SeverKoeff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_SeverKoeff]  DEFAULT ((50)) FOR [SeverKoeff]
GO
/****** Object:  Default [DF_Employee_RayonKoeff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_RayonKoeff]  DEFAULT ((30)) FOR [RayonKoeff]
GO
/****** Object:  Default [DF_FactStaff_StaffCount]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff] ADD  CONSTRAINT [DF_FactStaff_StaffCount]  DEFAULT ((1)) FOR [StaffCount]
GO
/****** Object:  Default [DF_Post_ManagerBit]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_ManagerBit]  DEFAULT ((0)) FOR [ManagerBit]
GO
/****** Object:  Default [DF_WorkType_IsReplacement]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[WorkType] ADD  CONSTRAINT [DF_WorkType_IsReplacement]  DEFAULT ((0)) FOR [IsReplacement]
GO
/****** Object:  Check [CheckBonusDateBegin]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Bonus]  WITH CHECK ADD  CONSTRAINT [CheckBonusDateBegin] CHECK  (([DateBegin]<[DateEnd]))
GO
ALTER TABLE [dbo].[Bonus] CHECK CONSTRAINT [CheckBonusDateBegin]
GO
/****** Object:  Check [CK_FactStaffStaffCount]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [CK_FactStaffStaffCount] CHECK  (([StaffCount]>(0)))
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [CK_FactStaffStaffCount]
GO
/****** Object:  Check [CheckDateBegin]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PKCategorySalary]  WITH CHECK ADD  CONSTRAINT [CheckDateBegin] CHECK  (([DateBegin]<=[dateEnd]))
GO
ALTER TABLE [dbo].[PKCategorySalary] CHECK CONSTRAINT [CheckDateBegin]
GO
/****** Object:  Check [CheckSalarySize]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PKCategorySalary]  WITH CHECK ADD  CONSTRAINT [CheckSalarySize] CHECK  (([SalarySize]>(0)))
GO
ALTER TABLE [dbo].[PKCategorySalary] CHECK CONSTRAINT [CheckSalarySize]
GO
/****** Object:  Check [CK_PlanStaffStaffCount]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [CK_PlanStaffStaffCount] CHECK  (([StaffCount]>(0)))
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [CK_PlanStaffStaffCount]
GO
/****** Object:  Check [CheckPlanStaffSalaryDateBegin]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaffSalary]  WITH CHECK ADD  CONSTRAINT [CheckPlanStaffSalaryDateBegin] CHECK  (([DateBegin]<=[dateEnd]))
GO
ALTER TABLE [dbo].[PlanStaffSalary] CHECK CONSTRAINT [CheckPlanStaffSalaryDateBegin]
GO
/****** Object:  Check [CheckPlanStaffSalarySalarySize]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaffSalary]  WITH CHECK ADD  CONSTRAINT [CheckPlanStaffSalarySalarySize] CHECK  (([SalarySize]>(0)))
GO
ALTER TABLE [dbo].[PlanStaffSalary] CHECK CONSTRAINT [CheckPlanStaffSalarySalarySize]
GO
/****** Object:  ForeignKey [FK_Audit_Event_Audit_Object]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Audit_Event]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Event_Audit_Object] FOREIGN KEY([ObjectID])
REFERENCES [dbo].[Audit_Object] ([ObjectID])
GO
ALTER TABLE [dbo].[Audit_Event] CHECK CONSTRAINT [FK_Audit_Event_Audit_Object]
GO
/****** Object:  ForeignKey [FK_Audit_Event_Audit_OperationType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Audit_Event]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Event_Audit_OperationType] FOREIGN KEY([OperationTypeID])
REFERENCES [dbo].[Audit_OperationType] ([OperationTypeID])
GO
ALTER TABLE [dbo].[Audit_Event] CHECK CONSTRAINT [FK_Audit_Event_Audit_OperationType]
GO
/****** Object:  ForeignKey [FK_Bonus_BonusType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Bonus]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_BonusType] FOREIGN KEY([idBonusType])
REFERENCES [dbo].[BonusType] ([id])
GO
ALTER TABLE [dbo].[Bonus] CHECK CONSTRAINT [FK_Bonus_BonusType]
GO
/****** Object:  ForeignKey [FK_Bonus_Prikaz]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Bonus]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Prikaz] FOREIGN KEY([idPrikaz])
REFERENCES [dbo].[Prikaz] ([id])
GO
ALTER TABLE [dbo].[Bonus] CHECK CONSTRAINT [FK_Bonus_Prikaz]
GO
/****** Object:  ForeignKey [FK_BonusEmployee_Bonus]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BonusEmployee_Bonus] FOREIGN KEY([idBonus])
REFERENCES [dbo].[Bonus] ([id])
GO
ALTER TABLE [dbo].[BonusEmployee] CHECK CONSTRAINT [FK_BonusEmployee_Bonus]
GO
/****** Object:  ForeignKey [FK_BonusEmployee_Employee]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BonusEmployee_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[BonusEmployee] CHECK CONSTRAINT [FK_BonusEmployee_Employee]
GO
/****** Object:  ForeignKey [FK_BonusFactStaff_Bonus]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusFactStaff]  WITH CHECK ADD  CONSTRAINT [FK_BonusFactStaff_Bonus] FOREIGN KEY([idBonus])
REFERENCES [dbo].[Bonus] ([id])
GO
ALTER TABLE [dbo].[BonusFactStaff] CHECK CONSTRAINT [FK_BonusFactStaff_Bonus]
GO
/****** Object:  ForeignKey [FK_BonusFactStaff_FactStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusFactStaff]  WITH CHECK ADD  CONSTRAINT [FK_BonusFactStaff_FactStaff] FOREIGN KEY([idFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO
ALTER TABLE [dbo].[BonusFactStaff] CHECK CONSTRAINT [FK_BonusFactStaff_FactStaff]
GO
/****** Object:  ForeignKey [FK_BonusPlanStaff_Bonus]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusPlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_BonusPlanStaff_Bonus] FOREIGN KEY([idBonus])
REFERENCES [dbo].[Bonus] ([id])
GO
ALTER TABLE [dbo].[BonusPlanStaff] CHECK CONSTRAINT [FK_BonusPlanStaff_Bonus]
GO
/****** Object:  ForeignKey [FK_BonusPlanStaff_PlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusPlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_BonusPlanStaff_PlanStaff] FOREIGN KEY([idPlanPost])
REFERENCES [dbo].[PlanStaff] ([id])
GO
ALTER TABLE [dbo].[BonusPlanStaff] CHECK CONSTRAINT [FK_BonusPlanStaff_PlanStaff]
GO
/****** Object:  ForeignKey [FK_BonusPost_Bonus]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusPost]  WITH CHECK ADD  CONSTRAINT [FK_BonusPost_Bonus] FOREIGN KEY([idBonus])
REFERENCES [dbo].[Bonus] ([id])
GO
ALTER TABLE [dbo].[BonusPost] CHECK CONSTRAINT [FK_BonusPost_Bonus]
GO
/****** Object:  ForeignKey [FK_BonusPost_Post]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusPost]  WITH CHECK ADD  CONSTRAINT [FK_BonusPost_Post] FOREIGN KEY([idPost])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[BonusPost] CHECK CONSTRAINT [FK_BonusPost_Post]
GO
/****** Object:  ForeignKey [FK_BonusType_BonusMeasure]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusType]  WITH CHECK ADD  CONSTRAINT [FK_BonusType_BonusMeasure] FOREIGN KEY([idBonusMeasure])
REFERENCES [dbo].[BonusMeasure] ([id])
GO
ALTER TABLE [dbo].[BonusType] CHECK CONSTRAINT [FK_BonusType_BonusMeasure]
GO
/****** Object:  ForeignKey [FK_BonusType_BonusSuperType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[BonusType]  WITH CHECK ADD  CONSTRAINT [FK_BonusType_BonusSuperType] FOREIGN KEY([idBonusSuperType])
REFERENCES [dbo].[BonusSuperType] ([id])
GO
ALTER TABLE [dbo].[BonusType] CHECK CONSTRAINT [FK_BonusType_BonusSuperType]
GO
/****** Object:  ForeignKey [FK_Department_Department]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Department] FOREIGN KEY([idDepartmentType])
REFERENCES [dbo].[DepartmentType] ([id])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Department]
GO
/****** Object:  ForeignKey [FK_Department_Department2]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Department2] FOREIGN KEY([idManagerDepartment])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Department2]
GO
/****** Object:  ForeignKey [FK_Department_PlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_PlanStaff] FOREIGN KEY([idManagerPlanStaff])
REFERENCES [dbo].[PlanStaff] ([id])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_PlanStaff]
GO
/****** Object:  ForeignKey [FK_EducDocument_EducDocumentType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EducDocument]  WITH CHECK ADD  CONSTRAINT [FK_EducDocument_EducDocumentType] FOREIGN KEY([idEducDocType])
REFERENCES [dbo].[EducDocumentType] ([id])
GO
ALTER TABLE [dbo].[EducDocument] CHECK CONSTRAINT [FK_EducDocument_EducDocumentType]
GO
/****** Object:  ForeignKey [FK_Employee_Grazd]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Grazd] FOREIGN KEY([idGrazd])
REFERENCES [dbo].[Grazd] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Grazd]
GO
/****** Object:  ForeignKey [FK_Employee_SemPol]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_SemPol] FOREIGN KEY([idSemPol])
REFERENCES [dbo].[SemPol] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_SemPol]
GO
/****** Object:  ForeignKey [FK_EmployeeDegree_Degree]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDegree_Degree] FOREIGN KEY([idDegree])
REFERENCES [dbo].[Degree] ([id])
GO
ALTER TABLE [dbo].[EmployeeDegree] CHECK CONSTRAINT [FK_EmployeeDegree_Degree]
GO
/****** Object:  ForeignKey [FK_EmployeeDegree_EducDocument]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDegree_EducDocument] FOREIGN KEY([idEducDocument])
REFERENCES [dbo].[EducDocument] ([id])
GO
ALTER TABLE [dbo].[EmployeeDegree] CHECK CONSTRAINT [FK_EmployeeDegree_EducDocument]
GO
/****** Object:  ForeignKey [FK_EmployeeDegree_Employee]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDegree_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[EmployeeDegree] CHECK CONSTRAINT [FK_EmployeeDegree_Employee]
GO
/****** Object:  ForeignKey [FK_EmployeeDegree_ScienceType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDegree_ScienceType] FOREIGN KEY([idScienceType])
REFERENCES [dbo].[ScienceType] ([id])
GO
ALTER TABLE [dbo].[EmployeeDegree] CHECK CONSTRAINT [FK_EmployeeDegree_ScienceType]
GO
/****** Object:  ForeignKey [FK_EmployeeRank_EducDocument]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeRank]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeRank_EducDocument] FOREIGN KEY([idEducDocument])
REFERENCES [dbo].[EducDocument] ([id])
GO
ALTER TABLE [dbo].[EmployeeRank] CHECK CONSTRAINT [FK_EmployeeRank_EducDocument]
GO
/****** Object:  ForeignKey [FK_EmployeeRank_Rank]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeRank]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeRank_Rank] FOREIGN KEY([idRank])
REFERENCES [dbo].[Rank] ([id])
GO
ALTER TABLE [dbo].[EmployeeRank] CHECK CONSTRAINT [FK_EmployeeRank_Rank]
GO
/****** Object:  ForeignKey [FK_EmployeeZvanye_Employee]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[EmployeeRank]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeZvanye_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[EmployeeRank] CHECK CONSTRAINT [FK_EmployeeZvanye_Employee]
GO
/****** Object:  ForeignKey [FK_FactStaff_Employee]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [FK_FactStaff_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [FK_FactStaff_Employee]
GO
/****** Object:  ForeignKey [FK_FactStaff_PlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [FK_FactStaff_PlanStaff] FOREIGN KEY([idPlanStaff])
REFERENCES [dbo].[PlanStaff] ([id])
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [FK_FactStaff_PlanStaff]
GO
/****** Object:  ForeignKey [FK_FactStaff_Prikaz]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [FK_FactStaff_Prikaz] FOREIGN KEY([idBeginPrikaz])
REFERENCES [dbo].[Prikaz] ([id])
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [FK_FactStaff_Prikaz]
GO
/****** Object:  ForeignKey [FK_FactStaff_Prikaz1]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [FK_FactStaff_Prikaz1] FOREIGN KEY([idEndPrikaz])
REFERENCES [dbo].[Prikaz] ([id])
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [FK_FactStaff_Prikaz1]
GO
/****** Object:  ForeignKey [FK_FactStaff_TypeWork]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaff]  WITH CHECK ADD  CONSTRAINT [FK_FactStaff_TypeWork] FOREIGN KEY([idTypeWork])
REFERENCES [dbo].[WorkType] ([id])
GO
ALTER TABLE [dbo].[FactStaff] CHECK CONSTRAINT [FK_FactStaff_TypeWork]
GO
/****** Object:  ForeignKey [FK_FactStaffReplacement_FactStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaffReplacement]  WITH CHECK ADD  CONSTRAINT [FK_FactStaffReplacement_FactStaff] FOREIGN KEY([idReplacedFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO
ALTER TABLE [dbo].[FactStaffReplacement] CHECK CONSTRAINT [FK_FactStaffReplacement_FactStaff]
GO
/****** Object:  ForeignKey [FK_FactStaffReplacement_FactStaff1]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaffReplacement]  WITH CHECK ADD  CONSTRAINT [FK_FactStaffReplacement_FactStaff1] FOREIGN KEY([idFactStaff])
REFERENCES [dbo].[FactStaff] ([id])
GO
ALTER TABLE [dbo].[FactStaffReplacement] CHECK CONSTRAINT [FK_FactStaffReplacement_FactStaff1]
GO
/****** Object:  ForeignKey [FK_FactStaffReplacement_ReplacementReason]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[FactStaffReplacement]  WITH CHECK ADD  CONSTRAINT [FK_FactStaffReplacement_ReplacementReason] FOREIGN KEY([idReplacedFactStaff])
REFERENCES [dbo].[FactStaffReplacementReason] ([id])
GO
ALTER TABLE [dbo].[FactStaffReplacement] CHECK CONSTRAINT [FK_FactStaffReplacement_ReplacementReason]
GO
/****** Object:  ForeignKey [FK_OKBufferEmployeeDegree_Degree]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[OKBufferEmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_OKBufferEmployeeDegree_Degree] FOREIGN KEY([idDegree])
REFERENCES [dbo].[Degree] ([id])
GO
ALTER TABLE [dbo].[OKBufferEmployeeDegree] CHECK CONSTRAINT [FK_OKBufferEmployeeDegree_Degree]
GO
/****** Object:  ForeignKey [FK_OKBufferEmployeeDegree_ScienceType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[OKBufferEmployeeDegree]  WITH CHECK ADD  CONSTRAINT [FK_OKBufferEmployeeDegree_ScienceType] FOREIGN KEY([idScienceType])
REFERENCES [dbo].[ScienceType] ([id])
GO
ALTER TABLE [dbo].[OKBufferEmployeeDegree] CHECK CONSTRAINT [FK_OKBufferEmployeeDegree_ScienceType]
GO
/****** Object:  ForeignKey [FK_PKCategory_PKCategory]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PKCategory]  WITH CHECK ADD  CONSTRAINT [FK_PKCategory_PKCategory] FOREIGN KEY([idPKGroup])
REFERENCES [dbo].[PKGroup] ([id])
GO
ALTER TABLE [dbo].[PKCategory] CHECK CONSTRAINT [FK_PKCategory_PKCategory]
GO
/****** Object:  ForeignKey [FK_PKCategorySalary_PKCategory]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PKCategorySalary]  WITH CHECK ADD  CONSTRAINT [FK_PKCategorySalary_PKCategory] FOREIGN KEY([idPKCategory])
REFERENCES [dbo].[PKCategory] ([id])
GO
ALTER TABLE [dbo].[PKCategorySalary] CHECK CONSTRAINT [FK_PKCategorySalary_PKCategory]
GO
/****** Object:  ForeignKey [FK_PlanStaff_Category]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_Category]
GO
/****** Object:  ForeignKey [FK_PlanStaff_Department]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_Department] FOREIGN KEY([idDepartment])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_Department]
GO
/****** Object:  ForeignKey [FK_PlanStaff_FinancingSource]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_FinancingSource] FOREIGN KEY([idFinancingSource])
REFERENCES [dbo].[FinancingSource] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_FinancingSource]
GO
/****** Object:  ForeignKey [FK_PlanStaff_Post]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_Post] FOREIGN KEY([idPost])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_Post]
GO
/****** Object:  ForeignKey [FK_PlanStaff_PrikazBegin]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_PrikazBegin] FOREIGN KEY([idBeginPrikaz])
REFERENCES [dbo].[Prikaz] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_PrikazBegin]
GO
/****** Object:  ForeignKey [FK_PlanStaff_PrikazEnd]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaff]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaff_PrikazEnd] FOREIGN KEY([idEndPrikaz])
REFERENCES [dbo].[Prikaz] ([id])
GO
ALTER TABLE [dbo].[PlanStaff] CHECK CONSTRAINT [FK_PlanStaff_PrikazEnd]
GO
/****** Object:  ForeignKey [FK_PlanStaffSalary_PlanStaff]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PlanStaffSalary]  WITH CHECK ADD  CONSTRAINT [FK_PlanStaffSalary_PlanStaff] FOREIGN KEY([idPlanStaff])
REFERENCES [dbo].[PlanStaff] ([id])
GO
ALTER TABLE [dbo].[PlanStaffSalary] CHECK CONSTRAINT [FK_PlanStaffSalary_PlanStaff]
GO
/****** Object:  ForeignKey [FK_Post_GlobalPrikaz]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_GlobalPrikaz] FOREIGN KEY([idGlobalPrikaz])
REFERENCES [dbo].[GlobalPrikaz] ([id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_GlobalPrikaz]
GO
/****** Object:  ForeignKey [FK_Post_PKCategory]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_PKCategory] FOREIGN KEY([idPKCategory])
REFERENCES [dbo].[PKCategory] ([id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_PKCategory]
GO
/****** Object:  ForeignKey [FK_Prikaz_PrikazType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[Prikaz]  WITH CHECK ADD  CONSTRAINT [FK_Prikaz_PrikazType] FOREIGN KEY([idPrikazType])
REFERENCES [dbo].[PrikazType] ([id])
GO
ALTER TABLE [dbo].[Prikaz] CHECK CONSTRAINT [FK_Prikaz_PrikazType]
GO
/****** Object:  ForeignKey [FK_PrikazType_PrikazSuperType]    Script Date: 09/22/2010 10:21:39 ******/
ALTER TABLE [dbo].[PrikazType]  WITH CHECK ADD  CONSTRAINT [FK_PrikazType_PrikazSuperType] FOREIGN KEY([idPrikazSuperType])
REFERENCES [dbo].[PrikazSuperType] ([id])
GO
ALTER TABLE [dbo].[PrikazType] CHECK CONSTRAINT [FK_PrikazType_PrikazSuperType]
GO
