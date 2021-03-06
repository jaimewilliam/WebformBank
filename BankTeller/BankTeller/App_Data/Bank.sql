USE [master]
GO
/****** Object:  Database [Bank]    Script Date: 2/15/2020 10:53:09 AM ******/
CREATE DATABASE [Bank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bank', FILENAME = N'C:\Users\Gerald Alzaga\Bank.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bank_log', FILENAME = N'C:\Users\Gerald Alzaga\Bank_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Bank] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bank] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bank] SET RECOVERY FULL 
GO
ALTER DATABASE [Bank] SET  MULTI_USER 
GO
ALTER DATABASE [Bank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bank] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Bank] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bank] SET QUERY_STORE = OFF
GO
USE [Bank]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Bank]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountNo] [nvarchar](22) NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MobileNumbers]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileNumbers](
	[MobileNumberID] [int] IDENTITY(1,1) NOT NULL,
	[MobileNumber] [nvarchar](10) NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_MobileNumbers] PRIMARY KEY CLUSTERED 
(
	[MobileNumberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NULL,
	[TransactionTypeFK] [int] NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[RemainingBalance] [decimal](18, 2) NULL,
	[InitialDepositAmount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[TransactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionName] [nvarchar](10) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[ACM_List]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ACM_List]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT * FROM [Accounts]
	if(@AccountId IS null)
	BEGIN
		SELECT 
		Accounts.AccountId,
		Accounts.AccountNo,
		Customers.CustomerName,
		MobileNumbers.MobileNumber
	  FROM Accounts
	  INNER JOIN Customers ON Accounts.CustomerFK = Customers.CustomerID
	  INNER JOIN MobileNumbers ON Customers.CustomerID = MobileNumbers.CustomerFK
	END
	ELSE
	BEGIN
		SELECT 
		 AccountId,
		 AccountNo,
		 Accounts.CustomerFK,
		 CustomerName,
		 MobileNumber
	  FROM Accounts
	  INNER JOIN Customers ON CustomerID = CustomerFK
	  INNER JOIN MobileNumbers ON Customers.CustomerID = MobileNumbers.CustomerFK
	  WHERE Accounts.AccountId = @AccountId
	END

END
GO
/****** Object:  StoredProcedure [dbo].[COUNTAccount]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[COUNTAccount] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(*) as [rowcount] FROM Accounts
END

GO
/****** Object:  StoredProcedure [dbo].[DELETEAccount]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETEAccount] 
	-- Add the parameters for the stored procedure here
	@AccountId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Accounts
	WHERE Accounts.AccountId = @AccountId
END

GO
/****** Object:  StoredProcedure [dbo].[DELETECustomer]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETECustomer] 
	-- Add the parameters for the stored procedure here
	@CustomerFK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Customers
	WHERE Customers.CustomerID = @CustomerFK
END

GO
/****** Object:  StoredProcedure [dbo].[DELETEMobile]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETEMobile] 
	-- Add the parameters for the stored procedure here
	@CustomerFK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM MobileNumbers
	WHERE MobileNumbers.CustomerFK = @CustomerFK
END

GO
/****** Object:  StoredProcedure [dbo].[DELETETrans]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETETrans] 
	-- Add the parameters for the stored procedure here
	@CustomerFK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Transactions
	WHERE Transactions.CustomerFK = @CustomerFK
END

GO
/****** Object:  StoredProcedure [dbo].[EditUpdate]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditUpdate]
	-- Add the parameters for the stored procedure here
	@CustomerName nvarchar(200),
	@CustomerFK int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Customers SET CustomerName = @CustomerName
    WHERE Customers.CustomerID = @CustomerFK


END
GO
/****** Object:  StoredProcedure [dbo].[INSERTAccount]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTAccount] 
	-- Add the parameters for the stored procedure here
	@AccountNo nvarchar(22),
	@CustomerFK int,
	@CreateDate datetime,
	@UpdateDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT into Accounts(AccountNo ,CustomerFK, CreateDate, UpdateDate)
	VALUES (@AccountNo ,@CustomerFK, @CreateDate, @UpdateDate)
END

GO
/****** Object:  StoredProcedure [dbo].[INSERTCustomer]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTCustomer]
	@CustomerName nvarchar(200),
	@CreateDate datetime,
	@UpdateDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--***Execute Insert command and return inserted Id in Sql
	INSERT into Customers (CustomerName, CreateDate, UpdateDate)
	OUTPUT INSERTED.CustomerID
	VALUES (@CustomerName, @CreateDate, @UpdateDate)
END

GO
/****** Object:  StoredProcedure [dbo].[INSERTMobileNum]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTMobileNum] 
	-- Add the parameters for the stored procedure here
	@MobileNumber nvarchar(10),
	@CustomerFK int,
	@CreateDate datetime,
	@UpdateDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT into MobileNumbers (MobileNumber, CustomerFK, CreateDate, UpdateDate)
	VALUES (@MobileNumber, @CustomerFK, @CreateDate, @UpdateDate)
END

GO
/****** Object:  StoredProcedure [dbo].[INSERTTrans]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTTrans]
	-- Add the parameters for the stored procedure here
	@Amount decimal(18,2),
	@CustomerFK int,
	@TransTypeFK int = null,
	@CreateDate datetime,
	@UpdateDate datetime,
	@RemainingBalance decimal(18,2) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT into Transactions (Amount, TransactionTypeFK ,CustomerFK, CreateDate, UpdateDate, RemainingBalance)
	VALUES (@Amount, @TransTypeFK ,@CustomerFK, @CreateDate, @UpdateDate, @RemainingBalance)
END

GO
/****** Object:  StoredProcedure [dbo].[ORDERBYTrans]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ORDERBYTrans] 
	-- Add the parameters for the stored procedure here
	@CustomerFK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Transactions
	WHERE Transactions.CustomerFK = @CustomerFK
	ORDER BY CreateDate DESC;
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateMobileNum]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateMobileNum] 
	-- Add the parameters for the stored procedure here
	@MobileNumber nvarchar(10),
	@MobileID int = null,
	@CreateDate datetime,
	@UpdateDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE MobileNumbers SET MobileNumber = @MobileNumber, CreateDate = @CreateDate, UpdateDate = @UpdateDate
    WHERE MobileNumbers.MobileNumberID = @MobileID
END
GO
/****** Object:  StoredProcedure [dbo].[ViewAccount]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewAccount] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	 Accounts.AccountId,
     Accounts.AccountNo,
	 Customers.CustomerName,
	 Accounts.CreateDate,
	 Accounts.CustomerFK
  FROM Accounts
  INNER JOIN Customers ON Accounts.CustomerFK = Customers.CustomerID
  WHERE Accounts.AccountId = @AccountId
END


GO
/****** Object:  StoredProcedure [dbo].[ViewMobile]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewMobile]
	-- Add the parameters for the stored procedure here
	@CustomerFK int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [MobileNumbers]
	WHERE MobileNumbers.CustomerFK = @CustomerFK
END

GO
/****** Object:  StoredProcedure [dbo].[ViewTrans]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewTrans] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	 Transactions.CreateDate,
	 TransactionTypes.TransactionName,
	 Transactions.Amount,
	 Transactions.RemainingBalance
  FROM Accounts
  INNER JOIN Customers ON Accounts.CustomerFK = Customers.CustomerID
  INNER JOIN Transactions ON Customers.CustomerID = Transactions.CustomerFK
  INNER JOIN TransactionTypes ON Transactions.TransactionTypeFK = TransactionTypes.TransactionTypeID
  WHERE Accounts.AccountId = @AccountId
END


GO
/****** Object:  StoredProcedure [dbo].[ViewTransType]    Script Date: 2/15/2020 10:53:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewTransType]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * From [TransactionTypes]
END

GO
USE [master]
GO
ALTER DATABASE [Bank] SET  READ_WRITE 
GO
