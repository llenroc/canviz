USE [PropertyInsurance]
GO
/****** Object:  Table [dbo].[Builders]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Builders](
	[BuilderId] [int] NOT NULL,
	[BuildersCompanyName] [varchar](50) NULL,
	[Risk] [varchar](10) NULL,
	[WebSite] [varchar](100) NULL,
	[Properties] [int] NOT NULL,
	[PercentProperties] [varchar](100) NULL,
	[Address] [varchar](100) NULL,
	[Contact] [varchar](20) NULL,
	[Phone] [varchar](20) NULL,
 CONSTRAINT [PK_dbo.Builders] PRIMARY KEY CLUSTERED 
(
	[BuilderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Claims]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Claims](
	[ClaimId] [int] NOT NULL,
	[PolicyHolderId] [int] NULL,
	[ClaimStatus] [varchar](10) NULL,
	[ClaimOpenDate] [datetime] NULL,
	[ClaimCloseDate] [datetime] NULL,
	[ClaimTypeId] [int] NULL,
	[ClaimMonth] [varchar](10) NULL,
	[ClaimYear] [int] NULL,
	[ClaimMonthYear] [varchar](10) NULL,
	[DaysToClose] [int] NULL,
	[ClaimConfidence] [varchar](10) NULL,
	[ClaimValue] [int] NULL,
	[ClaimDescription] [varchar](100) NULL,
	[ClaimPhotos] [varchar](100) NULL,
 CONSTRAINT [PK_dbo.Claims] PRIMARY KEY CLUSTERED 
(
	[ClaimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClaimTypes]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClaimTypes](
	[ClaimTypeId] [int] NOT NULL,
	[ClaimTypeName] [varchar](30) NULL,
 CONSTRAINT [PK_dbo.ClaimTypes] PRIMARY KEY CLUSTERED 
(
	[ClaimTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[PolicyHolderId] [int] NOT NULL,
	[PolicyHolderName] [varchar](50) NULL,
	[PolicyHolderUserName] [varchar](50) NULL,
	[Address] [varchar](100) NULL,
	[EmailAddress] [varchar](50) NULL,
	[DistrictId] [int] NULL,
	[BuilderId] [int] NULL,
	[AdjusterId] [int] NULL,
	[ManagerId] [int] NULL,
 CONSTRAINT [PK_dbo.Customers] PRIMARY KEY CLUSTERED 
(
	[PolicyHolderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Districts]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Districts](
	[DistrictId] [int] NOT NULL,
	[DistrictName] [varchar](50) NULL,
 CONSTRAINT [PK_dbo.Districts] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/17/2017 3:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] NOT NULL,
	[FullName] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Role] [varchar](20) NULL,
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE PROC GetHighRiskBuildings     
AS   
	SELECT 
		B.[BuildersCompanyName] AS Builder,
		C.[Address] AS PropertyAddress,
		C.[PolicyHolderName] AS PolicyHolder,
		A.[FullName] AS Adjuster,
		A.[Username] AS AdjusterEmail,
		M.[FullName] AS Manager,
		M.[Username] AS ManagerEmail
	FROM [dbo].[Builders] B
		INNER JOIN [dbo].[Customers] C ON B.[BuilderId] = C.[BuilderId] AND B.[Risk] = 'High'
		INNER JOIN [dbo].[Employees] A ON C.[AdjusterId] = A.[Id]
		INNER JOIN [dbo].[Employees] M ON C.[ManagerId] = M.[Id]
	ORDER BY B.[BuildersCompanyName]

GO
CREATE PROCEDURE [dbo].[ListApprovedContractors]
@PolicyHolderId nvarchar(max)
AS
BEGIN
              SET NOCOUNT ON;
              SELECT * FROM Customers
RETURN 0
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Builders] ([BuilderId], [BuildersCompanyName], [Risk], [WebSite], [Properties], [PercentProperties], [Address], [Contact], [Phone]) VALUES (1111, N'Adatum Corporation', N'High', N'http://www.adatum.com/', 4, N'5%', N'700 120th St, Orofino, ID 83544', N'Rob Barker', N'(555)111-2222')
INSERT [dbo].[Builders] ([BuilderId], [BuildersCompanyName], [Risk], [WebSite], [Properties], [PercentProperties], [Address], [Contact], [Phone]) VALUES (1116, N'VanArsdel, Ltd.', N'Low', N'http://www.vanarsdelltd.com', 19, N'25%', N'900 Antler Loop, Orofino, ID 83544', N'Margaret Au', N'(555)555-6666')
INSERT [dbo].[Builders] ([BuilderId], [BuildersCompanyName], [Risk], [WebSite], [Properties], [PercentProperties], [Address], [Contact], [Phone]) VALUES (1120, N'Fabrikam, Inc.', N'Low', N'http://www.fabrikam.com/', 43, N'56%', N'1100 84th Ave, Orofino, ID 83544', N'Ron Gabel', N'(555)222-3333')
INSERT [dbo].[Builders] ([BuilderId], [BuildersCompanyName], [Risk], [WebSite], [Properties], [PercentProperties], [Address], [Contact], [Phone]) VALUES (1132, N'Fabrikam Residences', N'High', N'http://fabrikamresidences.com', 11, N'14%', N'1200 Riveroaks Dr, Orofino, ID 83544', N'Katie Jordan', N'(555)333-4444')
INSERT [dbo].[Builders] ([BuilderId], [BuildersCompanyName], [Risk], [WebSite], [Properties], [PercentProperties], [Address], [Contact], [Phone]) VALUES (1133, N'Proseware, Inc.', N'Low', N'http://www.proseware.com/', 0, N'0%', N'1500 Kestrel Ct, Orofino, ID 83544', N'Chris Johnson', N'(555)444-5555')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15725, 1340001281, N'Approved', CAST(N'2016-02-01 00:00:00.000' AS DateTime), CAST(N'2016-02-23 00:00:00.000' AS DateTime), 2, N'Feb', 2016, N'Feb 2016', 22, N'0.95', 5000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15726, 1340001312, N'Approved', CAST(N'2016-11-01 00:00:00.000' AS DateTime), CAST(N'2017-01-01 00:00:00.000' AS DateTime), 3, N'Nov', 2016, N'Nov 2016', 61, N'0.95', 1000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15727, 1340001314, N'Approved', CAST(N'2016-10-01 00:00:00.000' AS DateTime), CAST(N'2016-02-18 00:00:00.000' AS DateTime), 3, N'Oct', 2016, N'Oct 2016', -226, N'0.95', 20000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15728, 1340001303, N'Pending', CAST(N'2016-12-01 00:00:00.000' AS DateTime), NULL, 2, N'Dec', 2016, N'Dec 2016', -42705, N'0.98', 2567, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15729, 1340001295, N'Declined', CAST(N'2016-07-11 00:00:00.000' AS DateTime), CAST(N'2016-09-12 00:00:00.000' AS DateTime), 1, N'Jul', 2016, N'Jul 2016', 63, N'0.2', 900, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15730, 1340001308, N'Submitted', CAST(N'2016-11-14 00:00:00.000' AS DateTime), NULL, 3, N'Nov', 2016, N'Nov 2016', -42688, N'0.6', 13000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15731, 1340001297, N'Approved', CAST(N'2016-08-19 00:00:00.000' AS DateTime), CAST(N'2016-10-25 00:00:00.000' AS DateTime), 1, N'Aug', 2016, N'Aug 2016', 67, N'0.4', 4687, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15732, 1340001280, N'Approved', CAST(N'2016-08-01 00:00:00.000' AS DateTime), CAST(N'2016-12-09 00:00:00.000' AS DateTime), 1, N'Aug', 2016, N'Aug 2016', 130, N'0.99', 8760, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15733, 1340001319, N'Submitted', CAST(N'2016-10-11 00:00:00.000' AS DateTime), NULL, 1, N'Oct', 2016, N'Oct 2016', -42654, N'0.8', 650, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15734, 1340001301, N'Pending', CAST(N'2016-12-01 00:00:00.000' AS DateTime), NULL, 3, N'Dec', 2016, N'Dec 2016', -42705, N'0.75', 25000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15735, 1340001311, N'Approved', CAST(N'2016-11-01 00:00:00.000' AS DateTime), CAST(N'2017-02-19 00:00:00.000' AS DateTime), 2, N'Nov', 2016, N'Nov 2016', 110, N'0.6', 9820, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15736, 1340001313, N'Declined', CAST(N'2016-11-01 00:00:00.000' AS DateTime), CAST(N'2016-12-12 00:00:00.000' AS DateTime), 2, N'Nov', 2016, N'Nov 2016', 41, N'0.9', 6540, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15737, 1340001306, N'Pending', CAST(N'2016-11-21 00:00:00.000' AS DateTime), NULL, 1, N'Nov', 2016, N'Nov 2016', -42695, N'0.9', 6280, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15738, 1340001306, N'Approved', CAST(N'2016-06-19 00:00:00.000' AS DateTime), CAST(N'2016-10-01 00:00:00.000' AS DateTime), 3, N'Jun', 2016, N'Jun 2016', 104, N'0.8', 7293, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15739, 1340001307, N'Approved', CAST(N'2016-11-16 00:00:00.000' AS DateTime), CAST(N'2017-01-23 00:00:00.000' AS DateTime), 2, N'Nov', 2016, N'Nov 2016', 68, N'0.75', 9078, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15740, 1340001285, N'Submitted', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 2, N'Jun', 2016, N'Jun 2016', -42540, N'0.3', 874, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15741, 1340001277, N'Approved', CAST(N'2016-09-21 00:00:00.000' AS DateTime), CAST(N'2016-12-03 00:00:00.000' AS DateTime), 7, N'Sep', 2016, N'Sep 2016', 73, N'0.2', 703, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15742, 1340001305, N'Pending', CAST(N'2016-11-23 00:00:00.000' AS DateTime), NULL, 2, N'Nov', 2016, N'Nov 2016', -42697, N'0.65', 9000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15743, 1340001314, N'Declined', CAST(N'2016-10-31 00:00:00.000' AS DateTime), CAST(N'2016-12-06 00:00:00.000' AS DateTime), 1, N'Oct', 2016, N'Oct 2016', 36, N'0.25', 8500, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15744, 1340001302, N'Approved', CAST(N'2016-12-01 00:00:00.000' AS DateTime), CAST(N'2017-02-11 00:00:00.000' AS DateTime), 2, N'Dec', 2016, N'Dec 2016', 72, N'0.5', 9963, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15745, 1340001310, N'Approved', CAST(N'2016-07-11 00:00:00.000' AS DateTime), CAST(N'2016-09-12 00:00:00.000' AS DateTime), 3, N'Jul', 2016, N'Jul 2016', 63, N'0.75', 5320, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15746, 1340001286, N'Submitted', CAST(N'2016-09-07 00:00:00.000' AS DateTime), NULL, 3, N'Sep', 2016, N'Sep 2016', -42620, N'0.9', 5342, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15747, 1340001286, N'Approved', CAST(N'2016-11-08 00:00:00.000' AS DateTime), CAST(N'2017-02-20 00:00:00.000' AS DateTime), 2, N'Nov', 2016, N'Nov 2016', 104, N'0.8', 7189, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15748, 1340001277, N'Submitted', CAST(N'2016-11-07 00:00:00.000' AS DateTime), NULL, 2, N'Nov', 2016, N'Nov 2016', -42681, N'0.98', 5120, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15749, 1340001312, N'Approved', CAST(N'2016-03-14 00:00:00.000' AS DateTime), CAST(N'2017-01-01 00:00:00.000' AS DateTime), 3, N'Mar', 2016, N'Mar 2016', 293, N'0.7', 6870, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15750, 1340001278, N'Declined', CAST(N'2016-02-03 00:00:00.000' AS DateTime), CAST(N'2016-02-28 00:00:00.000' AS DateTime), 3, N'Feb', 2016, N'Feb 2016', 25, N'0.25', 5290, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15751, 1340001293, N'Approved', CAST(N'2016-12-26 00:00:00.000' AS DateTime), CAST(N'2017-02-16 00:00:00.000' AS DateTime), 7, N'Dec', 2016, N'Dec 2016', 52, N'0.4', 4320, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15752, 1340001290, N'Pending', CAST(N'2016-01-24 00:00:00.000' AS DateTime), NULL, 2, N'Jan', 2016, N'Jan 2016', -42393, N'0.3', 8207, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15753, 1340001276, N'Pending', CAST(N'2016-12-27 00:00:00.000' AS DateTime), NULL, 2, N'Dec', 2016, N'Dec 2016', -42731, N'0.9', 4750, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15754, 1340001309, N'Pending', CAST(N'2016-11-13 00:00:00.000' AS DateTime), NULL, 1, N'Nov', 2016, N'Nov 2016', -42687, N'0.98', 1264, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15755, 1340001310, N'Approved', CAST(N'2016-08-29 00:00:00.000' AS DateTime), CAST(N'2016-10-07 00:00:00.000' AS DateTime), 2, N'Aug', 2016, N'Aug 2016', 39, N'0.9', 7493, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15756, 1340001284, N'Approved', CAST(N'2016-10-13 00:00:00.000' AS DateTime), CAST(N'2016-12-09 00:00:00.000' AS DateTime), 3, N'Oct', 2016, N'Oct 2016', 57, N'0.25', 759, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15757, 1340001317, N'Submitted', CAST(N'2016-10-18 00:00:00.000' AS DateTime), NULL, 2, N'Oct', 2016, N'Oct 2016', -42661, N'0.6', 4573, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15758, 1340001282, N'Pending', CAST(N'2016-01-23 00:00:00.000' AS DateTime), NULL, 2, N'Jan', 2016, N'Jan 2016', -42392, N'0.75', 3720, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15759, 1340001322, N'Pending', CAST(N'2016-09-25 00:00:00.000' AS DateTime), NULL, 5, N'Sep', 2016, N'Sep 2016', -42638, N'0.4', 7520, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15760, 1340001309, N'Approved', CAST(N'2016-06-19 00:00:00.000' AS DateTime), CAST(N'2016-10-01 00:00:00.000' AS DateTime), 3, N'Jun', 2016, N'Jun 2016', 104, N'0.2', 7402, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15761, 1340001295, N'Declined', CAST(N'2016-12-13 00:00:00.000' AS DateTime), CAST(N'2017-02-07 00:00:00.000' AS DateTime), 1, N'Dec', 2016, N'Dec 2016', 56, N'0.1', 6438, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15762, 1340001276, N'Approved', CAST(N'2016-09-24 00:00:00.000' AS DateTime), CAST(N'2017-02-16 00:00:00.000' AS DateTime), 4, N'Sep', 2016, N'Sep 2016', 145, N'0.3', 9260, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15763, 1340001280, N'Submitted', CAST(N'2016-09-16 00:00:00.000' AS DateTime), NULL, 1, N'Sep', 2016, N'Sep 2016', -42629, N'0.9', 5409, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15764, 1340001290, N'Pending', CAST(N'2016-07-12 00:00:00.000' AS DateTime), NULL, 5, N'Jul', 2016, N'Jul 2016', -42563, N'0.8', 8720, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15765, 1340001307, N'Approved', CAST(N'2016-08-19 00:00:00.000' AS DateTime), CAST(N'2016-10-25 00:00:00.000' AS DateTime), 2, N'Aug', 2016, N'Aug 2016', 67, N'0.98', 7406, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15766, 1340001310, N'Approved', CAST(N'2016-11-03 00:00:00.000' AS DateTime), CAST(N'2017-01-19 00:00:00.000' AS DateTime), 6, N'Nov', 2016, N'Nov 2016', 77, N'0.85', 8038, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15767, 1340001285, N'Declined', CAST(N'2016-09-08 00:00:00.000' AS DateTime), CAST(N'2016-12-19 00:00:00.000' AS DateTime), 3, N'Sep', 2016, N'Sep 2016', 102, N'0.75', 670, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15768, 1340001294, N'Pending', CAST(N'2016-03-14 00:00:00.000' AS DateTime), NULL, 7, N'Mar', 2016, N'Mar 2016', -42443, N'0.8', 3579, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15769, 1340001289, N'Submitted', CAST(N'2016-01-04 00:00:00.000' AS DateTime), NULL, 4, N'Jan', 2016, N'Jan 2016', -42373, N'0.9', 843, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15770, 1340001283, N'Approved', CAST(N'2016-11-08 00:00:00.000' AS DateTime), CAST(N'2017-02-20 00:00:00.000' AS DateTime), 8, N'Nov', 2016, N'Nov 2016', 104, N'0.99', 903, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15771, 1340001316, N'Pending', CAST(N'2016-10-19 00:00:00.000' AS DateTime), NULL, 5, N'Oct', 2016, N'Oct 2016', -42662, N'0.8', 7803, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15772, 1340001303, N'Approved', CAST(N'2016-08-19 00:00:00.000' AS DateTime), CAST(N'2016-10-25 00:00:00.000' AS DateTime), 8, N'Aug', 2016, N'Aug 2016', 67, N'0.75', 6730, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15773, 1340001320, N'Approved', CAST(N'2016-10-11 00:00:00.000' AS DateTime), CAST(N'2016-12-17 00:00:00.000' AS DateTime), 2, N'Oct', 2016, N'Oct 2016', 67, N'0.4', 4520, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15774, 1340001289, N'Submitted', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 2, N'Jun', 2016, N'Jun 2016', -42540, N'0.3', 7540, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15775, 1340001290, N'Pending', CAST(N'2016-01-01 00:00:00.000' AS DateTime), NULL, 1, N'Jan', 2016, N'Jan 2016', -42370, N'0.9', 4729, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15776, 1340001280, N'Approved', CAST(N'2016-02-02 00:00:00.000' AS DateTime), CAST(N'2016-03-01 00:00:00.000' AS DateTime), 1, N'Feb', 2016, N'Feb 2016', 28, N'0.1', 983, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15777, 1340001288, N'Approved', CAST(N'2016-01-05 00:00:00.000' AS DateTime), CAST(N'2017-02-27 00:00:00.000' AS DateTime), 1, N'Jan', 2016, N'Jan 2016', 419, N'0.6', 7409, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15778, 1340001279, N'Pending', CAST(N'2016-09-19 00:00:00.000' AS DateTime), NULL, 6, N'Sep', 2016, N'Sep 2016', -42632, N'0.9', 8540, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15779, 1340001297, N'Declined', CAST(N'2016-12-12 00:00:00.000' AS DateTime), CAST(N'2017-01-13 00:00:00.000' AS DateTime), 2, N'Dec', 2016, N'Dec 2016', 32, N'0.98', 9473, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15780, 1340001285, N'Approved', CAST(N'2016-01-12 00:00:00.000' AS DateTime), CAST(N'2016-02-14 00:00:00.000' AS DateTime), 7, N'Jan', 2016, N'Jan 2016', 33, N'0.95', 9740, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15781, 1340001299, N'Approved', CAST(N'2016-12-02 00:00:00.000' AS DateTime), CAST(N'2017-01-16 00:00:00.000' AS DateTime), 2, N'Dec', 2016, N'Dec 2016', 45, N'0.6', 7430, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15782, 1340001305, N'Submitted', CAST(N'2016-08-16 00:00:00.000' AS DateTime), NULL, 3, N'Aug', 2016, N'Aug 2016', -42598, N'0.75', 9302, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15783, 1340001315, N'Submitted', CAST(N'2016-10-21 00:00:00.000' AS DateTime), NULL, 8, N'Oct', 2016, N'Oct 2016', -42664, N'0.9', 7430, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15784, 1340001311, N'Approved', CAST(N'2016-03-12 00:00:00.000' AS DateTime), CAST(N'2017-01-13 00:00:00.000' AS DateTime), 4, N'Mar', 2016, N'Mar 2016', 307, N'0.98', 203, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15785, 1340001291, N'Declined', CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-03-01 00:00:00.000' AS DateTime), 2, N'Jan', 2016, N'Jan 2016', 425, N'0.2', 7340, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15786, 1340001318, N'Approved', CAST(N'2016-10-16 00:00:00.000' AS DateTime), CAST(N'2016-12-18 00:00:00.000' AS DateTime), 8, N'Oct', 2016, N'Oct 2016', 63, N'0.3', 9503, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15787, 1340001294, N'Pending', CAST(N'2016-12-25 00:00:00.000' AS DateTime), NULL, 5, N'Dec', 2016, N'Dec 2016', -42729, N'0.65', 15000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15788, 1340001304, N'Approved', CAST(N'2016-07-11 00:00:00.000' AS DateTime), CAST(N'2016-09-12 00:00:00.000' AS DateTime), 6, N'Jul', 2016, N'Jul 2016', 63, N'0.75', 21987, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15789, 1340001292, N'Submitted', CAST(N'2016-12-28 00:00:00.000' AS DateTime), NULL, 1, N'Dec', 2016, N'Dec 2016', -42732, N'0.9', 3278, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15790, 1340001321, N'Pending', CAST(N'2016-09-29 00:00:00.000' AS DateTime), NULL, 7, N'Sep', 2016, N'Sep 2016', -42642, N'0.2', 11876, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15791, 1340001300, N'Declined', CAST(N'2016-12-01 00:00:00.000' AS DateTime), CAST(N'2017-02-22 00:00:00.000' AS DateTime), 8, N'Dec', 2016, N'Dec 2016', 83, N'0.75', 9870, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15792, 1340001304, N'Submitted', CAST(N'2016-11-23 00:00:00.000' AS DateTime), NULL, 8, N'Nov', 2016, N'Nov 2016', -42697, N'0.25', 27633, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15793, 1340001298, N'Pending', CAST(N'2016-12-11 00:00:00.000' AS DateTime), NULL, 2, N'Dec', 2016, N'Dec 2016', -42715, N'0.8', 347, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15794, 1340001287, N'Approved', CAST(N'2016-07-11 00:00:00.000' AS DateTime), CAST(N'2016-09-12 00:00:00.000' AS DateTime), 1, N'Jul', 2016, N'Jul 2016', 63, N'0.9', 786, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15795, 1340001279, N'Approved', CAST(N'2016-02-02 00:00:00.000' AS DateTime), CAST(N'2016-03-03 00:00:00.000' AS DateTime), 2, N'Feb', 2016, N'Feb 2016', 30, N'0.95', 5000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15796, 1340001284, N'Approved', CAST(N'2016-11-18 00:00:00.000' AS DateTime), CAST(N'2017-02-06 00:00:00.000' AS DateTime), 3, N'Nov', 2016, N'Nov 2016', 80, N'0.95', 1000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15797, 1340001291, N'Approved', CAST(N'2016-08-19 00:00:00.000' AS DateTime), CAST(N'2016-10-25 00:00:00.000' AS DateTime), 3, N'Aug', 2016, N'Aug 2016', 67, N'0.95', 20000, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15798, 1340001281, N'Pending', CAST(N'2016-10-13 00:00:00.000' AS DateTime), NULL, 2, N'Oct', 2016, N'Oct 2016', -42656, N'0.98', 2567, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15799, 1340001296, N'Declined', CAST(N'2016-12-12 00:00:00.000' AS DateTime), CAST(N'2017-01-14 00:00:00.000' AS DateTime), 6, N'Dec', 2016, N'Dec 2016', 33, N'0.25', 9830, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15800, 1340001287, N'Submitted', CAST(N'2016-01-07 00:00:00.000' AS DateTime), NULL, 2, N'Jan', 2016, N'Jan 2016', -42376, N'0.75', 9630, N'NA', N'NA')
INSERT [dbo].[Claims] ([ClaimId], [PolicyHolderId], [ClaimStatus], [ClaimOpenDate], [ClaimCloseDate], [ClaimTypeId], [ClaimMonth], [ClaimYear], [ClaimMonthYear], [DaysToClose], [ClaimConfidence], [ClaimValue], [ClaimDescription], [ClaimPhotos]) VALUES (15801, 1340001295, N'Approved', CAST(N'2016-03-14 00:00:00.000' AS DateTime), CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, N'Mar', 2016, N'Mar 2016', 293, N'0.9', 7362, N'NA', N'NA')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (1, N'Fire')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (2, N'Flood')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (3, N'Theft')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (4, N'Vandalism')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (5, N'Personal Injury')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (6, N'Other')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (7, N'Storm')
INSERT [dbo].[ClaimTypes] ([ClaimTypeId], [ClaimTypeName]) VALUES (8, N'Weather Damage')
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001276, N'Cindy Smith', N'Cindy', N'530 Michigan Ave, Orofino, ID 83544 ', N'Cindy.Smith@conntoso.com', 1, 1120, 29, 30)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001277, N'Ellen Adams', N'EllenA', N'190 Boulder Dr, Orofino, ID 83544', N'Ellen.Adams@conntoso.com', 1, 1116, 11, 12)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001278, N'Lisa Andrews ', N'LisaAndrews ', N'Dent Bridge Rd, Orofino, ID 83544', N'Lisa.Andrews@conntoso.com', 1, 1120, 31, 32)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001279, N'Allen Brewer ', N'AllenB', N'855 Pine Dr, Orofino, ID 83544', N'Allen.Brewer@conntoso.com', 1, 1120, 17, 18)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001280, N'Percy Bowman ', N'PercyB', N'Chinook Ln, Orofino, ID 83544', N'Percy.Bowman@conntoso.com', 1, 1120, 19, 20)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001281, N'Jay Calvin', N'JayC', N'328 Calland Dr, Orofino, ID 83544', N'Jay.Calvin@conntoso.com', 1, 1116, 13, 14)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001282, N'Austin Ehrhardt ', N'AustinE', N'129 Swayne Ln, Orofino, ID 83544', N'Austin.Ehrhardt@conntoso.com', 1, 1120, 1, 2)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001283, N'Royce Freeland', N'RoyceF', N'1204 Shriver Rd, Orofino, ID 83544', N'Royce.Freeland@conntoso.com', 1, 1116, 15, 16)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001284, N'William Fox ', N'WilliamF', N'4660 Gilbert Grade Rd, Orofino, ID 83544', N'William.Fox@conntoso.com', 1, 1116, 17, 18)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001285, N'Misty Shock ', N'MistyS ', N'1265 Ahsahka Rd, Orofino, ID 83544', N'Misty.Shock@conntoso.com', 1, 1120, 3, 4)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001286, N'Chris Meyer ', N'ChrisM', N'1185 Riverside Ave, Orofino, ID 83544', N'Chris.Meyer@conntoso.com', 1, 1111, 1, 2)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001287, N'Walter Harp', N'WalterH', N'Chinook Ln, Orofino, ID 83544', N'Walter.Harp@conntoso.com', 1, 1120, 5, 6)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001288, N'Jeff Smith', N'JeffS', N'992 Miles Ave, Orofino, ID 83544', N'Jeff.Smith@conntoso.com', 1, 1120, 19, 20)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001289, N'Ben Smith ', N' BenS', N'1175 Ahsahka Rd, Orofino, ID 83544', N'Ben.Smith@conntoso.com', 1, 1111, 3, 4)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001290, N'Emma Lowton', N'EmmaL', N'4668 Gilbert Grade Rd, Orofino, ID 83544', N'Emma.Lowton@conntoso.com', 1, 1120, 7, 8)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001291, N'Tiffany Mach', N'TiffanyM', N'920 Miles Ave, Orofino, ID 83544', N'Tiffany.Mach@conntoso.com', 1, 1132, 17, 18)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001292, N'Naina Dhyani', N'NainaD', N'974 Miles Ave, Orofino, ID 83544', N'Naina.Dhyani@conntoso.com', 1, 1120, 21, 22)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001293, N'Jessica Oxley', N'JessicaO', N'Chinook Ln, Orofino, ID 83544', N'Jessica.Oxley@conntoso.com', 1, 1120, 5, 6)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001294, N'Shreya Smith', N'ShreyaS', N'St Theresa''s Catholic Church, 446 Brown Ave, Orofino, ID 83544', N'Shreya.Smith@conntoso.com', 1, 1120, 9, 10)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001295, N'Barbara Sankovic', N'BarbaraS', N'620 Braun Rd, Orofino, ID 83544', N'Barbara.Sankovic@conntoso.com', 1, 1116, 19, 20)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001296, N'Burton Guido', N'BurtonG', N'Chinook Ln, Orofino, ID 83544', N'Burton.Guido@conntoso.com', 1, 1120, 23, 24)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001297, N'Holly Kearney', N'HollyK', N'446 Michigan Ave, Orofino, ID 83544', N'Holly.Kearney@conntoso.com', 1, 1120, 11, 12)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001298, N'Dan Jump', N'DanJ', N'122-124 Michigan Ave, Orofino, ID 83544', N'Dan.Jump@conntoso.com', 1, 1120, 25, 26)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001299, N'Stephanie Bourne', N'StephanieB', N'Chinook Ln, Orofino, ID 83544', N'Stephanie.Bourne@conntoso.com', 1, 1120, 21, 22)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001300, N'Nicole Holliday', N'NicoleH', N'119-185 Brown Ave, Orofino, ID 83544', N' Nicole.Holliday@conntoso.com', 1, 1120, 27, 28)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001301, N'Rebecca Laszlo', N'RebeccaL', N'Chinook Ln, Orofino, ID 83544', N'Rebecca.Laszlo@conntoso.com', 1, 1120, 13, 14)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001302, N'Josh Barnhill', N'JoshB', N'Catfish Ln, Orofino, ID 83544', N'Josh.Barnhill@conntoso.com', 1, 1116, 23, 24)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001303, N'John Kane', N'JohnK', N'250 138th St, Orofino, ID 83544', N'John.Kane@conntoso.com', 1, 1116, 25, 26)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001304, N'Jean Trenary', N'JeanT', N'Chinook Ln, Orofino, ID 83544', N'JeanTrenary@conntoso.com', 1, 1120, 15, 16)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001305, N'Sergio Da Silva', N'SergioS', N'4291-4295 ID-7, Orofino, ID 83544', N'Sergio.DaSilva@conntoso.com', 1, 1132, 7, 8)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001306, N'Jian Wang', N'JianW', N'185 Boulder Dr, Orofino, ID 83544', N'Jian.Wang@conntoso.com', 1, 1116, 27, 28)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001307, N'Dan Wilson', N'DanW', N'Chinook Ln, Orofino, ID 83544', N'Dan.Wilson@conntoso.com', 1, 1120, 17, 18)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001308, N'Rachel Valdez', N'RachelV', N'4198 Ahsahka Loop, Lenore, ID 83541', N'Rachel.Valdez@conntoso.com', 1, 1120, 29, 30)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001309, N'Jim Giest ', N'JimG', N'155 Boulder Dr, Orofino, ID 83544', N'Jim.Giest@conntoso.com', 1, 1116, 29, 30)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001310, N'Jenny Gottfried', N'JennyG', N'296 Shasta Cir, Orofino, ID 83544', N'Jenny.Gottfried@conntoso.com', 1, 1120, 31, 32)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001311, N'Aidan Delaney', N'AidanD', N'4188 Northfork Dr, Lenore, ID 83541', N'Aidan.Delaney@conntoso.com', 1, 1120, 19, 20)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001312, N'Luca Dellamore', N'LucaD', N'135 Boulder Dr, Orofino, ID 83544', N'Luca.Dellamore@conntoso.com', 1, 1120, 21, 22)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001313, N'David Hamilton', N'DavidH', N'125 Boulder Dr, Orofino, ID 83544', N'David.Hamilton@conntoso.com', 1, 1132, 19, 20)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001314, N'Helge Hoeing', N'HelgeH', N'4173 Northfork Dr, Lenore, ID 83541', N'Helge.Hoeing@conntoso.com', 1, 1116, 31, 32)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001315, N'Stuart Munson', N'StuartM', N'105 Boulder Dr, Orofino, ID 83544', N'Stuart.Munson@conntoso.com', 1, 1132, 21, 22)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001316, N'Billie Jo Murray', N'BillieM', N'108 Dworshak Dr, Orofino, ID 83544', N'BillieJo.Murray@conntoso.com', 1, 1120, 23, 24)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001317, N'Kevin Kenneth', N'KevinK', N'13724 W 2nd Ave, Orofino, ID 83544', N'Kevin.Kenneth@conntoso.com', 1, 1132, 23, 24)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001318, N'Kari Hensien ', N'KariH', N'Chinook Ln, Orofino, ID 83544', N'Kari.Hensien@conntoso.com', 1, 1120, 25, 26)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001319, N'Bobby Moore', N'BobbyM', N'224 Blue Ridge Ct, Orofino, ID 83544', N'Bobby.Moore@conntoso.com', 1, 1132, 9, 10)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001320, N'Barbara Moreland ', N'BarbaraM', N'Chinook Ln, Orofino, ID 83544', N'Barbara.Moreland@conntoso.com', 1, 1120, 27, 28)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001321, N'Susan Metters', N'SusanM', N'240 Blue Ridge Ct, Orofino, ID 83544', N'Susan.Metters@conntoso.com', 1, 1132, 11, 12)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001322, N'Carole Poland', N'CaroleP', N'248 Shasta Cir, Orofino, ID 83544', N'Carole.Poland@conntoso.com', 1, 1120, 29, 30)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001323, N'Ken Sánchez', N'KenS', N'13834 1st Ave W, Orofino, ID 83544', N'Ken.Sánchez@conntoso.com', 1, 1116, 1, 2)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001324, N'Terri Duffy', N'TerriD', N'201 Shasta Cir, Orofino, ID 83544', N'Terri.Duffy@conntoso.com', 1, 1120, 21, 22)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001325, N'Roberto Tamburello', N'RobertoT', N'Chinook Ln, Orofino, ID 83544', N'Roberto.Tamburello@conntoso.com', 1, 1120, 31, 32)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001326, N'Rob Walters', N'RobW', N'13836 4th Ave W, Orofino, ID 83544', N'Rob.Walters@conntoso.com', 1, 1116, 3, 4)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001327, N'Gail Erickson', N'GailE', N'1245 Forsman St, Orofino, ID 83544', N'Gail.Erickson@conntoso.com', 1, 1132, 25, 26)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001328, N'Jossef Goldberg', N'JossefG', N'1235 Forsman St, Orofino, ID 83544', N'Jossef.Goldberg@conntoso.com', 1, 1120, 23, 24)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001329, N'Dylan Miller', N'DylanM', N'13930 W 2nd Ave, Orofino, ID 83544', N'Dylan.Miller@conntoso.com', 1, 1111, 7, 8)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001330, N'Diane Margheim', N'DianeM', N'1310 Michigan Ave, Orofino, ID 83544', N'Diane.Margheim@conntoso.com', 1, 1120, 1, 2)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001331, N'Gigi Matthew', N'GigiM', N'150 Birch St, Orofino, ID 83544', N'Gigi.Matthew@conntoso.com', 1, 1116, 5, 6)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001332, N'Michael Raheem', N'MichaelR', N'14016 US-12, Orofino, ID 83544', N'Michael.Raheem@conntoso.com', 1, 1120, 25, 26)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001333, N'Ovidiu Cracium', N'OvidiuC', N'185 Dogwood, Orofino, ID 83544', N'Ovidiu.Cracium@conntoso.com', 1, 1120, 3, 4)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001334, N'Thierry D''Hers', N'ThierryD', N'111 Forest St, Orofino, ID 83544', N'Thierry.D''Hers@conntoso.com', 1, 1111, 9, 10)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001335, N'Janice Galvin', N'JaniceG', N'4627 Laudenbach Rd, Orofino, ID 83544', N'Janice.Galvin@conntoso.com', 1, 1120, 5, 6)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001336, N'Michael Sullivan', N'MichaelS', N'1747 Hollywood St, Orofino, ID 83544', N'Michael.Sullivan@conntoso.com', 1, 1120, 1, 2)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001337, N'Sharon Salavaria', N'SharonS', N'1813-2465 Hollywood St, Orofino, ID 83544', N'Sharon.Salavaria@conntoso.com', 1, 1116, 7, 8)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001338, N'David Bradley', N'DavidB', N'421 Braun Rd, Orofino, ID 83544', N'David.Bradley@conntoso.com', 1, 1120, 3, 4)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001339, N'Kevin Brown', N'KevinB', N'155 Wisconsin St, Orofino, ID 83544', N'Kevin.Brown@conntoso.com', 1, 1116, 9, 10)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001340, N'John Wood', N'JohnW', N'14414-14424 US-12, Orofino, ID 83544', N'John.Wood@conntoso.com', 1, 1132, 13, 14)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001341, N'Mary Dempsey', N'MaryD', N'218 1st St, Orofino, ID 83544', N'Mary.Dempsey@conntoso.com', 1, 1116, 11, 12)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001342, N'Wanida Benshoof', N'WanidaB', N'Berry St, Orofino, ID 83544', N'Wanida.Benshoof@conntoso.com', 1, 1120, 27, 28)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001343, N'Terry Eminhizer', N'TerryE', N'Chinook Ln, Orofino, ID 83544', N'Wanida.Benshoof@conntoso.com', 1, 1120, 7, 8)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001344, N'Sariya Harnpadoungsataya', N'SariyaH', N'12743 Hartford Ave, Orofino, ID 83544', N'Sariya.Harnpadoungsataya@conntoso.com', 1, 1120, 9, 10)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001345, N'Mary Gibson', N'MaryG', N'12877 Hartford Ave, Orofino, ID 83544', N'Mary.Gibson@conntoso.com', 1, 1116, 13, 14)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001346, N'Jill Williams', N'JillW', N'13630 Freemont Ave, Orofino, ID 83544', N'Jill.Williams@conntoso.com', 1, 1120, 11, 12)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001347, N'James Hamilton', N'JamesH', N'12856 Indio Ave, Orofino, ID 83544', N'James.Hamilton@conntoso.com', 1, 1132, 5, 6)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001348, N'Peter Krebs', N'PeterK', N'12672 Indio Ave, Orofino, ID 83544', N'Peter.Krebs@conntoso.com', 1, 1120, 13, 14)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001349, N'Jo Brown', N'JoB', N'12356 Indio Ave, Orofino, ID 83544', N'Jo.Brown@conntoso.com', 1, 1116, 15, 16)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001350, N'Guy Gilbert', N'GuyG', N'4780 Obrien Rd, Orofino, ID 83544', N'Guy.Gilbert@conntoso.com', 1, 1132, 15, 16)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001351, N'Mark McArthur', N'MarkM', N'12216 Jerome Ave, Orofino, ID 83544', N'Mark.McArthur@conntoso.com', 1, 1120, 15, 16)
INSERT [dbo].[Customers] ([PolicyHolderId], [PolicyHolderName], [PolicyHolderUserName], [Address], [EmailAddress], [DistrictId], [BuilderId], [AdjusterId], [ManagerId]) VALUES (1340001352, N'Britta Simon', N'BrittaS', N'11820 Marquette Ct, Orofino, ID 83544', N'Britta.Simon@conntoso.com', 1, 1116, 17, 18)
INSERT [dbo].[Districts] ([DistrictId], [DistrictName]) VALUES (1, N'Riverside Water & Sewer District')
INSERT [dbo].[Districts] ([DistrictId], [DistrictName]) VALUES (2, N'Constoso Water & Sewer Distict')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (1, N'Lynda Chaney', N'lyndac@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (2, N'Lina Horton', N'linah@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (3, N'Annelie Zubar', N'anneliz@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (4, N'Magnus Hedlund', N'magnush@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (5, N'Luca Dellamore', N'lucad@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (6, N'Jill Frank', N'jillf@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (7, N'Dan Bacon', N'danb@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (8, N'Mark Hanson', N'markh@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (9, N'Humberto Acevedo', N'humbera@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (10, N'Alisa Strong', N'alisas@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (11, N'Sara Henson', N'sarah@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (12, N'Tia Rivera', N'tiar@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (13, N'Aamil Shammas', N'aamils@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (14, N'Lene Aalling', N'lenea@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (15, N'Boyd Rincon', N'boydr@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (16, N'Lisa Miller', N'lisam@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (17, N'Nicole Abrego', N'nicolea@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (18, N'Alexis Turner', N'alexist@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (19, N'Tabitha Pennington', N'tabithap@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (20, N'Hester Hyde', N'hesterh@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (21, N'Sarah Simmons', N'sarahs@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (22, N'Frank Miller', N'frankmi@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (23, N'Phyllis Peck', N'phyllisp@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (24, N'Syed Abbas', N'syeda@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (25, N'Cleveland McFarland', N'clevelandm@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (26, N'Shi Song', N'shis@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (27, N'Lucas Rodriguez', N'lucasr@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (28, N'Jeri Ball', N'jerib@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (29, N'Grover Oswalt', N'grovero@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (30, N'Marla Weiss', N'marlaw@onemtcqa.net', N'', N'Manager')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (31, N'Patti Barnes', N'pattib@onemtcqa.net', N'', N'ClaimsAdjuster')
INSERT [dbo].[Employees] ([Id], [FullName], [Username], [Password], [Role]) VALUES (32, N'Darlene Rios', N'darlener@onemtcqa.net', N'', N'Manager')
