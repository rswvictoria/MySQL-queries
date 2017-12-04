use foodmart
#B1.What are the total sales of “Potato Chips” including the quantity sold and 
#sales by store?(Sort the results by Total Sales)
select sales_fact.store_id,sum(store_sales) as TotalSales,sum(unit_sales) from sales_fact
join product on sales_fact.product_id = product.product_id
where product_name like '%potato chip%'
group by sales_fact.store_id
order by TotalSales desc;
#B2. What are total sales of all products, per month, for all stores? 
#(Sort the results by Month)
select the_month,sum(store_sales) as TotalSales from sales_fact
join time_by_day on sales_fact.time_id = time_by_day.time_id
group by the_month
order by month(the_date);
#B3. What are total sales of all products, per month, for all stores in 
#California? (Sort the results by Total Sales)
select the_month,sum(store_sales) as TotalSales from sales_fact
join time_by_day on sales_fact.time_id = time_by_day.time_id
join store on sales_fact.store_id = store.store_id
where store_state = 'CA'
group by the_month
order by TotalSales desc;
#B4. What are the total sales of each store, by region? (Sort the results by 
#Total Sales)
select sales_fact.store_id,sum(store_sales), sales_region from sales_fact
join store on sales_fact.store_id = store.store_id
join region on store.region_id = region.region_id
group by store_id
order by sum(store_sales) desc;
#B5. Which product category sells the most?(Hint: there can only be one answer 
#submitted and the query must show this)
select product_category, sum(store_sales) from sales_fact 
join product on sales_fact.product_id = product.product_id
join product_class on product.product_class_id = product_class.product_class_id
group by product_category
having sum(store_sales) >= all (select sum(store_sales) from sales_fact 
join product on sales_fact.product_id = product.product_id
join product_class on product.product_class_id = product_class.product_class_id
group by product_category);
#B6. Which days of the week do customers prefer to go shopping? (Sort the 
#results by Total Sales) (Hint: for this query, you will need to use the 
#Dayname function)
select dayname(the_date),sum(store_sales) from sales_fact
join time_by_day on sales_fact.time_id = time_by_day.time_id
group by dayname(the_date)
order by sum(store_sales) desc;