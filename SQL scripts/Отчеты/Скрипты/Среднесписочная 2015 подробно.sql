select 
Post.PostName,
WorkSuperType.WorkSuperTypeName,
[Employee].EmployeeName,
MonthName TimeSheetMonthName,
StaffAverage, FreeStaffAverage, TimeSheetHourCount
from [dbo].[GetAverageSums](2015,1,1, 1,12)averSums
inner join [dbo].[FactStaff] on averSums.idFactStaff=[FactStaff].id
inner join [dbo].[Employee] on [FactStaff].[idEmployee]=[Employee].id
INNER JOIN  dbo.WorkType ON averSums.idTypeWork=WorkType.id
		INNER JOIN dbo.WorkSuperType ON WorkType.idWorkSuperType=WorkSuperType.id
		INNER JOIN dbo.Months ON Months.MonthNumber=averSums.TimeSheetMonth
		INNER JOIN dbo.Post ON averSums.idPost=Post.id