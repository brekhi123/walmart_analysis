-- EDA
SELECT * FROM walmart;

SELECT COUNT(*) FROM walmart;

SELECT
    payment_method,
    COUNT(*)
FROM walmart
GROUP BY payment_method;


SELECT
    COUNT(DISTINCT Branch)
FROM walmart;


SELECT MAX(quantity) FROM walmart;

-- Business Problems

-- 1. Identify the highest-rated category in each branch, displaying the branch, category, and the average rating

SELECT *
FROM
(
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY 1, 2
)
WHERE rank = 1;

-- 2.  Busiest day for each branch based on their number of transactions
SELECT *
FROM
(
SELECT 
    branch,
    TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name,
    COUNT(*) AS transactions,
    RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
FROM walmart
GROUP BY 1, 2
)
WHERE rank = 1;

-- 3. Finding the total quantity of items sold per payment method. List payment_method and total_quantity

SELECT
    payment_method,
    SUM(quantity) AS total_quantity
FROM walmart
GROUP BY payment_method;

-- 4. Determine the average , minimum, maximum ratings of categories for each city and list the city, average rating, min rating and max rating

SELECT
    city,
    category,
    AVG(rating) AS avg_rating,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating

FROM walmart
GROUP BY 1,2
ORDER BY 1, 2;

-- 5. Calculate the total price for each category
SELECT
    category,
    SUM(total) AS revenue_total,
    SUM(total * profit_margin) AS profit_total
FROM walmart
GROUP BY 1
ORDER BY 2;

-- 6. Most common payment method for each branch. Display branch and tehe preferred_payment_method
SELECT
    branch,
    preferred_payment_method
FROM 
(
SELECT
    branch,
    payment_method AS preferred_payment_method,
    COUNT(payment_method),
    RANK() OVER (PARTITION BY branch ORDER BY COUNT(payment_method) DESC)
FROM walmart
GROUP BY branch, payment_method
ORDER BY 1,3 DESC
)
WHERE rank = 1;

-- 7. Categorizing sales into three distinct groups Morning, Afternoon and Evening
-- Find out number of invoices in each day_time


SELECT
branch,
CASE 
    WHEN EXTRACT (HOUR FROM(time::TIME)) < 12 THEN 'Morning'
    WHEN EXTRACT (HOUR FROM(time::TIME)) BETWEEN 12 and 17 THEN 'Afternoon'
    ELSE 'Evening'
END day_time,
COUNT(*)
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC;


-- 8. Identifying 5 branches w/ highest degree ratio in revenue compared to the last year
-- rdr = last_year_rev - cr_rev/last_year_rev * 100

-- 2022 sales
WITH revenue_2022
AS
(
SELECT 
    branch,
    SUM(total) AS revenue
FROM walmart
WHERE 
EXTRACT (YEAR FROM(TO_DATE(date, 'DD/MM/YY'))) = 2022
GROUP BY 1
),

-- 2023 sales
revenue_2023 AS
(
SELECT 
    branch,
    SUM(total) AS revenue
FROM walmart
WHERE 
EXTRACT (YEAR FROM(TO_DATE(date, 'DD/MM/YY'))) = 2023
GROUP BY 1
)
SELECT
    last_year.branch,
    last_year.revenue AS last_year_rev,
    current_year.revenue AS current_year_rev,
    ROUND(
        (last_year.revenue  - current_year.revenue)::numeric/last_year.revenue::numeric * 100, 2) AS rev_decrease_ratio
FROM revenue_2022 AS last_year
JOIN
revenue_2023 AS current_year
ON last_year.branch = current_year.branch
WHERE last_year.revenue > current_year.revenue
ORDER BY 4 DESC
LIMIT 5;

