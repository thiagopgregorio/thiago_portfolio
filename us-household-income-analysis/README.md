# US Household Income Analysis

## Objective
This project analyzes household income distribution across U.S. regions, with the goal of identifying regional disparities and uncovering how geographic and structural factors influence income levels.

## Key Insights
- Puerto Rico consistently ranks as the lowest-income region, significantly below all U.S. states  
- Median income is more reliable than mean due to the presence of outliers  
- "Community" regions show lower income levels, but this is driven by geographic concentration (Puerto Rico), not by the category itself  
- There are strong regional disparities in income across states  

## Dataset
- Source: Dataset provided as CSV files (source not specified)
- Description: Dataset combining geographic and economic data across U.S. regions

### Tables

#### 1. USHouseholdIncome (Geographic Data)
Contains location and regional information:

- State_Name  
- County  
- City  
- Place  
- Type  
- Zip_Code  
- Area_Code  
- ALand (land area)  
- AWater (water area)  
- Lat / Lon (geographic coordinates)  

#### 2. USHouseholdIncome_Statistics (Economic Data)
Contains income-related metrics:

- Mean (average income)  
- Median (median income)  
- Stdev (standard deviation)  
- sum_w (weighting factor)  

Both tables are joined using the `id` column.


## Data Cleaning
The dataset required several preprocessing steps to ensure data quality:

- Removed duplicate records using `ROW_NUMBER()`
- Fixed inconsistent state names (e.g., "georia" → "Georgia")
- Standardized categorical variables (e.g., "Boroughs" → "Borough")
- Corrected encoding issues in column names
- Validated geographic inconsistencies (city/place mismatches)
- Ensured consistency across both tables


## Analysis Approach
- Income distribution by state (mean vs median)
- Comparison across region types
- Identification of anomalies and outliers
- Evaluation of geographic influence on income patterns


## Tools Used
- SQL (Joins, Window Functions, Aggregations)


## Project Structure
- sql/01_data_cleaning.sql  
- sql/02_eda.sql


For a more detailed walkthrough and full storytelling of the analysis:
https://thiagopgregorio.wixsite.com/thiago-gregorio-port/post/from-raw-data-to-insights-us-household-income-analysis
