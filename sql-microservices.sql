
-- USE mssql-database-transaction-west-us;

CREATE TABLE [Transaction](
Id INT IDENTITY (1,1) PRIMARY KEY,
CorrelationId NVARCHAR(50) NOT NULL,
TransactionDate DATETIME NOT NULL,
CurrentState NVARCHAR(20) NOT NULL,
Amount DECIMAL(18,2) NOT NULL,
SourceAccount NVARCHAR(50) NOT NULL,
DestinationAccount NVARCHAR(50) NOT NULL,
CustomerId INT NOT NULL
)

INSERT INTO [Transaction] (CorrelationId, TransactionDate, CurrentState, Amount, SourceAccount, DestinationAccount, CustomerId)  
VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Pending', 500.00, '00908929778493-43984', '32408929778493-43984', 1);  

SELECT * FROM [Transaction]

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- USE mssql-database-balance-west-us;

CREATE TABLE [Balance](
Id INT IDENTITY(1,1) PRIMARY KEY,
CorrelationId NVARCHAR(50) NOT NULL,
BalanceDate DATETIME NOT NULL,
CurrentState NVARCHAR(20) NOT NULL,
CustomerId INT NOT NULL
)

INSERT INTO Balance (CorrelationId, BalanceDate, CurrentState, CustomerId)  
VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Approved', 1);

SELECT * FROM Balance

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE TABLE [Transfer] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CorrelationId NVARCHAR(50) NOT NULL,
    TransferDate DATETIME NOT NULL,
    CurrentState NVARCHAR(20) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    SourceAccount NVARCHAR(50) NOT NULL,
    DestinationAccount NVARCHAR(50) NOT NULL,
    CustomerId INT NOT NULL
);

INSERT INTO [Transfer] (CorrelationId, TransferDate, CurrentState, Amount, SourceAccount, DestinationAccount, CustomerId)  
VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Pending', 1500.75, '00908929778493-43984', '32408929778493-56984', 1);

SELECT * FROM [Transfer]

