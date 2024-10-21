USE HotelManagementDB
GO
INSERT INTO Hotel Values
(1,'Hotel-A','Uttara','1234567',0,1),
(2,'Hotel-B','Gulshan','1234568',0,1)
GO
INSERT INTO UserRole Values
(101,'Manager',1,0),
(102,'Staff',2,0),
(103, 'shefain', 1,0)
GO
INSERT INTO LoginUser Values
(1,'Habib','3131',101,0,1),
(2,'Sharif','3132',102,0,1),
(3,'Satu','3133',101,0,1),
(4,'Balal','3134',101,0,1),
(5,'Rayhan','3135',102,0,1)
GO
INSERT INTO Staff Values 
(1,'Ripon',101,'1990-2-1','9876543','2015-4-2',0,1),
(2,'Rafiq',102,'1991-2-2','8796543','2011-3-1',0,1)
GO
INSERT INTO HotelFacilities Values
(1,'AC',1,0,1,1),
(2,'TV',2,0,0,1),
(3,'Bed',1,1,0,1),
(4,'Sofa',2,0,0,1),
(5,'Lamp',1,1,1,1),
(6,'Fridg',1,1,1,1),
(7,'Geyser',2,0,1,1),
(8,'PresentSweet',1,1,1,1)
GO
INSERT INTO HotelRoomType Values
(1,'DeluxeRoom',1,1),
(2,'DoubleBedRoom',1,1),
(3,'SingleRoom',2,1)
GO
INSERT INTO HotelRoom Values
(1,'101',1,1),
(2,'102',2,1),
(3,'103',3,1)
GO
INSERT INTO HotelRoomTypeWithFacilities Values
(1,1,1,1),
(2,1,1,1)
GO
INSERT INTO Facility Values
(1,1,'Swimming',1),
(2,1,'Spa',1),
(3,2,'Gym',1),
(4,1,'WelcomeDrinks',1)
GO
INSERT INTO Guest Values
(1,'Sommit','Dhaka','2346189','123456096',1,1),
(2,'Farhan','Dhaka','6109838','1234565432',1,1),
(3,'Siddque','Dhaka','8906350','123450986',1,1),
(4,'Manna','Dhaka','7215340','123454568',1,1)
GO
INSERT INTO Booking Values
(1,1,1,2,'2020-2-1','2020-2-5',1),
(2,1,2,1,'2020-2-4','2020-2-8',1),
(3,1,3,3,'2020-6-30','2020-7-3',1),
(4,1,1,4,'2021-2-1','2021-2-5',1)
GO
INSERT INTO BookingOrGuestWithFacility Values
(1,1,1,1,1,'2023-02-20 10:00:00',1),
(2,2,2,1,1,'2023-04-15 12:00:00',1),
(3,1,3,3,4,'2022-11-03 08:00:00',1),
(4,1,4,4,4,'2022-02-09 15:00:00',1)
GO

--DELETE from Table
DELETE FROM Booking
WHERE BookingID=10
GO

--Upadate Table
UPDATE Hotel SET HotelName='Hotel-A'
WHERE HotelID=1
GO


--EXEC sp_helpindex HotelRoomType

--DROP DATABASE
IF DB_ID('HotelManagement') IS NOT NULL
DROP DATABASE HotelManagementDB
GO


--Query to retrive those hotel whose Guest states are all except 'SI' 
SELECT GuestNID, GuestName 
FROM Guest
WHERE GuestName NOT LIKE 'SI%'
GO

--write a query to retrive Hotel whose HotelAddress with 'Gul'
SELECT * FROM Hotel
WHERE HotelAddress LIKE 'GUL%'
GO

-- k-y, 
SELECT * FROM Hotel
WHERE HotelAddress LIKE 'N[A-J]%'
GO

--no k-y
SELECT * FROM Hotel
WHERE HotelAddress LIKE 'N[^A-J]%'
GO

--CUBE
SELECT HotelID,GuestID,CheckInDate,SUM(HotelID) AS TotalAmount
FROM Booking
GROUP BY CUBE(HotelID,GuestID,CheckInDate)
GO

--Rollup
SELECT HotelID,GuestID,CheckInDate,SUM(HotelID) AS TotalAmount
FROM Booking
GROUP BY ROLLUP(HotelID,GuestID,CheckInDate)
GO

--GROUPING SETS
SELECT HotelID,GuestID,CheckInDate,SUM(HotelID) AS TotalAmount
FROM Booking
GROUP BY GROUPING SETS(HotelID,GuestID,CheckInDate)
GO

--Subquery
SELECT HotelID, HotelName 
FROM Hotel
WHERE HotelID IN 
(
SELECT HotelID
FROM Booking
GROUP BY HotelID
ORDER BY COUNT(*)DESC
)
GO

--Exists operator
SELECT GuestID,GuestName,GuestAddress
FROM Guest g
WHERE EXISTS (
SELECT 1
FROM Booking b
WHERE b.GuestID=g.GuestID
)
GO

--CTE
WITH HotelCTE AS
(
SELECT HotelID,GuestID,CheckInDate,COUNT(HotelID) AS TotalAmount
FROM Booking
GROUP BY HotelID,GuestID,CheckInDate
)
SELECT * FROM HotelCTE
GO

--view (general, update)
CREATE VIEW HotelTotalBooking
AS
SELECT H.HotelID, H.HotelName, COUNT(*) AS CheckInDate, CheckOutDate
FROM Hotel AS H JOIN Booking AS B
ON H.HotelID=B.HotelID
GROUP BY H.HotelID, H.HotelName, CheckInDate, CheckOutDate

--Inner join in view
select * from Hotel
Inner join UserRole On UserRole.HotelID=Hotel.HotelID
Inner join LoginUser On LoginUser.RoleID=UserRole.RoleID
Inner Join Staff On Staff.UserID=LoginUser.UserID
Inner Join HotelFacility ON HotelFacility.HotelID=Hotel.HotelID
Inner Join HotelRoomType On HotelRoomType.HotelID=Hotel.HotelID
Inner Join HotelRoomTypeWithFacilities On HotelRoomTypeWithFacilities.HotelRoomTypeID=HotelRoomType.HotelRoomTypeID
Inner Join HotelRoom On HotelRoom.HotelRoomTypeID=HotelRoomType.HotelRoomTypeID
Inner Join Guest On Guest.HotelID=Hotel.HotelID
Inner Join Facility On Facility.HotelID=Hotel.HotelID
Inner Join Booking On Booking.GuestID=Guest.GuestID
Inner Join BookingOrGuestWithFacility On BookingOrGuestWithFacility.BookingID=Booking.BookingID
AND BookingOrGuestWithFacility.GuestID=Guest.GuestID 
AND BookingOrGuestWithFacility.FacilityID=Facility.FacilityID

--Cast
SELECT CAST('2023-02-20 10:00:00' AS date)
GO

--Convert
SELECT CONVERT(TIME, '2023-02-20T10:00:00',1)
GO

--ISnull
SELECT ISNULL(HotelID, 0) HotelId,GuestID,CheckInDate,SUM(HotelID) AS TotalAmount
FROM Booking
GROUP BY GROUPING SETS(HotelID,GuestID,CheckInDate)
GO

--ANY 
SELECT * FROM Staff
WHERE RoleID> any
(SELECT RoleID FROM UserRole WHERE HotelID =1)

--SOME 
SELECT * FROM Staff
WHERE RoleID> SOME
(SELECT RoleID FROM UserRole WHERE HotelID =1)

--ALL 
SELECT * FROM Staff
WHERE RoleID> ALL
(SELECT RoleID FROM UserRole WHERE HotelID =1)

--CURSOR
DECLARE @HotelRoomTypeId int,@HotelRoomTypeName Varchar(50),@HotelID int,@COUNT int
SET @COUNT=0
DECLARE Hotel CURSOR
FOR
SELECT HotelRoomTypeID,HotelRoomTypeName,HotelID FROM HotelRoomType
OPEN Hotel
FETCH NEXT FROM Hotel INTO @HotelRoomTypeId ,@HotelRoomTypeName,@HotelID
WHILE @@FETCH_STATUS=0
BEGIN
IF @HotelRoomTypeId>1
PRINT 'HotelRoomTypeName= '+ CONVERT(varchar,@HotelRoomTypeName) +' HotelID='+CONVERT(VarChar,@HotelID) 
FETCH NEXT FROM Hotel INTO @HotelRoomTypeId,@HotelRoomTypeName,@HotelID
END
CLOSE Hotel;
DEALLOCATE Hotel;


-- Transaction 

BEGIN TRY 
	BEGIN TRAN 
		DELETE FROM LoginUser WHERE RoleID= 103
		DELETE FROM UserRole WHERE RoleID = 103
	COMMIT TRAN
END TRY 

BEGIN CATCH 
	ROLLBACK TRAN
END CATCH 

-- insert , update. delete using stored procedure

EXEC InsertUpdateDeleteOutput 'SELECT', '','','','','';
EXEC InsertUpdateDeleteOutput 'Insert', '103','Shihab','2','1','';
EXEC InsertUpdateDeleteOutput 'UPDATE', '103','Md Abdullah','','','';
EXEC InsertUpdateDeleteOutput 'DELETE', '103','','','','';

SELECT * FROM UserRoleArchieve


-- merge

INSERT INTO HotelUpdate Values
(1,'Hotel-c','Uttara','1234567',0,1),
(2,'Hotel-B','Gulshan','1234568',0,1),
(3,'Hotel-c','Gulshan','1234568',0,1)
GO

MERGE Hotel AS Target
USING HotelUpdate	AS Source
ON Source.HotelID = Target.HotelID
WHEN MATCHED THEN 
UPDATE SET Target.HotelName=Source.HotelName, Target.HotelAddress=Source.HotelAddress,
Target.HotelPhone=Source.HotelPhone, Target.IsActive=Source.IsActive, Target.SavedBy=Source.SavedBy
WHEN NOT MATCHED  THEN
INSERT (HotelID, HotelName, HotelAddress ,HotelPhone,  IsActive, SavedBy) 
VALUES (Source.HotelID, Source.HotelName,Source.HotelAddress ,Source.HotelPhone,  Source.IsActive, Source.SavedBy);
GO

SELECT * FROM dbo.fnMytable('uttara')


SELECT * FROM HotelFacilities
SELECT * FROM HotelRoomType WHERE HotelID =1

