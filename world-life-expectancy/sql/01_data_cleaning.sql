SELECT * 
FROM world_life_expectancy
;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Objective: identify and remove duplicate records from the table.
-- Records are considered duplicates when they share the same
-- Country and Year combination.


-- Identify potential duplicate records by counting how many times
-- each Country-Year combination appears in the table.
-- If the count is greater than 1, duplicates exist.
SELECT Country, 
		Year,
        CONCAT(Country, Year),
        COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;


-- Inspect exactly which rows are duplicated.
-- We use ROW_NUMBER() to assign a sequence number within each
-- Country-Year group. The first record receives Row_Num = 1,
-- while duplicates receive values greater than 1.
SELECT *
FROM (
	SELECT Row_ID,
			CONCAT(Country, Year),
			ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy
    ) AS Row_table
WHERE Row_Num > 1
;


-- Remove duplicate records from the table.
-- We keep only the first occurrence of each Country-Year combination
-- and delete those where Row_Num > 1 (i.e., the duplicates).
DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
		SELECT Row_ID
		FROM (
			SELECT Row_ID,
					CONCAT(Country, Year),
					ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
			FROM world_life_expectancy
			) AS Row_table	
		WHERE Row_Num > 1
		)
;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Objective: identify and handle missing values in the Status column
-- using information from other records of the same country.
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

# Verificar quais categorias de Status existem no dataset (excluindo valores vazios)
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE status != ''
;

-- Identify which countries are classified as 'Developing'
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

-- Attempt to update Status to 'Developing' for all records
-- of countries already labeled as 'Developing'.
-- This query resulted in an error because MySQL does not allow
-- updating a table while it is being referenced in a subquery
-- within the same statement
-- (error: "You can't specify target table for update in FROM clause")
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (
	SELECT DISTINCT(Country)
	FROM world_life_expectancy
	WHERE Status = 'Developing'
	)
;


-- Corrected approach: perform a self join to update only
-- records with missing Status, using other records from the same
-- country where Status = 'Developing'
UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
	AND t2.Status != ''
    AND t2.Status = 'Developing'
;


-- Fill remaining missing Status values by assigning 'Developed'
-- when another record from the same country is already classified
-- as 'Developed'. The logic follows the same approach as above,
-- using a self join to reference another row from the same country.
UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
	AND t2.Status != ''
    AND t2.Status = 'Developed'
;
        
-------------------------------------------------------------------------------------------------------------------------------------------
-- Objective: identify and handle missing values in the `life expectancy` column.
-- Since only two records had missing values in the dataset, they were filled
-- using the average of the previous and next year's values for the same country.
-- This approach preserves the temporal consistency of the data.


-- Check which records have missing values in the `life expectancy` column
SELECT *
FROM world_life_expectancy
WHERE `life expectancy` = ''        
;


-- Inspect records with missing values along with the previous
-- and next year's values for the same country, also calculating
-- their average. This helps confirm the value to be used for imputation.
SELECT t1.Country, t1.Year, t1.`life expectancy`,
        t2.Country, t2.Year, t2.`life expectancy`,
        t3.Country, t3.Year, t3.`life expectancy`,
        ROUND((t2.`life expectancy` + t3.`life expectancy`) / 2,1)
FROM world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy AS t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`life expectancy` = ''
;


-- Update records with missing `life expectancy` values
-- by filling them with the average of the previous year (t2)
-- and the following year (t3) for the same country.
UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy AS t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`life expectancy` = ROUND((t2.`life expectancy` + t3.`life expectancy`) / 2,1)
WHERE t1.`life expectancy` = ''
;


-------------------------------------------------------------------------------------------------------------------------------------------
-- After completing the cleaning steps,
-- no additional significant issues were identified in the dataset.
-- Therefore, the data is considered ready to proceed
-- to the exploratory data analysis (EDA) stage.

SELECT * 
FROM world_life_expectancy