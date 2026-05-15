# Online Retail Database Management System

A complete SQL-based database project developed using MySQL for a fictional online retail company.

This project demonstrates:

- Database design
- Table relationships
- Sample data insertion
- SQL joins
- Reporting queries
- Data analysis using SQL

---

# 📌 Project Overview

The project simulates an online retail business where:

- Customers place orders
- Products belong to categories
- Orders contain multiple products
- Sales reports are generated using SQL queries
- Business insights are extracted through analytics queries

---

# 🛠 Technologies Used

- MySQL
- MySQL Workbench

---

# 🗂 Database Name

```sql
onlinedb
```

---

# 📂 Database Schema

The project contains the following tables:

| Table Name | Description |
|---|---|
| Customers | Stores customer information |
| Products | Stores product information |
| Cateries | Stores product categories |
| Orders | Stores customer order details |
| OrderItems | Stores products included in orders |

---

# 🧱 Database Structure

## 🔹 Customers Table

Stores customer details such as:

- First Name
- Last Name
- Email
- Phone Number
- Address
- City
- State
- Country

### Primary Key

```sql
CustomerID
```

---

## 🔹 Products Table

Stores product information including:

- Product Name
- Category ID
- Price
- Stock Quantity
- Created Date

### Primary Key

```sql
ProductID
```

---

## 🔹 Cateries Table

Stores product categories.

### Example Categories

- Electronics
- Clothing
- Books

### Primary Key

```sql
CateryID
```

---

## 🔹 Orders Table

Stores order-related information:

- Customer ID
- Order Date
- Total Amount

### Primary Key

```sql
OrderID
```

### Foreign Key

```sql
CustomerID → Customers(CustomerID)
```

---

## 🔹 OrderItems Table

Stores item-level order details:

- Order ID
- Product ID
- Quantity
- Product Price

### Primary Key

```sql
OrderItemID
```

### Foreign Keys

```sql
OrderID → Orders(OrderID)
ProductID → Products(ProductID)
```

---

# 📥 Sample Data Included

The project includes sample records for:

- Customers
- Products
- Categories
- Orders
- Order Items

This data helps in:

- Query testing
- Report generation
- SQL practice
- Data analysis exercises

---

# 📊 SQL Concepts Covered

## ✅ Joins

The project uses:

- INNER JOIN
- LEFT JOIN

Used for:

- Customer order reports
- Product sales analysis
- Customer purchase tracking

---

## ✅ Aggregate Functions

Functions used:

- `SUM()`
- `AVG()`
- `COUNT()`
- `MAX()`

Used for:

- Sales reports
- Revenue calculations
- Customer analytics

---

## ✅ Window Functions

Function used:

```sql
ROW_NUMBER()
```

Used for:

- Ranking reports
- Category analysis

---

## ✅ Date Functions

Functions used:

- `NOW()`
- `DATE_SUB()`
- `YEAR()`
- `MONTH()`

Used for:

- Monthly reports
- Recent order tracking
- Date-based filtering

---

# 📈 Reporting Queries Included

The project contains **20 SQL queries** for reporting and analysis.

## 🔹 Customer Reports

- Retrieve customer orders
- Find customers without orders
- List top spending customers
- Count customers by country

---

## 🔹 Product Reports

- Find out-of-stock products
- Retrieve most ordered products
- Calculate total product sales
- Find highest-priced products

---

## 🔹 Sales & Revenue Reports

- Calculate average order value
- Generate monthly order reports
- Calculate category-wise revenue
- Find total sales per product

---

## 🔹 Order Analytics

- Retrieve recent orders
- Find large orders
- Count products per order
- Analyze frequently ordered products

---

# ⚡ Important MySQL Concepts

## ✅ LIMIT instead of TOP

MySQL uses:

```sql
LIMIT 3
```

instead of SQL Server syntax:

```sql
TOP 3
```

---

## ✅ AUTO_INCREMENT

Used for automatic primary key generation:

```sql
AUTO_INCREMENT
```

---

## ✅ LEFT JOIN for Missing Records

Used to retrieve customers without orders:

```sql
LEFT JOIN
```

combined with:

```sql
WHERE o.OrderID IS NULL
```

---

# 🚀 How to Run the Project

## 1️⃣ Clone the Repository

```bash
git clone <repository-url>
```

---

## 2️⃣ Open MySQL Workbench

- Launch MySQL Workbench
- Connect to your MySQL server

---

## 3️⃣ Create the Database

Run:

```sql
CREATE DATABASE onlinedb;
USE onlinedb;
```

---

## 4️⃣ Execute the SQL Script

Run the complete SQL script to:

- Create tables
- Insert sample data
- Execute reporting queries

---

# 📚 Learning Outcomes

By completing this project, you will learn:

- Relational database design
- Primary & foreign keys
- SQL joins
- Aggregate queries
- Window functions
- Reporting queries
- Data analysis using SQL
- MySQL development basics

---

# 📝 Notes

- The project uses:

```text
Cateries
```

instead of:

```text
Categories
```

to match the original SQL script.

- The project is designed mainly for:
  - SQL beginners
  - Database practice
  - Query writing exercises
  - Reporting & analytics learning

---

# 👨‍💻 Author

Online Retail SQL Practice Project

Developed for:

- SQL Practice
- Database Learning
- Query Optimization Practice
- Reporting & Analytics Exercises
