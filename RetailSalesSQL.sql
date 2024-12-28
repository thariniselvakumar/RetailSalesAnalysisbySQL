--Database Creation
CREATE DATABASE p1_retail_db;

--Importing Data into the database
SELECT * FROM retail_Sales;
USE p1_retail_db;

--DATA EXPLORATION/CLEANING

--Record count - Total number of records in the data
SELECT COUNT(*) FROM retail_Sales;

--customer count -Unique number customers
SELECT COUNT (DISTINCT customer_id) FROM retail_Sales;

--category count
SELECT DISTINCT category FROM retail_Sales;

--NULL value check

SELECT * FROM retail_Sales
WHERE 
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR
	age IS NULL OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR
	cogs IS NULL OR total_sale IS NULL;

DELETE FROM retail_Sales
WHERE 
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR
	age IS NULL OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR
	cogs IS NULL OR total_sale IS NULL;

--Data analysis / findings

--Queries--

--1--Retrieve all columns for sales made on '2022-11-05:

SELECT * FROM retail_Sales
WHERE sale_date = '2022-11-05';

--2--Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_Sales
WHERE category = 'clothing' AND quantiy >= 4 AND sale_date LIKE '2022-11-__';

--3--Calculate the total sales (total_sale) for each category.:

SELECT category,
    SUM(total_sale) AS net_Sale,
	COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

--4--Average age of customers who purchased items from the 'Beauty' category.

SELECT 
	ROUND(AVG(age),2) as AVG_age
FROM retail_Sales
WHERE category = 'beauty';

--5--Find all transactions where the total_sale is greater than 1000.:

SELECT * FROM retail_Sales
WHERE total_sale > 1000;

--6--Find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category, gender,
   COUNT(*) AS TRANS
FROM retail_Sales
GROUP BY category,gender 
ORDER BY category;

--7--Calculate the average sale for each month. Find out best selling month in each year:

SELECT YEAR(sale_date) AS Year,
	   MONTH (sale_date) AS month,
	   AVG(total_Sale) AS avg_sale
	FROM retail_Sales
	GROUP BY  YEAR(sale_date) ,MONTH (sale_date)
	ORDER BY year, avg_Sale DESC;

--8--Top 5 customers based on the highest total sales **:

SELECT TOP 5 customer_id, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC;

--9--Number of unique customers who purchased items from each category.:

SELECT category ,
		COUNT(DISTINCT customer_id) AS purchasedunique
FROM retail_Sales 
GROUP BY category;

--10--Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT 
CASE 
	WHEN DATEPART (HOUR, sale_time) <12 THEN 'Morning'
	WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'		
	ELSE 'Evening'
END AS Shift ,
COUNT(*) as Total_orders
FROM retail_Sales
GROUP BY CASE
	WHEN DATEPART (HOUR, sale_time) <12 THEN 'Morning'
	WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'		
	ELSE 'Evening'
END

--END--