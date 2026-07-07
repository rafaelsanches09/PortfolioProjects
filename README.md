# COVID-19 Data Exploration using SQL

## Project Overview
COVID-19 is an infectious disease caused by the SARS-CoV-2 virus that spread globally in 2020. Its extensive public datasets provide an opportunity to explore real-world data using SQL and uncover trends related to infections, deaths, and vaccination efforts.

## Objectives
- Exploring COVID-19 trends across countries
- Comparing infection and mortality rates
- Analyzing global statistics over time
- Evaluating vaccination progress
- Demonstrating advanced SQL querying techniques


## Dataset
The analysis is based on two relational tables extracted from the **Our World in Data COVID-19 dataset**.

## Database Structure

### Table: `CovidDeaths`
Contains daily records related to COVID-19 cases and deaths for each country.

| Column | Description |
|---------|-------------|
| `iso_code` | ISO country code |
| `continent` | Continent name |
| `location` | Country or region |
| `date` | Reporting date |
| `population` | Total population |
| `total_cases` | Cumulative confirmed cases |
| `new_cases` | New confirmed cases reported on the day |
| `total_deaths` | Cumulative deaths |
| `new_deaths` | New deaths reported on the day |

**Additional fields available**

- ICU admissions
- Hospital admissions
- Reproduction rate
- Cases per million
- Deaths per million
- Smoothed daily metrics
- Other healthcare indicators

---

### Table: `CovidVaccinations`

Contains vaccination, testing, and demographic information.

| Column | Description |
|---------|-------------|
| `iso_code` | ISO country code |
| `continent` | Continent name |
| `location` | Country or region |
| `date` | Reporting date |
| `new_vaccinations` | New vaccinations administered |
| `total_vaccinations` | Cumulative vaccinations |
| `people_vaccinated` | People with at least one dose |
| `people_fully_vaccinated` | People fully vaccinated |

**Additional fields available**

- COVID testing data
- Vaccination rates per hundred people
- Population density
- Median age
- GDP per capita
- Human Development Index (HDI)
- Life expectancy
- Hospital beds per thousand
- Smoking prevalence
- Diabetes prevalence
- Stringency index
- Other demographic and health indicators

---

### Relationship

The two tables are joined using:

- `location`
- `date`

```sql
CovidDeaths.location = CovidVaccinations.location
AND CovidDeaths.date = CovidVaccinations.date
```

This relationship enables the combination of case, death, population, and vaccination data in a single analysis.

## SQL Skills Demonstrated
- SELECT statements
- Filtering with WHERE
- Aggregate Functions (SUM, MAX)
- GROUP BY
- ORDER BY
- INNER JOIN
- Common Table Expressions (CTEs)
- Window Functions
- Temporary Tables
- Views
- Data Type Conversion (CAST)

---

## Analysis Workflow

### 1. Initial Data Exploration

The analysis begins by inspecting both datasets to understand their structure and available fields.

---

### 2. Selecting Relevant Data

Only the columns required for the analysis are selected to improve readability and focus.

---

### 3. Case Fatality Analysis

Calculated the percentage of deaths relative to confirmed COVID-19 cases for each country over time.

**Question answered:**

> How likely was a confirmed COVID-19 case to result in death?

---

### 4. Infection Rate Analysis

Compared confirmed cases against each country's population to measure infection rates.

**Question answered:**

> What percentage of each country's population was infected?

---

### 5. Country-Level Comparisons

Identified:

- Countries with the highest infection rates
- Countries with the highest death counts
- Regional comparisons for South America
- Regional comparisons for Europe

---

### 6. Continental Analysis

Aggregated data by continent to compare total death counts across regions.

---

### 7. Global Statistics

Calculated worldwide figures including:

- Total confirmed cases
- Total deaths
- Global death percentage

Both cumulative and daily analyses were performed.

---

### 8. Vaccination Analysis

Combined deaths and vaccination datasets to analyze vaccination progress over time.

A rolling cumulative vaccination count was calculated for each country using window functions.

---

### 9. Advanced SQL Features

The project also demonstrates:

- Common Table Expressions (CTEs)
- Temporary Tables
- SQL Views

These techniques improve query organization and prepare the data for future visualization tools such as Power BI.

---

## Key Findings

Some insights generated during the analysis include:

- Infection rates varied significantly between countries.
- Countries with larger populations did not necessarily experience the highest infection percentages.
- Death counts were concentrated in a relatively small number of countries.
- Vaccination campaigns progressed at different speeds depending on the region.
- Window functions provide an efficient way to calculate cumulative vaccination totals.

---

## Repository Structure

```
📂 COVID-SQL-Project
│
├── COVID Portfolio Project.sql
├── README.md
└── dataset/
    ├── CovidDeaths.csv
    └── CovidVaccinations.csv
```

---

## How to Run

1. Download the datasets.
2. Import both CSV files into SQL Server.
3. Create the `PortfolioProject` database.
4. Execute the SQL script.
5. Review the queries and results.

---

## Future Improvements

Possible extensions for this project include:

- Interactive Power BI dashboard
- SQL stored procedures
- Parameterized queries
- Performance optimization using indexes
- Trend forecasting

---

## Author
**Rafael Sanches** 
