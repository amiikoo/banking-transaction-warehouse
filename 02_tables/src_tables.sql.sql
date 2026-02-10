CREATE DATABASE BankingTransactionWarehouseDB;
GO

USE BankingTransactionWarehouseDB;
GO

CREATE TABLE src.Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FullName NVARCHAR(200) NOT NULL,
	CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
	Email NVARCHAR(200) UNIQUE,
	PassportID NVARCHAR(100) NOT NULL UNIQUE,
	City NVARCHAR (200)
)

CREATE TABLE src.Accounts (
	AccountID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT NOT NULL,
	CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
	Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Active', 'Inactive', 'Frozen')),
	Currency CHAR(3) NOT NULL,
	AccountType NVARCHAR(50) NOT NULL,
	Balance DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (Balance >= 0),
	FOREIGN KEY (CustomerID) REFERENCES src.Customers(CustomerID)
)

CREATE TABLE src.Transactions (
	TransactionID INT PRIMARY KEY IDENTITY(1,1),
	AccountID INT NOT NULL,
	Amount DECIMAL(10, 2) NOT NULL,
	CreatedAt DATETIME2 NOT NULL,
	TransactionType NVARCHAR(20) NOT NULL CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer')),
	FOREIGN KEY (AccountID) REFERENCES src.Accounts(AccountID)
)


SELECT * FROM src.Transactions

--updated src.Transactions added ToAccountID
ALTER TABLE src.Transactions ADD ToAccountID INT 
ALTER TABLE src.Transactions ADD FOREIGN KEY (ToAccountID) REFERENCES src.Accounts(AccountID)