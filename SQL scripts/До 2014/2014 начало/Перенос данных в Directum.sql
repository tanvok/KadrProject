/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Department].id Code
      ,[Department].[DepartmentName] Name
	  ,1 Our_Organization
      ,[Department].idManagerDepartment HeadDepartment
	  ,0 ChiefManager
      ,ISNULL([Department].[DepPhoneNumber],'') Phone
  FROM [Kadr].[dbo].[Department] 
WHERE [Department].id<>1 --AND idManagerDepartment<>1

  FOR XML PATH('Record')




SELECT Employee.id Code
      ,CONVERT(VARCHAR(10),Employee.BirthDate,104) BirthDate
	  ,Post.PostName Position
	  ,'' HomeAddress
	  ,'' HomePhone
	  ,LastName LastName
	  ,FirstName FirstName
	  ,1 Our_Organization
	  ,Otch PatronymicName
	  ,'' Fax
	  ,'' WorkPhone
	  ,'' WorkEmail
	  ,'' ITIN
	  ,'' PersonalEmail
	  ,paspser+' '+paspnomer +' от '+CONVERT(VARCHAR(10),paspdate,104)  PassportInformation
	  , staff.idDepartment Department
	  ,'Мужской' Gender
	  ,'' Photo
	  ,'' Comment
  FROM 
   [dbo].[GetStaffByPeriod](GETDATE(),GETDATE())staff
   INNER JOIN dbo.Employee ON staff.idEmployee=Employee.id
   INNER JOIN dbo.Post ON staff.idPost=Post.id
WHERE staff.idDepartment<>1
AND [SexBit]=1

UNION SELECT
Employee.id Code
      ,CONVERT(VARCHAR(10),Employee.BirthDate,104) BirthDate
	  ,Post.PostName Position
	  ,'' HomeAddress
	  ,'' HomePhone
	  ,LastName LastName
	  ,FirstName FirstName
	  ,1 Our_Organization
	  ,Otch PatronymicName
	  ,'' Fax
	  ,'' WorkPhone
	  ,'' WorkEmail
	  ,'' ITIN
	  ,'' PersonalEmail
	  ,paspser+' '+paspnomer +' от '+CONVERT(VARCHAR(10),paspdate,104)  PassportInformation
	  , staff.idDepartment Department
	  ,'Женский' Gender
	  ,'' Photo
	  ,'' Comment
  FROM 
   [dbo].[GetStaffByPeriod](GETDATE(),GETDATE())staff
   INNER JOIN dbo.Employee ON staff.idEmployee=Employee.id
   INNER JOIN dbo.Post ON staff.idPost=Post.id
WHERE staff.idDepartment<>1
AND [SexBit]=0
  FOR XML PATH('Record')

 


 SELECT 
 'ПОД' Vid, [Department].id Kod,[Department].[DepartmentName] Name
 	  ,(SELECT 'Состояние' Name,
			'Priznak' Type,
			'Действующая' Value
			FOR XML raw('Requisite'),type)
	  ,(SELECT 'НашаОрг' Name,
			'Reference' Type,
			(SELECT 'НОР' Vid,
				1 Kod,
				'Федеральное государственное бюджетное образовательное учреждение высшего профессионального образования Ухтинский государственный технический университет' Name
				FOR XML raw('RecordRef'),type)
			FOR XML raw('Requisite'),type)	
		,(SELECT 'USTUIdStuct' Name,
			'String' Type,
			DepartmentGUID Value
			FOR XML raw('Requisite'),type)
  FROM [Kadr].[dbo].[Department] 
WHERE [Department].id<>1 --AND idManagerDepartment<>1
AND ([dateExit]>GETDATE() OR [dateExit] IS NULL)
  FOR XML raw('RecordRef'),type




 SELECT 
 'ПОД' Vid, [Department].id Kod,[Department].[DepartmentName] Name
 	  ,(SELECT 'Состояние' Name,
			'Priznak' Type,
			'Действующая' Value
			FOR XML raw('Requisite'),type)
	  ,(SELECT 'НашаОрг' Name,
			'Reference' Type,
			(SELECT 'НОР' Vid,
				1 Kod,
				'Федеральное государственное бюджетное образовательное учреждение высшего профессионального образования Ухтинский государственный технический университет' Name
				FOR XML raw('RecordRef'),type)
			FOR XML raw('Requisite'),type)	
		,(SELECT 'USTUIdStuct' Name,
			'String' Type,
			DepartmentGUID Value
			FOR XML raw('Requisite'),type)
  FROM [Kadr].[dbo].[Department] 
WHERE [Department].id<>1 --AND idManagerDepartment<>1
AND ([dateExit]>GETDATE() OR [dateExit] IS NULL)
  FOR XML raw('RecordRef'),type







SELECT 'ПРС' Vid, 
	Employee.id Kod,
	Employee.[EmployeeName] Name,
	(SELECT
		'Состояние' Name,
		'Priznak' Type,
		'Действующая' Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение' Name,
		'String' Type,
		[LastName] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение2' Name,
		'String' Type,
		[FirstName] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение3' Name,
		'String' Type,
		[Otch] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Признак2' Name,
		'Priznak' Type,
		'Мужской' Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Строка2' Name,
		'String' Type,
		[EmployeeLogin] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Город' Name,
		'Reference' Type,
		(SELECT
			'ГРД' Vid,
			'Д000164' Kod,
			'Ухта' Name,
			(SELECT
				'Ведущая аналитика' Name,
				'Reference' Type,
				(SELECT
					'РЕГ' Vid,
					'Д000154' Kod,
					'Республика Коми' Name
					FOR XML raw('RecordRef'),type) 
				FOR XML raw('Requisite'),type)
			FOR XML raw('RecordRef'),type) 
		FOR XML raw('Requisite'),type),
	(SELECT
		'ДаНет' Name,
		'Priznak' Type,
		'Нет' Value
		FOR XML raw('Requisite'),type)  
  FROM 
   (SELECT idEmployee FROM [dbo].[GetStaffByPeriod](GETDATE(),GETDATE()) GROUP BY idEmployee)staff
   INNER JOIN dbo.Employee ON staff.idEmployee=Employee.id
WHERE [SexBit]=1
FOR XML raw('RecordRef'),type  

SELECT 'ПРС' Vid, 
	Employee.id Kod,
	Employee.[EmployeeName] Name,
	(SELECT
		'Состояние' Name,
		'Priznak' Type,
		'Действующая' Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение' Name,
		'String' Type,
		[LastName] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение2' Name,
		'String' Type,
		[FirstName] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Дополнение3' Name,
		'String' Type,
		[Otch] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Признак2' Name,
		'Priznak' Type,
		'Женский' Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Строка2' Name,
		'String' Type,
		[EmployeeLogin] Value
		FOR XML raw('Requisite'),type),
	(SELECT
		'Город' Name,
		'Reference' Type,
		(SELECT
			'ГРД' Vid,
			'Д000164' Kod,
			'Ухта' Name,
			(SELECT
				'Ведущая аналитика' Name,
				'Reference' Type,
				(SELECT
					'РЕГ' Vid,
					'Д000154' Kod,
					'Республика Коми' Name
					FOR XML raw('RecordRef'),type) 
				FOR XML raw('Requisite'),type)
			FOR XML raw('RecordRef'),type) 
		FOR XML raw('Requisite'),type),
	(SELECT
		'ДаНет' Name,
		'Priznak' Type,
		'Нет' Value
		FOR XML raw('Requisite'),type)  
  FROM 
   (SELECT idEmployee FROM [dbo].[GetStaffByPeriod](GETDATE(),GETDATE()) GROUP BY idEmployee)staff
   INNER JOIN dbo.Employee ON staff.idEmployee=Employee.id
WHERE  [SexBit]=0
FOR XML raw('RecordRef'),type  













---Должности
 SELECT 
 'PositionKinds' Vid, Post.id Kod, Post.PostName Name
 	  ,(SELECT 'Состояние' Name,
			'Priznak' Type,
			'Действующая' Value
			FOR XML raw('Requisite'),type)
  FROM [Kadr].[dbo].Post
WHERE [DateEnd] IS  NULL OR [DateEnd]> GETDATE()
  FOR XML raw('RecordRef'),type


<RecordRef Vid="PositionKinds" Kod="Д000003" Name="УВП">
Requisite Name="Состояние" Type="Priznak" Value="Действующая"/>
</RecordRef>