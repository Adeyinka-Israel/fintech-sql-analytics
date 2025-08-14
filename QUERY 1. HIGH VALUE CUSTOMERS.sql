-- 1. High-Value Customers with Multiple Products
SELECT
    p.owner_id,
    concat(u.first_name," ",u.last_name) AS Name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.plan_id END) AS savings_count, -- counting how many savings plan,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.plan_id END) AS investment_count, -- counting how many investment plan,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits  -- converting the amount from kobo to naira
FROM savings_savingsaccount s
JOIN plans_plan p ON s.plan_id = p.id
JOIN users_customuser u ON p.owner_id = u.id
WHERE s.confirmed_amount > 0
GROUP BY p.owner_id
HAVING
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.plan_id END) > 0 AND
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.plan_id END) > 0
ORDER BY total_deposits DESC;