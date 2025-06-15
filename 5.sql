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

