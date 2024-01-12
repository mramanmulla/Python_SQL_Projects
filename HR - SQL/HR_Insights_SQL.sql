select * from HR;

-- What is the gender breakdown of employees in the company? --

select count(id) As Gender_count,gender from HR group by gender;

-- List the employees who were hired after '2020-01-01' in descending order of their hire dates --

select * from HR;

select id,first_name,last_name, hire_date from HR where hire_date > '2020-01-01';

-- Find the unique job titles available in the HR table --

select distinct jobtitle from HR;

-- Retrieve the employees who were terminated between '2022-01-01' and '2023-01-01' --

select id,concat(first_name,' ',last_name)as Full_Name,termdate from HR
where termdate between '2022-01-01' and '2023-01-01';

-- Provide a count of employees for each location state --

select COUNT(id) as Count_of_Emp,location_state from HR 
group by location_state
order by Count_of_Emp desc

-- Create a query to display the first and last names, along with their department names, for all employees. --

select first_name,last_name,concat(first_name,' ',last_name)as Full_Name, department from HR;

-- Calculate the average tenure (in years) of employees in each department -- 

select department, AVG(DATEDIFF(YEAR,hire_date,GETDATE())) as average_tenure_years from HR
group by department;
       

-- Find the total number of male and female employees in each location city -- 
select * from HR

select location_city,
       SUM(case when gender = 'Male' then 1 else 0 end) As Male_Count,
	   SUM(case when gender = 'Female' then 1 else 0 end) As Female_Count
from HR
group by location_city