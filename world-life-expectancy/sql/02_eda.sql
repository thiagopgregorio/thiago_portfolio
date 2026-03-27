-- Select all data from the table for an initial inspection
-- Objective: understand the structure, available columns, and identify potential areas for exploration
SELECT *
FROM world_life_expectancy
;


-- Calculate the minimum and maximum life expectancy by country
-- Objective: measure how much life expectancy has increased over the analyzed period
-- Remove invalid values (0), which likely represent missing data
-- Sorting in DESC order highlights countries with the greatest improvement
SELECT Country,
		MIN(`Life expectancy`),
        MAX(`Life expectancy`),
        ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
	HAVING MIN(`Life expectancy`) != 0
    AND MAX(`Life expectancy`) != 0
ORDER BY Life_Increase_15_Years DESC
;


-- Calculate the global average life expectancy per year
-- Objective: analyze the overall trend of life expectancy over time
-- Removing invalid values (0)
SELECT YEAR, 
		ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` != 0
    AND `Life expectancy` != 0
GROUP BY Year
ORDER BY Year
;


-- Calculate the average life expectancy and GDP by country
-- Objective: investigate a possible relationship between wealth and quality of life
-- Remove invalid values
-- Sort from highest to lowest GDP
-- A positive relationship between GDP and life expectancy is observed
-- Wealthier countries tend to have higher life expectancy
SELECT Country, 
		ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
        ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
	HAVING Life_Exp > 0
    AND GDP > 0
ORDER BY GDP DESC
;




-- Split the data into two groups: high GDP and low GDP
-- Objective: directly compare life expectancy between these groups
-- Countries with higher GDP (>=1500) have significantly higher life expectancy (74.2 vs 64.7)
-- This reinforces the hypothesis of a positive correlation between wealth and longevity
SELECT SUM(CASE
			WHEN GDP >= 1500 THEN 1
			ELSE 0
			END) AS High_GDP_Count,
		AVG(CASE
			WHEN GDP >= 1500 THEN `Life expectancy`
			ELSE NULL
			END) AS High_GDP_Life_Expectancy,
		SUM(CASE
			WHEN GDP <= 1500 THEN 1
			ELSE 0
			END) AS Low_GDP_Count,
		AVG(CASE
			WHEN GDP <= 1500 THEN `Life expectancy`
			ELSE NULL
			END) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy
;



-- Compare life expectancy between developed and developing countries
-- Developed countries (i.e., with Status "Developed") have higher average life expectancy (79.2 vs 66.8)
-- However, there is a significant imbalance in the sample:
-- there are many more developing countries (171) than developed ones (32)
-- This may influence the analysis, as the "Developing" group is more heterogeneous
-- and may contain greater socioeconomic variability
SELECT Status,
		ROUND(AVG(`Life expectancy`),1),
		COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;


-- Analyze the relationship between Body Mass Index (BMI) and life expectancy
-- There is a possible positive correlation between BMI and life expectancy
-- (this may indicate that countries with better nutrition have greater longevity)
-- Critical observation:
-- This relationship may not be causal. BMI could be correlated
-- with other factors, such as income level (GDP)
-- Wealthier countries tend to have better access to food (increasing BMI)
-- and also better healthcare systems (increasing life expectancy)

-- In other words, GDP may act as a confounding variable,
-- influencing both BMI and life expectancy
-- Apparently, BMI and life expectancy are positively correlated
SELECT Country, 
		ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
        ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
	HAVING Life_Exp > 0
    AND BMI > 0
ORDER BY BMI DESC
;



-- Analyze the evolution of adult mortality in Brazil over time
-- Using a window function to create a cumulative (rolling total)
-- Objective:
-- Understand how mortality evolves over time
-- and observe accumulated trends
SELECT Country,
		Year,
        `Life expectancy`,
        `Adult Mortality`,
        SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%Brazil%'
;