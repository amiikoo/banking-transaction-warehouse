USE BankingTransactionWarehouseDB
GO

--simulating DimDate looping (date) to (date) 
DECLARE @StartDate DATE = '2016-04-23';
DECLARE @EndDate DATE = '2034-09-08';

WHILE @StartDate <= @EndDate
BEGIN
	INSERT INTO dwh.DimDate (DateKey, FullDate, Year, Quarter, Month, MonthName, Day, DayOfWeek, DayName)
	VALUES (
		CONVERT(INT, FORMAT (@StartDate, 'yyyyMMdd')),
		@StartDate,
		YEAR(@StartDate),
		DATEPART(QUARTER, @StartDate),
		MONTH(@StartDate),
		FORMAT(@StartDate, 'MMMM'),
		DAY(@StartDate),
		DATEPART(WEEKDAY, @StartDate),
		FORMAT(@StartDate, 'dddd')
	);

	SET @StartDate = DATEADD(DAY, 1, @StartDate)

END


--seeding customers with src.customers
INSERT INTO dwh.DimCustomers ( CustomerID, FullName, Email, PassportID, City, EffectiveFrom, EffectiveTo, IsCurrent)
SELECT
	CustomerID,
    FullName,
    Email,
    PassportID,
    City,
    GETDATE() AS EffectiveFrom,
    NULL AS EffectiveTo,
    1 AS IsCurrent
FROM src.Customers



--seeding accounts with src.accounts
INSERT INTO dwh.DimAccounts (AccountID, CustomerID, AccountType, Currency, Status, EffectiveFrom, EffectiveTo, IsCurrent)
SELECT 
	AccountID,
	CustomerID,
	AccountType,
	Currency,
	Status,
	CreatedAt,
	NULL AS EffectiveTo,
	1 AS IsCurrent
FROM src.Accounts


--seding Fact table using joins dimdate and src.Transactions
INSERT INTO dwh.FactTransactions (TransactionID, AccountKey, CustomerKey, ToAccountKey, ToCustomerKey, DateKey, Amount, TransactionType)
SELECT 
	t.TransactionID,
	srcAcc.AccountKey,
	srcCust.CustomerKey,

	CASE WHEN t.TransactionType = 'Transfer'
		THEN destAcc.AccountKey
		ELSE NULL
	END AS ToAccountKey,

	CASE WHEN t.TransactionType = 'Transfer'
		THEN destCust.CustomerKey
		ELSE NULL
	END AS ToCustomerKey,

	d.DateKey,
	t.Amount,
	t.TransactionType

FROM src.Transactions AS t
INNER JOIN dwh.DimAccounts AS srcAcc
	ON srcAcc.AccountID = t.AccountID
	AND srcAcc.IsCurrent = 1

INNER JOIN dwh.DimCustomers AS srcCust
	ON srcCust.CustomerID = srcAcc.CustomerID
	AND srcCust.IsCurrent = 1

LEFT JOIN dwh.DimAccounts AS destAcc
	ON destAcc.AccountID = t.AccountID
	AND destAcc.IsCurrent = 1

LEFT JOIN dwh.DimCustomers AS destCust
	ON destCust.CustomerID = destAcc.CustomerID
	AND destAcc.IsCurrent = 1

INNER JOIN dwh.DimDate AS d
	ON d.FullDate = CAST(t.CreatedAt AS DATE)





