-- 3. Account Inactivity Alert

-- identifying each account types
WITH plan_types AS (
    SELECT 
        id AS plan_id,
        owner_id,
        CASE 
            WHEN is_regular_savings = 1 THEN 'Savings'
            WHEN is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type
    FROM plans_plan
    WHERE is_regular_savings = 1 OR is_a_fund = 1
),
-- checking the latest day of transaction
last_inflows AS (
    SELECT 
        plan_id,
        MAX(transaction_date) AS last_transaction_date -- Most recent inflow date per account
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY plan_id
),
-- 3. Combine account types with inflow data and calculate inactivity
inactivity AS (
    SELECT 
        pt.plan_id,
        pt.owner_id,
        pt.type,
        lif.last_transaction_date,
        DATEDIFF(CURDATE(), lif.last_transaction_date) AS inactivity_days
    FROM plan_types pt
    LEFT JOIN last_inflows lif ON pt.plan_id = lif.plan_id
    WHERE lif.last_transaction_date IS NULL OR DATEDIFF(CURDATE(), lif.last_transaction_date) > 365
)
-- 4. Output results ordered by how long the account has been inactive
SELECT * FROM inactivity
ORDER BY inactivity_days DESC;
