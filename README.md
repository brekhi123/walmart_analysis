# Walmart Sales Analysis

## Project Overview
This project provides an end-to-end analysis of Walmart sales data, focusing on data cleaning, exploratory data analysis (EDA), and business insights using both Python (Pandas) and SQL. The goal is to uncover trends, answer key business questions, and identify branches with significant changes in revenue.

## Dataset
- **Source:** `Walmart.csv`
- **Rows:** 10,051 (before cleaning)
- **Columns:**
  - `invoice_id`: Unique transaction identifier
  - `Branch`: Store branch code
  - `City`: City of the branch
  - `category`: Product category
  - `unit_price`: Price per unit (string, e.g., "$74.69")
  - `quantity`: Number of units sold
  - `date`: Transaction date (DD/MM/YY)
  - `time`: Transaction time (HH:MM:SS)
  - `payment_method`: Payment method used
  - `rating`: Customer rating
  - `profit_margin`: Profit margin for the transaction

## End-to-End Workflow

### 1. Data Loading & Cleaning
- Load the dataset using Pandas.
- Remove duplicate records and rows with missing values.
- Convert `unit_price` from string to float.
- Add a `total` column (`unit_price * quantity`).
- Standardize column names to lowercase.

### 2. Exploratory Data Analysis (EDA)
- Inspect data shape, types, and summary statistics.
- Analyze payment methods, branch and city distributions, and product categories.
- Check for outliers and data consistency.

### 3. Business Problem Solving (SQL & Pandas)
Key business questions addressed:
- **Highest-rated category in each branch:** Identify which product category receives the best customer feedback per branch.
- **Busiest day for each branch:** Find the day of the week with the most transactions for each branch.
- **Total quantity sold per payment method:** Understand customer payment preferences and their impact on sales volume.
- **Ratings statistics by city and category:** Calculate average, minimum, and maximum ratings for each product category in every city.
- **Revenue and profit by category:** Determine which categories drive the most revenue and profit.
- **Most common payment method per branch:** Discover the preferred payment method for each branch.
- **Sales distribution by time of day:** Categorize sales into Morning, Afternoon, and Evening to analyze peak sales periods.
- **Branches with the highest revenue decrease compared to last year:** Identify branches with the most significant year-over-year revenue drops.

**See `sql_queries.sql` for the exact SQL queries used.**

### 4. Methods and Functionalities Used/Learned
- **Pandas:** Data loading, cleaning (`drop_duplicates`, `dropna`), type conversion, column operations, and basic EDA (`describe`, `info`, `head`).
- **SQL (PostgreSQL):** Window functions (`RANK()`), aggregation (`SUM`, `AVG`, `MIN`, `MAX`), grouping, filtering, date/time extraction, and CTEs (Common Table Expressions).
- **SQLAlchemy & psycopg2:** For connecting Python to SQL databases and executing queries.
- **Data Transformation:** Creating new columns, standardizing data, and preparing for analysis.

### 5. Results Interpretation
- Visualize and interpret the results to provide actionable business insights.

## Dependencies
Install dependencies with:
```bash
pip install -r requirements.txt
```
- pandas
- sqlalchemy
- psycopg2

## Key Results: Branches with Highest Revenue Decrease (Year-over-Year)
The following table shows the top 5 Walmart branches with the largest percentage decrease in revenue compared to the previous year:

| Branch   | Last Year Revenue | Current Year Revenue | Revenue Decrease (%) |
|----------|-------------------|---------------------|----------------------|
| WALM045  | 1,731             | 647                 | 62.62                |
| WALM047  | 2,581             | 1,069               | 58.58                |
| WALM098  | 2,446             | 1,030               | 57.89                |
| WALM033  | 2,099             | 931                 | 55.65                |
| WALM081  | 1,723             | 850                 | 50.67                |

### Explanation
The analysis reveals that these five branches experienced the most significant drops in revenue, with decreases ranging from approximately 50% to over 62%. Such a sharp decline may indicate underlying issues such as increased competition, changes in local demand, operational challenges, or shifts in consumer preferences. Identifying these branches allows Walmart to prioritize further investigation and targeted interventions, such as marketing campaigns, operational improvements, or localized promotions, to address the revenue decline and improve overall business performance.

---

## Further Steps: Interactive Dashboard
To enhance the analysis and make insights more accessible, the next step would be to develop an interactive dashboard. This dashboard could:
- Visualize key metrics (revenue, profit, ratings, sales by time, etc.) using charts and graphs.
- Allow users to filter by branch, category, city, or time period.
- Provide drill-down capabilities for deeper exploration of trends and anomalies.
- Tools such as **Tableau**, **Power BI**, or Python libraries like **Dash** or **Streamlit** can be used for this purpose.

**For more details, see the Jupyter notebook (`project.ipynb`) and SQL queries (`sql_queries.sql`).**
