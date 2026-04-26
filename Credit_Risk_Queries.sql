-- Credit  Risk  Analysis
Author : Riya Gambhir

---------------------------------------------------------
-- 1. Top 3 Home Ownership Categories by Loan Investment
---------------------------------------------------------
SELECT home_ownership,
		SUM(loan_amnt)  AS Total_loan
		FROM Bank_loan
		GROUP BY home_ownership
		ORDER BY total_loan DESC
		LIMIT 3;

----------------------------------------------------------------
-- 2. Loan Performance and Default Rate Analysis by Income Level
----------------------------------------------------------------

SELECT 
    CASE 
        WHEN annual_inc < 50000 THEN 'Low Income'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_bracket,
    AVG(loan_amnt) as avg_loan,
    COUNT(*) as total_customers,
	COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) as default_customers,
	ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)::numeric/count(id)*100,2) as default_rate
FROM Bank_loan
GROUP BY income_bracket
ORDER BY Default_rate;

--------------------------------------------------------------------
-- 3. Capital Loss and Default Risk Analysis by Loan Duration (Term)
--------------------------------------------------------------------
SELECT 
    term, 
    SUM(loan_amnt) as lost_capital,
ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)::numeric/count(id)*100,2) as default_rate
FROM Bank_loan
WHERE loan_status = 'Charged Off'
GROUP BY term;

--------------------------------------------------------------
-- 4. Impact of Annual Income on Loan Amount and Default Risk
--------------------------------------------------------------
SELECT 
    CASE 
        WHEN annual_inc < 50000 THEN 'Low Income'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_bracket,
    AVG(loan_amnt) as avg_loan,
    COUNT(*) as total_customers,
	ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)::numeric/count(id)*100,2) as default_rate
FROM Bank_loan
GROUP BY income_bracket;
