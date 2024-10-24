USE [master]
GO
/****** Object:  Database [HotelManagementDB]    Script Date: 1/8/2024 8:44:57 PM ******/
CREATE DATABASE [HotelManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelManagementDB_Data_1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelManagementDB_Data_1.mdf' , SIZE = 25600KB , MAXSIZE = 102400KB , FILEGROWTH = 5%)
 LOG ON 
( NAME = N'HotelManagementDB_Log_1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelManagementDB_log_1.ldf' , SIZE = 2048KB , MAXSIZE = 51200KB , FILEGROWTH = 1%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HotelManagementDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelManagementDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HotelManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HotelManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HotelManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [HotelManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HotelManagementDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [HotelManagementDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HotelManagementDB]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[HotelID] [int] IDENTITY(1,1) NOT NULL,
	[HotelName] [varchar](50) NOT NULL,
	[HotelAddress] [varchar](50) NOT NULL,
	[HotelPhone] [varchar](11) NOT NULL,
	[IsActive] [int] NOT NULL,
	[SavedBy] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[HotelRoomID] [int] NOT NULL,
	[GuestID] [int] NOT NULL,
	[CheckInDate] [datetime] NOT NULL,
	[CheckOutDate] [datetime] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__Booking__73951ACD506C606B] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingOrGuestWithFacility]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingOrGuestWithFacility](
	[BookingOrGuestWithFacilityID] [int] IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[BookingID] [int] NULL,
	[GuestID] [int] NOT NULL,
	[FacilityID] [int] NOT NULL,
	[DateAndTime] [datetime] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__BookingO__AF87E69D171BC670] PRIMARY KEY CLUSTERED 
(
	[BookingOrGuestWithFacilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[FacilityID] [int] IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[FacilityName] [varchar](50) NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__Facility__5FB08B94DAF8061B] PRIMARY KEY CLUSTERED 
(
	[FacilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guest]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guest](
	[GuestID] [int] IDENTITY(1,1) NOT NULL,
	[GuestName] [varchar](50) NOT NULL,
	[GuestAddress] [varchar](50) NOT NULL,
	[GuestPhone] [varchar](11) NOT NULL,
	[GuestNID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__Guest__0C423C323BDB4B94] PRIMARY KEY CLUSTERED 
(
	[GuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelAsset]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelAsset](
	[HotelAssetID] [int] IDENTITY(1,1) NOT NULL,
	[HotelAssetName] [varchar](50) NOT NULL,
	[HotelID] [int] NOT NULL,
	[IsChangeable] [int] NOT NULL,
	[IsReuseable] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__HotelAss__9BD317B7656E3148] PRIMARY KEY CLUSTERED 
(
	[HotelAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelRoom]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelRoom](
	[HotelRoomId] [int] IDENTITY(1,1) NOT NULL,
	[HotelRoomName] [varchar](50) NOT NULL,
	[HotelRoomTypeID] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__HotelRoo__75980B05A8CB0362] PRIMARY KEY CLUSTERED 
(
	[HotelRoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelRoomType]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelRoomType](
	[HotelRoomTypeID] [int] IDENTITY(1,1) NOT NULL,
	[HotelRoomTypeName] [varchar](50) NOT NULL,
	[HotelID] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__HotelRoo__D3E96389B0957928] PRIMARY KEY CLUSTERED 
(
	[HotelRoomTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelRoomTypeWithAssets]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelRoomTypeWithAssets](
	[HotelRoomTypeWithAssetsID] [int] IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[HotelRoomTypeID] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__HotelRoo__3BD565B1D8CD2E93] PRIMARY KEY CLUSTERED 
(
	[HotelRoomTypeWithAssetsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginUser]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[UserPassword] [varchar](20) NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsActive] [varchar](5) NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__LoginUse__1788CCAC0E9E4B49] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[StaffName] [varchar](50) NOT NULL,
	[RoleID] [int] NOT NULL,
	[StaffDateOfBirth] [date] NOT NULL,
	[NID] [varchar](20) NOT NULL,
	[HireDate] [date] NOT NULL,
	[IsActive] [varchar](5) NULL,
	[SaveBy] [int] NOT NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK__Staff__96D4AAF715D5BA94] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[HotelID] [int] NOT NULL,
	[SaveBy] [int] NOT NULL,
 CONSTRAINT [PK__UserRole__8AFACE3A7BCEC838] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_HotelsAllData]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_HotelsAllData]
AS
SELECT dbo.Hotel.HotelName, dbo.Hotel.HotelAddress, dbo.Hotel.HotelPhone, dbo.UserRole.RoleName, dbo.LoginUser.UserName, dbo.LoginUser.UserPassword, dbo.Staff.StaffName, dbo.Staff.StaffDateOfBirth, dbo.Staff.NID, dbo.Staff.HireDate, 
                  dbo.HotelAsset.HotelAssetName, dbo.HotelAsset.IsChangeable, dbo.HotelAsset.IsReuseable, dbo.HotelRoomType.HotelRoomTypeName, dbo.HotelRoom.HotelRoomName, dbo.Guest.GuestName, dbo.Guest.GuestAddress, 
                  dbo.Guest.GuestPhone, dbo.Guest.GuestNID, dbo.Facility.FacilityName, dbo.Booking.CheckInDate, dbo.Booking.CheckOutDate, dbo.BookingOrGuestWithFacility.DateAndTime
FROM     dbo.Hotel INNER JOIN
                  dbo.UserRole ON dbo.UserRole.HotelID = dbo.Hotel.HotelID INNER JOIN
                  dbo.LoginUser ON dbo.LoginUser.RoleID = dbo.UserRole.RoleID INNER JOIN
                  dbo.Staff ON dbo.Staff.UserID = dbo.LoginUser.UserID INNER JOIN
                  dbo.HotelAsset ON dbo.HotelAsset.HotelID = dbo.Hotel.HotelID INNER JOIN
                  dbo.HotelRoomType ON dbo.HotelRoomType.HotelID = dbo.Hotel.HotelID INNER JOIN
                  dbo.HotelRoomTypeWithAssets ON dbo.HotelRoomTypeWithAssets.HotelRoomTypeID = dbo.HotelRoomType.HotelRoomTypeID INNER JOIN
                  dbo.HotelRoom ON dbo.HotelRoom.HotelRoomTypeID = dbo.HotelRoomType.HotelRoomTypeID INNER JOIN
                  dbo.Guest ON dbo.Guest.HotelID = dbo.Hotel.HotelID INNER JOIN
                  dbo.Facility ON dbo.Facility.HotelID = dbo.Hotel.HotelID INNER JOIN
                  dbo.Booking ON dbo.Booking.GuestID = dbo.Guest.GuestID INNER JOIN
                  dbo.BookingOrGuestWithFacility ON dbo.BookingOrGuestWithFacility.BookingID = dbo.Booking.BookingID AND dbo.BookingOrGuestWithFacility.GuestID = dbo.Guest.GuestID AND 
                  dbo.BookingOrGuestWithFacility.FacilityID = dbo.Facility.FacilityID
GO
/****** Object:  Table [dbo].[HotelUpdate]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelUpdate](
	[HotelID] [int] IDENTITY(1,1) NOT NULL,
	[HotelName] [varchar](50) NOT NULL,
	[HotelAddress] [varchar](50) NOT NULL,
	[HotelPhone] [varchar](11) NOT NULL,
	[IsActive] [int] NOT NULL,
	[SavedBy] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff_Audit]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff_Audit](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[Audit_Action] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingID], [HotelID], [HotelRoomID], [GuestID], [CheckInDate], [CheckOutDate], [SaveBy]) VALUES (1, 1, 1, 2, CAST(N'2020-02-01T00:00:00.000' AS DateTime), CAST(N'2020-02-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Booking] ([BookingID], [HotelID], [HotelRoomID], [GuestID], [CheckInDate], [CheckOutDate], [SaveBy]) VALUES (2, 1, 2, 1, CAST(N'2020-02-04T00:00:00.000' AS DateTime), CAST(N'2020-02-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Booking] ([BookingID], [HotelID], [HotelRoomID], [GuestID], [CheckInDate], [CheckOutDate], [SaveBy]) VALUES (3, 1, 3, 3, CAST(N'2020-06-30T00:00:00.000' AS DateTime), CAST(N'2020-07-03T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Booking] ([BookingID], [HotelID], [HotelRoomID], [GuestID], [CheckInDate], [CheckOutDate], [SaveBy]) VALUES (4, 1, 1, 4, CAST(N'2021-02-01T00:00:00.000' AS DateTime), CAST(N'2021-02-05T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[BookingOrGuestWithFacility] ON 

INSERT [dbo].[BookingOrGuestWithFacility] ([BookingOrGuestWithFacilityID], [HotelID], [BookingID], [GuestID], [FacilityID], [DateAndTime], [SaveBy]) VALUES (1, 1, 1, 1, 1, CAST(N'2023-02-20T10:00:00.000' AS DateTime), 1)
INSERT [dbo].[BookingOrGuestWithFacility] ([BookingOrGuestWithFacilityID], [HotelID], [BookingID], [GuestID], [FacilityID], [DateAndTime], [SaveBy]) VALUES (2, 2, 2, 1, 1, CAST(N'2023-04-15T12:00:00.000' AS DateTime), 1)
INSERT [dbo].[BookingOrGuestWithFacility] ([BookingOrGuestWithFacilityID], [HotelID], [BookingID], [GuestID], [FacilityID], [DateAndTime], [SaveBy]) VALUES (3, 1, 3, 3, 4, CAST(N'2022-11-03T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[BookingOrGuestWithFacility] ([BookingOrGuestWithFacilityID], [HotelID], [BookingID], [GuestID], [FacilityID], [DateAndTime], [SaveBy]) VALUES (4, 1, 4, 4, 4, CAST(N'2022-02-09T15:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BookingOrGuestWithFacility] OFF
GO
SET IDENTITY_INSERT [dbo].[Facility] ON 

INSERT [dbo].[Facility] ([FacilityID], [HotelID], [FacilityName], [SaveBy]) VALUES (1, 1, N'Swimming', 1)
INSERT [dbo].[Facility] ([FacilityID], [HotelID], [FacilityName], [SaveBy]) VALUES (2, 1, N'Spa', 1)
INSERT [dbo].[Facility] ([FacilityID], [HotelID], [FacilityName], [SaveBy]) VALUES (3, 2, N'Gym', 1)
INSERT [dbo].[Facility] ([FacilityID], [HotelID], [FacilityName], [SaveBy]) VALUES (4, 1, N'WelcomeDrinks', 1)
SET IDENTITY_INSERT [dbo].[Facility] OFF
GO
SET IDENTITY_INSERT [dbo].[Guest] ON 

INSERT [dbo].[Guest] ([GuestID], [GuestName], [GuestAddress], [GuestPhone], [GuestNID], [HotelID], [SaveBy]) VALUES (1, N'Sommit', N'Dhaka', N'2346189', 123456096, 1, 1)
INSERT [dbo].[Guest] ([GuestID], [GuestName], [GuestAddress], [GuestPhone], [GuestNID], [HotelID], [SaveBy]) VALUES (2, N'Farhan', N'Dhaka', N'6109838', 1234565432, 1, 1)
INSERT [dbo].[Guest] ([GuestID], [GuestName], [GuestAddress], [GuestPhone], [GuestNID], [HotelID], [SaveBy]) VALUES (3, N'Siddque', N'Dhaka', N'8906350', 123450986, 1, 1)
INSERT [dbo].[Guest] ([GuestID], [GuestName], [GuestAddress], [GuestPhone], [GuestNID], [HotelID], [SaveBy]) VALUES (4, N'Manna', N'Dhaka', N'7215340', 123454568, 1, 1)
SET IDENTITY_INSERT [dbo].[Guest] OFF
GO
SET IDENTITY_INSERT [dbo].[Hotel] ON 

INSERT [dbo].[Hotel] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (1, N'Hotel-c', N'Uttara', N'1234567', 0, 1)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (2, N'Hotel-B', N'Gulshan', N'1234568', 0, 1)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (3, N'Hotel-c', N'Gulshan', N'1234568', 0, 1)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (4, N'Hotel3', N'Dhaka', N'123456789', 1, 1)
SET IDENTITY_INSERT [dbo].[Hotel] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelAsset] ON 

INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (1, N'AC', 1, 0, 1, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (2, N'TV', 2, 0, 0, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (3, N'Bed', 1, 1, 0, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (4, N'Sofa', 2, 0, 0, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (5, N'Lamp', 1, 1, 1, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (6, N'Fridg', 1, 1, 1, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (7, N'Geyser', 2, 0, 1, 1)
INSERT [dbo].[HotelAsset] ([HotelAssetID], [HotelAssetName], [HotelID], [IsChangeable], [IsReuseable], [SaveBy]) VALUES (8, N'PresentSweet', 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[HotelAsset] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelRoom] ON 

INSERT [dbo].[HotelRoom] ([HotelRoomId], [HotelRoomName], [HotelRoomTypeID], [SaveBy]) VALUES (1, N'101', 1, 1)
INSERT [dbo].[HotelRoom] ([HotelRoomId], [HotelRoomName], [HotelRoomTypeID], [SaveBy]) VALUES (2, N'102', 2, 1)
INSERT [dbo].[HotelRoom] ([HotelRoomId], [HotelRoomName], [HotelRoomTypeID], [SaveBy]) VALUES (3, N'103', 3, 1)
SET IDENTITY_INSERT [dbo].[HotelRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelRoomType] ON 

INSERT [dbo].[HotelRoomType] ([HotelRoomTypeID], [HotelRoomTypeName], [HotelID], [SaveBy]) VALUES (1, N'DeluxeRoom', 1, 1)
INSERT [dbo].[HotelRoomType] ([HotelRoomTypeID], [HotelRoomTypeName], [HotelID], [SaveBy]) VALUES (2, N'DoubleBedRoom', 1, 1)
INSERT [dbo].[HotelRoomType] ([HotelRoomTypeID], [HotelRoomTypeName], [HotelID], [SaveBy]) VALUES (3, N'SingleRoom', 2, 1)
SET IDENTITY_INSERT [dbo].[HotelRoomType] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelRoomTypeWithAssets] ON 

INSERT [dbo].[HotelRoomTypeWithAssets] ([HotelRoomTypeWithAssetsID], [HotelID], [HotelRoomTypeID], [SaveBy]) VALUES (1, 1, 1, 1)
INSERT [dbo].[HotelRoomTypeWithAssets] ([HotelRoomTypeWithAssetsID], [HotelID], [HotelRoomTypeID], [SaveBy]) VALUES (2, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[HotelRoomTypeWithAssets] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelUpdate] ON 

INSERT [dbo].[HotelUpdate] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (1, N'Hotel-c', N'Uttara', N'1234567', 0, 1)
INSERT [dbo].[HotelUpdate] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (2, N'Hotel-B', N'Gulshan', N'1234568', 0, 1)
INSERT [dbo].[HotelUpdate] ([HotelID], [HotelName], [HotelAddress], [HotelPhone], [IsActive], [SavedBy]) VALUES (3, N'Hotel-c', N'Gulshan', N'1234568', 0, 1)
SET IDENTITY_INSERT [dbo].[HotelUpdate] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginUser] ON 

INSERT [dbo].[LoginUser] ([UserID], [UserName], [UserPassword], [RoleID], [IsActive], [SaveBy]) VALUES (1, N'Habib', N'3131', 101, N'0', 1)
INSERT [dbo].[LoginUser] ([UserID], [UserName], [UserPassword], [RoleID], [IsActive], [SaveBy]) VALUES (2, N'Sharif', N'3132', 102, N'0', 1)
INSERT [dbo].[LoginUser] ([UserID], [UserName], [UserPassword], [RoleID], [IsActive], [SaveBy]) VALUES (3, N'Satu', N'3133', 101, N'0', 1)
INSERT [dbo].[LoginUser] ([UserID], [UserName], [UserPassword], [RoleID], [IsActive], [SaveBy]) VALUES (4, N'Balal', N'3134', 101, N'0', 1)
INSERT [dbo].[LoginUser] ([UserID], [UserName], [UserPassword], [RoleID], [IsActive], [SaveBy]) VALUES (5, N'Rayhan', N'3135', 102, N'0', 1)
SET IDENTITY_INSERT [dbo].[LoginUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([StaffID], [StaffName], [RoleID], [StaffDateOfBirth], [NID], [HireDate], [IsActive], [SaveBy], [UserID]) VALUES (1, N'Ripon', 101, CAST(N'1990-02-01' AS Date), N'9876543', CAST(N'2015-04-02' AS Date), N'0', 1, 2)
INSERT [dbo].[Staff] ([StaffID], [StaffName], [RoleID], [StaffDateOfBirth], [NID], [HireDate], [IsActive], [SaveBy], [UserID]) VALUES (2, N'Rafiq', 102, CAST(N'1991-02-02' AS Date), N'8796543', CAST(N'2011-03-01' AS Date), N'0', 1, 1)
INSERT [dbo].[Staff] ([StaffID], [StaffName], [RoleID], [StaffDateOfBirth], [NID], [HireDate], [IsActive], [SaveBy], [UserID]) VALUES (3, N'Kobir', 101, CAST(N'1993-05-07' AS Date), N'4567893', CAST(N'2012-04-03' AS Date), N'0', 1, 1)
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff_Audit] ON 

INSERT [dbo].[Staff_Audit] ([StaffID], [Audit_Action]) VALUES (1, N'New staff with ID=3is Added atJan  7 2024  7:43PM')
SET IDENTITY_INSERT [dbo].[Staff_Audit] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([RoleID], [RoleName], [HotelID], [SaveBy]) VALUES (101, N'Manager', 1, 0)
INSERT [dbo].[UserRole] ([RoleID], [RoleName], [HotelID], [SaveBy]) VALUES (102, N'Staff', 2, 0)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
/****** Object:  Index [PK__Hotel__46023BBE06E0920A]    Script Date: 1/8/2024 8:44:57 PM ******/
ALTER TABLE [dbo].[Hotel] ADD  CONSTRAINT [PK__Hotel__46023BBE06E0920A] PRIMARY KEY NONCLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__HotelUpd__46023BBEE6105599]    Script Date: 1/8/2024 8:44:57 PM ******/
ALTER TABLE [dbo].[HotelUpdate] ADD  CONSTRAINT [PK__HotelUpd__46023BBEE6105599] PRIMARY KEY NONCLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__GuestID__5629CD9C] FOREIGN KEY([GuestID])
REFERENCES [dbo].[Guest] ([GuestID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__GuestID__5629CD9C]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__HotelID__5441852A] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__HotelID__5441852A]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__HotelRo__5535A963] FOREIGN KEY([HotelRoomID])
REFERENCES [dbo].[HotelRoom] ([HotelRoomId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__HotelRo__5535A963]
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility]  WITH CHECK ADD  CONSTRAINT [FK__BookingOr__Booki__59FA5E80] FOREIGN KEY([BookingID])
REFERENCES [dbo].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility] CHECK CONSTRAINT [FK__BookingOr__Booki__59FA5E80]
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility]  WITH CHECK ADD  CONSTRAINT [FK__BookingOr__Facil__5BE2A6F2] FOREIGN KEY([FacilityID])
REFERENCES [dbo].[Facility] ([FacilityID])
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility] CHECK CONSTRAINT [FK__BookingOr__Facil__5BE2A6F2]
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility]  WITH CHECK ADD  CONSTRAINT [FK__BookingOr__Guest__5AEE82B9] FOREIGN KEY([GuestID])
REFERENCES [dbo].[Guest] ([GuestID])
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility] CHECK CONSTRAINT [FK__BookingOr__Guest__5AEE82B9]
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility]  WITH CHECK ADD  CONSTRAINT [FK__BookingOr__Hotel__59063A47] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[BookingOrGuestWithFacility] CHECK CONSTRAINT [FK__BookingOr__Hotel__59063A47]
GO
ALTER TABLE [dbo].[Facility]  WITH CHECK ADD  CONSTRAINT [FK__Facility__HotelI__4E88ABD4] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[Facility] CHECK CONSTRAINT [FK__Facility__HotelI__4E88ABD4]
GO
ALTER TABLE [dbo].[Guest]  WITH CHECK ADD  CONSTRAINT [FK__Guest__HotelID__5165187F] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[Guest] CHECK CONSTRAINT [FK__Guest__HotelID__5165187F]
GO
ALTER TABLE [dbo].[HotelAsset]  WITH CHECK ADD  CONSTRAINT [FK__HotelAsse__Hotel__4222D4EF] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[HotelAsset] CHECK CONSTRAINT [FK__HotelAsse__Hotel__4222D4EF]
GO
ALTER TABLE [dbo].[HotelRoom]  WITH CHECK ADD  CONSTRAINT [FK__HotelRoom__Hotel__47DBAE45] FOREIGN KEY([HotelRoomTypeID])
REFERENCES [dbo].[HotelRoomType] ([HotelRoomTypeID])
GO
ALTER TABLE [dbo].[HotelRoom] CHECK CONSTRAINT [FK__HotelRoom__Hotel__47DBAE45]
GO
ALTER TABLE [dbo].[HotelRoomType]  WITH CHECK ADD  CONSTRAINT [FK__HotelRoom__Hotel__44FF419A] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[HotelRoomType] CHECK CONSTRAINT [FK__HotelRoom__Hotel__44FF419A]
GO
ALTER TABLE [dbo].[HotelRoomTypeWithAssets]  WITH CHECK ADD  CONSTRAINT [FK__HotelRoom__Hotel__4AB81AF0] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[HotelRoomTypeWithAssets] CHECK CONSTRAINT [FK__HotelRoom__Hotel__4AB81AF0]
GO
ALTER TABLE [dbo].[HotelRoomTypeWithAssets]  WITH CHECK ADD  CONSTRAINT [FK__HotelRoom__Hotel__4BAC3F29] FOREIGN KEY([HotelRoomTypeID])
REFERENCES [dbo].[HotelRoomType] ([HotelRoomTypeID])
GO
ALTER TABLE [dbo].[HotelRoomTypeWithAssets] CHECK CONSTRAINT [FK__HotelRoom__Hotel__4BAC3F29]
GO
ALTER TABLE [dbo].[LoginUser]  WITH CHECK ADD  CONSTRAINT [FK__LoginUser__RoleI__3C69FB99] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRole] ([RoleID])
GO
ALTER TABLE [dbo].[LoginUser] CHECK CONSTRAINT [FK__LoginUser__RoleI__3C69FB99]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK__Staff__RoleID__3F466844] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRole] ([RoleID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK__Staff__RoleID__3F466844]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK__UserRole__HotelI__398D8EEE] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK__UserRole__HotelI__398D8EEE]
GO
/****** Object:  StoredProcedure [dbo].[sp_Booking]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[sp_Booking]
(
@HotelID int,
@HotelRoomID int,
@GuestID int,
@CheckInDate datetime ,
@CheckOutDate datetime,
@SaveBy int
)
AS 
BEGIN
INSERT INTO Booking Values
(@HotelID,@HotelRoomID,@GuestID,@CheckInDate,@CheckOutDate,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BookingOrGuestWithFacility]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_BookingOrGuestWithFacility 1,1,1,1,'2023-02-20 10:00:00',1
*/
Create PROC [dbo].[sp_BookingOrGuestWithFacility]
(
@HotelID int,
@BookingID int,
@GuestID int,
@FacilityID int,
@DateAndTime datetime,
@SaveBy int
)
AS
BEGIN
INSERT INTO BookingOrGuestWithFacility Values
(@HotelID,@BookingID,@GuestID,@FacilityID,@DateAndTime,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Facility]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_Facility 1,'Swimming',1
*/
Create PROC [dbo].[sp_Facility]
(
@HotelID int,
@FacilityName varchar(50),
@SaveBy int 
)
AS
BEGIN
INSERT INTO Facility Values
(@HotelID,@FacilityName,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Guest]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_Guest 'Sommit','Dhaka','2346189','123456096',1,1
*/
Create PROC [dbo].[sp_Guest]
(
@GuestName Varchar(50), 
@GuestAddress Varchar(50), 
@GuestPhone Varchar(11), 
@GuestNID int, 
@HotelID int ,
@SaveBy int 
)
AS
BEGIN
INSERT INTO Guest Values
(@GuestName,@GuestAddress,@GuestPhone,@GuestNID,@HotelID,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Hotel]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_Hotel]
(
@HotelID int,  
@HotelName varchar(50), 
@HotelAddress varchar(50),
@HotelPhone varchar(11), 
@IsActive int, 
@SavedBy int 
)
AS
BEGIN
DECLARE @output varchar(50)='Not Match'
	select @output='Match' from Hotel where HotelName=@HotelName and HotelAddress=@HotelAddress

	print @output

	if(@output='Match')
	BEGIN
		select Booking.* from Hotel 
		inner join Booking ON Booking.HotelID=Hotel.HotelID
		where HotelName=@HotelName and HotelAddress=@HotelAddress
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HotelAsset]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_HotelAsset 'AC',1,0,1,1
*/
Create PROC [dbo].[sp_HotelAsset]
(
@HotelAssetName varchar(50), 
@HotelID int,
@IsChangeable int,
@IsReuseable int,
@SaveBy int 
)
AS
BEGIN
INSERT INTO HotelAsset Values
(@HotelAssetName,@HotelID,@IsChangeable,@IsReuseable,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HotelReg]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_HotelReg]
(  
@HotelName varchar(50), 
@HotelAddress varchar(50),
@HotelPhone varchar(11),  
@SavedBy int 
)
AS
BEGIN
INSERT INTO Hotel Values
(@HotelName,@HotelAddress,@HotelPhone,1,@SavedBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HotelRoom]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[sp_HotelRoom]
(
@HotelRoomName varchar(50),
@HotelRoomTypeID int,
@SaveBy int
)
AS
BEGIN
INSERT INTO HotelRoom Values
(@HotelRoomName,@HotelRoomTypeID,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HotelRoomType]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[sp_HotelRoomType]
(
@HotelRoomTypeName varchar(50),
@HotelID int,
@SaveBy int 
)
AS
BEGIN
INSERT INTO HotelRoomType Values
(@HotelRoomTypeName,@HotelID,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HotelRoomTypeWithAssets]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_HotelRoomTypeWithAssets 1,1,1
*/
Create PROC [dbo].[sp_HotelRoomTypeWithAssets]
(
@HotelID int,
@HotelRoomTypeID int,
@SaveBy int 
)
AS
BEGIN
INSERT INTO HotelRoomTypeWithAssets Values
(@HotelID,@HotelRoomTypeID,@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUserReg]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[sp_LoginUserReg]
(
@UserName varchar(50),
@UserPassword varchar(20), 
@RoleID int,
@SaveBy int 
)
AS
BEGIN
INSERT INTO LoginUser Values
(@UserName,@UserPassword,@RoleID,'Y',@SaveBy)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Staff]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[sp_Staff]
(
@StaffName varchar(50),
@RoleID int ,
@StaffDateOfBirth date,
@NID varchar(20),
@HireDate date ,
@SaveBy int ,
@UserID int
)
AS
BEGIN
INSERT INTO Staff Values
(@StaffName,@RoleID,@StaffDateOfBirth,@NID,@HireDate,'Y',@SaveBy,@UserID)
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_UserRole]    Script Date: 1/8/2024 8:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC dbo.sp_UserRole 'Manager',1,1
*/
Create PROC [dbo].[sp_UserRole]
(
@RoleName varchar(50),
@HotelID int,
@SaveBy int
)
AS
BEGIN
INSERT INTO UserRole Values
(@RoleName,@HotelID,@SaveBy)
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Hotel"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "UserRole"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LoginUser"
            Begin Extent = 
               Top = 7
               Left = 523
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Staff"
            Begin Extent = 
               Top = 7
               Left = 774
               Bottom = 170
               Right = 979
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "HotelRoomType"
            Begin Extent = 
               Top = 7
               Left = 1027
               Bottom = 170
               Right = 1271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HotelRoomTypeWithAssets"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 339
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HotelRoom"
            Begin Extent = 
               Top = 175
               Left = 387
               Bottom = 338
               Right = 606
            End
           ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HotelsAllData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingOrGuestWithFacility"
            Begin Extent = 
               Top = 175
               Left = 654
               Bottom = 338
               Right = 949
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Facility"
            Begin Extent = 
               Top = 175
               Left = 997
               Bottom = 338
               Right = 1191
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Guest"
            Begin Extent = 
               Top = 175
               Left = 1239
               Bottom = 338
               Right = 1433
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Booking"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "HotelAsset"
            Begin Extent = 
               Top = 343
               Left = 290
               Bottom = 506
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 69
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HotelsAllData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HotelsAllData'
GO
USE [master]
GO
ALTER DATABASE [HotelManagementDB] SET  READ_WRITE 
GO
