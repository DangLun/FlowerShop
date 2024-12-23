USE [master]
GO
/****** Object:  Database [FlowerShop]    Script Date: 30/07/2024 14:57:35 ******/
CREATE DATABASE [FlowerShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FlowerShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FlowerShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FlowerShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FlowerShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlowerShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlowerShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlowerShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlowerShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlowerShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlowerShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlowerShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FlowerShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlowerShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlowerShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlowerShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlowerShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlowerShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlowerShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlowerShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlowerShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FlowerShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlowerShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlowerShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlowerShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlowerShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlowerShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FlowerShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FlowerShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FlowerShop] SET  MULTI_USER 
GO
ALTER DATABASE [FlowerShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlowerShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FlowerShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FlowerShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FlowerShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [FlowerShop]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[CreateDate] [datetime] NULL,
	[QuantityLog] [int] NULL,
	[LogDate] [datetime] NULL,
	[Status] [bit] NULL,
	[TypeAccountID] [int] NULL,
	[CustomerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banners]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banners](
	[BannerID] [int] IDENTITY(1,1) NOT NULL,
	[BannerName] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[BannerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CustomerID] [int] NOT NULL,
	[FlowerID] [int] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK__Carts__2DD2237B7447C032] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[FlowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](250) NULL,
	[CustomerPhone] [varchar](11) NULL,
	[CustomerAvatar] [nvarchar](250) NULL,
	[CustomerEmail] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deliveries]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deliveries](
	[DeliveriyID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryName] [nvarchar](250) NULL,
	[DeliveryMain] [bit] NOT NULL,
	[CustomerID] [int] NULL,
	[FullName] [nvarchar](250) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliveriyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flowers]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flowers](
	[FlowerID] [int] IDENTITY(1,1) NOT NULL,
	[FlowerName] [nvarchar](250) NULL,
	[FlowerQuantity] [int] NULL,
	[FlowerDiscount] [float] NULL,
	[FlowerPrice] [int] NULL,
	[FlowerPicture] [nvarchar](250) NULL,
	[FlowerDiscription] [nvarchar](4000) NULL,
	[FlowerStatus] [bit] NULL,
	[FlowerNew] [bit] NULL,
	[FlowerDVT] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK__Flowers__97C47C39E6E02797] PRIMARY KEY CLUSTERED 
(
	[FlowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[FlowerID] [int] NOT NULL,
 CONSTRAINT [PK__Images__7516F4EC0BB095CE] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[FlowerID] [int] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK__OrderDet__4AEC1C6CCC8CA9F6] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FlowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Status] [char](10) NULL,
	[CustomerID] [int] NULL,
	[DeliveryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topics]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics](
	[TopicID] [int] IDENTITY(1,1) NOT NULL,
	[TopicName] [nvarchar](250) NULL,
 CONSTRAINT [PK__Topics__022E0F7D21AD420B] PRIMARY KEY CLUSTERED 
(
	[TopicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topics_Flowers]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics_Flowers](
	[TopicID] [int] NOT NULL,
	[FlowerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TopicID] ASC,
	[FlowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeAccounts]    Script Date: 30/07/2024 14:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeAccounts](
	[TypeAccountID] [int] IDENTITY(1,1) NOT NULL,
	[TypeAccountName] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountID], [Username], [Password], [CreateDate], [QuantityLog], [LogDate], [Status], [TypeAccountID], [CustomerID]) VALUES (6, N'admin', N'admin', CAST(N'2024-03-22T00:00:00.000' AS DateTime), 280, CAST(N'2024-07-30T14:54:44.243' AS DateTime), 1, 1, 1)
INSERT [dbo].[Accounts] ([AccountID], [Username], [Password], [CreateDate], [QuantityLog], [LogDate], [Status], [TypeAccountID], [CustomerID]) VALUES (1003, N'dang123', N'11111111', CAST(N'2024-06-30T21:12:05.623' AS DateTime), 1, CAST(N'2024-07-02T02:50:02.000' AS DateTime), 1, 2, NULL)
INSERT [dbo].[Accounts] ([AccountID], [Username], [Password], [CreateDate], [QuantityLog], [LogDate], [Status], [TypeAccountID], [CustomerID]) VALUES (1005, N'tan123', N'12345678', CAST(N'2024-07-09T06:44:19.013' AS DateTime), 2, CAST(N'2024-07-09T07:32:30.000' AS DateTime), 1, 2, NULL)
INSERT [dbo].[Accounts] ([AccountID], [Username], [Password], [CreateDate], [QuantityLog], [LogDate], [Status], [TypeAccountID], [CustomerID]) VALUES (2005, N'chau123', N'11111111', CAST(N'2024-07-24T08:25:42.060' AS DateTime), 9, CAST(N'2024-07-24T10:56:40.910' AS DateTime), 1, 2, 1007)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Banners] ON 

INSERT [dbo].[Banners] ([BannerID], [BannerName]) VALUES (1, N'slide2.png')
INSERT [dbo].[Banners] ([BannerID], [BannerName]) VALUES (2, N'slide1.jpg')
INSERT [dbo].[Banners] ([BannerID], [BannerName]) VALUES (3, N'slide3.png')
INSERT [dbo].[Banners] ([BannerID], [BannerName]) VALUES (4, N'slide4.jpg')
INSERT [dbo].[Banners] ([BannerID], [BannerName]) VALUES (8, N'123')
SET IDENTITY_INSERT [dbo].[Banners] OFF
GO
INSERT [dbo].[Carts] ([CustomerID], [FlowerID], [Quantity]) VALUES (4, 16, 1)
INSERT [dbo].[Carts] ([CustomerID], [FlowerID], [Quantity]) VALUES (6, 32, 1)
INSERT [dbo].[Carts] ([CustomerID], [FlowerID], [Quantity]) VALUES (1007, 32, 1)
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (1, N'Trần Duy Đăng', N'0868337747', N'm.jpg', N'dydzang@gmail.com')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (2, N'Nguyễn Thị Cẩm Trân', N'0868337747', N'default.png', N'cam18tran7@gmail.com')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (4, N'Trần Duy Đăng', NULL, N'dog.jpg', N'danglun337747@gmail.com')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (6, N'BuiHuy', N'123456789', N'face.jpg', N'buituanhuy8@gmail.com')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (7, N'Huỳnh Trung Tấn', N'0868337741', N'default.png', N'tanhuynh.31211020292@st.ueh.edu.vn')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerPhone], [CustomerAvatar], [CustomerEmail]) VALUES (1007, N'Phan Bội Châu', N'0121223345', N'dog.jpg', N'fkdsa@gmail.com')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Deliveries] ON 

INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1, N'Đường Văn Tấn Bảy, P6, Tp.Cao lãnh, Đồng Tháp', 0, 1, N'Trần Duy Đăng', N'0868337747')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (2, N'Ngõ 82, Thanh Bình, Đồng Tháp', 0, NULL, N'Nguyễn Công Thuận', N'0120688451')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1003, N'Q12, TP.HCM', 1, 1, N'Phạm Thanh Tú', N'0939616191')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1004, N'Thanh Bình, Đồng Tháp', 0, 1, N'Cao Văn Hiếu', N'0939616192')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1019, N'Nhà trọ Huy Hưng', 1, 4, N'Duy Đăng', N'0868337747')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1020, N'Số nhà 101, đường 12, p4, tp.cao lãnh', 1, 6, N'Huy Bùi', N'0120653645')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1021, N'Nhà trọ Phan Bội Châu', 0, 1, N'Phan Tuấn trung', N'0120688451')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (1022, N'QL30', 0, 1, N'Tấn', N'0939717122')
INSERT [dbo].[Deliveries] ([DeliveriyID], [DeliveryName], [DeliveryMain], [CustomerID], [FullName], [Phone]) VALUES (2022, N'1', 0, 4, N'123', N'123')
SET IDENTITY_INSERT [dbo].[Deliveries] OFF
GO
SET IDENTITY_INSERT [dbo].[Flowers] ON 

INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (2, N'Bó hoa dịu ngọt yêu thương', 46, 20, 1050000, N'1.jpg', N'Sản phẩm bao gồm:

Rose Sweet Avalanche Premium: 10 Cành
Hoa Cẩm Tú Cầu: 2 Cành
Hoa Cẩm Chướng Đơn: 10 Cành
Hoa Cát Tường: 1 Bó
Hoa Delphinium hoặc Tweedia: 1 Bó
Lá Bạc: 1 Bó
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (3, N'Bó Hoa Yêu Thương Đong Đầy', 40, 10, 980000, N'2.jpg', N'Sản phẩm bao gồm:

Rose Red Naomi Premium: 1 Bó
Hoa Cẩm Chướng Nhánh: 10 Cành
Hoa Chuỗi Ngọc: 1 Bó
Hoa Baby hoặc Baby: 1 Bó
Cỏ Đồng Tiền: 5 Cành
Lá Bạc: 1 Bó
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (4, N'Bó Hoa Sứ Giả May Mắn', 50, 10, 480000, N'3.jpg', N'Sản phẩm bao gồm:

Hoa Thủy Tiên: 20 Cành (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (5, N'Bó Hoa Me Before You', 40, 10, 390000, N'4.jpg', N'Sản phẩm bao gồm:

Rose Red Naomi Premium: 10 Cành
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (6, N'Bó Hoa Yêu Thương Nồng Ấm', 80, 20, 1300000, N'5.jpg', N'Sản phẩm bao gồm:

Hồng Ecuador: 3 Cành (giao màu ngẫu nhiên)
Hoa Cúc Mẫu Đơn nhuộm: 1 Bó (giao màu ngẫu nhiên)
Rose Avala PRE: 1 Bó
Hoa Cẩm Chướng Đơn: 5 Cành
Delphinium hoặc Baby hoặc Tana: 1 Bó
Baby hoặc Tana: 1 Bó
Hoa Cúc Nhánh: 1 Bó
Lá Bạc: 1 Bó
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (7, N'Bó Hoa Ngày Mới An Nhiên', 50, 15, 1400000, N'6.jpg', N'Sản phẩm bao gồm:

Rose Lily - Lily Kép: 1 Bó
Hoa Cẩm Tú Cầu: 2 Cành (hồng đậm hoặc hồng nhạt)
Hoa Hồng Chùm: 1 Bó
Hoa Kiwi Mellow: 1 Bó
Delphinium/Tweedia/ Cúc nhánh xanh: 1 Bó
Hoa Cúc Nhánh: 1 Bó
Lá Bạc: 1 Bó
Giấy & Nơ: 1 Bộ
', 1, 1, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (8, N'Bình Hoa Yêu Thương Đậm Sâu', 48, 12, 980000, N'7.jpg', N'Sản phẩm bao gồm:

Rose Cool Water: 7 Cành
Hoa Hồng Chùm: 1 Bó
Hoa Cúc Đơn Magnum nhuộm: 3 Cành
Hoa Mõm Sói: 5 Cành
Hoa Cẩm Chướng Đơn: 5 Cành
Cúc Tana hoặc Baby: 5 Cành
Cỏ Đồng Tiền: 3 Cành
Lá Bạc: 1 Bó
Bình + Foam: 1 Bộ
', 1, 1, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (9, N'Bình Hoa Nắng Ấm Dịu Dàng', 38, 15, 1200000, N'8.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Đơn Magnum nhuộm: 1 Bó
Hoa Cúc Mẫu Đơn nhuộm: 1 Bó
Hoa Cúc Ping Pong Hồng: 1 Bó
Cẩm Chướng mới: 1 Bó
Hoa Santini: 1 Bó
Lá Dương Xỉ: 1 Bó
Bình + Foam: 1 Bộ
', 1, 1, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (10, N'Giỏ Hoa Yêu Thương Rực Rỡ', 55, 15, 1400000, N'9.jpg', N'Sản phẩm bao gồm:

Rose Sweet Avala PRE: 1 Bó
Rose Peach Avala PRE: 1 Bó
Hoa Cẩm Tú Cầu: 2 Cành (hồng đậm hoặc hồng nhạt)
Hoa Hồng Chùm: 1 Bó
Delphinium hoặc Cúc nhánh xanh hoặc Tweedia: 1 Bó
Hoa Cúc Nhánh: 1 Bó
Lá Bạc: 1 Bó
Giỏ + Foam: 1 Bộ
', 1, 1, N'Giỏ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (11, N'Giỏ Hoa Dẫn Lối Yêu Thương', 45, 15, 1500000, N'10.jpg', N'Sản phẩm bao gồm:

Rose Espana Premium: 5 Cành
Hoa Cúc Mẫu Đơn nhuộm: 3 Cành
Đồng Tiền đỏ: 10 Cành
Đồng Tiền cam: 7 Cành
Hoa Calla Lily: 1 Bó
Sp Veronica: 1 Bó
Cúc Tana hoặc Baby: 3 Cành
Hoa Thủy Tiên: 3 Cành
Phi Yến: 5 Cành
Delphinium hoặc Tweedia: 1 Bó
Scabiosa: 0.5 Bó
Lá Bạc: 1 Bó
Giỏ + Foam: 1 Bộ
', 1, 1, N'Giỏ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (12, N'Giỏ Hoa Yêu Thương Trân Quý', 55, 20, 1200000, N'11.jpg', N'Sản phẩm bao gồm:
+ Hoa Cúc Mẫu Đơn hồng đậm hoặc hồng nhạt: 5 Cành (có thể thay đổi bằng hoa Cẩm Tú Cầu)
+ Rose  Peach Avala PRE: 1 Bó 
+ Hoa Cát Tường: 1 Bó
+ Lá: 1 Bó
+ Hoa Sao Tím: 1 Bó
+ Hoa Calimero: 0.5 Bó
+ Lá Dương Xỉ: 1.5 Bó
+ Giỏ + Foam: 1 Bộ
', 1, 0, N'Giỏ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (13, N'Combo Món Quà Yêu Thương 029', 30, 10, 600000, N'12.jpg', N'Sản phẩm bao gồm:

+ Bó Hoa Me Before You 

Rose Red Naomi Premium: 10 Cành
Giấy & Nơ: 1 Bộ
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ của sản phẩm.

+ Dâu Tây Hasfarm 500gram: 1 hộp

Dâu Tây Hasfarm được thu hoạch và chuyển đi mỗi ngày với số lượng có hạn nên có thể hết hàng sớm, Quý khách vui lòng liên hệ hotline 1800 1143 để kiểm tra trước nhé!
', 1, 1, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (14, N'Combo Món Quà Yêu Thương 022', 30, 10, 510000, N'13.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Thiết Kế Chân Thành 065

Chậu Hoa Cẩm Tú Cầu Lớn: 1 Chậu
Chậu sứ + Đất: 1 Bộ
Chiều cao và màu sắc hoa có thể thay đổi vào từng thời điểm giao hàng khác nhau do đặc tính của sản phẩm nông nghiệp.

Kiểu dáng và màu sắc chậu có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.

Dâu Tây Hasfarm 500gram

Dâu Tây Hasfarm được thu hoạch và chuyển đi mỗi ngày với số lượng có hạn nên có thể hết hàng sớm, bạn hãy liên hệ hotline 1800 1143 để kiểm tra trước nhé!
', 1, 1, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (15, N'Combo Món Quà Yêu Thương 020', 35, 10, 420000, N'14.jpg', N'Sản phẩm bao gồm:

+ Chậu Hoa Thiết Kế Điều Ngọt Ngào 096

+ Chậu Hoa Cúc Họa Mi: 1 Chậu (giao màu ngẫu nhiên)
+ Giấy & Nơ: 1 Bộ
Màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.

+ Dâu Tây Hasfarm 500gram

Dâu Tây Hasfarm được thu hoạch và chuyển đi mỗi ngày với số lượng có hạn nên có thể hết hàng sớm, bạn hãy liên hệ hotline 1800 1143 để kiểm tra trước nhé!
', 1, 1, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (16, N'Bình Hoa Giọt Nắng Tinh Khôi', 33, 15, 650000, N'15.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Tana: 2 Bó
Bình: 1 Cái
Kiểu dáng và màu sắc bình có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (17, N'Bình Hoa Ánh Dương Rực Rỡ', 39, 10, 1250000, N'16.jpg', N'Sản phẩm bao gồm:

Hướng Dương: 1 Bó
Hoa Cúc Mẫu Đơn: 1 Bó
Rose Peach Avala Premium: 1 Bó
Hoa Cẩm Chướng Đơn: 1 Bó
Sao Tím: 1 Bó
Lá Chanh: 1 Bó
Bình + Foam: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.

Kiểu dáng và màu sắc bình có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm
', 1, 1, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (18, N'Chậu Hoa Lavender Hạnh Phúc', 45, 15, 750000, N'17.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Oải Hương trung: 4 Chậu
Chậu Cây Nguyệt Quế mini: 1 Chậu
Chậu + Đất: 1 Bộ
Kiểu dáng và màu sắc chậu có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (19, N'Chậu Giấy Gói Hoa Cẩm Tú Cầu Lớn', 39, 10, 220000, N'18.jpg', N'Sản phẩm bao gồm:

 Chậu Hoa Cẩm Tú Cầu: 1 Chậu
Giấy & Nơ: 1 Bộ (giao màu ngẫu nhiên)
Chiều cao hoa và độ nở sẽ có chênh lệch do tính chất tự nhiên của hàng nông nghiệp.

Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (20, N'Giỏ Cẩm Tú Cầu Hoàng Gia 018', 45, 10, 620000, N'19.jpg', N'Sản phẩm bao gồm:

+ Chậu Cẩm Tú Cầu Hoàng Gia: 1 Chậu (màu hoa ngẫu nhiên)
+ Giỏ + Đất + Sỏi: 1 Bộ
Chiều cao và màu sắc hoa có thể thay đổi vào từng thời điểm giao hàng khác nhau do đặc tính của sản phẩm nông nghiệp.

Kiểu dáng và màu sắc giỏ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Giỏ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (21, N'Chậu Sứ Cẩm Tú Cầu Hoàng Gia 017', 50, 15, 620000, N'20.jpg', N'Sản phẩm bao gồm:

+ Chậu Cẩm Tú Cầu Hoàng Gia: 1 Chậu (màu hoa ngẫu nhiên)
+ Chậu Sứ + Đất + Sỏi: 1 Bộ
Chiều cao và màu sắc hoa có thể thay đổi vào từng thời điểm giao hàng khác nhau do đặc tính của sản phẩm nông nghiệp.

Kiểu dáng và màu sắc giỏ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (22, N'Chậu Giấy Gói Hoa Đồng Tiền', 47, 5, 140000, N'21.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Đồng Tiền trung: 1 Chậu (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ (giao màu ngẫu nhiên)
Số lượng hoa và độ nở sẽ có chênh lệch do tính chất tự nhiên của hàng nông nghiệp.

Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (23, N'Chậu Hoa Thiết Kế Điều Ngọt Ngào 01', 35, 5, 230000, N'22.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Hồng : 1 Chậu (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ 
Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (24, N'Chậu Hoa Thiết Kế Điều Ngọt Ngào 02', 34, 5, 230000, N'23.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Hồng trung: 1 Chậu (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ 
Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (25, N'Chậu Hoa Thiết Kế Điều Ngọt Ngào 03', 33, 5, 200000, N'24.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Anh Thảo: 1 Chậu (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ 
Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Chậu', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (26, N'Kệ Hoa Chúc Mừng 034', 36, 10, 2300000, N'25.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Mẫu Đơn nhuộm: 3 Bó
Hoa Cúc Đơn Magnum nhuộm: 1 Bó
Hoa Lily Kép: 1 Cành
Hoa Cúc Lưới: 1 Bó
Hoa Calimero/ Santini/ Rossi: 2 Bó
Hoa Cẩm Chướng Nhánh: 10 Cành
Hoa Thạch Thảo: 1 Bó
Lan Hồ Điệp: 1 Cành
Lá: 3 Bó
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (27, N'Kệ Hoa Chúc Mừng 031', 29, 15, 1500000, N'26.jpg', N'Sản phẩm bao gồm:

Hướng Dương: 17 Cành
Mõm Sói: 1 Bó
Hoa Lan Vũ Nữ: 2 Bó
Hoa Calimero: 2 Bó
Lá Dương Xỉ: 1 Bó
Lá Bạc: 1 Bó
Lá: 2 Bó
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (28, N'Kệ Hoa Chúc Mừng 030', 30, 15, 2350000, N'27.jpg', N'Sản phẩm bao gồm:

Rose Red Naomi PRE: 3 Bó
Hoa Cẩm Chướng Đơn Đỏ: 40 Cành
Hoa Cẩm Chướng Đơn Vàng: 10 Cành
Hồng Môn: 12 Cành
Lá Bạc: 2 Bó
Lá: 2 Bó
Phụ liệu Quạt giấy: Bộ
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (29, N'Kệ Hoa Chúc Mừng 026', 35, 15, 1750000, N'28.jpg', N'Sản phẩm bao gồm:

Hoa Hồng Môn: 10 Cành
Hoa Cúc Đơn Magnum nhuộm: 1 Bó
Hoa Cúc Mẫu Đơn nhuộm: 1 Bó
Hoa Hồng Chùm: 1 Bó
Hoa Cúc Nhánh: 2 Bó
Baby: 1 Bó
Sao Tím: 1 Bó
Lá: 1 Bó
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (30, N'Kệ Hoa Chúc Mừng 024', 40, 15, 1500000, N'29.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Mẫu Đơn nhuộm: 2 Bó
Hoa Cúc Đơn: 1 Bó
Hoa Cúc Đơn Magnum nhuộm: 1 Bó
Rose Red Naomi PRE: 1 Bó
Hoa Cúc Nhánh: 2 Bó
Baby: 1 Bó
Sao Tím: 1 Bó
Hồng Môn: 11 Cành
Lá: 1 Bó
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (31, N'Kệ Hoa Chúc Mừng 023', 45, 20, 1700000, N'30.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Mẫu Đơn nhuộm: 2 Bó
Hoa Cúc Đơn: 1 Bó
Hoa Cúc Nhánh Nhuộm: 1 Bó
Hoa Calimero: 1 Bó
Hoa Mõm Sói: 1 Bó
Hoa Lan Vũ Nữ: 1 Bó
Hoàng Anh: 1 Bó
Lá: 1 Bó
Phụ liệu khác: 0.5 Bộ
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (32, N'Bình Hoa Chúc Mừng 103', 30, 20, 4150000, N'31.jpg', N'Sản phẩm bao gồm:

Hồng Ecuador: 10 Cành
Hoa Cúc Mẫu Đơn nhuộm: 1 Bó
Địa Lan: 3 Cành
Mõm Sói hoặc Phi Yến: 1 Bó
Rose Penny lane PRE: 1 Bó
Hoa Hồng Chùm: 1 Bó
Hoa Thiên Điểu: 7 Cành
Lá Bạc: 2 Bó
Lá Dương Xỉ: 1 Bó
Hoa Cúc Rossi: 1 Bó
Hoa Cúc Nhánh: 1 Bó
Bình đại + Foam: 1 Cái
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (33, N'Bình Hoa Chúc Mừng 102', 32, 20, 3200000, N'32.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Mẫu Đơn nhuộm: 2 Bó
Hồng Ecuador: 7 Cành
Hoa Cúc Đơn: 1 Bó
Hoa Cát Tường: 1 Bó
Hoa Cẩm Tú Cầu: 4 Cành
Mõm Sói: 1 Bó
Lá Bạc: 2 Bó
Lá Dương Xỉ: 1 Bó
Sao Tím: 1 Bó
Bình đại + Foam: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bình', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (34, N'Kệ Hoa Chúc Mừng 004', 39, 20, 2950000, N'33.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Mẫu Đơn nhuộm: 1.2 Bó
Hoa Cúc Đơn Lưới Hồng: 1 Bó
Hoa Cúc Đơn Lưới Trắng: 1 Bó
Hoa Cúc Ping Pong Hồng: 1 Bó
Rose Freaky Avala PRE: 1 Bó
Hoa Hồng Chùm: 1 Bó
Hoa Chuông: 1 Bó
Mõm Sói: 1 Bó
Cẩm Chướng mới: 2 Bó
Baby nhuộm: 2 Bó
Thạch Thảo: 1 Bó
Lá Dương Xỉ: 1 Bó
Lá Chanh: 1 Bó
Lá Tùng Nho hoặc Đuôi Chồn: 1 Bó
Kệ + Foam, Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (35, N'Kệ Hoa Chúc Mừng 005', 40, 20, 4500000, N'34.jpg', N'Sản phẩm bao gồm:

Hồng Ecuador: 6 Cành
Hoa Cúc Mẫu Đơn nhuộm: 1 Bó
Hoa Cúc Đơn Magnum nhuộm: 2 Bó
Rose Peach Avala PRE: 1 Bó
Hoa Cúc Nhánh: 2 Bó
Hướng Dương: 2 Bó
Hoa Hồng Chùm: 1 Bó
Hoa Thủy Tiên: 1 Bó
Lá Chanh: 1 Bó
Lá Tùng Nho hoặc Đuôi Chồn: 1 Bó
Lá Bạc: 1 Bó
Phụ liệu quạt giấy: 1 Bộ
Lan Hồ Điệp: 5 Cành
Kệ Sắt + Foam, Giấy, Nơ, Ribbon: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (36, N'Kệ Hoa Chúc Mừng 018', 35, 20, 4100000, N'35.jpg', N'Sản phẩm bao gồm:

+ Hồng Ecuador Free Spirit: 25 Cành
+ Hoa Hồng Tỉ Muội cam: 3 Bó
+ Baby: 1 Bó
+ Lá bạc: 2 Bó
+ Hoa Green Wicky: 2 Bó
+ Chuỗi Ngọc xanh: 1 Bó
+ Lá: 2 Bó
+ Kệ: 1 Cái
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (37, N'Bó Hoa The Dreamers 448', 35, 5, 250000, N'36.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Nhánh Nhuộm: 2 Cành 
Hoa Cát Tường: 5 Cành (giao màu ngẫu nhiên)
Cỏ Đồng Tiền hoặc lá: 1 Cành
Sao Tím hoặc Baby: 1 Bó
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (38, N'Bó Hoa The Dreamers 447', 35, 5, 240000, N'37.jpg', N'Sản phẩm bao gồm:

Cát Tường: 3 Cành (giao màu ngẫu nhiên)
Cẩm Chướng Nhánh: 3 Cành (giao màu ngẫu nhiên)
Cẩm Chướng Sao: 3 Cành (giao màu ngẫu nhiên)
Cỏ Đồng Tiền hoặc lá: 2 Cành
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (39, N'Bó Hoa The Dreamers 446', 35, 5, 200000, N'38.jpg', N'Sản phẩm bao gồm:

Cúc Tana hoặc Baby: 2 Cành
Scabiosa: 2 Cành
Veronica: 2 Cành 
Cẩm Chướng Sao: 5 Cành (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (40, N'Bó Hoa The Dreamers 445', 35, 5, 240000, N'39.jpg', N'Sản phẩm bao gồm:

Đồng Tiền: 5 Cành (giao màu ngẫu nhiên)
Cúc Tana hoặc Baby: 3 Cành
Phi Yến hoặc Mõm Sói: 5 Cành (giao màu ngẫu nhiên)
Cỏ Đồng Tiền hoặc lá: 1 Cành
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (41, N'Bó Hoa The Dreamers 444', 38, 5, 200000, N'40.jpg', N'Sản phẩm bao gồm:

Thạch Thảo: 8 Cành (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (42, N'Bó Hoa Roselily - Hoa Lily Kép hồng (3 Cành)', 35, 5, 186000, N'41.jpg', N'Sản phẩm bao gồm: 1 bó Hoa Lily Kép Hồng 3 Cành (không kèm bình hoa)

Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về độ nở của hoa.
Thông thường shop sẽ giao sản phẩm còn nụ để hoa có thể nở rộ sau vài ngày được bạn chăm sóc.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (43, N'Bó Hoa Thủy Tiên - Alstroemeria (10 Cành)', 35, 0, 82000, N'42.jpg', N'Sản phẩm bao gồm: 1 Bó Hoa Thủy Tiên giao màu ngẫu nhiên (10 cành/bó) 

Hình dáng hoa có thể khác tùy vào tình hình thực tế nhưng vẫn bảo đảm chất lượng chuẩn.

Do tính chất tự nhiên của hoa mà sản phẩm thực nhận có thể khác với hình minh họa về độ nở của hoa. Thông thường shop sẽ giao sản phẩm mới để hoa có thể nở rộ sau vài ngày được bạn chăm sóc.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (44, N'Combo 10 Bó Hoa Cúc Nhánh Mix', 40, 10, 500000, N'43.jpg', N'Sản phẩm bao gồm: 10 Bó Hoa Cúc Nhánh Mix màu ngẫu nhiên đỏ, cam, hồng, trắng hoặc tím (5 cành/bó) 

Hình dáng hoa có thể khác tùy vào tình hình thực tế nhưng vẫn bảo đảm chất lượng chuẩn.

Do tính chất tự nhiên của hoa mà sản phẩm thực nhận có thể khác với hình minh họa về độ nở của hoa. Thông thường shop sẽ giao sản phẩm mới để hoa có thể nở rộ sau vài ngày được bạn chăm sóc.

Sản phẩm không bao gồm bình thủy tinh.
', 1, 0, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (45, N'Combo 10 Bó Hoa Cúc Lưới Mix', 35, 20, 1140000, N'44_1.jpg', N'Sản phẩm bao gồm: 10 Bó Hoa Cúc Lưới Mix (10 cành/bó) giao màu ngẫu nhiên
Hình dáng hoa có thể khác tùy vào tình hình thực tế nhưng vẫn bảo đảm chất lượng chuẩn.

Do tính chất tự nhiên của hoa mà sản phẩm thực nhận có thể khác với hình minh họa về độ nở của hoa. Thông thường shop sẽ giao sản phẩm mới để hoa có thể nở rộ sau vài ngày được bạn chăm sóc.

Sản phẩm không bao gồm bình thủy tinh.
', 1, 0, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (46, N'Combo 05 Bó Hoa Cúc Magnum Trắng', 34, 10, 650000, N'45.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Hồng Môn Size Trung Hasfarm: 10 Chậu
Thùng Carton Hasfarm: 1 Cái  (RPABVC29-P)
Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về số lượng và độ lớn của hoa trong chậu.
', 1, 0, N'Combo', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (47, N'Thùng Hoa Hồng Môn Trung', 35, 20, 1312000, N'46_1.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Hồng Môn Size Trung Hasfarm: 10 Chậu
Thùng Carton Hasfarm: 1 Cái  (RPABVC29-P)
Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về số lượng và độ lớn của hoa trong chậu.
', 1, 0, N'Thùng', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (48, N'Thùng Hoa Sống Đời Trung Kép Mix', 30, 10, 771000, N'47_1.jpg', N'Sản phẩm bao gồm: 

+ Hoa Sống Đời trung kép: 11 chậu màu ngẫu nhiên
+ Thùng carton Dalat Hasfarm: 01 thùng
Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về số lượng và độ lớn của hoa trong chậu.
', 1, 0, N'Thùng', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (49, N'Thùng Hoa Hồng Trung Mix', 30, 15, 991000, N'48_1.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Hồng size trung Dalat Hasfarm: 11 Chậu
Thùng Carton Hasfarm: 1 Cái (RPABVC05-P)
Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về độ nở của hoa.
Thông thường shop sẽ giao sản phẩm còn nụ để hoa có thể nở rộ sau vài ngày được bạn chăm sóc.
', 1, 0, N'Thùng', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (50, N'Thùng Hoa Cúc Lớn', 30, 10, 564000, N'49_1.jpg', N'Sản phẩm bao gồm:

Chậu Hoa Cúc Lớn Hasfarm: 8 Chậu
Thùng Carton Hasfarm: 1 Cái
Do tính chất tự nhiên của hoa và cây xanh mà sản phẩm thực nhận có thể khác với hình minh họa về số lượng và độ lớn của hoa trong chậu.
', 1, 0, N'Thùng', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (51, N'Bó Hoa Tinh Khôi 034', 34, 5, 300000, N'50_1.jpg', N'Sản phẩm bao gồm:

Bó Hoa Cúc Tana: 1 Bó
Giấy & Nơ: 1 Bộ(giao màu ngẫu nhiên)
Số lượng hoa và độ nở sẽ có chênh lệch do tính chất tự nhiên của hàng nông nghiệp.

Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (52, N'Bó Hoa Món Quà Hạnh Phúc 598', 30, 20, 1050000, N'51_1.jpg', N'Sản phẩm bao gồm:

Hoa Cẩm Chướng Đơn: 20 Cành (giao màu ngẫu nhiên)
Hoa Cúc Tana hoặc Baby: 1 Bó
Cỏ Đồng Tiền: 3 cành
Giấy & Nơ: 1 Bộ
Số lượng hoa và độ nở sẽ có chênh lệch do tính chất tự nhiên của hàng nông nghiệp.

Màu sắc giấy gói và nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (53, N'Bó Hoa Cúc Họa Mi Thuần Khiết 601', 35, 15, 950000, N'52_1.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Họa Mi Dalat Hasfarm: 40 Cành
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (54, N'Bó Hoa Yêu Thương 224', 35, 5, 300000, N'53_1.jpg', N'Sản phẩm bao gồm:

+ Rose  Avala PRE: 1 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (55, N'Bó Hoa Dịu Dàng 595', 30, 5, 350000, N'54_1.jpg', N'Sản phẩm bao gồm:

Hoa Phi Yến: 10 Cành (giao màu ngẫu nhiên)
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (56, N'Bó Hoa Yêu Thương Đong Đầy 276', 30, 5, 330000, N'55_1.jpg', N'Sản phẩm bao gồm:

+ Rose  Red Naomi PRE: 3 Cành
+ Lá Chanh: 6 Cành
+ Hoa Calimero: 3 Cành
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (57, N'Bó Hoa Món Quà Hạnh Phúc 354', 35, 5, 450000, N'56_1.jpg', N'Sản phẩm bao gồm:

Hoa Cẩm Chướng Đơn: 20 Cành (giao màu ngẫu nhiên)
Tana hoặc Baby: 0.5 Bó
Cỏ Đồng Tiền: 5 Cành
Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (58, N'Bó Hoa Trân Quý 281', 35, 5, 430000, N'57_1.jpg', N'Sản phẩm bao gồm:

+ Hoa Cúc Mẫu Đơn: 3 cành (giao màu ngẫu nhiên)
+ Cúc Tana: 0.5 Bó
+ Hoa Cúc Nhánh: 3 Cành
+ Lá Bạc: 0.5 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (59, N'Bó Hoa Hạnh Phúc 232', 40, 5, 250000, N'58_1.jpg', N'Sản phẩm bao gồm:

+ Hoa Cẩm Chướng Nhánh: 20 Cành (giao màu ngẫu nhiên)
+ Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (60, N'Bó Hoa Yêu Thương 226', 35, 5, 300000, N'59_1.jpg', N'Sản phẩm bao gồm:

+ Rose  Deep water PRE: 1 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (61, N'Bó Hoa Yêu Thương 230', 30, 5, 300000, N'60_1.jpg', N'Sản phẩm bao gồm:

+ Rose  Solair Premium: 1 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (62, N'Bó Hoa Thanh Xuân 239', 35, 2, 200000, N'61_1.jpg', N'Sản phẩm bao gồm:
+ Hoa Cúc Nhánh: 1 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (63, N'Bó Hoa Hạnh Phúc 233', 30, 3, 250000, N'62_1.jpg', N'Sản phẩm bao gồm:

+ Hoa Cẩm Chướng Nhánh: 20 cành
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (64, N'Bó Hoa Yêu Thương 227', 30, 4, 300000, N'63_1.jpg', N'Sản phẩm bao gồm:

+ Rose Freaky Avalanche: 1 Bó
+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (65, N'Bó Hoa Thanh Xuân 237', 30, 3, 250000, N'64_1.jpg', N'Sản phẩm bao gồm:

+ Hoa Calimero: 1 Bó

+ Giấy + nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (66, N'Bình Hoa Giọt Nắng Tinh Khôi 206', 34, 5, 500000, N'65_1.jpg', N'Sản phẩm bao gồm:

+ Hoa Baby nhập khẩu: 1 Bó (mix màu ngẫu nhiên)
+ Bình sứ + Foam: 1 Bộ
+ Nơ: 1 Cái
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc giấy, nơ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Bó', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (67, N'Kệ Hoa Chia Buồn Chốn Bình Yên 035', 10, 10, 1900000, N'66.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Nhánh Trắng: 30 Cành
Hoa Cúc Nhánh Xanh: 20 Cành
Hoa Cúc Đơn Lưới/Ping Pong Xanh: 20 Cành
Hoa Cát Tường: 15 Cành
Hoa Sao Trắng hoặc Baby: 3 Bó
Lá Dương Xỉ: 40 Cành
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (68, N'Kệ Hoa Chia Buồn Chốn Bình Yên 036', 15, 10, 1950000, N'67.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Đơn Magnum trắng: 20 Cành
Hoa Cúc Đơn Lưới Xanh: 10 Cành
Rose Avalanche Premium: 20 Cành
Hoa Cúc Nhánh: 30 Cành
Lá Dương Xỉ: 40 Cành
Lá: 3 Bó
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 0, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (69, N'Kệ Hoa Chia Buồn Chốn Bình Yên 001', 10, 20, 3300000, N'68.jpg', N'Sản phẩm bao gồm:

Hoa Cẩm Tú Cầu hoặc Cúc Mẫu Đơn: 7 Cành
Đồng Tiền: 30 Cành
Hoa Cúc Đơn: 40 Cành
Hoa Calimero/Rossi: 50 Cành
Rose Avalanche Premium: 20 Cành
Hoa Lily: 5 Cành
Hoa Cát Tường: 5 Cành
Lá Bạc: 2 Bó
Lá Dương Xỉ: 40 Cành
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (70, N'Kệ Hoa Chia Buồn Về Cõi An Yên 012', 15, 20, 3100000, N'69.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Calimero/ Rossi: 40 Cành
Hoa Cúc Đơn: 40 Cành
Hoa Cát Tường: 6 Bó
Hoa Cẩm Chướng Đơn: 40 Cành
Hoa Cẩm Chướng Nhánh: 20 Cành
Rose Cool Water: 2 Bó
Lá Bạc: 3 Bó
Lá Dương Xỉ: 20 Cành
Phụ liệu dây gỗ: 1 Bộ
Kệ + Foam + Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.
', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (71, N'Kệ Hoa Chia Buồn Chốn Bình Yên 011', 10, 20, 1600000, N'70.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Nhánh: 60 Cành
Hồng Môn hoặc Lily hoặc Cúc Magnum: 5 Cành
Lá Dương Xỉ: 1 Bó
Kệ + Foam, Giấy, Nơ: 1 Bộ
Một số loại hoa lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (72, N'Kệ Hoa Chia Buồn Chốn Bình Yên 010', 15, 20, 1900000, N'71.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Nhánh: 60 Cành
Hồng Môn hoặc Lily hoặc Cúc Magnum: 5 Cành
Hoa Cát Tường: 4 Bó
Kệ + Foam + Giấy & Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (73, N'Kệ Hoa Chia Buồn Về Cõi An Yên 009', 15, 20, 2900000, N'72.jpg', N'Sản phẩm bao gồm:

Đồng Tiền: 6 Bó
Hoa Cẩm Chướng Đơn: 2 Bó
Hoa Cẩm Chướng Nhánh: 2 Bó
Hoa Calimero: 3 Bó
Hoa Cát Tường: 2 Bó
Hoa Cúc Nhánh: 2 Bó
Hoa Cúc Đơn: 2 Bó
Lá Dương Xỉ: 1 Bó
Lá Bạc: 1 Bó
Kệ + Foam, Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (74, N'Kệ Hoa Chia Buồn Chốn Bình Yên 003', 10, 20, 2800000, N'73.jpg', N'Sản phẩm bao gồm:

Hoa Cúc Nhánh: 4 Bó
Hoa Hồng Avala PRE: 4 Bó
Hoa Lily: 1 Bó
Lá: 1 Bó
Kệ + Foam, Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (75, N'Kệ Hoa Chia Buồn Chốn Bình Yên 002', 15, 20, 2800000, N'74.jpg', N'Sản phẩm bao gồm:

Hoa Calimero: 7 Bó
Hoa Hồng Avala PRE: 5 Bó
Hoa Lily: 1 Bó
Lá Dương Xỉ: 1 Bó
Kệ + Foam, Giấy, Nơ: 1 Bộ
Một số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.
Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 1, N'Kệ', CAST(N'2024-11-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Flowers] ([FlowerID], [FlowerName], [FlowerQuantity], [FlowerDiscount], [FlowerPrice], [FlowerPicture], [FlowerDiscription], [FlowerStatus], [FlowerNew], [FlowerDVT], [CreateDate]) VALUES (76, N'Kệ Hoa Chia Buồn Về Cõi An Yên 016', 15, 20, 3650000, N'75.jpg', N'Sản phẩm bao gồm:Hoa Lily trắng: 1 BóLan Hồ Điệp hồng/tím: 3 CànhHoa Cát Tường tím: 3 BóHoa Cát Tường trắng: 2 BóRose Sweet Avalanche Premium: 2 BóRose Cool Water: 1 BóHoa Cúc Đơn: 1 BóHoa Sao Tím: 1 BóLá Chanh: 20 CànhLá Dương Xỉ: 40 CànhKệ + Foam + Giấy, Nơ: 1 BộMột số loại hoa, lá có thể được thay thế bằng loại hoa khác tùy vào tình hình thực tế.Kiểu dáng và màu sắc kệ có thể thay đổi ở từng khu vực khác nhau, tuy nhiên vẫn đảm bảo kích cỡ chuẩn và tính thẩm mỹ cho sản phẩm.', 1, 0, N'Kệ', NULL)
SET IDENTITY_INSERT [dbo].[Flowers] OFF
GO
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (1, N'1_1.jpg', 2)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (2, N'1_2.jpg', 2)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (3, N'1_3.jpg', 2)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (4, N'2_1.jpg', 3)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (5, N'2_2.jpg', 3)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (6, N'2_3.jpg', 3)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (8, N'2.jpg', 3)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (9, N'3.jpg', 4)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (10, N'3_1.jpg', 4)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (11, N'3_2.jpg', 4)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (12, N'3_3.jpg', 4)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (13, N'1.jpg', 2)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (33, N'dog.jpg', 76)
INSERT [dbo].[Images] ([ImageID], [ImageUrl], [FlowerID]) VALUES (34, N'face.jpg', 76)
SET IDENTITY_INSERT [dbo].[Images] OFF
GO
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1002, 4, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1002, 5, 4)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1003, 32, 4)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1003, 55, 2)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1005, 6, 2)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1005, 56, 2)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1014, 9, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1014, 62, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1029, 33, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1030, 33, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1031, 51, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1036, 25, 5)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1036, 33, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1037, 25, 2)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1037, 32, 3)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (1039, 33, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (2039, 16, 1)
INSERT [dbo].[OrderDetails] ([OrderID], [FlowerID], [Quantity]) VALUES (2039, 33, 1)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (4, CAST(N'2024-11-05T12:10:00.000' AS DateTime), N'Completed ', 1, 1)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1002, CAST(N'2024-10-11T00:00:00.000' AS DateTime), N'Completed ', 2, 2)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1003, CAST(N'2024-10-11T00:00:00.000' AS DateTime), N'Completed ', 2, 1003)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1005, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'Completed ', 4, 1004)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1014, CAST(N'2024-07-04T04:43:24.043' AS DateTime), N'Completed ', 4, 1003)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1023, CAST(N'2024-07-06T22:55:03.287' AS DateTime), N'Completed ', 1, 1019)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1029, CAST(N'2024-07-06T23:43:46.113' AS DateTime), N'Completed ', 4, 1)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1030, CAST(N'2021-07-06T23:44:01.730' AS DateTime), N'Completed ', 4, 1020)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1031, CAST(N'2021-07-06T23:44:13.190' AS DateTime), N'Completed ', 4, 1)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1036, CAST(N'2022-07-07T02:55:34.793' AS DateTime), N'Completed ', 1, 1003)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1037, CAST(N'2022-07-07T03:00:55.250' AS DateTime), N'Completed ', 1, 1004)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (1039, CAST(N'2023-07-10T07:25:50.827' AS DateTime), N'Completed ', 4, 1019)
INSERT [dbo].[Orders] ([OrderID], [CreateDate], [Status], [CustomerID], [DeliveryID]) VALUES (2039, CAST(N'2024-07-24T08:37:38.560' AS DateTime), N'Pending   ', 1, 1003)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (1, N'Hoa tặng')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (2, N'Hoa dịch vụ')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (3, N'Hoa chậu thiết kế')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (4, N'Hoa chúc mừng')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (5, N'Hoa cắt cành')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (6, N'Hoa chậu')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (7, N'Ngày của Mẹ')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (8, N'Hoa xinh giá tốt')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (9, N'Ngày Nhà Giáo Việt Nam')
INSERT [dbo].[Topics] ([TopicID], [TopicName]) VALUES (10, N'Hoa chia buồn')
SET IDENTITY_INSERT [dbo].[Topics] OFF
GO
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 2)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 3)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 4)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 5)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 6)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 7)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 8)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 9)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 10)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 11)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 12)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 13)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 14)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 15)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 16)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 17)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 18)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 19)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 20)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 21)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 22)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 23)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 24)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 25)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 37)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 38)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 40)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 53)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (1, 65)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 2)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 3)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 4)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 5)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 6)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 7)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 8)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 9)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 10)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 11)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 12)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 13)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 14)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 15)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 16)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 17)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 21)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 22)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 23)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 24)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 25)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 37)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 38)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 40)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 53)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (2, 65)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 18)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 19)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 20)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 21)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 22)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 23)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 24)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 25)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 43)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 44)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (3, 45)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 2)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 3)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 4)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 5)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 7)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 8)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 9)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 10)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 11)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 16)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 17)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 19)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 20)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 21)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 23)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 24)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 25)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 26)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 27)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 28)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 29)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 30)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 31)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 32)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 33)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 34)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 35)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 36)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 53)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (4, 65)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 25)
GO
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 41)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 42)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 71)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 72)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 73)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 74)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (5, 75)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 59)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 60)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 61)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 62)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 63)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 64)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (6, 76)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 2)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 3)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 4)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 5)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 6)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 7)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 8)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 9)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 10)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 11)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 12)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 13)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 14)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 15)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 16)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 17)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 18)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 19)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 20)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 37)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 38)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 40)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 41)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 42)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 54)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 55)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 56)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 57)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 58)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (7, 76)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 37)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 38)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 40)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 41)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 42)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (8, 53)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 2)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 3)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 4)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 5)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 6)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 7)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 8)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 9)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 10)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 11)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 12)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 13)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 16)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 17)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 18)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 37)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 38)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 39)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 40)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 41)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 42)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (9, 70)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 46)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 47)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 48)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 49)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 50)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 51)
INSERT [dbo].[Topics_Flowers] ([TopicID], [FlowerID]) VALUES (10, 52)
GO
SET IDENTITY_INSERT [dbo].[TypeAccounts] ON 

INSERT [dbo].[TypeAccounts] ([TypeAccountID], [TypeAccountName]) VALUES (1, N'Admin')
INSERT [dbo].[TypeAccounts] ([TypeAccountID], [TypeAccountName]) VALUES (2, N'Khách hàng')
SET IDENTITY_INSERT [dbo].[TypeAccounts] OFF
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [PK_Accounts_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [PK_Accounts_Customers]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [PK_Accounts_TypeAccounts] FOREIGN KEY([TypeAccountID])
REFERENCES [dbo].[TypeAccounts] ([TypeAccountID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [PK_Accounts_TypeAccounts]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Customers]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Flowers] FOREIGN KEY([FlowerID])
REFERENCES [dbo].[Flowers] ([FlowerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Flowers]
GO
ALTER TABLE [dbo].[Deliveries]  WITH CHECK ADD  CONSTRAINT [PK_Deliveries_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Deliveries] CHECK CONSTRAINT [PK_Deliveries_Customers]
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_Images_FlowerID] FOREIGN KEY([FlowerID])
REFERENCES [dbo].[Flowers] ([FlowerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_FlowerID]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Flowers] FOREIGN KEY([FlowerID])
REFERENCES [dbo].[Flowers] ([FlowerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Flowers]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Deliveries] FOREIGN KEY([DeliveryID])
REFERENCES [dbo].[Deliveries] ([DeliveriyID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Deliveries]
GO
ALTER TABLE [dbo].[Topics_Flowers]  WITH CHECK ADD  CONSTRAINT [FK__Topics_Fl__Flowe__49C3F6B7] FOREIGN KEY([FlowerID])
REFERENCES [dbo].[Flowers] ([FlowerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Topics_Flowers] CHECK CONSTRAINT [FK__Topics_Fl__Flowe__49C3F6B7]
GO
ALTER TABLE [dbo].[Topics_Flowers]  WITH CHECK ADD  CONSTRAINT [FK__Topics_Fl__Topic__48CFD27E] FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topics] ([TopicID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Topics_Flowers] CHECK CONSTRAINT [FK__Topics_Fl__Topic__48CFD27E]
GO
USE [master]
GO
ALTER DATABASE [FlowerShop] SET  READ_WRITE 
GO
