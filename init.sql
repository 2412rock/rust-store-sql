-- Check if the database exists, if not, create it
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'RustDB')
BEGIN
    CREATE DATABASE RustDB;
END;
GO

-- Switch to the FfhubDB
USE RustDB;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
BEGIN
    CREATE TABLE Orders (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        OrderId NVARCHAR(2048) NOT NULL,
        Amount INT NOT NULL,
        SteamId  NVARCHAR(2048) NOT NULL
    );
END;
GO