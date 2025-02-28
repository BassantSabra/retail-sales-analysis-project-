
# Retail Sales Analysis SQL Project

## Project Overview`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail`using SQL server import and export wizard 
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

![Screenshot 2025-02-08 022530](https://github.com/user-attachments/assets/9a285292-ce7a-43a5-82aa-5553f54693fe)


![Screenshot 2025-02-08 053129](https://github.com/user-attachments/assets/d359dfbc-7422-4917-b3d4-cf02c7e3eeb2)


### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select *
from retail_sales
where 
     category like 'Clothing%'
	 and
	 quantiy >= 4
	 and
	 sale_date between '2022-11-01' and '2022-11-30'
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select 
      category,
      SUM(total_sale)as net_sales,
	  count(*) as total_orders
from 
     retail_sales
group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
      category,
	  AVG(age) as avg_age
from 
    retail_sales
where 
    category = 'Beauty'
group by category
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
 select 
	   category,
	   gender,
	   count(*)as total_transactions
from 
    retail_sales
group by category,gender
order by category
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select 
     year,
	 month,
	 avg_sale
from 
    ( select 
	       year(sale_date)as year,
		   month(sale_date)as month,
		   AVG(total_sale) as avg_sale,
		   rank()over(PARTITION BY YEAR(sale_date) order by AVG(total_sale) DESC) AS rank 
	  from retail_sales
	  group by year(sale_date),month(sale_date)) as t
where
     rank= 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select 
  top 5 customer_id, 
  sum(total_sale) as total_sales 
from 
  retail_sales 
group by 
  customer_id 
order by 
  total_sales desc
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
  category, 
  count(distinct(customer_id)) as unique_customers 
from 
  retail_sales 
group by 
  category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_rate as   
( select 
      case  
       when datepart(hour ,sale_time) <12 then 'morning'
       when datepart(hour ,sale_time) between 12 and 17 then 'afternoon'
	   else 'evening'
      end as day_shifts
  from retail_sales)
select day_shifts,
       count(*)as total_orders
from hourly_rate
group by day_shifts
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.




