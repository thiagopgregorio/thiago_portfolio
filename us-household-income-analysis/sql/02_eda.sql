-- View data from both tables after the cleaning process
-- Objective: ensure data consistency before starting the analysis
SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;


-- Sum land area (ALand) by state
-- Objective: identify which states have the largest land area
SELECT State_Name,
       SUM(ALand),
       SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(ALand) DESC
LIMIT 10;


-- Sum water area (AWater) by state
-- Objective: identify states with the largest presence of water bodies
SELECT State_Name,
       SUM(ALand),
       SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(AWater) DESC
LIMIT 10;


-- Perform a JOIN between the two tables using the ID
-- Objective: combine geographic and economic data
SELECT *
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
    ON u.id = us.id;


-- Calculate average income (Mean and Median) by state
-- Objective: identify states with the lowest (ORDER BY ASC) and highest (ORDER BY DESC) income levels
-- Lowest average income states: Puerto Rico, Mississippi, Arkansas, West Virginia, and Alabama
-- Highest average income states: District of Columbia, Connecticut, New Jersey, Maryland, and Massachusetts
SELECT u.State_Name,
       ROUND(AVG(Mean),1),
       ROUND(AVG(Median),1)
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
    ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY ROUND(AVG(Mean),1)
LIMIT 5;


-- Sort by median income instead of mean
-- Objective: analyze income using a metric less sensitive to outliers
-- Lowest median income states: Puerto Rico, Arkansas, Mississippi, Louisiana, and Oklahoma
-- Highest median income states: New Jersey, Wyoming, Alaska, Connecticut, and Massachusetts
SELECT u.State_Name,
       ROUND(AVG(Mean),1),
       ROUND(AVG(Median),1)
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
    ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY ROUND(AVG(Median),1)
LIMIT 5;


-- Analyze mean and median income by region type (Type)
-- Objective: understand how location type impacts income
-- The "Community" type shows the lowest mean and median income values
SELECT Type,
       COUNT(Type),
       ROUND(AVG(Mean),1),
       ROUND(AVG(Median),1)
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
    ON u.id = us.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 4 DESC
LIMIT 20;


SELECT *
FROM us_household_income
WHERE Type = 'Community';
-- All "Communities" are located in Puerto Rico...
-- Since Puerto Rico has the lowest average income,
-- it makes sense that the "Community" type has the lowest median and mean income


-- Investigate where regions classified as "Community" are located
-- "Communities" are concentrated in Puerto Rico
-- Since Puerto Rico has lower average income,
-- this explains the result observed in the previous analysis
-- Conclusion:
-- The result is not necessarily structural to the "Community" type,
-- but rather influenced by geographic concentration (location effect)
SELECT u.State_Name,
       City,
       ROUND(AVG(Mean),1),
       ROUND(AVG(Median),1)
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
    ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC;