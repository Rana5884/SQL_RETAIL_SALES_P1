-- CHECKING IF THE DATA IS IMPORTED SUCCESSFULLY
select * from retail_data
limit 2;


-- CHEKING THE SHAPE OF THE DATA
select count(*)
from retail_data

-- How to remove the null values

Select * from retail_data
where transactions_id is null;

Select * from retail_data
where customer_id is null;


-- checking for null values for the entire dataset

Select count(*) from retail_data 
where transactions_id is null
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
total_sale is Null


-- Removing the null values

delete from retail_data
where transactions_id is null
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
total_sale is Null


-- Data Exploration Questions

-- How many customers do we have

Select count(Distinct customer_id) from retail_data

-- How many distinct category do we have

Select count(Distinct category) from retail_data

--- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) 


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_data
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

Select * from retail_data
where category = 'Clothing' and quantiy >= 4 and To_Char(sale_date,'yyyy-mm')= '2022-11'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
category,
sum(total_sale) as net_Sale
from retail_data 
group by category 



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select Round(avg(age),2)
from retail_data
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_data
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,
       gender,
	  count(*) as total_tranc
from retail_data
group by category,
         gender
order by category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Select 
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
avg(total_sale) as avg_sale
from retail_data
group by 1,2
order by 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select 
 customer_id,
 sum(total_sale) as total_Sales
from retail_data
group by customer_id
order by total_Sales desc
limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select  
   category,
   count(Distinct customer_id)
from retail_data
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) 

WITH hourly_sale
as 
(
select *,
       CASE 
	   when EXTRACT(HOUR FROM sale_time)<12 then 'morning'
	   when  EXTRACT(HOUR FROM sale_time) between 12 and 17  then 'afternoon'
	   else 'evening'
	   end as shift

from retail_data
)

select 
shift,
count(transactions_id)
from hourly_sale
group by shift
order by shift


-- End of projenct 








