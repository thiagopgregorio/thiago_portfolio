# US Household Income Analysis

## Objective
Analyze household income data across U.S. regions to identify patterns, regional disparities, and key socioeconomic insights.

## Dataset
- Source: (coloque o link aqui depois)

## Data Cleaning
- Removed duplicate records using ROW_NUMBER()
- Fixed inconsistent state names (e.g., "georia" → "Georgia")
- Standardized categorical variables
- Handled missing and inconsistent values
- Fixed encoding issues in column names

## Exploratory Data Analysis (EDA)
- Income distribution by state (mean vs median)
- Impact of region type on income
- Geographic patterns
- Outlier analysis

## Key Insights
- Puerto Rico has significantly lower income levels
- Median is more reliable than mean due to outliers
- "Community" regions appear poorer due to geographic concentration (Puerto Rico), not category itself
- Strong regional inequality across states

## Tools Used
- MySQL (Joins, Window Functions, Aggregations)
