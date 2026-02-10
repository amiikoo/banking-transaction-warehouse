Banking Transaction Data Warehouse (SQL Server)
Overview

This project implements a banking transaction data warehouse using SQL Server (T-SQL).
The goal is to model, load, and analyze transactional banking data using dimensional modeling principles, including slowly changing dimensions (Type 2) and a properly designed fact table.

The warehouse supports analytical use cases such as transaction trends, customer behavior analysis, account activity, and transfer flow analysis.

Architecture

The solution is organized into three logical layers:

1. Source Layer (src)

Simulates an operational banking system.

Tables:

src.Customers – current customer state (no history)

src.Accounts – bank accounts owned by customers

src.Transactions – financial events (deposits, withdrawals, transfers)

This layer represents mutable, real-world data.

2. Data Warehouse Layer (dwh)

Implements a star schema optimized for analytics.

Dimensions

dwh.DimCustomers

SCD Type 2

Tracks historical changes (e.g. city changes)

dwh.DimAccounts

SCD Type 2

Tracks account state changes (status, type)

dwh.DimDate

Static calendar dimension

One row per day

Fact Table

dwh.FactTransactions

One row per transaction

Stores surrogate keys for:

Source account & customer

Destination account & customer (for transfers)

Date

Measures:

Amount

Transaction type

Key Concepts Demonstrated

Star schema design

Surrogate keys vs business keys

Slowly Changing Dimensions (Type 2)

Fact table grain definition

Transfer modeling (source → destination)

Date dimension usage

Rebuildable ETL logic

Data validation and integrity checks

ETL Flow (High Level)

Seed source tables (src)

Load dimensions

Initial load

Preserve history using SCD Type 2 logic

Load fact table

Resolve surrogate keys via dimension joins

Handle transfers using dual account/customer joins

Validate

Referential integrity

Null checks

Transaction consistency