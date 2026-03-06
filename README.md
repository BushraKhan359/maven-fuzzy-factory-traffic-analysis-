# Maven Fuzzy Factory — Traffic & Conversion Analysis
**Tool:** MySQL Workbench | **Database:** Maven Fuzzy Factory | **Type:** E-Commerce Analytics

---

## 📌 Project Overview

Maven Fuzzy Factory is a fictional e-commerce company selling stuffed animal products. In this project, I acted as a data analyst responding to business questions from the CEO and Marketing Director.

The analysis focuses on **paid traffic performance, conversion optimization, and channel growth** — covering the period from the company's launch through late 2012.

---

## 🎯 Business Questions Answered

| # | Business Question | Key Focus |
|---|---|---|
| 1 | What is the monthly trend for Gsearch sessions and orders? | *Traffic & conversion trends* |
| 2 | Can we split Gsearch monthly trends by brand vs nonbrand campaigns? | *Campaign performance* |
| 3 | How do monthly sessions and orders break down by device type (Gsearch nonbrand)? | *Device performance* |
| 4 | How does Gsearch monthly volume compare to other channels? | *Channel mix analysis* |
| 5 | What is the overall session-to-order conversion rate by month? | *Conversion optimization* |
| 6 | What revenue did the Gsearch lander-1 A/B test generate? | *Landing page testing* |
| 7 | What does the full conversion funnel look like from lander to order? | *Funnel analysis* |
| 8 | What was the revenue impact of the billing page A/B test? | *Revenue lift analysis* |

---

## 📂 Repository Structure

```
maven-fuzzy-factory-traffic-analysis/
│
├── README.md                          ← You are here
│
├── sql/
│   ├── 01_gsearch_monthly_trends.sql          ← Q1: Monthly sessions & orders
│   ├── 02_brand_vs_nonbrand_campaigns.sql     ← Q2: Brand vs nonbrand split
│   ├── 03_device_type_analysis.sql            ← Q3: Desktop vs mobile
│   ├── 04_channel_mix_analysis.sql            ← Q4: Gsearch vs other channels
│   ├── 05_session_to_order_conversion.sql     ← Q5: Monthly conversion rate
│   ├── 06_lander_ab_test_revenue.sql          ← Q6: Landing page A/B test
│   ├── 07_conversion_funnel_analysis.sql      ← Q7: Full funnel breakdown
│   └── 08_billing_page_ab_test.sql            ← Q8: Billing page revenue lift
│
└── results/
    └── key_findings.md                        ← Summary of business insights
```

---

## 🗄️ Database Schema

The analysis uses the `mavenfuzzyfactory` MySQL database with the following key tables:

- **website_sessions** — every user session with UTM tracking, device type, and referrer data
- **website_pageviews** — every page viewed within each session
- **orders** — completed purchase records with revenue and product data
- **order_items** — individual product line items within each order
- **order_item_refunds** — refund records linked to order items

---

## 🔍 Key Findings

*### 1. Gsearch Is the Primary Traffic Driver*
Gsearch nonbrand consistently drove the majority of sessions and orders throughout 2012, making it the most critical channel to optimize and monitor.

*### 2. Desktop Significantly Outperforms Mobile*
Desktop sessions converted at a substantially higher rate than mobile across all months analyzed. Mobile traffic volume was notable but conversion rates remained low — suggesting mobile UX improvements as an opportunity.

*### 3. The Lander-1 A/B Test Generated Measurable Revenue Lift*
Replacing the default `/home` landing page with the custom `/lander-1` page improved the conversion rate by **0.87 percentage points**. Extrapolated over 22,972 sessions since the test, this translated to approximately **202 incremental orders**, or roughly **50 extra orders per month**.

*### 4. The Billing Page Test Delivered $8.51 More Revenue Per Session*
The new `/billing-2` page generated **$31.34 revenue per session** compared to **$22.83** for the original `/billing` page — a lift of **$8.51 per session**. With 1,193 billing sessions in the past month, this represents approximately **$10,140 in incremental monthly revenue**.

*### 5. Brand and Organic Channels Are Growing as a % of Nonbrand*
Over time, brand search, direct type-in, and organic sessions grew as a percentage of paid nonbrand traffic — a positive signal indicating that the business was building real brand equity beyond paid acquisition.

---

## 🛠️ SQL Techniques Used

- `JOIN` and `LEFT JOIN` across multiple tables
- Conditional aggregation with `CASE WHEN`
- Common Table Expressions (CTEs) with `WITH`
- Date functions: `YEAR()`, `MONTH()`, `MIN()`, `DATEDIFF()`
- Conversion rate calculations using division
- Multi-step subqueries for funnel analysis
- `GROUP BY` with multiple dimensions

---

## 💡 What I Would Do Differently

- **Add visualizations** — The raw SQL output is informative but presenting these trends as charts would communicate insights faster to non-technical stakeholders.
- **Automate monthly reporting** — Several of these queries are date-filtered manually. Building a stored procedure or scheduled query would make this analysis reusable.
- **Deeper mobile analysis** — Given the low mobile conversion rate, I would extend the analysis to identify exactly where mobile users are dropping off in the funnel.

---

## 📚 Dataset

This project uses the **Maven Analytics — Advanced MySQL for Analytics & Business Intelligence** course dataset. The database simulates a real e-commerce company's transactional data.

🔗 [Maven Analytics](https://www.mavenanalytics.io)

---

## 👤 Author

Bushra Khan
Data Analyst | [thedataalchemist.io](https://thedataalchemist.io)
[[LinkedIn](https://www.linkedin.com/in/bushra-nazeer-khan/)] 
[[GitHub](https://github.com/BushraKhan359)]
