select * from distribution_centers;
select * from events;
select * from inventory_items;
select * from order_items;
select * from orders;
select * from products;
select * from users;

--1. What are the top five most common event types?--

select top 5 event_type,COUNT(id) as id_count from events
group by event_type;

--2. How many unique users have performed events in each state?--

select COUNT(user_id) as Unique_User, state from events 
group by state order by Unique_User desc;

--3. What is the average age of users in each city?
select * from users;

select distinct(city) from users

select AVG(age) as Avg_User_Age, city from users 
group by city;

--4. Which distribution center has the highest number of inventory items, and in which city is it located?

select COUNT(id) as Inventory_items_Count,product_distribution_center_id from inventory_items
group by product_distribution_center_id
order by Inventory_items_Count desc

--5.What is the average cost of each product category?--

select AVG(cost) as Avg_cost, product_category from inventory_items
group by product_category;

--6.How many orders have been placed in each state?--

select COUNT(o.order_id) as Order_counts,u.state from orders o
inner join users u on o.user_id = u.id 
group by u.state
order by Order_counts desc


--7.What is the average number of items per order in each city?

select AVG(o.num_of_item) as Avg_Number_of_items,o.order_id,u.city from orders o
inner join users u on o.user_id = u.id 
group by u.city,o.order_id
order by Avg_Number_of_items desc;

--8.What is the distribution of orders by status in each state?--

SELECT u.state,
       COUNT(o.order_id) AS num_orders,
       COUNT(CASE WHEN o.status = 'Complete' THEN o.order_id END) AS Complete_Count,
       COUNT(CASE WHEN o.status = 'Returned' THEN o.order_id END) AS Returned_Count,
       COUNT(CASE WHEN o.status = 'Processing' THEN o.order_id END) AS Processing_Count,
       COUNT(CASE WHEN o.status = 'Cancelled' THEN o.order_id END) AS Cancelled_Count,
       COUNT(CASE WHEN o.status = 'Shipped' THEN o.order_id END) AS Shipped_Count
FROM orders o
JOIN users u ON o.user_id = u.id
GROUP BY u.state
ORDER BY num_orders desc;

--9.Which product category has the highest average retail price?--

select category,round(AVG(retail_price),2) as Avg_Retail_Price from products
group by category
order by Avg_Retail_Price desc

--10.How many orders have been returned in each city?--

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'orders'


SELECT e.city, COUNT(CAST(oi.order_id AS decimal)) AS Order_Count
FROM events e
JOIN order_items oi ON e.user_id = oi.user_id
JOIN orders o ON oi.order_id = o.order_id
WHERE oi.status = 'Returned'
GROUP BY e.city;


--11.What is the average age of users who returned orders in each state?--

SELECT e.state, AVG(u.age) AS avg_age,COUNT(TRY_CAST(u.id AS int))
FROM users u
JOIN order_items oi ON TRY_CAST(u.id AS int) = TRY_CAST(oi.user_id AS int)
JOIN events e ON TRY_CAST(oi.user_id AS int) = TRY_CAST(e.user_id AS int)
WHERE oi.status = 'Returned'
GROUP BY e.state;

--12.Which browser is most commonly used by users in each city?--

select distinct browser from events

select city,
       COUNT(CASE WHEN browser = 'Chrome' THEN user_id END) AS Chrome_Count,
	   COUNT(CASE WHEN browser = 'Safari' THEN user_id END) AS Safari_Count,
	   COUNT(CASE WHEN browser = 'IE' THEN user_id END) AS IE_Count,
	   COUNT(CASE WHEN browser = 'Firefox' THEN user_id END) AS Firefox_Count,
	   COUNT(CASE WHEN browser = 'Other' THEN user_id END) AS Other_Count,
	   COUNT(CASE WHEN browser = browser THEN user_id END) AS Total_Count
from events
group by city,browser
order by Total_Count desc;

--13.What are the top traffic sources leading to events in each state?--

select distinct traffic_source from events

select state,
       COUNT(CASE WHEN traffic_source = 'Organic' THEN user_id END) AS Organic_Count,
	   COUNT(CASE WHEN traffic_source = 'Email' THEN user_id END) AS Email_Count,
	   COUNT(CASE WHEN traffic_source = 'Adwords' THEN user_id END) AS Adwords_Count,
	   COUNT(CASE WHEN traffic_source = 'YouTube' THEN user_id END) AS YouTube_Count,
	   COUNT(CASE WHEN traffic_source = 'Facebook' THEN user_id END) AS Facebook_Count,
	   COUNT(CASE WHEN traffic_source = traffic_source THEN user_id END) AS Total_Count
from events
group by traffic_source,state
order by Total_Count desc;

--14.How many orders were shipped to each distribution center?--

select p.distribution_center_id,count(o.shipped_at) as shipped_Count from products p
join order_items oi on p.id=oi.product_id
join orders o on oi.order_id=o.order_id
group by p.distribution_center_id
order by shipped_Count;

--15.What is the distribution of orders by gender in each city?--

select u.city,
    COUNT(CASE WHEN u.gender ='F' then order_id end) As Female_Count,
	COUNT(CASE WHEN u.gender ='M' then order_id end) As Male_Count,
	COUNT(CASE WHEN u.gender =u.gender then order_id end) As Total_Count
from users u
join orders o on u.id=o.user_id
group by u.city
having u.city !='null'
order by Total_Count desc

--16.How many orders were placed in each product category, 
-- and what is the average number of items per order in each category?

select ii.product_category,count(o.order_id)as Order_Counts,Avg(o.num_of_item) as Num_of_Items from inventory_items ii
join order_items oi on ii.product_id=oi.product_id
join orders o on oi.order_id = o.order_id
group by product_category
order by Order_Counts desc

--17.What is the average number of events per session in each state?--

select count(session_id) as Sessions_Counts, state from events
group by state

--18.What is the average time between order delivery and return in each state?--


SELECT 
    delivered_at,
    returned_at,
    DATEDIFF(DAY, delivered_at, returned_at) AS avg_between_time
FROM 
    order_items
WHERE 
    delivered_at IS NOT NULL
    AND returned_at IS NOT NULL
order by 
    avg_between_time desc;

--19.How many users were acquired from each traffic source in each city?--

select COUNT(user_id) as Acquired_Users,city,
       COUNT(CASE WHEN traffic_source = 'Organic' THEN user_id END) AS Organic_Count,
	   COUNT(CASE WHEN traffic_source = 'Email' THEN user_id END) AS Email_Count,
	   COUNT(CASE WHEN traffic_source = 'Adwords' THEN user_id END) AS Adwords_Count,
	   COUNT(CASE WHEN traffic_source = 'YouTube' THEN user_id END) AS YouTube_Count,
	   COUNT(CASE WHEN traffic_source = 'Facebook' THEN user_id END) AS Facebook_Count,
	   COUNT(CASE WHEN traffic_source = traffic_source THEN user_id END) AS Total_Count
from events
where city is not null and city !='null'
group by city
order by Total_Count desc

--20.What is the distribution of users by age group in each state?--

select state,
       COUNT(CASE WHEN age < 35 THEN id END) as Teenager_user_count,
	   COUNT(CASE WHEN age > 35 and age <50 THEN id END) as Adult_User_count,
	   COUNT(CASE WHEN age > 50 THEN id END) as Citizens_User_count,
	   count(id) as User_count
from users
group by state
order by User_count desc;

--21.Which distribution center has the highest average shipping time for orders?--

select top 1 ii.product_distribution_center_id,dc.name,AVG(DATEDIFF(Hour,oi.created_at,oi.shipped_at)) AS average_shipped_time,
Count(oi.order_id) as Orders_Count from inventory_items ii
join order_items oi on ii.product_id=oi.product_id
join distribution_centers dc on dc.id=ii.product_distribution_center_id
group by ii.product_distribution_center_id,dc.name
order by average_shipped_time desc

--22.Identify users who have placed orders from multiple states and list their details.--

SELECT
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(DISTINCT u.state) AS num_states_ordered_from
FROM
    users u
JOIN
    events e ON TRY_CAST(u.id as int) = TRY_CAST(e.user_id AS int)
GROUP BY
    u.id, u.first_name, u.last_name, u.email
HAVING
    COUNT(DISTINCT u.state) > 1;

--23.Identify users who have made multiple purchases within a short time frame 
--(e.g., within 24 hours) and list their details.

select u.id,u.first_name,u.last_name,u.email,o.user_id,Count(o.order_id) as order_count,DATEDIFF(Hour,o.created_at,o.shipped_at) As Order_time
from users u join orders o on u.id=o.user_id
where o.created_at is not null and o.shipped_at is not null
group by u.id,o.created_at,o.shipped_at,u.first_name,u.last_name,u.email,o.user_id,o.order_id
having DATEDIFF(Hour,o.created_at,o.shipped_at) < 24
order by order_count desc

--24.Determine the average customer lifetime value (CLV) for users acquired from different traffic sources.

WITH UserRevenue AS (
    SELECT
        u.id AS user_id,
        u.traffic_source,
        SUM(ii.product_retail_price) AS total_revenue
    FROM
        users u
    INNER JOIN
        orders o ON u.id = o.user_id
    INNER JOIN
        order_items oi ON o.order_id = oi.order_id
	Inner JOIN
	    inventory_items ii on ii.product_id=oi.product_id
    GROUP BY
        u.id,
        u.traffic_source
),
UserOrders AS (
    SELECT
        u.id AS user_id,
        u.traffic_source,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM
        users u
    LEFT JOIN
        orders o ON u.id = o.user_id
    GROUP BY
        u.id,
        u.traffic_source
)
SELECT
    ur.traffic_source,
    AVG(ur.total_revenue / uo.total_orders) AS avg_order_value,
    -- Assuming an average customer lifespan of 12 months
    12 AS avg_customer_lifespan_months,
    AVG(ur.total_revenue / uo.total_orders) * 12 AS avg_clv
FROM
    UserRevenue ur
INNER JOIN
    UserOrders uo ON ur.user_id = uo.user_id
GROUP BY
    ur.traffic_source;

--Revenue Calculation--

select 
    ii.product_category,
	SUM(ii.product_retail_price*o.num_of_item) As Total_Revenue 
from 
    inventory_items ii
join 
    order_items oi on ii.product_id=oi.product_id
join 
    orders o on o.order_id= oi.order_id
group by 
    ii.product_category;

--25.Calculate the average order value (AOV) for each product category.--

select 
     ii.product_category,
	 SUM(ii.product_retail_price*o.num_of_item) As Total_Revenue,
     SUM(ii.product_retail_price*o.num_of_item)/Count(oi.order_id) as AOV
from 
     inventory_items ii
join 
     order_items oi on ii.product_id=oi.product_id
join 
     orders o on o.order_id= oi.order_id
group by 
     ii.product_category;

--26.Calculate the customer acquisition cost (CAC) for users acquired from different traffic sources.--

--Here, Considering Marketing Expences as per Insustry Standard

select COUNT(distinct user_id) as Aquired_Users,
       SUM(CASE when traffic_source ='Adwords' Then 2500 else 0 End) as Adwords_Marketing_Expences,
	   SUM(CASE when traffic_source ='Facebook' Then 1500 else 0 End) as Facebook_Marketing_Expences,
	   SUM(CASE when traffic_source ='YouTube' Then 1500 else 0 End) as YouTube_Marketing_Expences,
	   SUM(CASE when traffic_source ='Organic' Then 100 else 0 End) as Organic_Marketing_Expences,
	   SUM(CASE when traffic_source ='Email' Then 1200 else 0 End) as Email_Marketing_Expences,
	   (SUM(CASE when traffic_source ='Adwords' Then 2500 else 0 End) +
	    SUM(CASE when traffic_source ='Facebook' Then 1500 else 0 End) +
		SUM(CASE when traffic_source ='YouTube' Then 1500 else 0 End)  + 
		SUM(CASE when traffic_source ='Organic' Then 100 else 0 End) +
	   SUM(CASE when traffic_source ='Email' Then 1200 else 0 End))/NULLIF(COUNT(distinct user_id),0) as CAC
from 
    events
WHERE 
    traffic_source IS NOT NULL
group by 
    traffic_source;


--27.Implement a market basket analysis to identify frequently co-occurring products in orders.

-- Step 1: Count the occurrences of each pair of products in the same order
WITH OrderPairs AS (
    SELECT oi1.product_id AS product1_id,
           oi2.product_id AS product2_id,
           COUNT(*) AS pair_count
    FROM order_items oi1
    JOIN order_items oi2 ON oi1.order_id = oi2.order_id
                          AND oi1.product_id < oi2.product_id -- Avoid counting pairs twice
    GROUP BY oi1.product_id, oi2.product_id
),
RankedPairs AS (
    SELECT *,
           RANK() OVER (ORDER BY pair_count DESC) AS pair_rank
    FROM OrderPairs
)
SELECT rp.product1_id,
       p1.name AS product1_name,
       rp.product2_id,
       p2.name AS product2_name,
       rp.pair_count
FROM RankedPairs rp
JOIN products p1 ON rp.product1_id = p1.id
JOIN products p2 ON rp.product2_id = p2.id
WHERE rp.pair_rank <= 10;

-- 28.Calculate the average profit margin for each product category--

SELECT
    category,
    Round(AVG((retail_price - cost) / retail_price * 100),2) AS profit_margin
FROM 
    products
GROUP BY 
    category
order by
    profit_margin desc;

--THANK YOU--


