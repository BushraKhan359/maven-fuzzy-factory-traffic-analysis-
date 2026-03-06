-- ============================================================
-- Q2: Monthly Gsearch Trends Split by Brand vs Nonbrand
-- ------------------------------------------------------------
-- Business Question:
--   It looks like nonbrand is our biggest driver. Could you
--   pull monthly Gsearch sessions and orders, splitting out
--   nonbrand and brand campaigns separately?
-- ------------------------------------------------------------
-- Tables Used : website_sessions, orders
-- Filter      : utm_source = 'gsearch', before 2012-11-27
-- ============================================================

USE mavenfuzzyfactory;

SELECT 
    YEAR(ws.created_at)  AS year,
    MONTH(ws.created_at) AS month,

    -- Nonbrand sessions and orders
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN ws.website_session_id END) AS nonbrand_sessions,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN o.order_id END)            AS nonbrand_orders,

    -- Brand sessions and orders
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN ws.website_session_id END)    AS brand_sessions,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN o.order_id END)               AS brand_orders,

    -- Nonbrand conversion rate
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN o.order_id END)
        / COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN ws.website_session_id END) AS nonbrand_conv_rate,

    -- Brand conversion rate
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN o.order_id END)
        / COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN ws.website_session_id END)    AS brand_conv_rate

FROM website_sessions ws
    LEFT JOIN orders o USING (website_session_id)
WHERE ws.utm_source = 'gsearch'
  AND ws.created_at < '2012-11-27'
GROUP BY 1, 2;

-- ------------------------------------------------------------
-- Finding:
--   Nonbrand campaigns drive the vast majority of volume.
--   Brand campaign sessions are small but growing, indicating
--   the business is starting to build brand recognition.
--   Both channels show improving conversion rates over time.
-- ------------------------------------------------------------
