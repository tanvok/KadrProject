/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Department.DepartmentName, DepartmentSmallName, [FinancingSource].FinancingSourceName, Employee.EmployeeName, Prikaz.PrikazName+' от '+ CONVERT(VARCHAR(10),Prikaz.DatePrikaz,102),
  [YearNumber], [MonthNumber], FactStaff.[HourCount],FactStaff.[HourSalary]--,FactStaff.[HourFullSalary]
  FROM [Kadr].[dbo].[FactStaffMonthHour]
  inner join
 [dbo].[FactStaffCurrent] FactStaff
 ON [FactStaffMonthHour].idFactStaff=FactStaff.id
 left join 
 [dbo].[FactStaffCurrent] MainFactStaff
 ON FactStaff.[idMainFactStaff]=MainFactStaff.id
  left join [dbo].[Employee] ON FactStaff.idEmployee=Employee.id or MainFactStaff.idEmployee=Employee.id

 left join dbo.Department ON FactStaff.idDepartment=Department.id

 left join [dbo].[FinancingSource] ON FactStaff.[idFinancingSource]=[FinancingSource].id or MainFactStaff.[idFinancingSource]=[FinancingSource].id
 left join [dbo].Prikaz ON FactStaff.idBeginPrikaz=Prikaz.id or MainFactStaff.idBeginPrikaz=Prikaz.id
 ORDER BY Department.DepartmentName, DepartmentSmallName, [FinancingSource].FinancingSourceName, Employee.EmployeeName, 
  [YearNumber], [MonthNumber]
 --where [Employee].id is null