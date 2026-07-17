USE olist_marketing_analysis;

-- ============================================================
-- Olist Marketing Analysis
-- Business SQL Analysis Queries
-- ============================================================

-- ============================================================
-- Question 1
-- Which business segments generated the highest number of closed deals?
-- ============================================================

SELECT
    business_segment,
    COUNT(*) AS total_closed_deals
FROM closed_deals
GROUP BY business_segment
ORDER BY total_closed_deals DESC;


-- ============================================================
-- Question 2
-- Which lead acquisition channels generated the highest number
-- of qualified leads?
-- ============================================================

SELECT
    origin,
    COUNT(*) AS total_qualified_leads
FROM marketing_qualified_leads
GROUP BY origin
ORDER BY total_qualified_leads DESC;


-- ============================================================
-- Question 3
-- Which business types generated the highest declared
-- monthly revenue?
-- ============================================================

SELECT
    business_type,
    ROUND(SUM(declared_monthly_revenue),2) AS total_revenue
FROM closed_deals
GROUP BY business_type
ORDER BY total_revenue DESC;


-- ============================================================
-- Question 4
-- Calculate the average monthly revenue generated
-- by each business segment.
-- ============================================================

SELECT
    business_segment,
    ROUND(AVG(declared_monthly_revenue),2) AS average_monthly_revenue
FROM closed_deals
GROUP BY business_segment
ORDER BY average_monthly_revenue DESC;


-- ============================================================
-- Question 5
-- Which lead acquisition channels resulted in the highest
-- number of successfully closed deals?
-- ============================================================

SELECT
    m.origin,
    COUNT(c.mql_id) AS total_closed_deals
FROM marketing_qualified_leads AS m
INNER JOIN closed_deals AS c
ON m.mql_id = c.mql_id
GROUP BY m.origin
ORDER BY total_closed_deals DESC;


-- ============================================================
-- Question 6
-- Identify business segments whose average monthly revenue
-- is higher than the overall average monthly revenue.
-- ============================================================

SELECT
    business_segment,
    ROUND(AVG(declared_monthly_revenue),2) AS average_revenue
FROM closed_deals
GROUP BY business_segment
HAVING AVG(declared_monthly_revenue) >
(
    SELECT AVG(declared_monthly_revenue)
    FROM closed_deals
)
ORDER BY average_revenue DESC;


-- ============================================================
-- Question 7
-- Rank business segments based on their total declared
-- monthly revenue.
-- ============================================================

SELECT
    business_segment,
    ROUND(SUM(declared_monthly_revenue),2) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(declared_monthly_revenue) DESC
    ) AS revenue_rank
FROM closed_deals
GROUP BY business_segment
ORDER BY revenue_rank;


-- ============================================================
-- Question 8
-- Compare lead acquisition channels by the number of
-- closed deals and the revenue they generated.
-- ============================================================

SELECT
    m.origin,
    COUNT(c.mql_id) AS total_closed_deals,
    ROUND(SUM(c.declared_monthly_revenue),2) AS total_revenue,
    ROUND(AVG(c.declared_monthly_revenue),2) AS average_revenue
FROM marketing_qualified_leads AS m
INNER JOIN closed_deals AS c
ON m.mql_id = c.mql_id
GROUP BY m.origin
ORDER BY total_revenue DESC;