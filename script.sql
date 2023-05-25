USE [master]
GO
/****** Object:  Database [RmProDb]    Script Date: 5/25/2023 11:14:52 AM ******/
CREATE DATABASE [RmProDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RmProDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RmProDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RmProDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RmProDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [RmProDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RmProDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RmProDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RmProDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RmProDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RmProDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RmProDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [RmProDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RmProDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RmProDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RmProDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RmProDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RmProDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RmProDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RmProDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RmProDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RmProDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RmProDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RmProDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RmProDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RmProDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RmProDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RmProDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RmProDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RmProDb] SET RECOVERY FULL 
GO
ALTER DATABASE [RmProDb] SET  MULTI_USER 
GO
ALTER DATABASE [RmProDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RmProDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RmProDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RmProDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RmProDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RmProDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RmProDb', N'ON'
GO
ALTER DATABASE [RmProDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [RmProDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RmProDb]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/25/2023 11:14:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[Email] [varchar](50) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Password] [varchar](12) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 5/25/2023 11:14:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetAllUsers]
AS
SELECT Id, Username, Email, FirstName + ' ' + LastName AS FullName
	FROM Users
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsernamePassword]    Script Date: 5/25/2023 11:14:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetUserByUsernamePassword]
	@username varchar(20),   
    @password varchar(12)  
	AS   

    SET NOCOUNT ON;  
    SELECT Id, Username, Email, FirstName + ' ' + LastName  
    FROM Users
    WHERE Username = @username AND Password = @password
GO
USE [master]
GO
ALTER DATABASE [RmProDb] SET  READ_WRITE 
GO
