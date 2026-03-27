# US Household Income Analysis

## Objective
Analyze household income data across U.S. regions to identify patterns, regional disparities, and key socioeconomic insights.

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

---

## Data Cleaning
The dataset required several preprocessing steps to ensure data quality:

- Removed duplicate records using `ROW_NUMBER()`
- Fixed inconsistent state names (e.g., "georia" → "Georgia")
- Standardized categorical variables (e.g., "Boroughs" → "Borough")
- Corrected encoding issues in column names
- Validated geographic inconsistencies (city/place mismatches)
- Ensured consistency across both tables

---

## Exploratory Data Analysis (EDA)
The analysis focused on understanding income distribution and regional differences:

- Income distribution by state (mean vs. median)
- Comparison between different region types (Type)
- Geographic patterns in income levels
- Identification of outliers and anomalies
- Analysis of land and water area distribution by state

---

## Key Insights
- Puerto Rico has significantly lower income levels compared to U.S. states  
- Median income is more reliable than mean due to the presence of outliers  
- "Community" regions show lower income levels, but this is driven by geographic concentration (Puerto Rico), not by the category itself  
- There are strong regional disparities in income across states  

---

## Analytical Considerations
- Mean income can be distorted by extreme values (outliers)  
- Median provides a more robust measure of central tendency  
- Geographic concentration can bias categorical analysis (e.g., "Community")  

---

## 🛠 Tools Used
- SQL (Joins, Window Functions, Aggregations)

## Project Structure
- sql/01_data_cleaning.sql  
- sql/02_eda.sql
