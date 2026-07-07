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

```sql
SELECT * 
FROM dbo.Coviddeaths
ORDER BY 3, 4;
```
<img width="1881" height="381" alt="image" src="https://github.com/user-attachments/assets/3c1c43ec-2f21-49a6-b0fc-50ed8ab27e54" />

```sql
SELECT * 
FROM dbo.Covidvaccinations
ORDER BY 3, 4;
```
<img width="1875" height="393" alt="image" src="https://github.com/user-attachments/assets/9e3a9d23-faf4-479b-804e-e1e6bf3c0785" />

During the initial exploration, it was observed that some records have NULL values in the continent column. These rows represent aggregated data (such as continents or global totals) rather than individual countries. Since this analysis focuses on country-level metrics, these records are excluded from subsequent queries.

---

### 2. Selecting Relevant Data

Only the columns required for the analysis are selected to improve readability and focus.

```sql
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;
```
<img width="657" height="408" alt="image" src="https://github.com/user-attachments/assets/b7c45bb8-a305-4149-ad86-4765ee026d1c" />

---

### 3. Case Fatality Analysis

Calculated the percentage of deaths relative to confirmed COVID-19 cases for each country over time.

**Question answered:**

> How likely was a confirmed COVID-19 case to result in death?

```sql
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;
```
<img width="752" height="426" alt="image" src="https://github.com/user-attachments/assets/bd4b234b-fcd8-44ee-98d9-96386824e4af" />


---

### 4. Infection Rate Analysis

Compared confirmed cases against each country's population to measure infection rates.

**Question answered:**

> What percentage of each country's population was infected?

```sql
SELECT Location, date, total_cases, population, (total_cases/population)*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;
```
<img width="700" height="407" alt="image" src="https://github.com/user-attachments/assets/8397c349-36cc-4997-95db-2892d24acaa4" />

---

### 5. Country-Level Comparisons

Identified:

- Countries with the highest infection rates

- Countries with the highest death counts
```sql
SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population,
MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;
```
<img width="711" height="415" alt="image" src="https://github.com/user-attachments/assets/feac7f0c-0fe7-48b7-8c4f-52657d035fca" />

- Regional comparisons for South America
```sql
SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent = 'South America'
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;
```
<img width="727" height="351" alt="image" src="https://github.com/user-attachments/assets/8997cd84-cd15-47fa-b76e-cbc25fff70cb" />

  
- Regional comparisons for Europe
```sql
SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent = 'Europe'
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;
```
<img width="667" height="451" alt="image" src="https://github.com/user-attachments/assets/245b7fbb-eb0f-4eaa-94d8-a28683752eb5" />


---

### 6. Continental Analysis

Aggregated data by continent to compare total death counts across regions.

```sql
SELECT location, MAX(CAST(total_deaths as INT)) as TotalDeathCount
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;
```
<img width="293" height="227" alt="image" src="https://github.com/user-attachments/assets/8086d1b4-b55a-4fbf-807c-4172a0e1c3f3" />

---

### 7. Global Statistics

Calculated worldwide figures including:

- Daily Analysis: Total confirmed cases, Total deaths, Death Percentage

```sql
SELECT date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))*100/SUM(new_cases) as Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2
```
<img width="561" height="457" alt="image" src="https://github.com/user-attachments/assets/0c0745b4-04d5-46be-a717-e584e21ab600" />

- Comulative Analysis: Total confirmed cases, Total deaths, Death Percentage

```sql
SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))*100/SUM(new_cases) as Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2
```
<img width="392" height="87" alt="image" src="https://github.com/user-attachments/assets/2bfd63e9-c5d9-4782-864c-27088cfded40" />
  

---

### 8. Vaccination Analysis

Combined deaths and vaccination datasets to analyze vaccination progress over time.

A rolling cumulative vaccination count was calculated for each country using window functions.

```sql
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) AS 
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(cast(cv.new_vaccinations as int)) OVER (PARTITION BY  cd.location ORDER BY cd.location, cd.date) as RollingPeopleVaccinated
FROM CovidDeaths cd
JOIN CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL --AND cd.location = 'Brazil'
-- ORDER BY 1,2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac
ORDER BY Continent, Location, Date
```
<img width="947" height="246" alt="image" src="https://github.com/user-attachments/assets/71c4bfb6-4b3a-47b1-8349-5ade83fd055a" />

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
