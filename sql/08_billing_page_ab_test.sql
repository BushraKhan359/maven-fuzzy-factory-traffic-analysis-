-- ============================================================
-- Q8: Revenue Impact of the Billing Page A/B Test
-- ------------------------------------------------------------
-- Business Question:
--   Could you quantify the impact of our billing page test?
--   Please analyze revenue per billing page session for
--   /billing vs /billing-2 (Sep 10 – Nov 10), then pull
--   the billing session count for the past month to calculate
--   total monthly revenue impact.
-- ------------------------------------------------------------
-- Tables Used : website_pageviews, orders
-- Test Period : 2012-09-10 to 2012-11-10
-- ============================================================

USE mavenfuzzyfactory;

-- STEP 1: Compare revenue per session for each billing page version
SELECT 
    seen_billing_page,
    COUNT(DISTINCT website_session_id)              AS sessions,
    ROUND(SUM(price_usd) / COUNT(DISTINCT website_session_id), 2) AS revenue_per_session
FROM (
    SELECT
        wp.website_session_id, 
        wp.pageview_url AS seen_billing_page,
        o.order_id,
        o.price_usd
    FROM website_pageviews wp
        LEFT JOIN orders o USING (website_session_id)
    WHERE wp.created_at BETWEEN '2012-09-10' AND '2012-11-10'
      AND wp.pageview_url IN ('/billing', '/billing-2')
) AS billing_data
GROUP BY 1;

-- ------------------------------------------------------------
-- Results:
--   /billing   → $22.83 revenue per session
--   /billing-2 → $31.34 revenue per session
--   Lift       → $8.51 more revenue per session
-- ------------------------------------------------------------

-- STEP 2: Count billing sessions in the past month (Oct 27 – Nov 27)
SELECT 
    COUNT(DISTINCT website_session_id) AS billing_sessions_past_month
FROM website_pageviews 
WHERE pageview_url IN ('/billing', '/billing-2')
  AND created_at BETWEEN '2012-10-27' AND '2012-11-27';

-- ------------------------------------------------------------
-- Revenue Impact Calculation:
--   Sessions in past month : 1,193
--   Revenue lift per session: $8.51
--   Total monthly impact   : 1,193 × $8.51 = ~$10,153
--
--   Conclusion: Switching all billing traffic to /billing-2
--   generates approximately $10,153 in additional monthly revenue.
-- ------------------------------------------------------------
