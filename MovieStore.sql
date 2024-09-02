USE [master]
GO
/****** Object:  Database [MovieStoreDB]    Script Date: 2.09.2024 08:50:52 ******/
CREATE DATABASE [MovieStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MovieStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MovieStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MovieStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MovieStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MovieStoreDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MovieStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MovieStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MovieStoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MovieStoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MovieStoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MovieStoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MovieStoreDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MovieStoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MovieStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MovieStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MovieStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MovieStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MovieStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MovieStoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MovieStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MovieStoreDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MovieStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MovieStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MovieStoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MovieStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MovieStoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MovieStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MovieStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MovieStoreDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MovieStoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [MovieStoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MovieStoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MovieStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MovieStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MovieStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MovieStoreDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MovieStoreDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [MovieStoreDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MovieStoreDB]
GO
/****** Object:  Table [dbo].[Directors]    Script Date: 2.09.2024 08:50:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directors](
	[director_id] [int] IDENTITY(1,1) NOT NULL,
	[director_name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[director_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieViews]    Script Date: 2.09.2024 08:50:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieViews](
	[view_id] [int] IDENTITY(1,1) NOT NULL,
	[director_id] [int] NOT NULL,
	[view_count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[view_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DirectorViewReport]    Script Date: 2.09.2024 08:50:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. View oluşturma
CREATE VIEW [dbo].[DirectorViewReport] AS
SELECT 
    d.director_name AS Director,
    SUM(m.view_count) AS TotalViews
FROM 
    MovieViews m
JOIN 
    Directors d ON m.director_id = d.director_id
GROUP BY 
    d.director_name;
GO
ALTER TABLE [dbo].[MovieViews]  WITH CHECK ADD FOREIGN KEY([director_id])
REFERENCES [dbo].[Directors] ([director_id])
GO
USE [master]
GO
ALTER DATABASE [MovieStoreDB] SET  READ_WRITE 
GO
