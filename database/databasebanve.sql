USE [WebDatVe]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChuyenBay](
	[MaChuyenBay] [bigint] IDENTITY(1,1) NOT NULL,
	[DiemDi] [bigint] NULL,
	[DiemDen] [bigint] NULL,
	[ThoiGianDi] [datetime] NULL,
	[ThoiGianDen] [datetime] NULL,
	[MaMayBay] [varchar](10) NULL,
	[Gia] [float] NULL,
 CONSTRAINT [PK_CB] PRIMARY KEY CLUSTERED 
(
	[MaChuyenBay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangBay](
	[MaHangBay] [bigint] IDENTITY(1,1) NOT NULL,
	[TenHangBay] [nvarchar](50) NULL,
	[Logo] [text] NULL,
 CONSTRAINT [PK_HangBay] PRIMARY KEY CLUSTERED 
(
	[MaHangBay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [bigint] IDENTITY(1,1) NOT NULL,
	[Ho] [nvarchar](50) NULL,
	[Ten] [nvarchar](50) NULL,
	[SDT] [varchar](10) NULL,
	[NgaySinh] [date] NULL,
	[CMND] [varchar](50) NULL,
	[QuocTich] [nvarchar](50) NULL,
	[MaVe] [varchar](50) NULL,
	[LoaiKhachHang] [nvarchar](50) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MayBay](
	[MaMayBay] [varchar](10) NOT NULL,
	[SoGhePhoThong] [int] NULL,
	[SoGheThuongGia] [int] NULL,
	[SoGhePhoThongDacBiet] [int] NULL,
	[SoGheHangNhat] [int] NULL,
	[MahangBay] [bigint] NULL,
	[HanhLiXachTay] [int] NULL,
	[HanhLiKiGui] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[MaMayBay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDatVe](
	[MaNguoiDat] [bigint] IDENTITY(1,1) NOT NULL,
	[Ho] [nvarchar](50) NULL,
	[Ten] [nvarchar](50) NULL,
	[SDT] [char](10) NULL,
	[Email] [nvarchar](50) NULL,
	[MaVe] [varchar](50) NULL,
 CONSTRAINT [PK_NguoiDatVe] PRIMARY KEY CLUSTERED 
(
	[MaNguoiDat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanBay](
	[MaSanBay] [bigint] IDENTITY(1,1) NOT NULL,
	[TenSanBay] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](max) NULL,
 CONSTRAINT [PK_SanBay] PRIMARY KEY CLUSTERED 
(
	[MaSanBay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](200) NULL,
	[MatKhau] [varchar](50) NULL,
	[HoTen] [nvarchar](50) NULL,
	[SDT] [varchar](10) NULL,
	[Quyen] [nchar](10) NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ve](
	[MaVe] [varchar](50) NOT NULL,
	[MaChuyenBay] [bigint] NULL,
	[HangVe] [nvarchar](50) NULL,
	[SoLuongGhe] [int] NULL,
	[MaTaiKhoan] [bigint] NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[NgayDat] [datetime] NULL,
	[TongTien] [float] NULL,
	[NgayHuyVe] [datetime] NULL,
 CONSTRAINT [PK_Ve] PRIMARY KEY CLUSTERED 
(
	[MaVe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VeDaLuu](
	[MaVeDaLuu] [bigint] IDENTITY(1,1) NOT NULL,
	[MaChuyenBay] [bigint] NULL,
	[MaTaiKhoan] [bigint] NULL,
 CONSTRAINT [PK_VeDaLuu] PRIMARY KEY CLUSTERED 
(
	[MaVeDaLuu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChuyenBay] ON 

INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (1, 1, 2, CAST(N'2021-12-18T07:30:00.000' AS DateTime), CAST(N'2021-12-18T09:30:00.000' AS DateTime), N'VJ-521', 420000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (2, 1, 2, CAST(N'2021-12-18T10:00:00.000' AS DateTime), CAST(N'2021-12-18T13:00:00.000' AS DateTime), N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (3, 1, 2, CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-05-30T00:00:00.000' AS DateTime), N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (4, 1, 2, CAST(N'2022-05-30T00:00:00.000' AS DateTime), CAST(N'2022-06-03T00:00:00.000' AS DateTime), N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (5, 1, 2, CAST(N'2022-06-14T23:00:00.000' AS DateTime), CAST(N'2022-06-15T02:00:00.000' AS DateTime), N'BB-123', 42000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (6, 1, 2, CAST(N'2022-05-30T03:00:00.000' AS DateTime), CAST(N'2022-05-30T05:00:00.000' AS DateTime), N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (7, 1, 2, CAST(N'2022-06-01T23:00:00.000' AS DateTime), NULL, N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (8, 1, 2, CAST(N'2022-06-01T23:00:00.000' AS DateTime), CAST(N'2022-06-30T23:00:00.000' AS DateTime), N'BB-123', 430000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (9, 1, 2, CAST(N'2022-08-19T23:00:00.000' AS DateTime), CAST(N'2022-06-30T23:00:00.000' AS DateTime), N'BB-123', 420000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (10, 1, 2, CAST(N'2022-06-09T23:00:00.000' AS DateTime), CAST(N'2022-06-10T02:00:00.000' AS DateTime), N'VJ-521', 10000)
INSERT [dbo].[ChuyenBay] ([MaChuyenBay], [DiemDi], [DiemDen], [ThoiGianDi], [ThoiGianDen], [MaMayBay], [Gia]) VALUES (11, 2, 1, CAST(N'2022-06-30T23:00:00.000' AS DateTime), CAST(N'2022-06-30T23:30:00.000' AS DateTime), N'BB-123', 43000)
SET IDENTITY_INSERT [dbo].[ChuyenBay] OFF
GO
SET IDENTITY_INSERT [dbo].[HangBay] ON 

INSERT [dbo].[HangBay] ([MaHangBay], [TenHangBay], [Logo]) VALUES (1, N'VietJet Air', N'Images/Logo-Vietjet.png')
INSERT [dbo].[HangBay] ([MaHangBay], [TenHangBay], [Logo]) VALUES (2, N'Bamboo', N'Images/Logo-Bamboo.png')
SET IDENTITY_INSERT [dbo].[HangBay] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (73, N'', N'', N'', NULL, N'', N'', N'506/13/2022 11:08:21', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (74, N'', N'', N'', NULL, N'', N'', N'506/13/2022 11:12:35', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (75, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:11:27', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (76, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:29', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (77, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:32', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (78, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:34', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (79, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:34', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (80, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:38', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (81, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:13:38', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (82, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:16:04', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (83, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:16:46', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (84, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:16:48', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (85, N'', N'', N'', NULL, N'', N'', N'506/13/2022 14:16:48', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (86, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:48:16', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (87, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:52:13', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (88, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:56:17', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (89, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:57:06', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (90, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:57:07', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (91, N'', N'', N'', NULL, N'', N'', N'306/13/2022 14:57:07', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (92, N'', N'', N'', NULL, N'', N'', N'306/13/2022 15:03:42', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (93, N'', N'', N'', NULL, N'', N'', N'306/13/2022 15:07:22', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (94, N'', N'', N'', NULL, N'', N'', N'306/14/2022 10:24:38', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (95, N'', N'', N'', NULL, N'', N'', N'306/14/2022 10:24:42', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (96, N'', N'', N'', NULL, N'', N'', N'306/14/2022 10:24:42', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (97, N'', N'', N'', NULL, N'', N'', N'306/14/2022 10:28:24', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (98, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:34:24', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (99, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:47:41', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (100, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:47:44', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (101, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:51:12', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (102, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:53:22', N'Người lớn')
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ho], [Ten], [SDT], [NgaySinh], [CMND], [QuocTich], [MaVe], [LoaiKhachHang]) VALUES (103, N'', N'', N'', NULL, N'', N'', N'506/14/2022 10:53:25', N'Người lớn')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
INSERT [dbo].[MayBay] ([MaMayBay], [SoGhePhoThong], [SoGheThuongGia], [SoGhePhoThongDacBiet], [SoGheHangNhat], [MahangBay], [HanhLiXachTay], [HanhLiKiGui]) VALUES (N'aaaaaa', 1, 1, 1, 1, 1, 100, 100)
INSERT [dbo].[MayBay] ([MaMayBay], [SoGhePhoThong], [SoGheThuongGia], [SoGhePhoThongDacBiet], [SoGheHangNhat], [MahangBay], [HanhLiXachTay], [HanhLiKiGui]) VALUES (N'as', 12, 12, 12, 12, 2, 240, 864)
INSERT [dbo].[MayBay] ([MaMayBay], [SoGhePhoThong], [SoGheThuongGia], [SoGhePhoThongDacBiet], [SoGheHangNhat], [MahangBay], [HanhLiXachTay], [HanhLiKiGui]) VALUES (N'BB-123', 60, 40, 20, 10, 2, 100, 1000)
INSERT [dbo].[MayBay] ([MaMayBay], [SoGhePhoThong], [SoGheThuongGia], [SoGhePhoThongDacBiet], [SoGheHangNhat], [MahangBay], [HanhLiXachTay], [HanhLiKiGui]) VALUES (N'VJ-521', 60, 40, 20, 10, 1, 100, 1000)
GO
SET IDENTITY_INSERT [dbo].[NguoiDatVe] ON 

INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (72, N'', N'', N'          ', N'ngotunghien@gmail.com', N'506/13/2022 11:08:21')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (73, N'', N'', N'          ', N'', N'506/13/2022 11:12:35')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (74, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/13/2022 14:11:27')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (75, N'', N'', N'          ', N'ngotunghien@gmail.com', N'506/13/2022 14:13:29')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (76, N'', N'', N'          ', N'ngotunghien@gmail.com', N'506/13/2022 14:13:32')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (77, N'', N'', N'          ', N'ngotunghien@gmail.com', N'506/13/2022 14:13:34')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (78, N'', N'', N'          ', N'ngotunghien@gmail.com', N'506/13/2022 14:13:38')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (79, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/13/2022 14:16:04')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (80, N'', N'', N'          ', N'', N'506/13/2022 14:16:46')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (81, N'', N'', N'          ', N'', N'506/13/2022 14:16:48')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (82, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 14:48:16')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (83, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 14:52:13')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (84, N'', N'', N'          ', N'admin1@admin.com', N'306/13/2022 14:56:17')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (85, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 14:57:06')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (86, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 14:57:07')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (87, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 15:03:42')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (88, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/13/2022 15:07:22')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (89, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/14/2022 10:24:38')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (90, N'', N'', N'          ', N'ngotunghien@gmail.com', N'306/14/2022 10:24:42')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (91, N'', N'', N'          ', N'ducviet072001@gmail.com', N'306/14/2022 10:28:24')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (92, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:34:24')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (93, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:47:41')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (94, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:47:44')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (95, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:51:12')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (96, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:53:22')
INSERT [dbo].[NguoiDatVe] ([MaNguoiDat], [Ho], [Ten], [SDT], [Email], [MaVe]) VALUES (97, N'', N'', N'          ', N'ducviet072001@gmail.com', N'506/14/2022 10:53:25')
SET IDENTITY_INSERT [dbo].[NguoiDatVe] OFF
GO
SET IDENTITY_INSERT [dbo].[SanBay] ON 

INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (1, N'Nội Bài', N'Hà Nội')
INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (2, N'Tân Sơn Nhất', N'TP HCM')
INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (3, N'Cát Bi', N'Hải Phòng')
INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (4, N'Điện Biên Phủ', N'Điện Biên')
INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (5, N'Thọ Xuân', N'Thanh Hóa')
INSERT [dbo].[SanBay] ([MaSanBay], [TenSanBay], [DiaChi]) VALUES (6, N'Vinh', N'Nghệ An')
SET IDENTITY_INSERT [dbo].[SanBay] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [HoTen], [SDT], [Quyen]) VALUES (1, N'anhvu62882690@gmail.com', N'123', N'Trịnh Anh Vũ ', N'0123456789', N'0         ')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [HoTen], [SDT], [Quyen]) VALUES (3, N'ducviet072001@gmail.com', N'1234', N'Lê Đức Việt ', NULL, N'0         ')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [HoTen], [SDT], [Quyen]) VALUES (5, N'ngotunghien@gmail.com', N'12345', N'Ngô Tùng Hiền', NULL, N'0         ')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [HoTen], [SDT], [Quyen]) VALUES (6, N'websitebanve@gmail.com', N'123', N'Flight Admin', NULL, NULL)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 14:48:16', 5, N'Phổ thông', 1, 3, N'Canceled', CAST(N'2022-06-13T14:48:16.887' AS DateTime), 69300, CAST(N'2022-06-13T15:05:15.820' AS DateTime))
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 14:52:13', 5, N'Phổ thông', 1, 3, N'Canceled', CAST(N'2022-06-13T14:52:13.440' AS DateTime), 69300, CAST(N'2022-06-13T15:05:22.677' AS DateTime))
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 14:56:17', 5, N'Phổ thông', 1, 3, N'Paid', CAST(N'2022-06-13T14:56:17.733' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 14:57:06', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-13T14:57:06.540' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 14:57:07', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-13T14:57:07.043' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 15:03:42', 5, N'Phổ thông', 1, 3, N'Paid', CAST(N'2022-06-13T15:03:42.680' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/13/2022 15:07:22', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-13T15:07:22.383' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/14/2022 10:24:38', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-14T10:24:38.943' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/14/2022 10:24:42', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-14T10:24:42.647' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'306/14/2022 10:28:24', 5, N'Phổ thông', 1, 3, N'Processing', CAST(N'2022-06-14T10:28:24.920' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 11:08:21', 5, N'Phổ thông', 1, 5, N'Canceled', CAST(N'2022-06-13T11:08:21.743' AS DateTime), 69300, CAST(N'2022-06-13T11:09:23.680' AS DateTime))
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 11:12:35', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T11:12:35.573' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:11:27', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:11:27.657' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:13:29', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:13:29.250' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:13:32', 11, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:13:32.843' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:13:34', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:13:34.853' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:13:38', 11, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:13:38.003' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:16:04', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:16:04.667' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:16:46', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:16:46.590' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/13/2022 14:16:48', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-13T14:16:48.997' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:34:24', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-14T10:34:24.847' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:47:41', 5, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-14T10:47:41.830' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:47:44', 11, N'Phổ thông', 1, 5, N'Processing', CAST(N'2022-06-14T10:47:44.453' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:51:12', 5, N'Phổ thông', 1, 5, N'Paid', CAST(N'2022-06-14T10:51:12.967' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:53:22', 5, N'Phổ thông', 1, 5, N'Paid', CAST(N'2022-06-14T10:53:22.113' AS DateTime), 69300, NULL)
INSERT [dbo].[Ve] ([MaVe], [MaChuyenBay], [HangVe], [SoLuongGhe], [MaTaiKhoan], [TinhTrang], [NgayDat], [TongTien], [NgayHuyVe]) VALUES (N'506/14/2022 10:53:25', 11, N'Phổ thông', 1, 5, N'Paid', CAST(N'2022-06-14T10:53:25.320' AS DateTime), 69300, NULL)
GO
SET IDENTITY_INSERT [dbo].[VeDaLuu] ON 

INSERT [dbo].[VeDaLuu] ([MaVeDaLuu], [MaChuyenBay], [MaTaiKhoan]) VALUES (1, 7, 2)
SET IDENTITY_INSERT [dbo].[VeDaLuu] OFF
GO
ALTER TABLE [dbo].[ChuyenBay]  WITH CHECK ADD  CONSTRAINT [FK_ChuyenBay_MayBay] FOREIGN KEY([MaMayBay])
REFERENCES [dbo].[MayBay] ([MaMayBay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChuyenBay] CHECK CONSTRAINT [FK_ChuyenBay_MayBay]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_Ve] FOREIGN KEY([MaVe])
REFERENCES [dbo].[Ve] ([MaVe])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHang_Ve]
GO
ALTER TABLE [dbo].[MayBay]  WITH CHECK ADD  CONSTRAINT [FK_MayBay_HangBay] FOREIGN KEY([MahangBay])
REFERENCES [dbo].[HangBay] ([MaHangBay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MayBay] CHECK CONSTRAINT [FK_MayBay_HangBay]
GO
ALTER TABLE [dbo].[NguoiDatVe]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDatVe_Ve] FOREIGN KEY([MaVe])
REFERENCES [dbo].[Ve] ([MaVe])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NguoiDatVe] CHECK CONSTRAINT [FK_NguoiDatVe_Ve]
GO
ALTER TABLE [dbo].[Ve]  WITH CHECK ADD  CONSTRAINT [FK_Ve_ChuyenBay1] FOREIGN KEY([MaChuyenBay])
REFERENCES [dbo].[ChuyenBay] ([MaChuyenBay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ve] CHECK CONSTRAINT [FK_Ve_ChuyenBay1]
GO
ALTER TABLE [dbo].[VeDaLuu]  WITH CHECK ADD  CONSTRAINT [FK_VeDaLuu_ChuyenBay] FOREIGN KEY([MaChuyenBay])
REFERENCES [dbo].[ChuyenBay] ([MaChuyenBay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VeDaLuu] CHECK CONSTRAINT [FK_VeDaLuu_ChuyenBay]
GO
