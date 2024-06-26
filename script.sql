USE [WebApiNet5]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaHh] [uniqueidentifier] NOT NULL,
	[MaDH] [uniqueidentifier] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
	[GiamGia] [tinyint] NOT NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaHh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [uniqueidentifier] NOT NULL,
	[NgayDat] [datetime2](7) NOT NULL,
	[NgayGiao] [datetime2](7) NULL,
	[TinhTrangDonHang] [int] NOT NULL,
	[NguoiNhan] [nvarchar](max) NULL,
	[DiaChiGiaoHang] [nvarchar](max) NULL,
	[SoDienThoai] [nvarchar](max) NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangHoa]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangHoa](
	[MaHh] [uniqueidentifier] NOT NULL,
	[TenHh] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[DonGia] [float] NOT NULL,
	[GiamGia] [tinyint] NOT NULL,
	[MaLoai] [int] NULL,
 CONSTRAINT [PK_HangHoa] PRIMARY KEY CLUSTERED 
(
	[MaHh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Loai] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Hoten] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 4/24/2024 5:33:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[Id] [uniqueidentifier] NOT NULL,
	[Token] [nvarchar](max) NOT NULL,
	[jwtId] [nvarchar](max) NOT NULL,
	[UserId] [int] NOT NULL,
	[IsUsed] [bit] NOT NULL,
	[IssuedAt] [datetime2](7) NOT NULL,
	[ExpiredAt] [datetime2](7) NOT NULL,
	[IsRevoked] [bit] NOT NULL,
 CONSTRAINT [PK_RefreshToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231011120524_DbInit', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231011143240_AddTbLoai', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231012115419_AddDonHangAndChiTietDH', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231021093159_AddUser', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231024182545_Add-RefreshToken', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231024182904_Delete-Role', N'5.0.17')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231024184118_Edit-RefreshToken', N'5.0.17')
GO
INSERT [dbo].[HangHoa] ([MaHh], [TenHh], [MoTa], [DonGia], [GiamGia], [MaLoai]) VALUES (N'54593a1b-1dd1-4c77-9090-a749eef23080', N'Chuột máy tính', N'chuột không dây tốc độ cao', 450000, 25, 4)
INSERT [dbo].[HangHoa] ([MaHh], [TenHh], [MoTa], [DonGia], [GiamGia], [MaLoai]) VALUES (N'54593a1b-1dd1-4c77-9090-a749eef23081', N'SamSung Ultral S22', N'Điện thoại gập tốt nhất thế giới', 450000, 25, 5)
INSERT [dbo].[HangHoa] ([MaHh], [TenHh], [MoTa], [DonGia], [GiamGia], [MaLoai]) VALUES (N'54593a1b-1dd1-4c77-9090-a749eef23082', N'Bóng adidas', N'bóng chất lượng cao dùng trong thi đấu chuyên nghiệp', 120000, 5, 4)
INSERT [dbo].[HangHoa] ([MaHh], [TenHh], [MoTa], [DonGia], [GiamGia], [MaLoai]) VALUES (N'54593a1b-1dd1-4c77-9090-a749eef23083', N'máy in và scand doc', N'máy tiết kiệm mực in', 26000000, 15, 4)
GO
SET IDENTITY_INSERT [dbo].[Loai] ON 

INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (4, N'Văn phòng phẩm')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (5, N'điện thoại')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (6, N'Laptop')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (7, N'xe oto')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (8, N'Thực phẩm chức năng')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (9, N'côc nước')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (10, N'quần áo')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (18, N'máy bay')
SET IDENTITY_INSERT [dbo].[Loai] OFF
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([Id], [UserName], [Password], [Hoten], [Email]) VALUES (1, N'admin', N'admin', N'Đặng Minh Tiến', N'tienadmin@gmail.com')
INSERT [dbo].[NguoiDung] ([Id], [UserName], [Password], [Hoten], [Email]) VALUES (2, N'vip', N'vip', N'Đặng Minh Tiến', N'tienvip@gmail.com')
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'ac2c4487-2a49-41bb-811d-0eb2bbf051f6', N'i3O50vIpna8ivf13iTHIK1l5rQVocWEMMYB6cKzs4QI=', N'49aedbe0-65df-456e-acfe-0b9fd3b6800c', 1, 1, CAST(N'2023-10-25T16:24:40.5070702' AS DateTime2), CAST(N'2023-10-25T17:24:40.5072071' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'b39ad4c7-c5ca-47a5-b2f9-14fca606dd2f', N'RfAROkqW8NaVt1x4qBmMjgSRIpYdufgxRHwE0SPEkuI=', N'abfb1b1c-ee87-4db2-8e74-82d67e34d6d8', 1, 0, CAST(N'2023-10-25T16:01:30.0042262' AS DateTime2), CAST(N'2023-10-25T17:01:30.0042696' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'9e2dfcf9-5602-472e-94ef-17d9fc899180', N'DFVenN+Uy5MHag04jsUjhn17FGSF1FA2Mfs8+Qqcl2M=', N'f6640450-6e5b-4269-8513-9bdbc07e046e', 2, 0, CAST(N'2023-10-25T16:41:06.8085222' AS DateTime2), CAST(N'2023-10-25T17:41:06.8085228' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'7db95234-d649-47c4-8fc5-2e8f4e1a49ef', N'rr99kLvPKh4QwtV6QXC2HQ25+NQnlafOqxrT95eg6rc=', N'88959d7a-defa-4693-be04-3dbe72db8622', 1, 1, CAST(N'2023-10-25T16:46:54.0822964' AS DateTime2), CAST(N'2023-10-25T17:46:54.0822966' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'6685dc31-afaa-4460-a4a5-3629c6a45a07', N'PZTiKXJahwODkFKsPbarMxfplKQuNTXN5R+ds0JPMz4=', N'f218eb6b-596a-4f61-a808-23e52b330fbe', 2, 1, CAST(N'2023-10-25T16:40:35.1673563' AS DateTime2), CAST(N'2023-10-25T17:40:35.1674991' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'ef256f3c-b19c-40ce-8072-43ca5ae4b0b5', N'VE95x+i2XnI6Ki36/6pUxr4up7sHI3J2rltzBAK6AqQ=', N'f4d58917-35d8-452b-b3fe-255f3c0b8072', 1, 0, CAST(N'2023-10-25T16:10:07.7875588' AS DateTime2), CAST(N'2023-10-25T16:11:07.7875592' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'8bc63079-b448-41d6-91dd-49977c67e120', N'y95qXMqCU0C9nNiCDfD+A8MlJTr5/k5y19ljRkhqlD0=', N'2d2b2f1f-52d5-45b3-a420-210d30f78c69', 1, 0, CAST(N'2023-10-25T16:05:59.4553724' AS DateTime2), CAST(N'2023-10-25T16:06:59.4554696' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'26aa286a-d9aa-420e-84ec-56c091f148be', N'OjYKInOYaME2AvbKOAezisMoOHfqvTRm7o5TM8lq4Mc=', N'3c6f13b1-15f9-4592-890a-83f6a31dde57', 2, 0, CAST(N'2023-10-25T16:40:55.9359774' AS DateTime2), CAST(N'2023-10-25T17:40:55.9359779' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'0c181904-72c8-4fe0-acdd-5bafad97ee12', N'7cjaLfSsCbBzaSEr5YqxSHL5R4hlPKcxQdrPezsrCcU=', N'cfeed3d1-0024-4dd2-b2ec-d4e8ac0af599', 2, 0, CAST(N'2023-10-25T16:41:03.3467844' AS DateTime2), CAST(N'2023-10-25T17:41:03.3467849' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'3989c4fe-8209-4092-b04f-5eddd35f44ef', N'NSldKfXsSG5IVUhlz5sddr853fAqqLh+lxe5vRgG7Nk=', N'07b712f1-8668-4242-8940-1123326cc9d8', 1, 1, CAST(N'2023-10-25T16:41:52.2388305' AS DateTime2), CAST(N'2023-10-25T17:41:52.2388306' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'f074446d-4829-4cae-ab6e-5f96726e301e', N'yduUdpT/Pi7ZPS4KoRnK8L4UNqZti0hLBd2qptQUHO0=', N'8731ec27-c8b6-4640-bea6-d86f741a956c', 2, 0, CAST(N'2023-10-25T16:37:45.5142606' AS DateTime2), CAST(N'2023-10-25T17:37:45.5142615' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'66aab48b-a490-4103-b7fb-6e73e1a1d1e9', N'gf+fmMngFxZVnqZ67rirIvsYii93h3wgKOcDtxtYLjA=', N'48f56fd8-3b1b-484d-86f9-36d2810743a6', 1, 0, CAST(N'2023-10-25T16:44:49.0724947' AS DateTime2), CAST(N'2023-10-25T17:44:49.0724954' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'9874e900-bd7d-413a-baca-6efe3febde3a', N'kAEunLhzrApLwaQM9gldusafGIdRvDTdWLutEGv3Dtg=', N'a67a5b94-c2df-4861-b014-3364dc83499d', 1, 1, CAST(N'2023-10-25T16:48:24.5833854' AS DateTime2), CAST(N'2023-10-25T17:48:24.5833857' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'77472c7a-0b55-48a0-91be-70690dee45a9', N'0j/FICF9CaWy6tp8YwKooaN71AM8oRd1y7esuzBwVqY=', N'3f680693-61c5-4a5c-9ccb-723829c5fe0c', 2, 0, CAST(N'2023-10-25T16:40:59.9461210' AS DateTime2), CAST(N'2023-10-25T17:40:59.9461216' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'c3146723-6111-4dfd-ae30-8537ab45bf73', N'tFT7iwlxD0HLuQqjCqlDx9mrKG7z5CJg278PzaLXMhI=', N'cfcc7412-1b60-4208-88ab-9e0301d7b3f8', 1, 1, CAST(N'2023-10-25T16:33:03.3738083' AS DateTime2), CAST(N'2023-10-25T17:33:03.3739061' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'0d906279-149f-47a8-a8a9-88426a667bf4', N'HxoT4hS9D+548wyrJJpYGNMVD4Yg1MeMAxmIHH3idNU=', N'10e3ec10-9aae-40ff-92fc-5480c0f9e092', 1, 1, CAST(N'2023-10-25T16:47:30.4858490' AS DateTime2), CAST(N'2023-10-25T17:47:30.4858496' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'e05a40f1-57f4-47a0-b7f3-a5451d1b6fd1', N'malhbD+f6ZxUlyZ2xpkZXScXRDjF3H1/Uv2AYO11BNc=', N'dd9d4af7-ce2f-4de1-9536-216bfb718d80', 1, 0, CAST(N'2023-10-25T16:16:36.7826400' AS DateTime2), CAST(N'2023-10-25T16:17:36.7827415' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'50fce276-487c-48c6-8cf3-c2778cf08820', N'LuuyBdDTMXTFBMVwwJluWxsuG8Ruc3bCSf1NGdkdA68=', N'ab4328e9-ab53-478c-bfce-9c42e1104711', 2, 1, CAST(N'2023-10-25T16:37:36.7573642' AS DateTime2), CAST(N'2023-10-25T17:37:36.7574619' AS DateTime2), 1)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'b551a749-914a-4cc7-b938-d79b2729959d', N'PkS8x7UIDnRpIgmZCbQZ/7nBSMeXh117Q08LKPAyQKc=', N'310acae3-5499-4c07-a0a4-5ead169f422e', 2, 0, CAST(N'2023-10-25T16:40:51.6237128' AS DateTime2), CAST(N'2023-10-25T17:40:51.6237135' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'09087007-e52a-4a98-9490-d7eaee544870', N'BL6Vx5QDrxQDi1ISLLUO/A9UGPZCkfCsAurcjvVGU3Q=', N'd3f94740-72b6-4013-9cdf-b89827406e0e', 1, 0, CAST(N'2023-10-25T16:50:01.5210474' AS DateTime2), CAST(N'2023-10-25T17:50:01.5210479' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'd758e544-c7e6-4e8e-9724-df10dd6d16a3', N'S8HRjBv1HTLyD5FVFt9FKpQdZ7rLilQvpa5zwxnpCOU=', N'0faf0f30-9084-4b85-ba9f-b252868a8463', 1, 0, CAST(N'2023-10-25T16:24:53.4376980' AS DateTime2), CAST(N'2023-10-25T17:24:53.4376986' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'148dce8d-5381-479e-acaa-ebef9306749a', N'CcOVGCP0eMLzg1xuhnlFOmOT1bnrubvqGhmi7eWeEvk=', N'a45a99e9-b5b2-4f31-8197-476123962691', 1, 0, CAST(N'2023-10-25T16:12:09.5698863' AS DateTime2), CAST(N'2023-10-25T16:13:09.5699871' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'cb2a5ac0-f23a-496e-b38e-ee2d832ca54a', N'JgmEB/i7sASdFBIcf+jov5GTpDPI7gzmepJ0i0hz44k=', N'fe1ef8cc-d773-46ff-bf30-cb8c0bd0de25', 1, 0, CAST(N'2023-10-25T16:27:59.9130681' AS DateTime2), CAST(N'2023-10-25T17:27:59.9131658' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'0117fb0e-cd21-4b59-bd81-f4bb9ce32b8c', N'0Xuby+4LrM4Xe+jvvQM0F5ivfNtHcoUCZJw1GyJ/OX8=', N'f862f8c9-efa3-4b3d-a7b6-1d50b9660dda', 1, 0, CAST(N'2023-10-25T16:30:50.0301198' AS DateTime2), CAST(N'2023-10-25T17:30:50.0302479' AS DateTime2), 0)
INSERT [dbo].[RefreshToken] ([Id], [Token], [jwtId], [UserId], [IsUsed], [IssuedAt], [ExpiredAt], [IsRevoked]) VALUES (N'3e20d164-24d3-4c16-8056-f8b3377b93b3', N'iWs8qOKZpc3U2IXT6SVBFIAlg1Qsq/R/jSMaU3/YyOM=', N'9a29f64d-c759-40d5-a4e2-3495e69545a3', 1, 0, CAST(N'2023-10-25T16:33:13.2924193' AS DateTime2), CAST(N'2023-10-25T17:33:13.2924198' AS DateTime2), 0)
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getutcdate()) FOR [NgayDat]
GO
ALTER TABLE [dbo].[RefreshToken] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsRevoked]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CtDonHang_DonHang] FOREIGN KEY([MaDH])
REFERENCES [dbo].[DonHang] ([MaDH])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CtDonHang_DonHang]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CtDonHang_HangHoa] FOREIGN KEY([MaHh])
REFERENCES [dbo].[HangHoa] ([MaHh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CtDonHang_HangHoa]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [FK_HangHoa_Loai_MaLoai] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[Loai] ([MaLoai])
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [FK_HangHoa_Loai_MaLoai]
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD  CONSTRAINT [FK_RefreshToken_NguoiDung_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[NguoiDung] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RefreshToken] CHECK CONSTRAINT [FK_RefreshToken_NguoiDung_UserId]
GO
