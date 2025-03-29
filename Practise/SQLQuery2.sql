


BULK INSERT SalesDatatest
	FROM 'C:\Temp\SalesData.csv'
	WITH(
	   format = 'csv',
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '0x0a',
		FIRSTROW = 2
	)



EXEC xp_fileexist 'W:\SalesData.csv';
