/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PlanStaffSalary].*, Sal2.*,Sal2.DateBegin-1  --, Employee.EmployeeName
--update [PlanStaffSalary]
--SET DateEnd=Sal2.DateBegin-1
FROM 
(SELECT    DISTINCT  [idPlanStaff], COUNT([SalarySize]) Col
      
  FROM [Kadr].[dbo].[PlanStaffSalary]
  WHERE [DateEnd] IS NULL
  GROUP BY [idPlanStaff]
  HAVING COUNT([SalarySize])>1)Salaries
  INNER JOIN [dbo].[GetSalaryByPeriod]('04.15.2014','04.15.2014')CurrentSalaries
	ON Salaries.idPlanStaff=CurrentSalaries.idPlanStaff 
INNER JOIN [dbo].[PlanStaffSalary] 
	ON [PlanStaffSalary].idPlanStaff=CurrentSalaries.idPlanStaff
		AND [PlanStaffSalary].SalarySize<>CurrentSalaries.SalarySize
INNER JOIN [dbo].[PlanStaffSalary] Sal2
	ON CurrentSalaries.idPlanStaff=Sal2.idPlanStaff
		AND CurrentSalaries.SalarySize=Sal2.SalarySize
 WHERE [PlanStaffSalary].DateEnd IS NULL