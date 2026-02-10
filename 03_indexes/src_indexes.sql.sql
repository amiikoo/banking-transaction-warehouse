--adding Indexes to the src.Customers
CREATE UNIQUE INDEX IX_Customers_PassportID ON src.Customers(PassportID);

--adding Indexes to the src.Accounts
CREATE INDEX IX_Accounts_CustomerID ON src.Accounts(CustomerID);
CREATE INDEX IX_Accounts_Status ON src.Accounts(Status);

--adding Indexes to the src.Transactions
CREATE INDEX IX_Transactions_AccountID ON src.Transactions(AccountID);
CREATE INDEX IX_Transactions_CreatedAt ON src.Transactions(CreatedAt);


