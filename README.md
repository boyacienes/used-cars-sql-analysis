# Used Cars SQL Analysis

## 📌 Project Overview

This project analyzes a used car dataset using **SQL Server (T-SQL)**.

The main goal is to explore used car prices and identify differences between car brands based on factors such as **year, engine size, transmission type, and model**.

The project was created as part of my SQL and Data Analysis learning journey.

## 🗂️ Dataset

The dataset contains used car listings from multiple brands, including:

- Audi
- BMW
- Mercedes

Main columns used in the analysis:

- `model`
- `year`
- `price`
- `transmission`
- `mileage`
- `fueltype`
- `tax`
- `mpg`
- `engineSize`

## 🔎 Analysis Questions

The project answers questions such as:

1. How many cars are available from each brand?
2. What is the average price difference between automatic and manual cars within the same brand?
3. What is the relationship between engine size and price?
4. How do Audi and BMW compare in average price for cars with the same engine size?
5. Which brand has the highest average price among Audi, BMW, and Mercedes with the same characteristics?
6. Among automatic cars from 2018 onwards, which brand has the highest average price for the same engine size?
7. What are the three most expensive cars from each brand?

## 🛠️ SQL Skills Used

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- Aggregate Functions (`AVG`, `COUNT`, `SUM`, `MAX`)
- `CASE WHEN`
- `INNER JOIN`
- `LEFT JOIN`
- Subqueries
- `UNION ALL`
- Window Functions
  - `ROW_NUMBER()`

## 📊 Key Concepts Practiced

This project focuses on:

- Data aggregation
- Filtering and grouping
- Comparing multiple brands
- Joining aggregated datasets
- Ranking records within groups
- Using window functions for analytical queries
- Extracting insights from real-world data

- ## Dataset Source
[Kaggle - 100,000 UK Used Car Dataset](https://www.kaggle.com/datasets/adityadesai13/used-car-dataset-ford-and-mercedes)

## 💻 Tools

- **Microsoft SQL Server**
- **T-SQL**
- **GitHub**

## 📁 Project Structure

```text
used-cars-sql-analysis/
│
├── README.md
└── used_cars_analysis.sql
```

## 🎯 Purpose

This project demonstrates my ability to use SQL for **data analysis and extracting meaningful insights from structured datasets**.
