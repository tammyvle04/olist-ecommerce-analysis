# Olist Commerce Analysis
An analysis of Olist's Brazilian e-commerce data using SQL, Python, Tableau, and Excel.

## Business Problem
- Which product categories generate the most revenue?
  (Shows where demand is concentrated, which helps with inventory and marketing decisions.)
- How do revenue and order volume vary by state?
  (Shows how dependent the business is on particular regions and where growth could come from.)
- How does average payment value differ by payment method?
  (Shows how typical payment size differs by method, which matters for payment partnerships and cash flow planning.)
- Does delivery time affect customer review scores?
  (Delivery speed is something operations can change, so a link to reviews would show where improvement matters most.)

## Data Source
- Brazilian E-Commerce public dataset by Olist via Kaggle.
- Date range of orders: Sept. 2016 - Oct. 2018
- The dataset has 9 tables; 7 were used (all except geolocation and sellers)
- All monetary values are listed in Brazilian Reais (R$).
- Payment method listed as "boleto" is an official Brazilian bank slip payment method; customers pay a barcoded slip at a bank, ATM, or banking app.
- Payment type "voucher" is a prepaid credit (e.g. gift cards, refund balance, store credit); the dataset doesn't define it specifically.
- Revenue means item price only. Freight is not included.

## Approach
- SQL: Loaded the CSVs into SQLite and joined orders, order items, customers, products, payments, reviews, and the category translation table to calculate revenue by category and state, average payment value by payment type, and delivery time by review score. Also built state level versions of these queries to power the dashboard's state filter.
- Python: Merged orders with reviews to calculate delivery time for each individual order (about 96,000 delivered orders), measured its correlation with review score (-0.33), and checked the distribution for outliers.
- Tableau: Built an interactive dashboard with a revenue by state map and charts for category revenue, payment value, and delivery time. Clicking a state filters every chart.
- Excel: Built a pivot table of category revenue with a state filter, an XLOOKUP block that returns orders, revenue, revenue per order, and revenue share for the selected state, and a short summary.

## Key Findings
- Category: the two top categories were health_beauty (R$1,258,681) and watches_gifts (R$1,205,006).
- State: Sao Paulo's revenue (R$5,202,955) accounts for ~38% of the national total of R$13,591,643.
- Payment: credit card had the highest average payment value (R$163), while voucher had the lowest (R$66). Voucher payments are likely smaller because they often cover only part of an order.
- Delivery vs. Reviews: Orders with 1 star reviews took about 21 days to arrive on average, versus about 11 days for 5 star orders (correlation of -0.33 across about 96,000 delivered orders).

## Recommendations
- Treat late deliveries as a review score risk and flag them early. Orders with 1 star reviews took about 21 days to arrive on average, versus about 11 for 5 star orders, and the order level correlation was -0.33. A logistics team could flag orders that run past the typical window and contact those customers proactively. This is a suggestion to test, since the data shows the two move together but not that delays cause the low scores.
- Look at the long tail, not just the average. The median delivery was about 10 days, but the mean was 12.5 and the slowest order took 208 days. A small number of severely delayed orders pulls the average up, so tracking the share of orders over a threshold would be more informative than tracking average delivery time.
- Note the revenue concentration in Sao Paulo. SP generated about 38% of total revenue. That could mean the business depends heavily on one region, or that other states are underserved. The data can't tell which, so the next step would be comparing delivery times and order volume by state.

## Limitations
- Revenue is item price only. Freight is excluded, so these totals aren't total customer spend.
- All values are in Brazilian Reais, unadjusted for inflation or exchange rates.
- Revenue includes all order statuses. Canceled and unavailable orders account for about 0.7% of item revenue, and orders not yet delivered (shipped, processing, etc.) about 2%, so category and state rankings are unaffected. Delivery time analysis covers delivered orders only.
- The review relationship is a correlation. A coefficient of -0.33 is moderate, and reviews also depend on product quality and customer expectations.
- Payment values are per payment record, not per order, so an order paid with a voucher plus a card appears as two payments.
- Averages and rankings for small states rest on very few orders (Acre (AC) has 81), so treat state level views with caution. 

## Links
- Tableau: https://public.tableau.com/app/profile/tammy.le8267/viz/OlistE-CommercePerformanceDashboard_17918469483720/Dashboard1 
- Excel Workbook: Olist_ecommerce_project_2.xlsx
- SQL Queries: olist_queries.sql
- Python: Olist_commerce_analysis.ipynb
