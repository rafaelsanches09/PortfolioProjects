# COVID-19 Data Exploration using SQL

## Project Overview
COVID-19 is an infectious disease caused by the SARS-CoV-2 virus that spread globally in 2020. Its extensive public datasets provide an opportunity to explore real-world data using SQL and uncover trends related to infections, deaths, and vaccination efforts.

## Objectives

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

## Analysis Workflow

### 1. Initial Data Exploration

### 2. Selecting Relevant Data

### 3. Case Fatality Analysis

### 4. Infection Rate Analysis

### 5. Country-Level Comparisons

### 6. Continental Analysis

### 7. Global Statistics

### 8. Vaccination Analysis

### 9. Advanced SQL Features

## Key Findings

## Repository Structure

## How to Run

## Future Improvements

## Author
