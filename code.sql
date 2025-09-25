-- ##########################################################################
-- SCRIPT CONSOLIDADO DE INICIALIZACIÓN (DATABASE-PER-MICROSERVICE PATTERN)
-- ##########################################################################

-- NOTA:
-- El nombre de la base de datos (USE [DB_NAME]) es dinámico
-- y se manejará por separado en el script de despliegue o la conexión del microservicio.

---------------------------------------------------------------------------------------------------
-- MICROSERVICIO: Transactions
-- TABLA: Transactions (Base de Datos: mssql-database-transactions-west-us, etc.)
---------------------------------------------------------------------------------------------------

-- 1. Eliminación de la tabla si existe
IF OBJECT_ID(N'Transactions', N'U') IS NOT NULL
    DROP TABLE Transactions;
GO

-- 2. Creación de la tabla
CREATE TABLE Transactions (
    Id                  INT             IDENTITY (1,1) PRIMARY KEY,
    CorrelationId       NVARCHAR(100)   NOT NULL,
    TransactionDate     DATETIME        NOT NULL,
    CurrentState        NVARCHAR(50)    NOT NULL,
    Amount              DECIMAL(18,2)   NOT NULL,
    SourceAccount       NVARCHAR(100)   NOT NULL,
    DestinationAccount  NVARCHAR(100)   NOT NULL,
    CustomerId          INT             NOT NULL
);
GO

-- 3. Creación de índices
CREATE NONCLUSTERED INDEX IX_Transactions_CorrelationId ON Transactions(CorrelationId);
CREATE NONCLUSTERED INDEX IX_Transactions_CustomerId ON Transactions(CustomerId);
GO

-- 4. Inserción de datos de ejemplo (protegida)
IF NOT EXISTS (SELECT 1 FROM Transactions WHERE CorrelationId = '123e4567-e89b-12d3-a456-426614174000')
BEGIN
    INSERT INTO Transactions (CorrelationId, TransactionDate, CurrentState, Amount, SourceAccount, DestinationAccount, CustomerId)
    VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Pending', 500.00, '00908929778493-43984', '32408929778493-43984', 1);
END
GO

SELECT 'MICROSERVICIO TRANSACTIONS: Datos de Transactions' AS Contexto;
SELECT * FROM Transactions;
GO


---------------------------------------------------------------------------------------------------
-- MICROSERVICIO: Balances
-- TABLA: Balances (Base de Datos: mssql-database-balances-xxxx, etc.)
---------------------------------------------------------------------------------------------------

IF OBJECT_ID(N'Balances', N'U') IS NOT NULL
    DROP TABLE Balances;
GO

CREATE TABLE Balances (
    Id              INT             IDENTITY(1,1) PRIMARY KEY,
    CorrelationId   NVARCHAR(100)   NOT NULL,
    BalanceDate     DATETIME        NOT NULL,
    CurrentState    NVARCHAR(50)    NOT NULL,
    CustomerId      INT             NOT NULL
);
GO

CREATE NONCLUSTERED INDEX IX_Balances_CorrelationId ON Balances(CorrelationId);
CREATE NONCLUSTERED INDEX IX_Balances_CustomerId ON Balances(CustomerId);
GO

IF NOT EXISTS (SELECT 1 FROM Balances WHERE CorrelationId = '123e4567-e89b-12d3-a456-426614174000')
BEGIN
    INSERT INTO Balances (CorrelationId, BalanceDate, CurrentState, CustomerId)
    VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Approved', 1);
END
GO

SELECT 'MICROSERVICIO BALANCES: Datos de Balances' AS Contexto;
SELECT * FROM Balances;
GO


---------------------------------------------------------------------------------------------------
-- MICROSERVICIO: Transfers
-- TABLA: Transfers (Base de Datos: mssql-database-transfers-xxxx, etc.)
---------------------------------------------------------------------------------------------------

IF OBJECT_ID(N'Transfers', N'U') IS NOT NULL
    DROP TABLE Transfers;
GO

CREATE TABLE Transfers (
    Id                  INT             IDENTITY(1,1) PRIMARY KEY,
    CorrelationId       NVARCHAR(100)   NOT NULL,
    TransferDate        DATETIME        NOT NULL,
    CurrentState        NVARCHAR(50)    NOT NULL,
    Amount              DECIMAL(18,2)   NOT NULL,
    SourceAccount       NVARCHAR(100)   NOT NULL,
    DestinationAccount  NVARCHAR(100)   NOT NULL,
    CustomerId          INT             NOT NULL
);
GO

CREATE NONCLUSTERED INDEX IX_Transfers_CorrelationId ON Transfers(CorrelationId);
CREATE NONCLUSTERED INDEX IX_Transfers_CustomerId ON Transfers(CustomerId);
GO

IF NOT EXISTS (SELECT 1 FROM Transfers WHERE CorrelationId = '123e4567-e89b-12d3-a456-426614174000')
BEGIN
    INSERT INTO Transfers (CorrelationId, TransferDate, CurrentState, Amount, SourceAccount, DestinationAccount, CustomerId)
    VALUES ('123e4567-e89b-12d3-a456-426614174000', GETDATE(), 'Pending', 1500.75, '00908929778493-43984', '32408929778493-56984', 1);
END
GO

SELECT 'MICROSERVICIO TRANSFERS: Datos de Transfers' AS Contexto;
SELECT * FROM Transfers;
GO
