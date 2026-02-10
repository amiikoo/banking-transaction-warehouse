USE BankingTransactionWarehouseDB
GO

-- Support SCD lookups and fact joins
CREATE NONCLUSTERED INDEX IX_DimCustomers_CustomerID_Current
ON dwh.DimCustomers (CustomerID, IsCurrent)
INCLUDE (CustomerKey);

-- Support account lookups and SCD resolution
CREATE NONCLUSTERED INDEX IX_DimAccounts_AccountID_Current
ON dwh.DimAccounts (AccountID, IsCurrent)
INCLUDE (AccountKey, CustomerID);

-- Support time-based analytics
CREATE NONCLUSTERED INDEX IX_FactTransactions_DateKey
ON dwh.FactTransactions (DateKey)
INCLUDE (Amount, TransactionType);

-- Support customer-level analysis
CREATE NONCLUSTERED INDEX IX_FactTransactions_CustomerKey
ON dwh.FactTransactions (CustomerKey)
INCLUDE (Amount, TransactionType, DateKey);

-- Support transfer destination analysis
CREATE NONCLUSTERED INDEX IX_FactTransactions_ToAccountKey
ON dwh.FactTransactions (ToAccountKey)
WHERE ToAccountKey IS NOT NULL;