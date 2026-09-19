--Translated product name and total revenue

SELECT
t.product_category_name_english, SUM(oi.price) AS total_revenue

FROM
olist_order_items_dataset oi

JOIN 
olist_products_dataset p ON oi.product_id = p.product_id
JOIN
product_category_name_translation t ON p.product_category_name = t.product_category_name

GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC

;

--Revenue and orders by state

SELECT
c.customer_state, COUNT(DISTINCT o.order_id) AS order_count, SUM(oi.price) AS total_revenue

FROM
olist_customers_dataset c

JOIN
olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN
olist_order_items_dataset oi ON oi.order_id = o.order_id

GROUP BY c.customer_state
ORDER BY total_revenue DESC

;

--Average order value by payment type

SELECT
ROUND(avg(payment_value),2) AS avg_order_value, payment_type
FROM
olist_order_payments_dataset

GROUP BY
payment_type

ORDER BY 
avg_order_value DESC

;

--Delivery time vs. review score

SELECT
 ROUND(AVG(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)), 1) AS Days_to_Deliver,  review_score

FROM
olist_orders_dataset o

JOIN
olist_order_reviews_dataset r on r.order_id = o.order_id

WHERE
order_delivered_customer_date IS NOT NULL
GROUP BY
review_score
ORDER BY
review_score ASC








</sql><current_tab id="0"/></tab_sql></sqlb_project>
