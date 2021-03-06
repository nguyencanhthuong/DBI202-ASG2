
GO
/****** Object:  Database [Grading  Management ]    Script Date: 7/8/2022 11:13:37 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[check_pass]    Script Date: 7/17/2022 11:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Hàm check điều kiện xem có điểm thành phần nào không đủ điều kiện không?. 
CREATE FUNCTION [dbo].[check_pass](@courseID varchar(10), @sID char(8)) 
RETURNS int
AS
BEGIN
	DECLARE @flag int;
	DECLARE @categoryID varchar(10);
	SET @flag = 0;
	DECLARE check_pass_cursor CURSOR FOR
	SELECT [sID],CourseID, CategoryID FROM 
	(
	SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
	INNER JOIN Assessment a on g.AssID = a.AssID
	INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
	INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
	) as tbl1 WHERE  CourseID = @courseID and [sID] = @sID ;
	OPEN check_pass_cursor;
	FETCH NEXT FROM check_pass_cursor INTO @sID, @courseID, @categoryID
	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @score fLOAT;
			DECLARE @scoreMin FLOAT
			SELECT @score = sub_total , @scoreMin = [Completion Criteria] FROM 
			(
				SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria]
				FROM Grade g
				INNER JOIN Assessment a on g.AssID = a.AssID
				INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
				INNER JOIN Category c on c.CategoryID = cd.CategoryID
				GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria] 
			) as tbl1 WHERE tbl1.CourseID = @courseID  AND  tbl1.[sID] = @sID AND  CategoryID = @categoryID 
			IF @score <= @scoreMin
				BEGIN
					set @flag = 1;
					break;
				END
			FETCH NEXT FROM check_pass_cursor INTO @courseID, @sid, @categoryID
		END
	CLOSE check_pass_cursor;
	DEALLOCATE check_pass_cursor;
	return @flag;
END
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 7/17/2022 11:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [varchar](10) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Completion Criteria] [float] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category Details]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Grade]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Group]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Group_Student]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Lecturers]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Semester]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 7/17/2022 11:13:37 PM ******/
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
/****** Object:  Table [dbo].[View]    Script Date: 7/17/2022 11:13:37 PM ******/
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
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_Completion Criteria]  DEFAULT ((0)) FOR [Completion Criteria]
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
/****** Object:  StoredProcedure [dbo].[select_sub_total]    Script Date: 7/17/2022 11:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[select_sub_total]
AS
BEGIN
	SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
	INNER JOIN Assessment a on g.AssID = a.AssID
	INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
	INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
END
GO
/****** Object:  StoredProcedure [dbo].[update_status_pass]    Script Date: 7/17/2022 11:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_status_pass]
	@courseID varchar(10),
	@sID char(8)
AS
BEGIN
	DECLARE @average1 FLOAT;
	SELECT @average1 = Average FROM [View] WHERE  CourseID = @courseID  and  [sID] = @sID ;
	IF @average1 > 5 AND dbo.check_pass(@courseID,@sID) = 0
	UPDATE [View] SET [Status] = 'PASSED' WHERE  CourseID = @courseID  and  [sID] = @sID ;
	ELSE
	UPDATE [View] SET [Status] = 'NOT PASSED' WHERE  CourseID = @courseID  and  [sID] = @sID ;
END

-- cusor update status while have average.
GO
USE [master]
GO
ALTER DATABASE [Grading  Management ] SET  READ_WRITE 
GO
