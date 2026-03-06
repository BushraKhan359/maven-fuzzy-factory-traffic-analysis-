-- ============================================================
-- Q7: Full Conversion Funnel — /home vs /lander-1 to Orders
-- ------------------------------------------------------------
-- Business Question:
--   I'd like to understand the full conversion funnel from
--   each of the two landing pages all the way to order.
--   Can you build a funnel showing click-through rates at
--   each step?
-- ------------------------------------------------------------
-- Tables Used : website_sessions, website_pageviews
-- Period      : 2012-06-19 to 2012-07-28
-- Funnel Steps: lander → products → mr_fuzzy → cart →
--               shipping → billing → thank you
-- ============================================================

USE mavenfuzzyfactory;

-- STEP 1 & 2: Flag each funnel step at the pageview level
WITH pageview_flags AS (
    SELECT
        ws.website_session_id,
        wp.pageview_url,
        CASE WHEN pageview_url = '/home'                    THEN 1 ELSE 0 END AS homepage,
        CASE WHEN pageview_url = '/lander-1'                THEN 1 ELSE 0 END AS custom_lander,
        CASE WHEN pageview_url = '/products'                THEN 1 ELSE 0 END AS product_page,
        CASE WHEN pageview_url = '/the-original-mr-fuzzy'  THEN 1 ELSE 0 END AS mr_fuzzy_page,
        CASE WHEN pageview_url = '/cart'                    THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN pageview_url = '/shipping'                THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN pageview_url = '/billing'                 THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
    FROM website_sessions ws
        LEFT JOIN website_pageviews wp USING (website_session_id)
    WHERE utm_campaign = 'nonbrand'
      AND utm_source = 'gsearch'
      AND ws.created_at BETWEEN '2012-06-19' AND '2012-07-28'
),

-- STEP 3: Collapse to session level (max flags per session)
session_level AS (
    SELECT
        website_session_id,
        MAX(homepage)      AS saw_homepage,
        MAX(custom_lander) AS saw_lander,
        MAX(product_page)  AS product_made_it,
        MAX(mr_fuzzy_page) AS mr_fuzzy_made_it,
        MAX(cart_page)     AS cart_made_it,
        MAX(shipping_page) AS shipping_made_it,
        MAX(billing_page)  AS billing_made_it,
        MAX(thankyou_page) AS thankyou_made_it
    FROM pageview_flags
    GROUP BY website_session_id
)

-- STEP 4: Calculate click-through rates at each funnel step
SELECT  
    CASE 
        WHEN saw_lander   = 1 THEN 'lander-1'
        WHEN saw_homepage = 1 THEN 'home'
        ELSE 'other'
    END AS segment,
    COUNT(DISTINCT website_session_id)                                                                                          AS sessions,
    COUNT(DISTINCT CASE WHEN product_made_it  = 1 THEN website_session_id END) / COUNT(DISTINCT website_session_id)            AS lander_click_rate,
    COUNT(DISTINCT CASE WHEN mr_fuzzy_made_it = 1 THEN website_session_id END) / COUNT(DISTINCT CASE WHEN product_made_it  = 1 THEN website_session_id END) AS product_click_rate,
    COUNT(DISTINCT CASE WHEN cart_made_it     = 1 THEN website_session_id END) / COUNT(DISTINCT CASE WHEN mr_fuzzy_made_it = 1 THEN website_session_id END) AS mr_fuzzy_click_rate,
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id END) / COUNT(DISTINCT CASE WHEN cart_made_it     = 1 THEN website_session_id END) AS cart_click_rate,
    COUNT(DISTINCT CASE WHEN billing_made_it  = 1 THEN website_session_id END) / COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id END) AS shipping_click_rate,
    COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id END) / COUNT(DISTINCT CASE WHEN billing_made_it  = 1 THEN website_session_id END) AS billing_click_rate
FROM session_level
GROUP BY 1;

-- ------------------------------------------------------------
-- Finding:
--   The custom lander-1 page outperformed /home at the top
--   of the funnel. Both segments showed similar drop-off
--   patterns deeper in the funnel, with the biggest drop
--   occurring between the product page and the cart —
--   a key area for future optimization.
-- ------------------------------------------------------------
