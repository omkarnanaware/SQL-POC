--JOINS


--INNER JOIN

--Q Write a query for getting aggreated sum of order order_item_subtotal for order ids

select o.order_id , sum(oi.order_item_subtotal)
	from order_items oi
	inner join orders o
	on  oi.order_item_order_id = o.order_id
	where o.order_status in ('COMPLETE')
	group by o.order_id


-- Q select order id which are not present in the order item order id

	select o.order_id,
	from order_items oi
	inner join orders o
	on  oi.order_item_order_id != o.order_id



	select o.*,oi.order_item_product_id from orders o
	left join order_items oi
	on o.order_id = oi.order_item_order_id
	and to_char(o.order_date::timestamp,'yyyy-MM') = '2013-01'


	-- VIEW

	-- The views are just select queries
	-- We use views to modularize the sql code
	-- Defination of view is stored in database
	--So we can use view when ever we want


	create or replace view  orderandorderitemsjoinview as
	select o.*,oi.order_item_product_id,oi.order_item_subtotal from orders o
	left join order_items oi
	on o.order_id = oi.order_item_order_id;



	select * from orderandorderitemsjoin where order_id=2;


 ---CTE comman table expression
   with orderandorderitemsjoincte as
   (select o.*,oi.order_item_product_id,oi.order_item_subtotal from orders o
	left join order_items oi
	on o.order_id = oi.order_item_order_id)
	select * from orderandorderitemsjoincte;


	select count(*) from orders o
	left outer join order_items oi
	on o.order_id = oi.order_item_order_id
	where oi.order_item_product_id is null;

-- Q get the products which are unsolde in Jan 2014

--This query will not work as we have added the filtering condition of order_date in where condition and for the unsold product the order_Date will be null
--where odv.order_item_product_id is null and to_char(odv.order_date::timestamp,'yyyy-MM')='2014-01';
--Above both conditions will never satisfy as order_Date will be null for not ordered products
select count(*) from products p
	left outer join orderandorderitemsjoinview odv
	on p.product_id = odv.order_item_product_id
	where odv.order_item_product_id is null
and to_char(odv.order_date::timestamp,'yyyy-MM')='2014-01';


--So we have to add that condtion in the join condtion
select count(*) from products p
	left outer join orderandorderitemsjoinview odv
	on p.product_id = odv.order_item_product_id
	and to_char(odv.order_date::timestamp,'yyyy-MM')='2014-01'
	where odv.order_item_product_id is null;





