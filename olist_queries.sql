-- PART 1: OVERALL SUMMARY QUERIES
-- Data: Olist Brazilian e-commerce dataset (all monetary values in BRL)
------------------------------------------------------------------------------------------------------------------------------------------------------------

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

;

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PART 2: STATE LEVEL QUERIES

--Category by state

SELECT
c.customer_state, p.product_category_name_english, SUM(oi.price) AS total_revenue

FROM

olist_order_items_dataset oi
JOIN
olist_orders_dataset oo ON oi.order_id = oo.order_id
JOIN
olist_customers_dataset c ON oo.customer_id = c.customer_id
JOIN
olist_products_dataset op ON oi.product_id = op.product_id
JOIN
product_category_name_translation p ON op.product_category_name = p.product_category_name

GROUP BY

c.customer_state, p.product_category_name_english

;

--Payment type by state

SELECT
c.customer_state, p.payment_type, SUM(p.payment_value) AS total_payment_value, CoUNT(P.PAYMENT_TYPE) AS payment_count

FROM
olist_customers_dataset c
JOIN
olist_orders_dataset oo ON c.customer_id = oo.customer_id
JOIN
olist_order_payments_dataset p ON p.order_id = oo.order_id

GROUP BY
c.customer_state, p.payment_type

;

--Delivery time by review score by state

SELECT
c.customer_state, r.review_score, 
	ROUND(SUM(julianday(oo.order_delivered_customer_date) - julianday(order_purchase_timestamp)),1) AS days_to_deliver,
	COUNT(*) AS order_count

FROM
olist_order_reviews_dataset r
JOIN
olist_orders_dataset oo ON r.order_id = oo.order_id
JOIN
olist_customers_dataset c ON oo.customer_id = c.customer_id

WHERE
oo.order_delivered_customer_date IS NOT NULL
GROUP BY
c.customer_state, r.review_score

;







