-- Check if the database exists, if not, create it
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'RustDB')
BEGIN
    CREATE DATABASE RustDB;
END;
GO

-- Switch to the FfhubDB
USE RustDB;
GO

CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SteamId NVARCHAR(17) UNIQUE NOT NULL
);

CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    TotalNumberOfItems INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    PaypalOrderId NVARCHAR(255) NOT NULL UNIQUE,
    Total INT NOT NULL,
    TransactionFinalized BIT NOT NULL DEFAULT 0,
    TransactionFinalizedButPlayerDidNotGet BIT NOT NULL DEFAULT 0
);

CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL UNIQUE,
    Price INT NOT NULL
);

CREATE TABLE OrderItems (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    NumberOfItems INT NOT NULL,
    Subtotal INT NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE,
);

GO