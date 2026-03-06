-- ============================================================
-- Q3: Monthly Sessions and Orders Split by Device Type
-- ------------------------------------------------------------
-- Business Question:
--   I'm worried about the mobile conversion rate. Could you
--   pull monthly sessions and orders for Gsearch nonbrand,
--   split by device type (desktop vs mobile)?
-- ------------------------------------------------------------
-- Tables Used : website_sessions, orders
-- Filter      : gsearch nonbrand only, before 2012-11-27
-- ============================================================

USE mavenfuzzyfactory;

SELECT  
    YEAR(ws.created_at)  AS year,
    MONTH(ws.created_at) AS month,

    -- Desktop
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN ws.website_session_id END) AS desktop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN o.order_id END)            AS desktop_orders,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN o.order_id END)
        / COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN ws.website_session_id END) AS desktop_conv_rate,

    -- Mobile
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN ws.website_session_id END)  AS mobile_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN o.order_id END)             AS mobile_orders,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN o.order_id END)
        / COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN ws.website_session_id END)  AS mobile_conv_rate

FROM website_sessions ws
    LEFT JOIN orders o USING (website_session_id)
WHERE ws.created_at < '2012-11-27'
  AND ws.utm_source = 'gsearch'
  AND ws.utm_campaign = 'nonbrand'
GROUP BY 1, 2;

-- ------------------------------------------------------------
-- Finding:
--   Desktop consistently outperforms mobile on conversion rate
--   by a significant margin. Mobile traffic volume is notable
--   but conversions are low — a clear UX improvement opportunity.
-- ------------------------------------------------------------
