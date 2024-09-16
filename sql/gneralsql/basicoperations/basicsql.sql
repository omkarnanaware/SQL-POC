--Global aggrigate functions

select count(*) from categories c;
select count(*) from customers c ;
select count(*) from departments d ;
select count(*) from order_items oi ;
select count(*) from orders o ;
select count(*) from products p ; 


select distinct order_status from orders;


--This will not work
select upper(distinct(product_name) from products p ;

--The reason for this issue is how SQL handles function calls and the DISTINCT keyword.
--
--DISTINCT works by eliminating duplicate rows from the result set. It applies at the row level, meaning it considers the full row when determining duplicates.
--
--UPPER() is a function that transforms text into uppercase, and it applies to a specific column or expression.
--
--If you write UPPER(DISTINCT product_name), SQL doesn't know how to handle the DISTINCT keyword in that context because DISTINCT applies to the entire result set or the specified column(s), not individual function calls.
--
--Thus, the query should first transform the values using UPPER() and then apply DISTINCT on the result of that transformation. That's why the correct way to write the query is:


-- This query will work
select count(distinct(upper(product_name))) from products p ;



--Filter condition 




-- Q.I want to count number of orders having status COMPLETE and ON_HOLD

--get the records form order_staus COMPLETE
select * from orders where order_status = 'COMPLETE';

--count the rows
select count(*) from orders where order_status = 'COMPLETE';


-- Q.Counting togeher for status COMPLETE and ON_HOLD

select * from orders where order_status = 'COMPLETE' or order_status = 'ON_HOLD' ;

select count(*) from orders where order_status = 'COMPLETE' or order_status = 'ON_HOLD' ;


-- We can write the query as below for better reading and when trying to add more filter condition on order_status this will reduce the code
select count(*) from orders where order_status in ('COMPLETE','ON_HOLD')


-- Q. Get the count of orders for all the order_status

select order_status,count(*) as records_number from orders 
group by order_status;

select *  from orders 
group by order_status;
--This query will not work

--SQL Error [42803]: ERROR: column "orders.order_id" must appear in the GROUP BY clause or be used in an aggregate function

--Columns present in the group by must be present in the select 
--We can use other columns which are not part of the group by in agg function in select clause


select order_status,count(*) as records_number from orders 
group by order_status;

select order_status,count(*) as records_number from orders 
group by 1
order by 2 desc;

--select order_customer_id,order_status,count(*) from orders group by order_customer_id,order_status having max(count(order_status));


-- Q count number of records by date and show in descencing order

select order_date,count(*) from orders 
group by order_date
order by count(order_date) desc

-- Q count number of records by month and show in descencing order

select to_char(order_date,'yyy-MM') as order_month,count(*) from orders
group by order_month
order by count(*) desc;

select to_char(order_date,'yyy-MM') as order_month,count(*) from orders
group by to_char(order_date,'yyy-MM')
order by count(*) desc;


select to_char(order_date,'yyy-MM') as order_month,count(*) from orders
group by order_month
order by order_month;

--to_char(order_date, 'yyy-MM') AS order_month creates an alias called order_month for the result of the to_char function, which formats order_date as YYYY-MM.
--You’re grouping by order_month, which is the alias.
--You're ordering by COUNT(*), the count of rows per order_month, in descending order.
--Why GROUP BY order_month Works:
--The GROUP BY clause can work with the alias order_month because by the time the GROUP BY is processed, the alias has already been created by the SELECT statement. In SQL, aliasing in the SELECT clause is allowed in the GROUP BY because SQL recognizes that the alias refers to the result of the function (to_char(order_date, 'yyy-MM')).
--
--Why ORDER BY order_month May Fail:
--In many SQL implementations (such as PostgreSQL), the ORDER BY clause is processed after the SELECT clause, which means that aliasing should work there too. However, some SQL engines may enforce a stricter rule where the ORDER BY must directly reference either:
--
--A column from the underlying table, or
--The full expression (not the alias).
--In this case, the alias order_month refers to an expression (to_char(order_date, 'yyy-MM')). Therefore, the engine may fail to recognize the alias and require you to use the full expression instead.


-- Q. in table order_items find the aggrigated sum of subtotal by order_item_order_id

select order_item_order_id,sum(order_item_subtotal) from order_items oi 
group by order_item_order_id 
order by order_item_order_id ;


--Round up the value to the decimal number

select order_item_order_id,round(sum(order_item_subtotal)) from order_items oi 
group by order_item_order_id 
order by order_item_order_id ;

-- To round the value to 2 decimal digit we need to cast the column value to numeric

select order_item_order_id,round(sum(order_item_subtotal)::numeric,2) as ordered_revenue from order_items oi 
group by order_item_order_id 
order by order_item_order_id ;

select order_item_order_id,round(sum(order_item_subtotal)::numeric,2) as ordered_revenue from order_items oi 
group by order_item_order_id 
order by ordered_revenue desc;


--ORDER OF WRITING QUERY

select 
from 
where
group by
having
order by 


-- ORDER OF EXECUTION

from
where 
group by 
having
select
order by

--Let's understand how the query is typically executed.
--First, the query which is written using select from where Group by Order by ET Cetera will be compiled
--into low level code.
--Then the low level code will be executed to process the data as per the logic in the query, the data
--from the table will be read into the memory of the server in which database is running.
--Then it will start processing the data.
--So when it comes to order of execution, it will start with the from clause as part of from clause.
--We will have table or view or sub query, whatever we have.
--Based on that, the data will be read from tables into the memory.
--Once data is read from tables into the memory, then it will apply the conditions in where clause.
--If the table have thousand rows, all the thousand rows will be read into the memory.
--Once all the thousand rows are read into the memory, then based on the conditions in where clause the
--data will be filtered and intermediate results will be staged again in memory.
--For example, if where condition written three records, though the three records will be placed in
--memory or if where condition written 100 records out of 1000, those 100 records again will be stored
--in the memory.
--So whatever data that is filtered will be made available to us in memory after where clause it will
--execute whatever is there in group by typically as part of group by, we specify the keys on which the
--data is supposed to be grouped in the select clause.
--Also, we specify those columns and also we might have aggregate functions in select clause along with
--executing the logic in a group by it will also take care of executing whatever is there in select clause.
--Both will be executed simultaneously because many times there will be dependency between the two.
--So after group by it will typically execute third clause or it can execute select clause at the same
--time.
--Then finally it will sort the data again after grouping the data by the key and performing the aggregation,
--we'll get some output.
--That output will be preserved in the memory.
--That output will be sorted because of order by.
--So finally order by will be executed.
--Then it will return the results as per the logic.
--This is how the query will be executed.


---------------------------------------------------------------------------------------------------------

--RULES AND RESTRICTIONS TO GROUP BY AND FILTER DATA IN SQL QUERIES

---------------------------------------------------------------------------------------------------------

--Now because of this order, there are few restrictions when it comes to writing queries.
--Also on top of it, when we use group by, we have to follow certain rules.
--Only then the queries will be executed.
--
--First, let me talk about the rules related to group by and then I will also talk about restrictions
--because of the order of the execution.
--When it comes to group by, we are supposed to specify the key based on which data is supposed to be
--grouped.
--Either we use the column name or only those functions which are non aggregation in nature.
--You cannot use aggregate functions as part of group by because it doesn't make sense to group the data
--by some of something.
--
--We typically group the data by date or month, which is typically derived from date using year and month
--or year, something like that.
--We typically don't group the data by using aggregated functions as keys, hence as part of group by,
--we typically use column names such as order, date, order, status, etcetera or derived fields using
--non aggregate functions.
--
--If you try to add aggregate functions such as count sum, et cetera, it will just fail.
--You cannot use aggregate functions as part of group by even in where clause you will not be able to
--filter the data using aggregate functions.
--It is not possible.
--
--It will just throw exception saying that you are trying to use aggregate function which is not allowed

--One of the key restriction, which is quite confusing, is using the aliases as part of where clause
--because order of execution is from where group by and then select whatever aliases you are using here
--you will not be able to use as part of where clause.
--However, there is an exception in case if you say order date as order date, in this case you are using
--same column name as the alias for whatever reason.
--You should be able to use that in where clause.
--But if you use the aliases which doesn't match any column name, then you will not be able to use that
--alias.
--The reason why it will work for order date is because as part of orders, we already have ordered it.
--First.
--It will execute whatever is there as part of from clause.
--Then it will go to where clause because orders have ordered it.
--When we use order date as part of where it actually use the column name, not the alias.
--But when it comes to order underscore count as orders doesn't have when you try to use the order underscore
--count as part of where clause, it will just throw an error.


--You see it is saying order underscore count doesn't exist because it will execute the from clause first
--and then it will go to the where clause by the time it go to the where clause, we only have the raw
--data from orders.
--We don't have the aggregated result with this alias and hence it is failing.
--Then some people might get tempted to use aggregate function as part of where clause itself.
--Already I have explained that this will not work.
--You cannot use aggregate functions as part of where clause to filter the data.
--It will throw different error.


-- Q find the order_id which having orderde revenue more havn 2000

select order_item_order_id,sum(order_item_subtotal) as orderd_revenue from order_items oi 
group by order_item_order_id
	having sum(order_item_subtotal) > 2000;

-- Having will always comes with the group by not seprately 
-- Having is used to perform conditional operations on the aggregated fucntion
-- we cannot use alias in having we must use the full operation eg. having sum(order_item_subtotal) > 2000;





