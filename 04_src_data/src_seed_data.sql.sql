USE BankingTransactionWarehouseDB
GO


INSERT INTO src.Customers (FullName, CreatedAt, Email, PassportID, City)
VALUES
	('Amiko Davlasheridze', '2016-04-23', 'davlasheridze2@test.com', '0165023245', 'Tbilisi'),
	('Davit Shengelia', '2016-04-27', 'Shengelia23@test.com', '01651111111', 'Tbilisi'),
	('Saba Tavaria', '2016-06-02', 'tavaria2@test.com', '0165063400', 'Tbilisi'),
	('Davit Darsalia', '2017-01-07', 'darsaliadavit@test.com', '0165388200', 'Tbilisi')

INSERT INTO src.Accounts (CustomerID, CreatedAt, Status, Currency, AccountType, Balance)
VALUES 
	(1,'2016-04-23', 'Active', 'GEL', 'Checking', 203.7),
	(2,'2016-04-27', 'Frozen', 'GEL', 'Savings', 0),
	(2,'2016-06-28', 'Active', 'GEL', 'Checking', 544),
	(4,'2016-04-23', 'Active', 'GEL', 'Checking', 2400),
	(4,'2016-05-23', 'Frozen', 'GEL', 'Savings', 0),
	(3,'2016-04-30', 'Inactive', 'GEL', 'Checking', 122)


INSERT INTO src.Transactions (AccountID, Amount, CreatedAt, TransactionType)
VALUES
	(1, 20, '2016-04-25', 'Deposit'),
	(1, 20, '2016-04-25', 'Withdrawal'),
	(3, 20, '2016-04-25', 'Deposit'),
	(2, 20, '2016-05-27', 'Transfer'),
	(4, 20, '2016-06-25', 'Withdrawal')



INSERT INTO src.Transactions (AccountID,Amount, CreatedAt, TransactionType, ToAccountID)
VALUES
	(1, 500, '2016-05-01', 'Deposit', NULL),
	(1, 100, '2016-05-10', 'Withdrawal', NULL),
	(1, 150, '2016-05-15', 'Transfer', 4),
	(2, 300, '2016-06-01', 'Deposit', NULL),
	(2, 50, '2016-06-10', 'Withdrawal', NULL),
	(2, 75, '2016-06-20', 'Transfer', 3),
	(3, 400, '2016-06-05', 'Deposit', NULL),
	(3, 200, '2016-06-25', 'Transfer', 1),
	(3, 150, '2016-07-01', 'Withdrawal', NULL),
	(4, 600, '2016-05-20', 'Deposit', NULL),
	(4, 250, '2016-06-05', 'Withdrawal', NULL),
	(4, 100, '2016-07-10', 'Transfer', 2),
	(4, 300, '2016-07-15', 'Deposit', NULL),
	(6, 250, '2016-05-05', 'Deposit', NULL),
	(6, 75, '2016-05-20', 'Withdrawal', NULL)


SELECT * FROM src.Transactions