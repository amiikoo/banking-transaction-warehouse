USE BankingTransactionWarehouseDB;
GO


CREATE TABLE dwh.DimCustomers (
	CustomerKey INT PRIMARY KEY IDENTITY (1, 1),
	CustomerID INT NOT NULL, 
	FullName NVARCHAR(200),
	Email NVARCHAR(200) UNIQUE,
	PassportID NVARCHAR(200) UNIQUE,
	City NVARCHAR(200),
	EffectiveFrom DATETIME2 NOT NULL DEFAULT GETDATE(),
	EffectiveTo DATETIME2 NULL,
	IsCurrent BIT NOT NULL DEFAULT 1
)


CREATE TABLE dwh.DimAccounts (
	AccountKey INT PRIMARY KEY IDENTITY (1,1),
	AccountID INT NOT NULL,
	CustomerID INT NOT NULL,
	AccountType NVARCHAR(200),
	Currency CHAR(3),
	Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Active', 'Inactive', 'Frozen')),
	EffectiveFrom DATETIME2 NOT NULL DEFAULT GETDATE(),
	EffectiveTo DATETIME2 NULL,
	IsCurrent BIT NOT NULL DEFAULT 1
)


CREATE TABLE dwh.DimDate (
	DateKey INT PRIMARY KEY, -- yyyyMMdd
	FullDate DATE NOT NULL,
	Year INT,
	Quarter INT,
	Month INT,
	MonthName NVARCHAR(20),
	Day INT,
	DayOfWeek INT,
	DayName NVARCHAR(20)
)


CREATE TABLE dwh.FactTransactions (
	TransactionKey INT PRIMARY KEY IDENTITY (1,1),
	TransactionID INT NOT NULL,
	AccountKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	DateKey INT NOT NULL,
	Amount DECIMAL(10,2) NOT NULL,
	TransactionType NVARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer')), 
	FOREIGN KEY (AccountKey) REFERENCES dwh.DimAccounts(AccountKey),
	FOREIGN KEY (CustomerKey) REFERENCES dwh.DimCustomers(CustomerKey),
	FOREIGN KEY (DateKey) REFERENCES dwh.DimDate(DateKey)
)

ALTER TABLE dwh.FactTransactions 
ADD ToAccountKey INT,
	ToCustomerKey INT

ALTER TABLE dwh.FactTransactions
ADD CONSTRAINT FK_ToAccount FOREIGN KEY (ToAccountKey) REFERENCES dwh.DimAccounts(AccountKey),
	CONSTRAINT FK_ToCustomer FOREIGN KEY (ToCustomerKey) REFERENCES dwh.DimCustomers(CustomerKey)
	