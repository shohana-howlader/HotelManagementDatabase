USE master
GO
IF DB_ID('HotelManagementDB') IS NOT NULL
DROP DATABASE HotelManagementDB
GO

CREATE DATABASE HotelManagementDB
ON
(
Name='HotelManagementDB_Data_1',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelManagementDB_Data_1.mdf',
Size=25MB,
Maxsize=100MB,
FileGrowth=5%
)
Log ON
(
Name='HotelManagementDB_Log_1',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelManagementDB_log_1.ldf',
Size=2MB,
Maxsize=50MB,
FileGrowth=1%
)
GO

USE HotelManagementDB
GO

CREATE Table Hotel
(
HotelID int  NOT NULL PRIMARY KEY NONCLUSTERED,
HotelName varchar(50) NOT NULL,
HotelAddress varchar(50) NOT NULL,
HotelPhone varchar(11) NOT NULL,
IsActive bit NOT NULl,
CreateBy bit NOT NULL
)
GO
CREATE Table UserRole
(
RoleID int NOT NULL PRIMARY KEY,
RoleName varchar(50) NOT NULL,
HotelID int REFERENCES Hotel(HotelID) NOT NULL,
CreateBy bit NOT NULL
)
GO
CREATE Table LoginUser
(
UserID int NOT NULL PRIMARY KEY,
UserName varchar(50) NOT NULL,
UserPassword varchar(20) NOT NULL,
RoleID int REFERENCES UserRole(RoleID) NOT NULL,
IsActive varchar(5),
CreateBy bit NOT NULL
)
GO
CREATE Table Staff
(
StaffID int NOT NULL PRIMARY KEY,
StaffName varchar(50) NOT NULL,
RoleID int NOT NULL REFERENCES UserRole(RoleID),
StaffDateOfBirth date NOT NULL,
NID varchar(20) NOT NULL,
HireDate date NOT NULL,
IsActive varchar(5),
CreateBy bit NOT NULL
)
GO
CREATE Table HotelFacilities
(
HotelFacilityID int NOT NULL PRIMARY KEY,
HotelFacilityName varchar(50) NOT NULL,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
IsChangeable int NOT NULL,
IsReuseable int NOT NULL,
CreateBy bit NOT NULL
)
GO
CREATE Table HotelRoomType
(
HotelRoomTypeID int NOT NULL PRIMARY KEY,
HotelRoomTypeName varchar(50) NOT NULL,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
CreateBy bit NOT NULL
)
GO
CREATE Table HotelRoom
(
HotelRoomId int NOT NULL PRIMARY KEY,
HotelRoomName varchar(50) NOT NULL,
HotelRoomTypeID int NOT NULL REFERENCES HotelRoomType(HotelRoomTypeID),
CreateBy bit NOT NULL

)
Go
CREATE Table HotelRoomTypeWithFacilities
(
HotelRoomTypeWithAssetsID int NOT NULL PRIMARY KEY,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
HotelRoomTypeID int NOT NULL REFERENCES HotelRoomType(HotelRoomTypeID),
CreateBy bit NOT NULL
)
GO
CREATE Table Facility
(
FacilityID int NOT NULL PRIMARY KEY,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
FacilityName varchar(50) NOT NULL,
CreateBy bit NOT NULL
)
GO
CREATE Table Guest
(
GuestID int NOT NULL PRIMARY KEY,
GuestName Varchar(50) NOT NULL,
GuestAddress Varchar(50) NOT NULL,
GuestPhone Varchar(11) NOT NULL,
GuestNID int nOT NULL,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
CreateBy bit NOT NULL
)
GO
CREATE Table Booking
(
BookingID int NOT NULL PRIMARY KEY,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
HotelRoomID int NOT NULL REFERENCES HotelRoom(HotelRoomID),
GuestID int NOT NULL REFERENCES Guest(GuestID),
CheckInDate datetime NOT NULL,
CheckOutDate datetime NOT NULL,
CreateBy bit NOT NULL
)
GO
CREATE Table BookingOrGuestWithFacility
(
BookingOrGuestWithFacilityID int NOT NULL PRIMARY KEY,
HotelID int NOT NULL REFERENCES Hotel(HotelID),
BookingID int Null REFERENCES Booking(BookingID),
GuestID int NOT NULL REFERENCES Guest(GuestID),
FacilityID int NOT NULL REFERENCES Facility(FacilityID),
DateAndTime datetime NOT NULL,
CreateBy bit NOT NULL
)
GO

--NONCLUSTERED
CREATE NONCLUSTERED INDEX ix_HotelRoomType_T_HotelRoomTypeName
ON HotelRoomType(HotelRoomTypeName)


GO

--For Merge
CREATE Table HotelUpdate
(
HotelID int  NOT NULL PRIMARY KEY NONCLUSTERED,
HotelName varchar(50) NOT NULL,
HotelAddress varchar(50) NOT NULL,
HotelPhone varchar(11) NOT NULL,
IsActive int NOT NULl,
SavedBy int NOT NULL
)

--ALTER Table
ALTER TABLE Booking
DROP Column Bookings
GO

-- Store Procedure

USE [Hotel]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	EXEC dbo.sp_Login 'Habib','3130'
*/
Create PROCEDURE [dbo].[sp_Login]
(
@UserName varchar(50),
@UserPassword varchar(20)
)
AS
BEGIN
DECLARE @output varchar(50)='Not Match'
select @output='Match' from LoginUser where UserName=@UserName and UserPassword=@UserPassword

print @output

if(@output='Match')
BEGIN
select Staff.* from LoginUser 
inner join Staff ON Staff.UserId=LoginUser.UserID
where UserName=@UserName and UserPassword=@UserPassword
END
END

--Store Procedure With Raise Error

CREATE PROC spWithRaiseError
@UserID int,
@UserName varchar(50),
@UserPass Varchar(20),
@RoleId int,
@IsActive varchar(5),
@SaveBy int
AS
BEGIN
IF EXISTS (SELECT * FROM UserRole WHERE RoleID=@RoleId)
INSERT INTO LoginUser
VALUES (@UserID ,@UserName ,@UserPass,@RoleId,@IsActive,@SaveBy)
ELSE 
THROW 50001, 'This data Is not valid', 1;
END

BEGIN TRY
EXEC  spWithRaiseError 6,'Shefain','samia', 105,'no',2
END TRY

BEGIN CATCH 
PRINT Error_Message()
END CATCH
GO

-- PROCEDURE FOR INSERT UPDATE DELETE AND OUTOUT PARAMETER

CREATE PROC InsertUpdateDeleteOutput
@Functionality varchar(10)='',
@RoleID int,
@RoleName varchar(50),
@HotelID int,
@SaveBy int,
@Count int output
AS 
BEGIN
IF @Functionality='SELECT'
	SELECT * FROM UserRole
IF @Functionality='INSERT'
	INSERT INTO UserRole 
	Values (@RoleID,@RoleName,@HotelID,@SaveBy)
IF @Functionality='UPDATE'
	UPDATE UserRole
	SET RoleName=@RoleName WHERE RoleID=@RoleID
	IF @Functionality='DELETE'
DELETE FROM UserRole
	WHERE RoleID=@RoleID
	SET @Count=@@ROWCOUNT
END


--TRIGGER 
CREATE Table UserRoleArchieve
(
RoleID int NOT NULL PRIMARY KEY,
RoleName varchar(50) NOT NULL,
HotelID int REFERENCES Hotel(HotelID) NOT NULL,
SaveBy int NOT NULL
)

CREATE TRIGGER UserRoleDeleted
ON UserRole
AFTER DELETE
AS
INSERT INTO UserRoleArchieve 
(RoleID ,RoleName ,HotelID,SaveBy)
SELECT RoleID ,RoleName ,HotelID,SaveBy FROM deleted

GO

--Scalar Function
CREATE FUNCTION TotalLogIn()
Returns int
BEGIN 
RETURN (SELECT COUNT(UserName) FROM LoginUser)
END
PRINT 'Total Log in User is ' + convert(varchar,dbo.TotalLogIn(),0)
GO

-- Raise error 

CREATE PROC spRaiseError
	@hotelRoomID int , @HotelRoomName varchar(50),
	@HotelRoomType int , @saveBy int
AS 
BEGIN 
	IF EXISTS (SELECT * FROM HotelRoomType WHERE HotelRoomTypeID = @HotelRoomType)
		INSERT INTO HotelRoom
		VALUES (@hotelRoomID, @HotelRoomName ,@HotelRoomType , @saveBy)
	ELSE 
		THROW 50001, 'Data is not valid', 1;
END 

BEGIN TRY
EXEC spRaiseError 1,'Presidential Suit',66,500
END TRY 

BEGIN CATCH
	PRINT Error_Message()
	PRINT Error_Severity()
END CATCH

---- table valued 

CREATE  fnMytable(@address varchar(50))
returns table 

RETURN 
	(SELECT HotelID, HotelName, HotelAddress, HotelPhone, IsActive, SavedBy 
	FROM Hotel 
	WHERE HotelAddress=@address )




