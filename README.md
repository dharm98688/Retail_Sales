# Retail_Sales

# Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

# Project Structure
Database Creation: The project starts by creating a database named retail_sales.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

create database sql_project_1

create table retail_sales
		(
		transactions_id int primary key,
		sale_date Date,
		sale_time Time,
		customer_id int,
		gender varchar(15),
		age	int,
		category varchar(15),
		quantiy int,
		price_per_unit float,
		cogs float,
		total_sale float
		)
