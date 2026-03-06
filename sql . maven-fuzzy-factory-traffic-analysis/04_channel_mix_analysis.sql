-- ============================================================
-- Q4: Monthly Gsearch Volume vs Other Traffic Channels
-- ------------------------------------------------------------
-- Business Question:
--   I'd like to know the monthly trends for Gsearch alongside
--   other channels, so we can understand how dependent we are
--   on paid search.
-- ------------------------------------------------------------
-- Tables Used : website_sessions
-- Filter      : before 2012-11-27
-- ============================================================

USE mavenfuzzyfactory;

SELECT 
    YEAR(created_at)  AS year,
    MONTH(created_at) AS month,
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN website_session_id END) AS gsearch_sessions,
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN website_session_id END) AS bsearch_sessions,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_session_id END) AS organic_sessions,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_session_id END)     AS direct_sessions
FROM website_sessions
WHERE created_at < '2012-11-27'
GROUP BY 1, 2;

-- ------------------------------------------------------------
-- Finding:
--   Gsearch dominates traffic volume. Bsearch launched mid-year
--   and grew quickly. Organic and direct sessions are small but
--   meaningful, showing early signs of brand-driven traffic
--   that does not rely on paid spend.
-- ------------------------------------------------------------
