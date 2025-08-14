-- Grouping transactions by user and month 
WITH user_monthly_transaction AS (
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS transaction_month,
        COUNT(*) AS monthly_transaction
    FROM savings_savingsaccount s
    WHERE s.transaction_status = 'success'
    GROUP BY s.owner_id, transaction_month
),
-- User's average monthly transaction
user_avg_transaction_per_month AS (
    SELECT 
        owner_id,
        AVG(monthly_transaction) AS avg_transaction_per_month
    FROM user_monthly_transaction
    GROUP BY owner_id
),
-- Categorizing user based on the average transaction
categorized_users AS (
    SELECT 
        owner_id,
        avg_transaction_per_month,
        CASE 
            WHEN avg_transaction_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transaction_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM user_avg_transaction_per_month
)
-- Result Summary
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transaction_per_month), 1) AS avg_transactions_per_month
FROM categorized_users
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
