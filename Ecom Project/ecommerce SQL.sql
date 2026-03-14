use ecommerce_olist;

-- KPI1
select weekdays, sum(payment_value) as payment
from olist_orders 
inner join olist_order_payments
on olist_orders.order_id=olist_order_payments.order_id
group by weekdays;

-- KPI2
select r.review_score,payment_type,count(distinct r.order_id) as orders from olist_order_payments p
inner join olist_order_reviews r
on p.order_id=r.order_id
where r.review_score=5 and p.payment_type="credit_card";

-- KPI3
select customer_city,avg(order_delivered_customer_date) as days from olist_orders
inner join olist_customers 
on olist_orders.customer_id = olist_customers.customer_id
where customer_city = "sao paulo";

-- KPI4
SELECT
    c.customer_city,
    ROUND(AVG(oi.price), 2) AS average_price,
    ROUND(AVG(op.payment_value), 2) AS average_payment_value
FROM
    olist_customers c
JOIN
    olist_orders o ON c.customer_id = o.customer_id
JOIN
    olist_order_items oi ON o.order_id = oi.order_id
JOIN
    olist_order_payments op ON o.order_id = op.order_id
WHERE
    LOWER(c.customer_city) = 'sao paulo'
GROUP BY
    c.customer_city;

-- KPI5 
 select review_score, count('shipping days') from olist_order_reviews
inner join olist_orders
on olist_order_reviews.order_id=olist_orders.order_id
group by review_score;
  
 -- KPI6
select review_score, count('shipping days') from olist_order_reviews
inner join olist_orders
on olist_order_reviews.order_id=olist_orders.order_id
group by review_score;

-- KPI7
 select i.product_category,count(distinct o.order_id) as orders from olist_orders o
 join olist_order_items i
 on o.order_id = i.order_id
 group by i.product_category
 order by i.product_category asc limit 10;
 








