---------- Crear BD-------
CREATE DATABASE Hotel
ON PRIMARY
	(NAME = Hotel_Data,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\DATA\Hotel_Data.mdf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),
	
	( NAME = Hotel_Data_2,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\DATA\Hotel_Data_2.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

FILEGROUP Hotel_filegroup1
	( NAME = Hotel_Data_3,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\DATA\Hotel_Data_3.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),
	
	( NAME = Hotel_Data_4,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\DATA\Hotel_Data_4.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

FILEGROUP Hotel_group_2
	( NAME = Hotel_Data_5,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\DATA\Hotel_Data_5.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%)

LOG ON
	( NAME = Hotel_Log_1,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\LOG\Hotel_Log_1.ldf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

	( NAME = Hotel_Log_2,
	  FILENAME = N'D:\BDII IIIC 2021\SQL\LOG\Hotel_Log_2.ldf',
          SIZE = 5MB,
          MAXSIZE = 25MB,
          FILEGROWTH = 5MB)
GO

-----------crear dispositivo-------------
USE Hotel;  
GO

EXEC sp_addumpdevice 'disk', 'HotelData',   
'D:\BDII IIIC 2021\SQL\BACKUP\HotelData.bak';  
GO

-------------Hacer backup full----------
BACKUP DATABASE Hotel   
 TO HotelData  
   WITH FORMAT, INIT, NAME = N'Hotel – Full Backup' ;  
GO  

---------- crear demotable-------

USE Hotel
GO

CREATE TABLE dbo.DemoTable
( DemoTableId int IDENTITY(1,1) PRIMARY KEY,
  FirstLargeColumn nvarchar(600),
  BigIntColumn bigint
);
GO

--------------hacer backup diferencial1-----------
BACKUP DATABASE [Hotel] 
TO  DISK = N'D:\BDII IIIC 2021\SQL\BACKUP\HotelDIF.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Hotel-Differential Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10

--------------insertar datos demotable--------
SET NOCOUNT ON;
INSERT INTO DemoTable (FirstLargeColumn,BigIntColumn)
  VALUES('Prueba1',12345);
GO 5000

---------------crear backup diferencial2-----------------
BACKUP DATABASE [Hotel] 
TO  DISK = N'D:\BDII IIIC 2021\SQL\BACKUP\HotelDIF2.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Hotel-Differential Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
