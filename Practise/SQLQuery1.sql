select * from Hospital.Patient

INSERT INTO OPENROWSET('Microsoft.ACE.OLEDB.12.0',  
    'Text;Database=W:\Users\sardo\OneDrive\Desktop\Maab and Data Analytics',  
    'SELECT * FROM [mydata.csv]')  
SELECT * FROM Hospital.Patient


EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1;
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1;


-- xp_cmdshell ni yoqish uchun
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;


EXEC xp_cmdshell 'bcp "select * from Hospital.Department" queryout "S:\ftt\patients.csv" -c -t -T '



Sardors-laptop\SQLSERVER2025  as varchar(max)

SQLState = 28000, NativeError = 18456
Error = [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]Login failed for user 'NT Service\MSSQL$SQLSERVER2025'.
NULL



select @@SERVERNAME

select * from Hospital.Department




--BCP - bulk copy Program

--Ishlamasa  SQL Serverga Kerakli Ruxsat Berish kk 
USE master;
GO
GRANT EXECUTE ON xp_cmdshell TO [NT Service\MSSQL$SQLSERVER2025];
GO

--xp_cmdshell-ni Faollashtirish

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- NT Service hisobiga SQL Serverga kirish ruxsatini berish

USE master;
GO
CREATE LOGIN [NT Service\Sardors-laptop\SQLSERVER2025] FROM WINDOWS;
ALTER SERVER ROLE sysadmin ADD MEMBER [NT Service\MSSQL$SQLSERVER2025];
GO

--power shell dan NT service name olish

--whoami /user




declare @BCPTEXT as varchar(1000)

select @BCPTEXT= 'bcp "Select * from [Hospital].[Department]" queryout "S:\ftt\patients.csv" -c -t, -T ' 

EXEC xp_cmdshell @BCPTEXT




--creating user for NT Service 

USE master;
GO
CREATE LOGIN [NT Service\MSSQL$SQLSERVER2025] FROM WINDOWS;
ALTER SERVER ROLE sysadmin ADD MEMBER [NT Service\MSSQL$SQLSERVER2025];
GO


BULK INSERT SalesData
FROM 'W:\Users\sardo\OneDrive\Desktop\SalesData.csv'
WITH(
  Format = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
\


	BULK INSERT SalesDatatest
	FROM 'W:\\SalesData.csv'
	WITH(
	   
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		FIRSTROW = 2
	)




create table SalesDataTEst (Date date, product varchar(max), sales int )




select * from SalesDataTEst

select * from homework3



EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

EXEC sp_MSset_oledb_prop N'BULK', N'AllowInProcess', 1;
EXEC sp_MSset_oledb_prop N'BULK', N'DynamicParameters', 1;
