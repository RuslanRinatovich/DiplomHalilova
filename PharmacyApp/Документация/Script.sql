USE [master]
GO
/****** Object:  Database [FlowersMarketsDB]    Script Date: 03.04.2024 10:50:36 ******/
CREATE DATABASE [FlowersMarketsDB]
GO
USE [FlowersMarketsDB]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Info] [nvarchar](1000) NULL,
	[Address] [nvarchar](1000) NULL,
	[Phone] [nvarchar](50) NULL,
	[Site] [nvarchar](50) NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[Rate] [float] NULL,
	[Photo] [nvarchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[WorkTimeId] [int] NOT NULL,
 CONSTRAINT [PK_Pharmacy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceOrganization]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceOrganization](
	[ServiceOrganizationId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_ServicePharmacy] PRIMARY KEY CLUSTERED 
(
	[ServiceOrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Username] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkTime]    Script Date: 03.04.2024 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTime](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](1000) NULL,
 CONSTRAINT [PK_WorkTime] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Title]) VALUES (1, N'Ларёк(палатка)')
INSERT [dbo].[Category] ([Id], [Title]) VALUES (2, N'Магазин цветов')
INSERT [dbo].[Category] ([Id], [Title]) VALUES (3, N'Цветочный бутик')
INSERT [dbo].[Category] ([Id], [Title]) VALUES (4, N'Оптовый')
INSERT [dbo].[Category] ([Id], [Title]) VALUES (5, N'Интернет магазин')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Organization] ON 

INSERT [dbo].[Organization] ([Id], [Title], [Info], [Address], [Phone], [Site], [Latitude], [Longitude], [Rate], [Photo], [CategoryId], [WorkTimeId]) VALUES (1, N'Клумба', N'Оптово-розничная цветочная база', N'г. Зеленодольск, ​Комсомольская, 9', N'8‒800‒220‒55‒55', N'klumba.ru', 55.852315529491428, 48.565684328680454, 3, N'klumba.jpg', 4, 1)
INSERT [dbo].[Organization] ([Id], [Title], [Info], [Address], [Phone], [Site], [Latitude], [Longitude], [Rate], [Photo], [CategoryId], [WorkTimeId]) VALUES (3, N'Цвет''ок', N'магазин цветов', N'г. Зеленодольск,  ​Татарстан, 9/1', N'+7‒962‒555‒56‒34', N'нет', 55.849042958659865, 48.501385285497058, 5, N'cvetok.jpg', 2, 3)
INSERT [dbo].[Organization] ([Id], [Title], [Info], [Address], [Phone], [Site], [Latitude], [Longitude], [Rate], [Photo], [CategoryId], [WorkTimeId]) VALUES (4, N'Цветы у Сони', N'Скидка 10% по промокоду «2ГИС»', N'г.Зеленодольск, Улица Карла Маркса, 37Б/1', N'+7‒965‒609‒48‒02', N'нет', 55.850517677224545, 48.49843717137955, 5, N'Usony.jpg', 2, 2)
INSERT [dbo].[Organization] ([Id], [Title], [Info], [Address], [Phone], [Site], [Latitude], [Longitude], [Rate], [Photo], [CategoryId], [WorkTimeId]) VALUES (7, N'Дом цветов', N'Ежедневно с 07:00 до 24:00', N'г. Зеленодольск, ​Гоголя, 21/2', N'+7‒960‒080‒84‒48', N'нет', 55.8527161442143, 48.502488863058794, 4, N'domcvetov.jpg', 2, 4)
INSERT [dbo].[Organization] ([Id], [Title], [Info], [Address], [Phone], [Site], [Latitude], [Longitude], [Rate], [Photo], [CategoryId], [WorkTimeId]) VALUES (8, N'Мир цветов', N'​Стадион Авангард', N'​г.Зеленодольск. ул. Ленина, 35', N'+7‒906‒327‒24‒72', N'нет', 55.846096007274738, 48.506362311218133, 3, N'mircvetov.jpg', 3, 3)
SET IDENTITY_INSERT [dbo].[Organization] OFF
GO
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([Id], [Title]) VALUES (1, N'С сайтом')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (2, N'Расчет по картам')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (3, N'С фото')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (4, N'Круглосуточный')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (5, N'Доступно для инвалидов')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (6, N'Доставка цветов')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (7, N'Искусственные цветы')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (8, N'Комнатные растения')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (9, N'Мягкие игрушки')
INSERT [dbo].[Service] ([Id], [Title]) VALUES (10, N'Сухоцветы')
SET IDENTITY_INSERT [dbo].[Service] OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceOrganization] ON 

INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (53, 2, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (54, 3, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (55, 4, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (56, 5, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (57, 6, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (58, 8, 4)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (66, 2, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (67, 3, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (68, 4, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (69, 5, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (70, 6, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (71, 8, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (72, 10, 3)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (73, 1, 1)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (74, 2, 1)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (75, 3, 1)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (76, 4, 1)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (85, 2, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (86, 3, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (87, 5, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (88, 6, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (89, 7, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (90, 8, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (91, 9, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (92, 10, 7)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (93, 2, 8)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (94, 3, 8)
INSERT [dbo].[ServiceOrganization] ([ServiceOrganizationId], [ServiceId], [OrganizationId]) VALUES (95, 6, 8)
SET IDENTITY_INSERT [dbo].[ServiceOrganization] OFF
GO
INSERT [dbo].[User] ([Username], [Password]) VALUES (N'admin', N'2')
INSERT [dbo].[User] ([Username], [Password]) VALUES (N'user', N'1')
GO
SET IDENTITY_INSERT [dbo].[WorkTime] ON 

INSERT [dbo].[WorkTime] ([Id], [Title]) VALUES (1, N'Круглосуточно')
INSERT [dbo].[WorkTime] ([Id], [Title]) VALUES (2, N'8:00 - 21:00')
INSERT [dbo].[WorkTime] ([Id], [Title]) VALUES (3, N'9:00 - 22:00')
INSERT [dbo].[WorkTime] ([Id], [Title]) VALUES (4, N'7:00 - 24:00')
SET IDENTITY_INSERT [dbo].[WorkTime] OFF
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Pharmacy_Category]
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_WorkTime] FOREIGN KEY([WorkTimeId])
REFERENCES [dbo].[WorkTime] ([Id])
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Pharmacy_WorkTime]
GO
ALTER TABLE [dbo].[ServiceOrganization]  WITH CHECK ADD  CONSTRAINT [FK_ServiceOrganization_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([Id])
GO
ALTER TABLE [dbo].[ServiceOrganization] CHECK CONSTRAINT [FK_ServiceOrganization_Organization]
GO
ALTER TABLE [dbo].[ServiceOrganization]  WITH CHECK ADD  CONSTRAINT [FK_ServicePharmacy_Service] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Service] ([Id])
GO
ALTER TABLE [dbo].[ServiceOrganization] CHECK CONSTRAINT [FK_ServicePharmacy_Service]
GO
USE [master]
GO
ALTER DATABASE [FlowersMarketsDB] SET  READ_WRITE 
GO
