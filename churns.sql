-- Customer Churn Analytics – SQL Analysis
-- Author: Deep Roy
-- Purpose: Risk segmentation and financial impact assessment
-- Data Integrity Check: identify total records and duplicate customer IDs
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customerid) AS unique_customers,
    COUNT(*) - COUNT(DISTINCT customerid) AS duplicate_records
FROM
    churn;
-- Data Validation: detect invalid or unrealistic values in key customer fields
SELECT *
FROM churn
WHERE Age < 18 
   OR Age > 100
   OR CreditScore NOT BETWEEN 300 AND 900
   OR Tenure < 0
   OR EstimatedSalary < 0
   OR balance < 0;
-- Baseline KPI View: compute total customers, total churned, and overall churn rate
CREATE OR REPLACE VIEW churn_baseline AS
SELECT 
    COUNT(*) AS total_customers,
    SUM(Exited) AS total_churned,
    ROUND(SUM(Exited) * 1.0 / COUNT(*), 4) AS baseline_churn_rate
FROM churn;
-- Overall churn percentage calculation for performance benchmarking
SELECT 
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(100 * SUM(Exited)/COUNT(*), 2) AS churn_rate_pct
FROM churn;
-- Feature Engineering View: create analytical segments and derived metrics for advanced churn analysis
CREATE OR REPLACE VIEW churn_feature_engineering AS
SELECT 
    *,
    
    -- Age Segmentation
    CASE 
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 45 THEN 'Mid-Age'
        WHEN Age BETWEEN 46 AND 60 THEN 'Mature'
        ELSE 'Senior'
    END AS age_segment,
    
    -- Tenure Segmentation
    CASE 
        WHEN Tenure <= 2 THEN 'New'
        WHEN Tenure BETWEEN 3 AND 6 THEN 'Established'
        ELSE 'Loyal'
    END AS tenure_segment,
    
    -- Balance / Salary Ratio
    (balance / NULLIF(EstimatedSalary, 0)) AS balance_salary_ratio,
    
    -- Balance Quartile (MySQL 8+ required)
    NTILE(4) OVER (ORDER BY balance) AS balance_quartile

FROM churn;

-- Product-Level Churn Lift Analysis: measure relative churn risk by number of products
WITH baseline AS (
    SELECT SUM(Exited) / COUNT(*) AS base_rate 
    FROM churn
),
product_risk AS (
    SELECT 
        NumOfProducts,
        SUM(Exited) / COUNT(*) AS churn_rate
    FROM churn
    GROUP BY NumOfProducts
)

SELECT 
    p.NumOfProducts,
    ROUND(p.churn_rate, 4) AS churn_rate,
    ROUND(p.churn_rate / b.base_rate, 2) AS lift_ratio
FROM product_risk p
CROSS JOIN baseline b
ORDER BY lift_ratio DESC;
-- Engagement Risk Analysis: compare churn lift between active and inactive customers
WITH baseline AS (
    SELECT SUM(Exited) / COUNT(*) AS base_rate 
    FROM churn
),
activity_risk AS (
    SELECT 
        IsActiveMember,
        SUM(Exited) / COUNT(*) AS churn_rate
    FROM churn
    GROUP BY IsActiveMember
)

SELECT 
    a.IsActiveMember,
    ROUND(a.churn_rate, 4) AS churn_rate,
    ROUND(a.churn_rate / b.base_rate, 2) AS lift_ratio
FROM activity_risk a
CROSS JOIN baseline b
ORDER BY lift_ratio DESC;
-- Geographic Churn Lift Analysis: identify high-risk regions relative to baseline churn

WITH baseline AS (
    SELECT SUM(Exited) / COUNT(*) AS base_rate
    FROM churn
),
geo_risk AS (
    SELECT 
        Geography,
        COUNT(*) AS total_customers,
        SUM(Exited) / COUNT(*) AS churn_rate
    FROM churn
    GROUP BY Geography
)

SELECT 
    g.Geography,
    g.total_customers,
    ROUND(g.churn_rate, 4) AS churn_rate,
    ROUND(g.churn_rate / b.base_rate, 2) AS lift_ratio
FROM geo_risk g
CROSS JOIN baseline b
ORDER BY lift_ratio DESC;

-- Gender-Based Churn Differential: measure churn gap compared to overall average

WITH gender_stats AS (
    SELECT 
        Gender,
        COUNT(*) AS total_customers,
        SUM(Exited) * 1.0 / COUNT(*) AS churn_rate
    FROM churn
    GROUP BY Gender
)

SELECT 
    Gender,
    total_customers,
    ROUND(churn_rate, 4) AS churn_rate,
    ROUND(
        churn_rate - AVG(churn_rate) OVER (),
    4) AS differential_from_avg
FROM gender_stats;


-- Credit Score Risk Segmentation: analyze churn performance across credit quality tiers

WITH credit_segment AS (
    SELECT *,
        CASE 
            WHEN CreditScore < 500 THEN 'Very Low'
            WHEN CreditScore BETWEEN 500 AND 649 THEN 'Low'
            WHEN CreditScore BETWEEN 650 AND 749 THEN 'Medium'
            ELSE 'High'
        END AS credit_band
    FROM churn
)

SELECT 
    credit_band,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(100 * SUM(Exited)/COUNT(*), 2) AS churn_rate_pct
FROM credit_segment
GROUP BY credit_band
ORDER BY churn_rate_pct DESC;
-- Multi-Factor Risk Segmentation: identify high-risk customer clusters using churn rate and lift
WITH base AS (
    SELECT SUM(Exited) / COUNT(*) AS base_rate 
    FROM churn
)

SELECT 
    age_segment,
    tenure_segment,
    NumOfProducts,
    COUNT(*) AS total_customers,
    ROUND(100 * SUM(Exited)/COUNT(*), 2) AS churn_rate_pct,
    ROUND((SUM(Exited)/COUNT(*)) / base.base_rate, 2) AS lift_ratio
FROM churn_feature_engineering
CROSS JOIN base
GROUP BY age_segment, tenure_segment, NumOfProducts, base.base_rate
ORDER BY lift_ratio DESC;

-- Risk Exposure Index: assign churn risk score based on key behavioral and demographic drivers
CREATE OR REPLACE VIEW churn_exposure_index AS
SELECT *,
(
    (CASE WHEN NumOfProducts = 1 THEN 1.8 ELSE 0 END) +
    (CASE WHEN IsActiveMember = 0 THEN 2.5 ELSE 0 END) +
    (CASE WHEN Age > 45 THEN 1.1 ELSE 0 END) +
    (CASE WHEN CreditScore < 500 THEN 1.6 ELSE 0 END)
) AS churn_driver_count
FROM churn_feature_engineering;
-- Behavioral Risk Segmentation: classify customers into exposure tiers for retention prioritization
CREATE OR REPLACE VIEW churn_behavior_segment AS
SELECT *,
CASE 
    WHEN churn_driver_count >= 3 THEN 'High Exposure'
    WHEN churn_driver_count = 2 THEN 'Moderate Exposure'
    ELSE 'Low Exposure'
END AS exposure_segment
FROM churn_exposure_index;
-- Exposure Segment Performance: evaluate churn rate across risk tiers
SELECT 
    exposure_segment,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(100 * SUM(Exited)/COUNT(*), 2) AS churn_rate_pct
FROM churn_behavior_segment
GROUP BY exposure_segment
ORDER BY churn_rate_pct DESC;

-- Financial Impact Assessment: measure total assets and percentage lost due to churn
SELECT 
    SUM(balance) AS total_assets,
    SUM(CASE WHEN Exited = 1 THEN balance ELSE 0 END) AS churned_assets,
    ROUND(
        100 * SUM(CASE WHEN Exited = 1 THEN balance ELSE 0 END) / SUM(balance),
        2
    ) AS asset_loss_pct
FROM churn_feature_engineering;
-- Asset Distribution by Risk Tier: quantify balance concentration and loss across exposure segments
SELECT 
    exposure_segment,
    COUNT(*) AS customers,
    SUM(balance) AS total_balance,
    SUM(CASE WHEN Exited = 1 THEN balance ELSE 0 END) AS lost_balance
FROM churn_behavior_segment
GROUP BY exposure_segment
ORDER BY total_balance DESC;
-- Retention Scenario Simulation: estimate potential asset savings with churn reduction in high-risk segment

WITH high_exposure AS (
    SELECT *
    FROM churn_behavior_segment
    WHERE exposure_segment = 'High Exposure'
),
current_loss AS (
    SELECT 
        SUM(CASE WHEN Exited = 1 THEN balance ELSE 0 END) AS current_lost_balance
    FROM high_exposure
),
simulated_loss AS (
    SELECT 
        SUM(
            CASE 
                WHEN Exited = 1 THEN balance * 0.95
                ELSE 0 
            END
        ) AS simulated_lost_balance
    FROM high_exposure
)

SELECT 
    c.current_lost_balance,
    s.simulated_lost_balance,
    c.current_lost_balance - s.simulated_lost_balance AS potential_asset_saved
FROM current_loss c
CROSS JOIN simulated_loss s;

-- Executive Summary View: consolidated KPIs for churn rate and financial impact
CREATE OR REPLACE VIEW churn_executive_summary AS
SELECT 
    COUNT(*) AS total_customers,
    ROUND(100 * SUM(Exited)/COUNT(*), 2) AS baseline_churn_rate_pct,
    SUM(balance) AS total_assets,
    SUM(CASE WHEN Exited = 1 THEN balance ELSE 0 END) AS total_asset_loss
FROM churn;

-- Query Execution Plan Analysis: evaluate performance for product-based filtering
EXPLAIN
SELECT *
FROM churn
WHERE NumOfProducts = 1;
-- Performance Optimization: create composite indexes to improve filtering and aggregation speed
CREATE INDEX idx_products_active 
ON churn(NumOfProducts, IsActiveMember);
CREATE INDEX idx_exited_balance 
ON churn(Exited, balance);
CREATE INDEX idx_credit_score ON churn(CreditScore);
CREATE INDEX idx_age ON churn(Age);