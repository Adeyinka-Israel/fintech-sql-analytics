# Fintech SQL Analytics – Customer Insights & BI

This is me running SQL on a fintech-style dataset (think savings + investment platform) to pull out real business insights.  
The queries answer practical questions like:  
- Who are our biggest customers?  
- Who’s using both savings and investments?  
- Which accounts have gone quiet?  
- How much are customers really worth over time?  

---

## The Business Questions I Tackled

### 1. High-Value Customers with Multiple Products
**Goal:** Find customers who have **both** a savings plan and an investment plan, then rank them by how much they’ve deposited.  
**Why it matters:** Marketing can target these people for cross-sells and loyalty perks.  

**Key SQL moves:**
- Conditional aggregation  
- Joins between `users`, `plans`, and `savings` tables  
- Converting kobo → naira  

---

### 2. Transaction Frequency Analysis
**Goal:** Group customers based on how active they are per month:  
- **High:** 10+ transactions/month  
- **Medium:** 3–9 transactions/month  
- **Low:** 2 or less  

**Why it matters:** Makes it easier to target the right people for promos or campaigns.  

**Key SQL moves:**
- CTEs for clean step-by-step logic  
- Grouping by month per customer  
- `CASE` statements for tagging  

---

### 3. Account Inactivity Alert
**Goal:** Spot accounts (savings or investments) with **no inflow in the last 365 days**.  
**Why it matters:** These accounts are slipping away — time for reactivation campaigns.  

**Key SQL moves:**
- `DATEDIFF` for time checks  
- `MAX()` to get the last transaction  
- Filters for inactivity threshold  

---

### 4. Customer Lifetime Value (CLV) Estimation
**Goal:** Estimate how much each customer is worth over their time with us.  
**Why it matters:** Helps decide where to focus retention and upselling efforts.  

**Key SQL moves:**
- `TIMESTAMPDIFF` for tenure  
- Aggregating transaction count and averages  
- `NULLIF` to avoid dividing by zero  


## That’s a wrap  
Just me exploring fintech data and seeing what stories SQL can tell. If you like the vibe, fork this repo, tweak the queries, and run it on your own data. You might even find something I missed. 
