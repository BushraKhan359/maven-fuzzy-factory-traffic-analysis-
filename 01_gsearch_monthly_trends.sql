-- ============================================================
-- Q1: Monthly Trend for Gsearch Sessions and Orders
-- ------------------------------------------------------------
-- Business Question:
--   Can you pull overall session and order volume for Gsearch,
--   trended by month, so we can see if the paid campaigns are
--   growing?
-- ------------------------------------------------------------
-- Tables Used : website_sessions, orders
-- Filter      : utm_source = 'gsearch'
-- ============================================================

USE mavenfuzzyfactory;

SELECT 
    YEAR(ws.created_at)  AS year,
    MONTH(ws.created_at) AS month,
    COUNT(DISTINCT ws.website_session_id)                        AS sessions,
    COUNT(DISTINCT o.order_id)                                   AS orders,
    COUNT(DISTINCT o.order_id)
        / COUNT(DISTINCT ws.website_session_id) * 100           AS conversion_rate
FROM website_sessions ws
    LEFT JOIN orders o USING (website_session_id)
WHERE ws.utm_source = 'gsearch'
GROUP BY 1, 2;

-- ------------------------------------------------------------
-- Finding:
--   Gsearch sessions and orders grew steadily month over month
--   throughout 2012, confirming that paid search is scaling.
--   Conversion rate improvements in later months suggest
--   ongoing landing page and bid optimizations are working.
-- ------------------------------------------------------------
