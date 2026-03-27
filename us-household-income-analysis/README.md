# US Household Income Analysis

## Objective
Analyze household income data across U.S. regions to uncover patterns, regional disparities, and key socioeconomic insights.

## Dataset
- Source: (add link here)

## Data Cleaning
The dataset required several preprocessing steps to ensure consistency and reliability:

- Removed duplicate records using `ROW_NUMBER()`
- Corrected inconsistent state names (e.g., "georia" → "Georgia")
- Standardized categorical variables
- Handled missing and invalid values
- Fixed encoding issues in column names

## Exploratory Data Analysis (EDA)
The analysis focused on understanding income distribution and regional differences:

- Income distribution by state (mean vs. median)
- Impact of region type on income levels
- Geographic patterns across the U.S.
- Identification of outliers and anomalies

## Key Insights
- Puerto Rico shows significantly lower income levels compared to U.S. states  
- Median income is a more reliable metric than mean due to the presence of outliers  
- "Community" regions appear to have lower income, but this is driven by geographic concentration (Puerto Rico), not by the category itself  
- There are strong regional disparities in income across states  

## Tools Used  
- SQL (Joins, Window Functions, Aggregations)
