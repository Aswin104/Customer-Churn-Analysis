-- Overall Churn Rate:

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn;

-- Churn by Contract Type:

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

-- Churn by Tenure Segment:

SELECT
    CASE
        WHEN tenure <= 12 THEN '0–12 Months'
        WHEN tenure <= 24 THEN '12–24 Months'
        WHEN tenure <= 48 THEN '24–48 Months'
        ELSE '48+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;

-- Churn by Payment Method:

SELECT
    PaymentMethod,
    COUNT(*) AS customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_percent DESC;

-- Churn by Monthly Charges:

SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low'
        WHEN MonthlyCharges < 70 THEN 'Medium'
        ELSE 'High'
    END AS charge_band,
    COUNT(*) AS total_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn
GROUP BY charge_band
ORDER BY churn_rate_percent DESC;

-- Senior Citizen Churn Analysis:

SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_churn
GROUP BY SeniorCitizen;

-- High Risk Customer Identification:

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    PaymentMethod
FROM customer_churn
WHERE tenure < 12
  AND MonthlyCharges > 70
  AND Contract = 'Month-to-month'
  AND Churn = 'Yes';

-- Revenue at Risk due to Churn:

SELECT
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost
FROM customer_churn
WHERE Churn = 'Yes';


