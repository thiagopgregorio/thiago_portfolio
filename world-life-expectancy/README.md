# World Life Expectancy Analysis

## Objective
Analyze global life expectancy data to understand how longevity has evolved over time and identify key factors associated with higher life expectancy across countries.

## Dataset
- Source: Dataset provided as a CSV file (source not specified)
- Description: Global dataset containing health and socioeconomic indicators by country and year

### Features
- Country  
- Year  
- Status (Developed / Developing)  
- Life expectancy  
- Adult Mortality  
- Infant deaths  
- Under-five deaths  
- BMI  
- Measles  
- Polio  
- Diphtheria  
- HIV/AIDS  
- GDP  
- Schooling  
- Thinness (1–19 years and 5–9 years)  
- Percentage expenditure  

## Data Cleaning
The dataset required multiple preprocessing steps to ensure data quality and consistency:

- Removed duplicate records based on Country-Year combinations using `ROW_NUMBER()`
- Handled missing values in the `Status` column using self joins, leveraging existing country-level information
- Identified and resolved SQL limitations (e.g., updating a table referenced in a subquery)
- Imputed missing `life expectancy` values using the average of adjacent years (temporal interpolation)
- Validated data consistency after cleaning

## Exploratory Data Analysis (EDA)
The analysis focused on identifying global patterns and relationships:

- Evolution of life expectancy over time
- Growth in life expectancy by country
- Relationship between GDP and life expectancy
- Comparison between developed and developing countries
- Analysis of BMI as a potential factor influencing longevity
- Country-specific trend analysis (Brazil case study using window functions)

## Key Insights
- Life expectancy has increased over time across most countries  
- There is a strong positive relationship between GDP and life expectancy  
- Countries with higher GDP tend to exhibit higher longevity  
- Developed countries show significantly higher life expectancy than developing ones  
- BMI is positively correlated with life expectancy, but this relationship is likely influenced by GDP (confounding effect)  
- Data imbalance between developed and developing countries should be considered when interpreting results  

## Analytical Considerations
- Some relationships (e.g., BMI and life expectancy) are not necessarily causal  
- GDP may act as a confounding variable, influencing multiple health-related factors  
- Uneven group sizes (developed vs. developing countries) may bias comparisons  

## Tools Used
- SQL (Joins, Window Functions, Aggregations)

## 📁 Project Structure
- sql/01_data_cleaning.sql  
- sql/02_eda.sql
