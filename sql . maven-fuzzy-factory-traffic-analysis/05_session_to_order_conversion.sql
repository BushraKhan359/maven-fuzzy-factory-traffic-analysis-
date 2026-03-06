-- ============================================================
-- Q5: Overall Session-to-Order Conversion Rate by Month
-- ------------------------------------------------------------
-- Business Question:
--   I want to understand if our conversion rate is improving
--   over time. Can you pull monthly session and order volume
--   with conversion rate for all traffic?
-- ------------------------------------------------------------
-- Tables Used : website_sessions, orders
-- Filter      : before 2012-11-27
-- ============================================================

USE mavenfuzzyfactory;

SELECT 
    YEAR(ws.created_at)  AS year,
    MONTH(ws.created_at) AS month,
    COUNT(DISTINCT ws.website_session_id)                                          AS sessions,
    COUNT(DISTINCT o.order_id)                                                     AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100       AS conversion_rate
FROM website_sessions ws
    LEFT JOIN orders o USING (website_session_id)
WHERE ws.created_at < '2012-11-27'
GROUP BY 1, 2;

-- ------------------------------------------------------------
-- Finding:
--   Conversion rate improved steadily throughout 2012,
--   reflecting the positive impact of landing page tests,
--   bid optimization, and funnel improvements made over
--   the course of the year.
-- ------------------------------------------------------------
