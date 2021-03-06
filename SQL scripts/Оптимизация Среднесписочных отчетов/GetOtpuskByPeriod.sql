USE [Kadr]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOtpuskByPeriod]    Script Date: 23.04.2015 16:09:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--выбирает отпуски за заданный период
--SET STATISTICS TIME ON
--select * from [dbo].[GetOtpuskByPeriod_exper]('20.01.2013','20.05.2015')
DROP FUNCTION [dbo].[GetOtpuskByPeriod_exper] 
go
CREATE FUNCTION [dbo].[GetOtpuskByPeriod_exper] 
(
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL
)
RETURNS @Result TABLE
   (
	idOtpusk	INT,
    idFactStaff		INT NOT NULL,
	idOtpuskVid INT,
    isMaternity BIT,
	otpTypeShortName VARCHAR(50),
	[DateBegin] DATE,
	[DateEnd] DATE
   ) 

AS
BEGIN
INSERT INTO @Result
 SELECT OK_Otpusk.idOtpusk, OK_Otpusk.idFactStaff, OK_Otpusk.idOtpuskVid,
		isMaternity, otpTypeShortName, [DateBegin], [DateEnd]
	FROM dbo.OK_Otpusk INNER JOIN dbo.OK_Otpuskvid ON OK_Otpusk.idOtpuskVid=OK_Otpuskvid.idOtpuskVid
	WHERE 
		((OK_Otpusk.DateBegin<=@PeriodBegin AND (OK_Otpusk.DateEnd>=@PeriodBegin OR OK_Otpusk.DateEnd IS NULL))
								OR (OK_Otpusk.DateBegin>=@PeriodBegin AND OK_Otpusk.DateBegin<=@PeriodEnd))
RETURN
	--group by FactStaff.id, idPlanStaff, idEmployee, idTypeWork, IsReplacement, LastFactStaff.DateBegin		  
		  
END


GO
--выбирает отпуски за заданный период
--select * from [dbo].[GetOtpuskByPeriod]('20.01.2013','20.05.2015')
ALTER FUNCTION [dbo].[GetOtpuskByPeriod] 
(
@PeriodBegin	DATETIME=NULL,
@PeriodEnd	DATETIME=NULL
)
RETURNS  TABLE

AS
RETURN (SELECT OK_Otpusk.idOtpusk, OK_Otpusk.idFactStaff, OK_Otpusk.idOtpuskVid,
		isMaternity, otpTypeShortName, [DateBegin], [DateEnd]
	FROM dbo.OK_Otpusk INNER JOIN dbo.OK_Otpuskvid ON OK_Otpusk.idOtpuskVid=OK_Otpuskvid.idOtpuskVid
	WHERE 
		((OK_Otpusk.DateBegin<=@PeriodBegin AND (OK_Otpusk.DateEnd>=@PeriodBegin OR OK_Otpusk.DateEnd IS NULL))
								OR (OK_Otpusk.DateBegin>=@PeriodBegin AND OK_Otpusk.DateBegin<=@PeriodEnd))
	)
	--group by FactStaff.id, idPlanStaff, idEmployee, idTypeWork, IsReplacement, LastFactStaff.DateBegin