 
		

	SELECT DepartmentName,  PostName, WorkSuperTypeShortName TypeWorkName, Employee.EmployeeName, TimeSheetMonth, MonthName TimeSheetMonthName,
		(StaffAverage) StaffAverage,
		FreeStaffAverage,
		
		(TimeSheetHourCount),
		(PersonCount) 
		
	FROM 
		[dbo].[GetAverageSums](2015, 1,1,1,6)averSums
		INNER JOIN  dbo.WorkType ON averSums.idTypeWork=WorkType.id
		INNER JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
		INNER JOIN dbo.Months ON Months.MonthNumber=averSums.TimeSheetMonth
		INNER JOIN dbo.Post ON averSums.idPost=Post.id
		INNER JOIN dbo.Category ON Post.idCategory=Category.id
		INNER JOIN dbo.FinancingSource ON FinancingSource.id=averSums.idFinancingSource
		inner join dbo.Employee ON averSums.idEmployee=Employee.id
		LEFT JOIN [dbo].[CategoryVPO] ON [CategoryVPO].id=Post.idCategoryVPO
		LEFT JOIN [dbo].[CategoryZP] ON [CategoryZP].id=Post.idCategoryZP
		LEFT JOIN [dbo].[OKVED] ON averSums.idOKVED=[OKVED].id
	WHERE 
		WorkType.idWorkSuperType<>4
ORDER BY 
DepartmentName,  PostName, WorkSuperTypeShortName , Employee.EmployeeName, TimeSheetMonth
--‘»ќ, должность, вид работ, количество дней или дол€ отработанна€ отдельно по мес€цам.