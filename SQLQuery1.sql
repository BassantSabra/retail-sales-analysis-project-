create database retail

select *
from [dbo].[retail_sales]

alter table [dbo].[retail_sales]
alter column sale_time time

-- check the tables row 
select
      count(*) as row_no
from retail_sales

-- data exploration and cleaning 

select *
from retail_sales
where transactions_id is null

--check all null values 
select *
from retail_sales
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

-- delete all null values 
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

-- 1- Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
from retail_sales
where sale_date = '2022-11-05'

-- 2- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *
from retail_sales
where 
     category like 'Clothing%'
	 and
	 quantiy >= 4
	 and
	 sale_date between '2022-11-01' and '2022-11-30'

-- 3- Write a SQL query to calculate the total sales (total_sale) for each category

select 
      category,
      SUM(total_sale)as net_sales,
	  count(*) as total_orders
from 
     retail_sales
group by category

-- 4- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select 
      category,
	  AVG(age) as avg_age
from 
    retail_sales
where 
    category = 'Beauty'
group by category

-- 5- Write a SQL query to find all transactions where the total_sale is greater than 1000

select *
from 
    retail_sales
where 
    total_sale > 1000

-- 6- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
 select 
	   category,
	   gender,
	   count(*)as total_transactions
from 
    retail_sales
group by category,gender
order by category

-- 7- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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


-- 8- Write a SQL query to find the top 5 customers based on the highest total sales 
select 
  top 5 customer_id, 
  sum(total_sale) as total_sales 
from 
  retail_sales 
group by 
  customer_id 
order by 
  total_sales desc

-- 9-Write a SQL query to find the number of unique customers who purchased items from each category.

select 
  category, 
  count(distinct(customer_id)) as unique_customers 
from 
  retail_sales 
group by 
  category

--10- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_rate as   -- using cte to create new column 
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


	 








