🗃️ Inventory Management System
A SQL-based inventory and stock tracking system that manages products, suppliers, customers, transactions, and stock changes. Built to simulate a retail inventory backend with clear relational design and structured queries.

📌 Overview
This project models an inventory system for a mid-sized retail operation using SQL. It includes operations like purchases, sales, stock adjustments, supplier and customer tracking.

🧱 Key Features
Tracks inventory levels by product and category

Logs all stock changes (additions/removals)

Records transactions (purchase/sale) with customer linkage

Maintains supplier and customer information

Provides insightful queries for analysis

🗄️ Tables Created
Categories – product classification

Suppliers – vendor details

Customers – buyer information

Products – inventory items

Transactions – logs purchases and sales

StockLogs – tracks quantity updates and inventory movement

🔗 Table Relationships
Products has foreign keys to Categories and Suppliers

Transactions links Products and Customers

StockLogs is connected to Products

📊 Sample Queries Included
Product list with corresponding category and supplier

Total quantity in stock by category

Total sales and purchase amounts

Detailed sale transactions with customer data

✅ Technologies & Concepts Used
SQL (MySQL)

Relational Schema Design

Normalization (upto BCNF)

JOINs and Aggregation Queries

ENUM types and Constraints
