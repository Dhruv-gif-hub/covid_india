# 🦠COVID-19 India Dashboard — SQL + Tableau Project

A data analytics and visualization project that explores the impact of COVID-19 across Indian states using SQL for data processing, Tableau for visual storytelling, and VS Code for scripting.
Dataset sourced from Kaggle.

## 🛠 Tools Used

- PostgreSQL – for data cleaning, transformation, and querying

- Tableau – for interactive dashboards and visualizations

- VS Code – for writing and managing SQL scripts

- Excel/CSV – for initial data formatting and inspection

- Kaggle Dataset – as the data source

## 📊 Project Overview

This project aims to analyze and visualize the spread and impact of COVID-19 in India. Using raw data from Kaggle, we built a clean relational database, generated analytical queries in SQL, and presented the findings through a Tableau dashboard.The tableau dashboard provide insight into:
- Total confirmed, recovered, and deceased cases

- Age-wise vaccination distribution

- State-wise comparison

- Trends over time

## 📁 Data Source

COVID-19 India [Dataset](https://www.kaggle.com/datasets/sudalairajkumar/covid19-in-india) from Kaggle

### Contains 
- COVID-19 cases at daily level
- Statewise testing details
- Vaccine details statewise


## 📊 Dashboard Features

- Interactive Map View showing deaths per state with color density based on confirmed cases

- Time-series line charts for trends in daily confirmed, recovered, and death cases

- Bar charts for state-wise comparisons

- Age Group Analysis of vaccinated individuals (18–44, 45–60, 60+)


##  1. Excel

Before working in SQL or Tableau, the dataset was manually cleaned using Excel:

- Removed duplicates and unnecessary columns

- Standardized column names (e.g., state_name, confirmed_cases)

- Handled missing values (replacing with 0 or NULL where appropriate)

Final CSV files were saved and imported into PostgreSQL.


## 🐘 2. PostgreSQL — Data Transformation & Analysis
PostgreSQL was used for writing complex SQL queries to extract insights:

### 🔧 Key Transformations:
- Date formatting and standardization

- Window functions for rolling averages and daily trends

- CTEs to break down large queries for modularity

#### PostgreSQL queries :

```sql
-- Query on the covid_india table 


WITH covid_new AS(
  SELECT 
    state_ut,
	MAX(cured) AS cured,
	MAX(deaths) AS deaths,
	MAX(confirmed) AS confirmed
  FROM
    covid_india
  WHERE 
    state_ut <> 'Unassigned' AND state_ut <> 'Cases being reassigned to states'
  GROUP BY
    state_ut
  ORDER BY
    state_ut ASC
)




WITH per_day AS(
SELECT
  c.state_ut,c._date_,COALESCE(c.confirmed-c.pev,NULL) AS per_day_cases,
  COALESCE(c.deaths-c.dea,NULL) AS per_day_deaths,
  COALESCE(c.cured-c.cu,NULL) AS per_day_cured
FROM
(
	SELECT
	  state_ut,_date_,confirmed,
	  LAG(confirmed) OVER(PARTITION BY state_ut ORDER BY _date_) AS pev,
	  deaths,
	  LAG(deaths) OVER(PARTITION BY state_ut ORDER BY _date_) AS dea,
	  cured,
	  LAG(cured) OVER(PARTITION BY state_ut ORDER BY _date_) AS cu
	FROM
	  covid_india 
) AS c
)

SELECT *
FROM per_day
WHERE 
  state_ut <> 'Cases being reassigned to states' 
  AND state_ut <> 'unassigned'




WITH per_day AS(
SELECT
  c.state_ut AS state_ut,
  c._date_ AS date,
  COALESCE(c.confirmed-c.pev,NULL) AS per_day_cases
FROM
(
	SELECT
	  state_ut,_date_,confirmed,LAG(confirmed) OVER(PARTITION BY state_ut ORDER BY _date_) AS pev
	FROM
	  covid_india 
) AS c
)
SELECT
  date,
  SUM(per_day_cases)
FROM
  per_day
GROUP BY
  date
ORDER BY
  date
    



SELECT
  c._state_,c._date_,COALESCE(c.total_samples-c.ts,NULL) AS per_day_samples,
  COALESCE(c.negative-c.ng,NULL) AS per_day_negative,
  COALESCE(c.positive-c.po,NULL) AS per_day_positive
FROM
(
	SELECT
	  _state_,_date_,total_samples,
	  LAG(total_samples) OVER(PARTITION BY _state_ ORDER BY _date_) AS ts,
	  negative,
	  LAG(negative) OVER(PARTITION BY _state_ ORDER BY _date_) AS ng,
	  positive,
	  LAG(positive) OVER(PARTITION BY _state_ ORDER BY _date_) AS po
	FROM
	  statewise_testing_details
) AS c

```


## 📸 Screenshots

[Pic 1]()
[Pic 2]()


## 🔗 Live Dashboard:
📍[View on Tableau Public](https://public.tableau.com/app/profile/dhruv.bhatt1880/viz/Covid_19_India_17499761388210/CovidTrendsoverview)


## 📈 Key Insights

- Highest confirmed cases were consistently reported in Maharashtra and Kerala

- Tripura had the highest test positivity rate.

- As of June 2021 45-60 age group received the most vaccination.

- Death rate gradually declined as vaccination picked up


## 🙋‍♂️ Author
### Dhruv Bhatt

#### 🔗 [LinkedIn](https://www.linkedin.com/in/dhruv-bhatt-820b61352/) • [Twitter/X](https://x.com/DhruvBhatt47863) • [Hashnode](https://hashnode.com/@ChiefConnector) • [Medium](https://medium.com/@dhruvbhatt938_72019) 
