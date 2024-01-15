select * from WalmartSalesData


--Retrieve the total number of records in the table--

select count(*) as total_records from WalmartSalesData;

-- List all unique branches in the dataset--

select distinct branch from WalmartSalesData

-- Find the average unit price for each product line--

select product_line, round(avg(unit_price),2) as avg_unit_price_product from WalmartSalesData
group by product_line;

--Calculate the total quantity sold for each customer type--

select customer_type,SUM(quantity) as total_quantity_sold from WalmartSalesData
group by customer_type

--Identify the highest gross income in the dataset and display the associated details--

select top 1 * from WalmartSalesData order by gross_income desc;

---------------OR-----------
select * from WalmartSalesData 
where gross_income = (select MAX(gross_income) from WalmartSalesData); 

--List the cities where the average rating is above 4--

select round(AVG(rating),2) from WalmartSalesData where rating > 4;

select city, round(rating,2) as avg_rating from WalmartSalesData
where rating > (select round(AVG(rating),2) from WalmartSalesData where rating > 4)
group by city,rating
order by avg_rating desc;

--Retrieve the total sales (excluding tax) for each payment type--

select payment,(SUM(total)-SUM(tax_5)) as Total_sales from WalmartSalesData
group by payment

--Find the date with the highest total sales (including tax)--

select top 1 date,(SUM(total)+SUM(tax_5)) as Total_sales from WalmartSalesData
group by date
order by Total_sales desc

--Determine the most common product line among female customers--

select product_line, COUNT(product_line) as product_count, gender from WalmartSalesData 
where gender = 'Female'
group by product_line,gender
order by product_count desc;

--Calculate the average gross margin percentage for each branch--

select branch,round(avg(gross_margin_percentage),2) as GMP from WalmartSalesData
group by Branch

--How many unique cities does the data have?--

select distinct city from WalmartSalesData;

--What is the total revenue by month--

select Month(date),SUM(Total) as Total_revenue from WalmartSalesData
group by Month(date)

--What month had the largest COGS?--

select top 1 MONTH(date) as Month_, sum(cogs) as COGS from WalmartSalesData
group by MONTH(date)
order by COGS desc

--What product line had the largest revenue?--
select top 1 product_line, SUM(total) as Total_revenue from WalmartSalesData
group by Product_line,total
order by Total_revenue desc

--What is the city with the largest revenue?--

select branch,city, SUM(total) as Total_revenue from WalmartSalesData
group by branch,City
order by Total_revenue desc

--What product line had the largest VAT?--

select Product_line, AVG(tax_5) as largestVAT from WalmartSalesData
group by Product_line
order by largestVAT desc

--Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales--

select AVG(quantity) as avg_quantity from WalmartSalesData

select product_line, AVG(quantity) as avg_quantity, 
    CASE when AVG(quantity) >6 then 'good' else 'bad'
end as remark from WalmartSalesData 
group by product_line

--Which branch sold more products than average product sold?--

select branch,AVG(Quantity) as avg_quantity from WalmartSalesData
group by branch, Quantity
having AVG(quantity) > (select AVG(quantity) from WalmartSalesData)

--What is the most common product line by gender--

select product_line, gender , count(quantity) as sum_quantity from WalmartSalesData
group by product_line,gender
order by sum_quantity desc

--What is the average rating of each product line--

select product_line, AVG(rating) as avg_rating from WalmartSalesData
group by product_line
order by avg_rating desc;

--How many unique customer types does the data have?--

select COUNT(distinct invoice_ID) as unique_customers from WalmartSalesData;

--How many unique payment methods does the data have?--

select distinct payment from WalmartSalesData


--What is the most common customer type?--

select customer_type, COUNT(*) as count from WalmartSalesData
group by customer_type 
order by count desc

--What is the gender of most of the customers?--

select COUNT(invoice_ID) as Customer_count, Gender from WalmartSalesData 
group by gender
order by Customer_count desc

-- What is the gender distribution per branch?

select branch,gender, count(*) as gender_count from WalmartSalesData
group by Gender,branch
order by branch

-- Which time of the day do customers give most ratings?

select * from WalmartSalesData

select time, AVG(rating) as avg_rating from WalmartSalesData
group by time
order by avg_rating desc

-- Which day fo the week has the best avg ratings?

select datename(weekday,date) as dayofweek, avg(rating) as avg_rating from WalmartSalesData
group by datename(weekday,date)
order by avg_rating desc

--Which day of the week has the best average ratings per branch?

select branch,datename(weekday,date) as dayofweek,avg(rating) as avg_rating from WalmartSalesData
group by datename(weekday,date),branch
order by avg_rating desc


