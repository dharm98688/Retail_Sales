--SQL retail analysis
drop table if exists retail_sales

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
select * from retail_sales
limit 10

select count(*) from retail_sales     ---for rows count

select *  from retail_sales
where transactions_id is null
--DATA CLEANING
-- for null values check
select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or 
	category is null
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--deleting null values from records
delete from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or 
	category is null
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--DATA EXPLORATION
--1. HOW MANY SALES WE HAVE?
select count(*) as total_sale from retail_sales
--2. How many customer we have?
select count(distinct customer_id) from retail_sales
--3. How many categories we have?
select count(distinct category) from retail_sales
select distinct category from retail_sales

--Data Analysis and Business key problems and answers
/*
1.Write a SQL query to retrieve all columns for sales made on '2022-11-05':
2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
3.Write a SQL query to calculate the total sales (total_sale) for each category.:
4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
8.Write a SQL query to find the top 5 customers based on the highest total sales:
9.Write a SQL query to find the number of unique customers who purchased items from each category:
10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
*/

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05':
select *
from retail_sales
where sale_date = '2022-11-05'

/*2--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold 
is more than 4 in the month of Nov-2022*/
select 
category, 
sum(quantiy)
from retail_sales
where category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM')='2022-11' 
group by 1
select 
*
from retail_sales
where category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM')='2022-11' 
AND
quantiy >=4

select * from retail_sales

--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select 
ROUND(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales
where total_sale >1000
/*6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender 
in each category.:*/
select 
	category,
	gender,
count(*) as total_trans
from retail_sales
group by 
	category,
	gender
order by 1

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
	year,
	month, 
	avg_sale 
from (
select 
	extract(YEAR FROM sale_date) as year,
	extract(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	rank() over(partition by extract(YEAR FROM sale_date) order by avg(total_sale) desc)
from retail_sales
group by 1, 2
) as t1
where rank = 1

--8.Write a SQL query to find the top 5 customers based on the highest total sales:
select 
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5
--9.Write a SQL query to find the number of unique customers who purchased items from each category:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift