-- COVID-19 Global Analysis
-- SQL Analysis

-- 1. Total COVID-19 cases/Death by country
SELECT
  country,
  MAX(total_cases) AS total_cases,
  MAX(total_deaths) AS total_deaths,
  MAX(total_cases_per_million) AS cases_per_million,
  MAX(total_deaths_per_million) AS deaths_per_million
FROM
  `your-project.your-dataset.covid_data_full`
WHERE
  continent IS NOT NULL
  AND population > 1000000
GROUP BY
  country
ORDER BY
  total_cases DESC
LIMIT 20;


-- 2. Case trend over time 
SELECT
  country,
  date,
  new_cases_smoothed
FROM
  `your-project.your-dataset.covid_data_full`
WHERE
  country IN ('India', 'United States', 'Brazil', 'United Kingdom')
  AND new_cases_smoothed IS NOT NULL
ORDER BY
  country, date;


-- 3. Healthcare Capacity VS Outcome
SELECT
  country,
  MAX(hospital_beds_per_thousand) AS hospital_beds_per_thousand,
  MAX(gdp_per_capita) AS gdp_per_capita,
  MAX(total_deaths_per_million) AS deaths_per_million
FROM
  `your-project.your-dataset.covid_data_full`
WHERE
  continent IS NOT NULL
  AND population > 1000000
GROUP BY
  country
HAVING
  hospital_beds_per_thousand IS NOT NULL
  AND gdp_per_capita IS NOT NULL
  AND deaths_per_million IS NOT NULL
ORDER BY
  gdp_per_capita DESC;
-- 4. Stringency vs deaths
SELECT
  country,
  AVG(stringency_index) AS avg_stringency_index,
  MAX(total_deaths_per_million) AS deaths_per_million,
  MAX(gdp_per_capita) AS gdp_per_capita
FROM
  `your-project.your-dataset.covid_data_full`
WHERE
  continent IS NOT NULL
  AND population > 1000000
GROUP BY
  country
HAVING
  avg_stringency_index IS NOT NULL
  AND deaths_per_million IS NOT NULL
ORDER BY
  avg_stringency_index DESC;
