SELECT currentOtp.idFactStaff, Employee.EmployeeName, otpTypeShortName, CONVERT(VARCHAR(10),[DateBegin],104), CONVERT(VARCHAR(10),[OK_Otpusk].[DateEnd],104)
FROM
			[dbo].[GetOtpuskByPeriod]('03.3.2014','03.3.2014')currentOtp
inner join [dbo].[OK_Otpusk] ON currentOtp.idOtpusk=[OK_Otpusk].idOtpusk	
inner join dbo.FactStaff ON currentOtp.idFactStaff=FactStaff.id
inner join dbo.Employee ON 	FactStaff.idEmployee=Employee.id	
WHERE isMaternity=1
order by EmployeeName, otpTypeShortName



SELECT idFactStaff, MIN(otpTypeShortName) otpTypeShortName  FROM
			[dbo].[GetOtpuskByPeriod]('03.3.2014','03.3.2014')
			WHERE isMaternity=1 and idFactStaff= 11007
			GROUP BY idFactStaff

