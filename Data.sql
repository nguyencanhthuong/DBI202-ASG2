USE [master]
GO
/****** Object:  Database [Grading  Management ]    Script Date: 7/13/2022 11:36:44 PM ******/
CREATE DATABASE [Grading  Management ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Grading  Management', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Grading  Management .mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Grading  Management _log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Grading  Management _log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Grading  Management ] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Grading  Management ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Grading  Management ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Grading  Management ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Grading  Management ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Grading  Management ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Grading  Management ] SET ARITHABORT OFF 
GO
ALTER DATABASE [Grading  Management ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Grading  Management ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Grading  Management ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Grading  Management ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Grading  Management ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Grading  Management ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Grading  Management ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Grading  Management ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Grading  Management ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Grading  Management ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Grading  Management ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Grading  Management ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Grading  Management ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Grading  Management ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Grading  Management ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Grading  Management ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Grading  Management ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Grading  Management ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Grading  Management ] SET  MULTI_USER 
GO
ALTER DATABASE [Grading  Management ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Grading  Management ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Grading  Management ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Grading  Management ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Grading  Management ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Grading  Management ] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Grading  Management ] SET QUERY_STORE = OFF
GO
USE [Grading  Management ]
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment](
	[AssID] [varchar](10) NOT NULL,
	[CategoryDetailsID] [varchar](10) NOT NULL,
	[CourseID] [varchar](10) NOT NULL,
	[Duration] [nvarchar](30) NOT NULL,
	[Weight] [float] NOT NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[AssID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [varchar](10) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Completion Criteria] [varchar](10) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category Details]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category Details](
	[CategoryDetailsID] [varchar](10) NOT NULL,
	[CategoryID] [varchar](10) NOT NULL,
	[CategoryDetailName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category Details] PRIMARY KEY CLUSTERED 
(
	[CategoryDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [varchar](10) NOT NULL,
	[CourseName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[SID] [char](8) NOT NULL,
	[AssID] [varchar](10) NOT NULL,
	[Score] [float] NOT NULL,
	[Date Exam] [date] NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[AssID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Gid] [varchar](10) NOT NULL,
	[GName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group_Student]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Student](
	[Gid] [varchar](10) NOT NULL,
	[Sid] [char](8) NOT NULL,
 CONSTRAINT [PK_Group_Student] PRIMARY KEY CLUSTERED 
(
	[Gid] ASC,
	[Sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturers](
	[LecID] [varchar](10) NOT NULL,
	[GID] [varchar](10) NOT NULL,
	[First Name] [varchar](50) NOT NULL,
	[Last Name] [varchar](50) NOT NULL,
	[Gender] [bit] NOT NULL,
 CONSTRAINT [PK_Lecturers] PRIMARY KEY CLUSTERED 
(
	[LecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semester](
	[SesID] [varchar](10) NOT NULL,
	[SesName] [varchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[SesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Sid] [char](8) NOT NULL,
	[First name] [nvarchar](50) NOT NULL,
	[Last name] [nvarchar](50) NOT NULL,
	[Gender] [bit] NOT NULL,
	[DOB] [date] NOT NULL,
	[Address] [nvarchar](150) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[View]    Script Date: 7/13/2022 11:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[View](
	[Sid] [char](8) NOT NULL,
	[CourseID] [varchar](10) NOT NULL,
	[Semester] [varchar](10) NOT NULL,
	[Average] [float] NULL,
	[Status] [varchar](20) NULL,
 CONSTRAINT [PK_View] PRIMARY KEY CLUSTERED 
(
	[Sid] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_FE', N'FE', N'CSI104', N'01:00:00', 40)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_LAB1', N'LAB1', N'CSI104', N'01:00:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_LAB2', N'LAB2', N'CSI104', N'01:00:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_PRE1', N'PRE1', N'CSI104', N'00:10:00', 5)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_PRE2', N'PRE2', N'CSI104', N'00:10:00', 5)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_PT1', N'PT1', N'CSI104', N'01:00:00', 15)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'CSI_PT2', N'PT2', N'CSI104', N'01:00:00', 15)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_ASS1', N'ASS1', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_ASS2', N'ASS2', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_ASS3', N'ASS3', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_FE', N'FE', N'MAE101', N'00:10:00', 40)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_PT1', N'PT1', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_PT2', N'PT2', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'MAE_PT3', N'PT3', N'MAE101', N'00:20:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_ASS', N'ASS', N'PRF192', N'01:00:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_FE', N'FE', N'PRF192', N'01:00:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_PE', N'PE', N'PRF192', N'01:30:00', 10)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_PT1', N'PT1', N'PRF192', N'00:25:00', 5)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_PT2', N'PT2', N'PRF192', N'00:25:00', 5)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS1', N'WS1', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS2', N'WS2', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS3', N'WS3', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS4', N'WS4', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS5', N'WS5', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS6', N'WS6', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS7', N'WS7', N'PRF192', N'02:00:00', 1.3)
INSERT [dbo].[Assessment] ([AssID], [CategoryDetailsID], [CourseID], [Duration], [Weight]) VALUES (N'PRF_WS8', N'WS8', N'PRF192', N'02:00:00', 1.3)
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'ACT', N'Activity', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'ASS', N'Assignment', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'FE', N'Final Exam', N'4', N'final exam')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'GA', N'Group asm', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'GP', N'Group Project', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'LAB', N'Lab', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'ME', N'Mid-term test', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'PA', N'Participation', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'PE', N'Practice Exam', N'>0', N'practical exam')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'PEc', N'Practice Exam', N'4', N'final exam')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'PRE', N'Group presentation', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'PT', N'Progress Test', N'>0', N'quiz')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'QUIZ', N'Quiz', N'>0', N'on-going')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'TE', N'Theory Exam', N'4', N'final exam')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [Completion Criteria], [Type]) VALUES (N'WS', N'Workshop', N'>0', N'on-going')
GO
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ACT1', N'ACT', N'Activity 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ACT2', N'ACT', N'Activity 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ACT3', N'ACT', N'Activity 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS', N'ASS', N'Assignment ')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS1', N'ASS', N'Assignment 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS2', N'ASS', N'Assignment 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS3', N'ASS', N'Assignment 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS4', N'ASS', N'Assignment 4')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS5', N'ASS', N'Assignment 5')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS6', N'ASS', N'Assignment 6')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS7', N'ASS', N'Assignment 7')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ASS8', N'ASS', N'Assignment 8')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'FE', N'FE', N'Final Exam')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'GA1', N'GA', N'Group asm 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'GA2', N'GA', N'Group asm 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'GP1', N'GP', N'Group Project 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'GP2', N'GP', N'Group Project 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'GP3', N'GP', N'Group Project 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB1', N'LAB', N'Lab 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB2', N'LAB', N'Lab 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB3', N'LAB', N'Lab 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB4', N'LAB ', N'Lab 4')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB5', N'LAB', N'Lab 5')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'LAB6', N'LAB', N'Lab 6')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'ME', N'ME', N'Mid-term test')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PA', N'PA', N'Participation')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PE', N'PE', N'Practice Exam')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PEc', N'PEc', N'Practice Exam')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PRE1', N'PRE', N'Presentation 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PRE2', N'PRE', N'Presentation 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PRE3', N'PRE', N'Presentation 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PRE4', N'PRE', N'Presentation 4 ')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PT1', N'PT', N'Progress Test')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PT2', N'PT', N'Progress Test 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'PT3', N'PT', N'Progress Test 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'QUIZ', N'QUIZ', N'Quiz')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'TE', N'TE', N'Theory Exam')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS1', N'WS', N'Workshop 1')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS2', N'WS', N'Workshop 2')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS3', N'WS', N'Workshop 3')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS4', N'WS', N'Workshop 4')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS5', N'WS', N'Workshop 5')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS6', N'WS', N'Workshop 6')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS7', N'WS', N'Workshop 7')
INSERT [dbo].[Category Details] ([CategoryDetailsID], [CategoryID], [CategoryDetailName]) VALUES (N'WS8', N'WS', N'Workshop 8')
GO
INSERT [dbo].[Course] ([CourseID], [CourseName]) VALUES (N'CSI104', N'Introduction to Computer Science')
INSERT [dbo].[Course] ([CourseID], [CourseName]) VALUES (N'MAD101', N'Discrete  mathematics')
INSERT [dbo].[Course] ([CourseID], [CourseName]) VALUES (N'MAE101', N'Mathematics for Enginerring')
INSERT [dbo].[Course] ([CourseID], [CourseName]) VALUES (N'PRF192', N'Programming Fundamentals')
INSERT [dbo].[Course] ([CourseID], [CourseName]) VALUES (N'SSL101c', N'Academic Skills ')
GO
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163740', N'CSI_PT1', 5.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163741', N'CSI_PT1', 6.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163742', N'CSI_PT1', 7.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163742', N'MAE_ASS1', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163742', N'MAE_ASS2', 5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163742', N'PRF_WS2', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163743', N'CSI_PT1', 8.1, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163743', N'MAE_ASS1', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163743', N'MAE_ASS3', 8.9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163743', N'PRF_PE', 8.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163743', N'PRF_WS2', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'CSI_PRE2', 8.3, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'CSI_PT1', 8.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'MAE_ASS1', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'MAE_ASS3', 7.9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'PRF_PE', 7.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163744', N'PRF_WS2', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'CSI_PRE1', 8.9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'CSI_PRE2', 8.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'MAE_ASS1', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'MAE_ASS3', 6.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'PRF_PE', 6.6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'PRF_WS2', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'PRF_WS4', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163745', N'PRF_WS5', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'CSI_PRE1', 5.9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'CSI_PRE2', 6.6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'MAE_ASS2', 10, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'MAE_ASS3', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_PE', 7.8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_PT1', 6.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_WS2', 6.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_WS3', 6.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_WS4', 10, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163746', N'PRF_WS5', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'CSI_PRE1', 8.8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'CSI_PRE2', 7.3, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'MAE_ASS2', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'MAE_ASS3', 9.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'PRF_FE', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'PRF_PT1', 6.8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'PRF_WS3', 9.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'PRF_WS4', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163747', N'PRF_WS5', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'CSI_PRE1', 7.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'CSI_PRE2', 6.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'PRF_FE', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'PRF_PT1', 6.7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'PRF_WS3', 7.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'PRF_WS4', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163748', N'PRF_WS5', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'CSI_PRE1', 6.3, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'CSI_PRE2', 5.4, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'PRF_FE', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'PRF_PT1', 9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'PRF_WS3', 8.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'PRF_WS4', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163749', N'PRF_WS5', 7.7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163750', N'MAE_ASS2', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163750', N'PRF_WS1', 5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163750', N'PRF_WS6', 7.3, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163751', N'CSI_FE', 8.9, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163751', N'MAE_ASS3', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163751', N'PRF_WS1', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163751', N'PRF_WS6', 8.6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163752', N'CSI_FE', 5.6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163752', N'PRF_WS6', 9.8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163753', N'CSI_FE', 7.2, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163753', N'PRF_FE', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163753', N'PRF_WS1', 7, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163753', N'PRF_WS6', 6.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163754', N'CSI_FE', 6, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163754', N'MAE_ASS3', 7.5, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163754', N'PRF_FE', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163754', N'PRF_WS1', 8, NULL)
INSERT [dbo].[Grade] ([SID], [AssID], [Score], [Date Exam]) VALUES (N'HE163754', N'PRF_WS6', 5.9, NULL)
GO
INSERT [dbo].[Group] ([Gid], [GName]) VALUES (N'IA1', N'IA1604')
INSERT [dbo].[Group] ([Gid], [GName]) VALUES (N'SE1', N'SE1636')
INSERT [dbo].[Group] ([Gid], [GName]) VALUES (N'SE2', N'SE1647')
GO
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'IA1', N'HE163750')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'IA1', N'HE163751')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'IA1', N'HE163752')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'IA1', N'HE163753')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'IA1', N'HE163754')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE1', N'HE163740')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE1', N'HE163741')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE1', N'HE163742')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE1', N'HE163743')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE1', N'HE163744')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE2', N'HE163745')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE2', N'HE163746')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE2', N'HE163747')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE2', N'HE163748')
INSERT [dbo].[Group_Student] ([Gid], [Sid]) VALUES (N'SE2', N'HE163749')
GO
INSERT [dbo].[Semester] ([SesID], [SesName], [StartDate], [EndDate]) VALUES (N'FALL21', N'Fall 2021', CAST(N'2021-09-06' AS Date), CAST(N'2021-11-30' AS Date))
INSERT [dbo].[Semester] ([SesID], [SesName], [StartDate], [EndDate]) VALUES (N'SP21', N'Spring 2021', CAST(N'2021-09-06' AS Date), CAST(N'2021-03-25' AS Date))
INSERT [dbo].[Semester] ([SesID], [SesName], [StartDate], [EndDate]) VALUES (N'SP22', N'Spring 2022', CAST(N'2021-01-05' AS Date), CAST(N'2022-03-25' AS Date))
INSERT [dbo].[Semester] ([SesID], [SesName], [StartDate], [EndDate]) VALUES (N'SU21', N'Summer 2021', CAST(N'2021-05-06' AS Date), CAST(N'2021-07-02' AS Date))
GO
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163740', N'Nguyen Canh', N'Thuong', 1, CAST(N'2002-12-01' AS Date), N'Nghe An')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163741', N'Nguyen Quoc', N'Khanh', 1, CAST(N'2002-12-02' AS Date), N'Thai Binh')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163742', N'Dang Ngoc ', N'Anh', 1, CAST(N'2002-12-03' AS Date), N'Ha Giang')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163743', N'Pham Quang', N'Hung', 1, CAST(N'2002-12-04' AS Date), N'Thanh Hoa')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163744', N'Hoang Huyen', N'Dieu', 0, CAST(N'2002-12-05' AS Date), N'Hai Phong')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163745', N'Dinh Thuy ', N'Lan', 0, CAST(N'2002-12-06' AS Date), N'Son Tay')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163746', N'Nguyen An ', N'Tuan', 1, CAST(N'2002-12-07' AS Date), N'Ha Noi')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163747', N'Nguyen Ha', N'Phuong', 0, CAST(N'2002-12-08' AS Date), N'Nam Dinh')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163748', N'Nguyen An ', N'Dat', 1, CAST(N'2002-12-09' AS Date), N'Quang Binh')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163749', N'Nguyen Thi', N'Quynh Trang', 0, CAST(N'2002-12-10' AS Date), N'Ha Tinh')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163750', N'Hoang Viet ', N'Phuong', 0, CAST(N'2002-12-11' AS Date), N'Ninh Binh')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163751', N'Do Trong ', N'Tuan', 1, CAST(N'2002-12-12' AS Date), N'Bac Giang')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163752', N'Kim Thi', N'Hong Quyen', 0, CAST(N'2002-11-01' AS Date), N'Hung Yen')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163753', N'Vu Duy', N'Duc', 1, CAST(N'2002-11-02' AS Date), N'Phu Tho')
INSERT [dbo].[Student] ([Sid], [First name], [Last name], [Gender], [DOB], [Address]) VALUES (N'HE163754', N'Nguyen Quang ', N'Huy', 1, CAST(N'2002-11-03' AS Date), N'Hoa Binh')
GO
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163742', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163742', N'PRF192', N'Fall21', 0, N'NOT PASS')

INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163743', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163743', N'PRF192', N'Fall21', 0, N'NOT PASS')

INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163744', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163744', N'PRF192', N'Fall21', 0, N'NOT PASS')

INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163745', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163745', N'PRF192', N'Fall21', 0, N'NOT PASS')

INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163746', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163746', N'PRF192', N'Fall21', 0, N'NOT PASS')

INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163747', N'MAE101', N'Fall21', 0, N'NOT PASS')
INSERT [dbo].[View] ([Sid], [CourseID], [Semester], [Average], [Status]) VALUES (N'HE163747', N'PRF192', N'Fall21', 0, N'NOT PASS')
GO
ALTER TABLE [dbo].[View] ADD  CONSTRAINT [DF_View_Average]  DEFAULT ((0)) FOR [Average]
GO
ALTER TABLE [dbo].[View] ADD  CONSTRAINT [DF_View_Status]  DEFAULT ('NOT PASS') FOR [Status]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_Category Details] FOREIGN KEY([CategoryDetailsID])
REFERENCES [dbo].[Category Details] ([CategoryDetailsID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_Category Details]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_Course]
GO
ALTER TABLE [dbo].[Category Details]  WITH CHECK ADD  CONSTRAINT [FK_Category Details_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category Details] CHECK CONSTRAINT [FK_Category Details_Category]
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Assessment] FOREIGN KEY([AssID])
REFERENCES [dbo].[Assessment] ([AssID])
GO
ALTER TABLE [dbo].[Grade] CHECK CONSTRAINT [FK_Grade_Assessment]
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Student] FOREIGN KEY([SID])
REFERENCES [dbo].[Student] ([Sid])
GO
ALTER TABLE [dbo].[Grade] CHECK CONSTRAINT [FK_Grade_Student]
GO
ALTER TABLE [dbo].[Group_Student]  WITH CHECK ADD  CONSTRAINT [FK_Group_Student_Group] FOREIGN KEY([Gid])
REFERENCES [dbo].[Group] ([Gid])
GO
ALTER TABLE [dbo].[Group_Student] CHECK CONSTRAINT [FK_Group_Student_Group]
GO
ALTER TABLE [dbo].[Group_Student]  WITH CHECK ADD  CONSTRAINT [FK_Group_Student_Student] FOREIGN KEY([Sid])
REFERENCES [dbo].[Student] ([Sid])
GO
ALTER TABLE [dbo].[Group_Student] CHECK CONSTRAINT [FK_Group_Student_Student]
GO
ALTER TABLE [dbo].[Lecturers]  WITH CHECK ADD  CONSTRAINT [FK_Lecturers_Group] FOREIGN KEY([GID])
REFERENCES [dbo].[Group] ([Gid])
GO
ALTER TABLE [dbo].[Lecturers] CHECK CONSTRAINT [FK_Lecturers_Group]
GO
ALTER TABLE [dbo].[View]  WITH CHECK ADD  CONSTRAINT [FK_View_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[View] CHECK CONSTRAINT [FK_View_Course]
GO
ALTER TABLE [dbo].[View]  WITH CHECK ADD  CONSTRAINT [FK_View_Semester] FOREIGN KEY([Semester])
REFERENCES [dbo].[Semester] ([SesID])
GO
ALTER TABLE [dbo].[View] CHECK CONSTRAINT [FK_View_Semester]
GO
ALTER TABLE [dbo].[View]  WITH CHECK ADD  CONSTRAINT [FK_View_Student] FOREIGN KEY([Sid])
REFERENCES [dbo].[Student] ([Sid])
GO
ALTER TABLE [dbo].[View] CHECK CONSTRAINT [FK_View_Student]
GO
USE [master]
GO
ALTER DATABASE [Grading  Management ] SET  READ_WRITE 
GO
