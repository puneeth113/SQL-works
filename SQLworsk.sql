# Selelcting the database

USE  empifo;

# 1.Show all records from the HR cases table.

SELECT * FROM grivs;

# 2. Show only case_id, employee_id, branch, issue_type, and status.

SELECT case_id,employee_id,branch,issue_type,status 
FROM grivs;

# 3. Find all Pending cases.

SELECT * FROM grivs WHERE status = "pending";

# 4.Find all Salary-related cases.

SELECT * FROM grivs WHERE issue_type = "Salary";

# 5. Find all cases from Bangalore North.

SELECT * FROM grivs WHERE  branch = 'Bangalore North';

# 6.Find all cases sorted by latest received_date.

SELECT * FROM grivs ORDER BY case_ID DESC;

# 7.Show the first 10 records only.

SELECT * FROM grivs LIMIT 10;

#8. Find Pending Salary cases.

SELECT * FROM grivs WHERE issue_type = "Salary" AND status ="Pending";

# 9. Find Salary or Attendance cases.

SELECT * FROM grivs WHERE issue_type = "Salary" OR issue_type = "Attendence";

# 10 Find cases from Bangalore North, Bangalore South, and Mysore.

SELECT * FROM grivs WHERE branch IN ('Bangalore North','Bangalore South',"Mysore");

# 11 Find cases except Hyderabad and Delhi.

SELECT * FROM grivs WHERE branch NOT IN ('Hydrabad','Delhi');

# 12 Find cases received between 2026-03-01 and 2026-03-31.

SELECT * FROM grivs WHERE received_date BETWEEN '2026-03-01' AND '2026-03-31';

# 13 Find branches starting with 'B'.

SELECT * FROM  grivs WHERE  branch like "b%";

# 14 Find cases where closed_date is missing.

SELECT * FROM grivs WHERE closed_date IS NULL;

# 15 Find cases where closed_date is available.

SELECT * FROM grivs WHERE closed_date IS NOT NULL;

# 16 Count total cases.

SELECT COUNT(*) AS counts FROM  grivs;

# 17 Count total cases by issue_type.

SELECT issue_type,COUNT(*) total_case FROM grivs
GROUP BY issue_type;

# 18 Count total cases by branch.

SELECT branch, COUNT(*) total_cases FROM grivs
GROUP BY  branch;

# 19 Find total Pending cases by branch.

SELECT branch,COUNT(*) as pending_cases 
FROM grivs WHERE status = 'Pending'
GROUP BY  branch;

# 20 Find Closed cases by owner.

SELECT * FROM grivs;

SELECT owner,count(*) as closed_Case from grivs 
WHERE status = "closed"
GROUP BY owner;

# 21 Find average closure_days by issue_type.

SELECT issue_type, ROUND(AVG(closure_days),0) as AVG_closure_days FROM grivs
GROUP BY issue_type;

#21 Find maximum closure_days by issue_type.

SELECT issue_type,MAX(closure_days) as max_closure_days FROM grivs
GROUP BY issue_type;

# 22 Find branches having more than 10 cases.

SELECT branch,COUNT(*) as counts FROM grivs 
GROUP BY branch
HAVING counts >=10;

# 24 Find top 5 branches with highest cases.

SELECT branch,COUNT(*) as counts FROM grivs
GROUP BY branch 
ORDER BY counts DESC
LIMIT 5;

# 25 Find top 5 issue_subtypes by case count.

SELECT issue_subtype,COUNT(*) AS counts 
FROM grivs
GROUP BY issue_subtype
ORDER BY counts DESC
LIMIT 5;

# 26 Find closure rate by branch.
SELECT 
    branch,
    COUNT(*) AS total_cases,
    SUM(
        CASE 
            WHEN status = 'Closed' THEN 1
            ELSE 0
        END
    ) AS closed_cases,
    ROUND(
        SUM(
            CASE 
                WHEN status = 'Closed' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS closure_rate_per
FROM grivs
GROUP BY branch
ORDER BY closure_rate_per DESC;
        
SELECT * FROM grivs;

# JOIN Operations

USE empinfo;

SELECT * FROM grivs;

# 1. 1. Show all grievance cases with employee name, department, and designation.

SELECT * FROM empMuster;

SELECT 
g.employee_id,
e.employee_name,
e.department,
e.designation
FROM grivs g JOIN empMuster e;

# 2. Show all grievance cases with branch region, state, and branch manager.

SELECT 
g.issue_type,
b.branch,
b.region,
b.state,
b.branch_manager
FROM grivs g JOIN branchMuster b;

# 3  Show all grievance cases with assigned owner team, level, and email.



SELECT 
g.issue_type,
g.owner,
o.level,
o.email
FROM grivs g JOIN ownerMuster o;

# 4 Show only matching cases between `grivs` and `employee_master` using INNER JOIN.

SELECT 
*
FROM grivs g INNER JOIN empMuster e 
WHERE g.employee_id = e.employee_id;

# 5 Show all cases even if employee details are missing using LEFT JOIN.
SELECT * FROM empMuster;
SELECT * FROM grivs;

SELECT 
*
FROM empMuster e  LEFT JOIN grivs g
ON g.employee_id = e.employee_id;

# . Find cases where employee details are missing from employee master.
SELECT 
g.case_id,
g.employee_type,
g.issue_type
FROM grivs g LEFT JOIN empMuster e
ON g.employee_id = e.employee_id
WHERE e.employee_id IS NULL;

# 7. Show all employees and their grievance cases.
SELECT * FROM empMuster;
SELECT * FROM grivs;

SELECT 
g.employee_id,
e.employee_name,
e.branch,
g.issue_type,
g.status,
g.priority
FROM grivs g RIGHT JOIN empMuster e
ON g.employee_id = e.employee_id;

# 8. Find employees who have not raised any grievance case 

SELECT 
e.employee_name,
e.gender,
e.department
FROM empMuster e LEFT JOIN grivs g
ON e.employee_id = g.employee_id
WHERE g.employee_id IS NULL;

# Joins --- DAY 2 



# 1. Show all grievance cases with employee name, department, and designation.

SELECT 
g.employee_id,
e.employee_name,
g.department,
e.designation
FROM grivs g RIGHT JOIN empmuster e 
ON g.employee_id = e.employee_id;

# 2.Show all grievance cases with employee name and employee branch.
SELECT 
g.employee_id,
e.employee_name,
g.issue_type,
g.status,
g.owner,
e.branch,
e.active_status
FROM grivs g LEFT JOIN  empMuster e 
ON g.employee_id = e.employee_id;

# 3 Show all grievance cases with branch region, state, and branch manager.

SELECT 
g.branch,
g.issue_type,
b.city,
b.region,
b.state,
b.branch_manager
FROM grivs g JOIN branchmuster b
ON g.branch = b.branch;

# 4 Show all grievance cases with owner team, owner level, and owner email.


SELECT 
g.owner,
o.team,
o.level,
o.email
FROM grivs g JOIN ownermuster o
ON g.owner  = o.owner_name;

# Show all matching records between grivs and empMuster using INNER JOIN.


SELECT 
e.employee_name,
g.issue_type,
g.status,
g.owner
FROM grivs g INNER JOIN empMuster e
ON g.employee_id = e.employee_id;

# Show all grievance cases even if employee details are missing using LEFT JOIN.
SELECT * FROM grivs LIMIT 4;
SELECT * FROM empMuster LIMIT 4;

SELECT 
e.employee_name,
e.branch,
g.issue_type,
g.owner
FROM empMuster e LEFT JOIN grivs g
ON e.employee_id = g.employee_id;

# Show all employees and their grievance case details. 

SELECT 
e.employee_id,
e.employee_name,
g.issue_type,
g.status,
g.owner
FROM empMuster e JOIN grivs g
ON e.employee_id = g.employee_id;

# Find employees who have not raised any grievance case.

SELECT 
e.employee_name,
e.department
FROM empMuster e JOIN grivs g
ON e.employee_id != g.employee_id;

# Sub query 
# 1. Show cases where closure_days is greater than average closure_days.

SELECT * from grivs;

SELECT * 
FROM grivs 
WHERE closure_days > ( SELECT AVG(closure_days) as avg_cdays FROM grivs) ;

#  2. Show cases where closure_days is equal to maximum closure_days.

SELECT * 
FROM grivs 
WHERE closure_days = ( SELECT MAX(closure_days) as max_days FROM  grivs );

# 3. Show cases where closure_days is equal to minimum closure_days.
SELECT * 
FROM grivs 
WHERE closure_days = ( SELECT MIN(closure_days) as min_days FROM  grivs );

# 4. Show grievance cases raised by employees from Payroll department.

SELECT * FROM grivs
WHERE department = "Payroll";

# 5 Show grievance cases raised by employees from HR department.

SELECT * FROM grivs
WHERE department = "HR";

# 6. Show employees who have raised at least one grievance case using EXISTS.

SELECT e.employee_name,
e.branch
FROM empMuster e
WHERE EXISTS ( 
		SELECT 1 FROM grivs g WHERE g.employee_id = e.employee_id);
        
# 7 Show employees who have not raised any grievance case using NOT EXISTS.
SELECT e.employee_name,
e.branch
FROM empMuster e
WHERE EXISTS ( 
		SELECT 1 FROM grivs g WHERE g.employee_id != e.employee_id);

# 8 Show pending cases from branches having more than 10 total cases.

SELECT 
g.employee_id,
g.issue_type,
g.branch
FROM grivs g
WHERE EXISTS(  SELECT 1 FROM branchmuster b WHERE b.branch = g.branch);

# 9. Show salary cases from employees whose active_status is Active.

SELECT * FROM grivs;
SELECT * FROM empMuster;

SELECT e.employee_name,
e.department,
e.active_status
FROM empMuster e 
WHERE e.active_status = "active",
EXISTS ( SELECT * FROM grivs g WHERE g.issue_type ="salary")

# 10. Show cases from branches located in Karnataka using branchMuster.

SELECT  * FROM branchmuster;

SELECT b.branch,
b.state
FROM branchmuster b 
WHERE b.state ="karnataka"
AND  employee_id IN ( SELECT g.branch FROM  grivs g);


# CTEs 
use empinfo;
SELECT * from grivs;

# 1. sample CTEs 

WITH consol AS (
SELECT 
COUNT(empid) total_count,
AVG(closure_days) cd
FROM grivs
)
SELECT * from consol;
SELECT * FROM grivs;

# work 2 
WITH sample as (
SELECT 
branch,
COUNT(*) AS total_cases,
SUM(CASE WHEN status = "Closed" THEN 1 ELSE 0 END) as closed_cases
FROM grivs
GROUP BY  branch
)
SELECT branch, total_cases,closed_cases FROM sample;

# CTEs with Joins 
select * from grivs;
select * from branchmuster;

describe branchmuster;

WITH joins AS (
SELECT 
g.department,
g.employee_type,
g.status,
b.region,
b.employee_strength
FROM grivs g JOIN  branchmuster b 
ON g.branch = b.branch
)
SELECT * FROM joins;


WITH case_branch_data AS (
    SELECT 
        g.case_id,
        g.branch,
        g.status,
        b.region,
        b.employee_strength
    FROM grivs g
    LEFT JOIN branchMuster b 
    ON g.branch = b.branch
),
region_summary AS (
    SELECT 
        region,
        COUNT(*) AS total_cases,
        SUM(CASE WHEN status = 'Closed' THEN 1 ELSE 0 END) AS closed_cases
    FROM case_branch_data
    GROUP BY region
)
SELECT 
    region,
    total_cases,
    closed_cases,
    ROUND(closed_cases * 100.0 / total_cases, 2) AS closure_rate
FROM region_summary
ORDER BY closure_rate DESC;