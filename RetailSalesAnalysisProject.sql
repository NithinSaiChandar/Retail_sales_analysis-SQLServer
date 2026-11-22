use retail;
select * from retail_sales;

--retrieve all columns for sales made on november 5, 2022.

select * from retail_sales where sale_date='2022-11-05';

--retrieve all transactions where the category is 
--clothing and the quantity sold is greater than 2,
--and the transaction occured in november 2022.

select * from retail_sales where category='clothing'
and quantiy>2 and sale_date>='2022-11-01' and sale_date<'2022-12-01';

--calculate total sales revenue and total number of 
--transactions for each product category.

select category, sum(price_per_unit) as TotalSale, count(transactions_id) as 
ProductTransactions from retail_sales group by category;

--find the average age of customers who purchased 
--products from the beauty category.

select avg(age) as customer_average_age
from retail_sales where category='beauty';

--retrieve all transactions where total sale
--exceeds 1000.

select * from retail_sales where total_sale>1000
order by total_sale desc;

--calculate the total number of transactions
--made by each gender in each product category.

select gender, category, count(transactions_id) as totalTransactions
from retail_sales group by gender, category order by gender;

--calculate total monthly sales for each year and identify 
--the best selling month in each year.

with monthly_sales as(
select datepart(year, sale_date) as year,
datepart(month, sale_date) as month,
sum(total_sale) as total_sales,
rank() over(partition by datepart(year, sale_date) order by 
sum(total_sale) desc) as ranked from retail_sales
group by datepart(year, sale_date),
datepart(month, sale_date)
) select * from monthly_sales where ranked=1;

--identify the top 5 customers based on their
--highest total sales.

select top 5 customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id order by total_sales desc;

--calculate the number of unique customers who 
--purchased products from each category.

select category, count(distinct customer_id) as unique_customer
from retail_sales group by category;

--categorize transactions into morning, afternoon and evening shifts 
--and count the orders in each shift
--Morning before 12:00 P.M.
--Afternoon 12:00 P.M. to before 6:00 P.M.
--Evening 6:00 P.M. onwards.

select
	case
	when sale_time<'12:00:00' then 'Morning'
    when sale_time < '18:00:00' then 'Afternoon'
	else 'Evening' 
	end as shift, count(*) as total_orders
	from retail_sales group by case
	when sale_time<'12:00:00' then 'Morning'
    when sale_time < '18:00:00' then 'Afternoon'
	else 'Evening' 
	end;

