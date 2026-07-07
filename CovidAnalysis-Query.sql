-- First of all: Connect to 'PortfolioProject' database

USE PortfolioProject;
GO


-- Quick look at the two tables available: 'Coviddeaths' and 'Covidvaccinations'

SELECT * 
FROM dbo.Coviddeaths
ORDER BY 3, 4;

SELECT * 
FROM dbo.Covidvaccinations
ORDER BY 3, 4;


-- Select data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in your country

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT Location, date, total_cases, population, (total_cases/population)*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- Looking at Countries with Highest Infection Rate to Population

SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;


-- Looking at Countries with Highest Infection Rate to Population in South America

SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent = 'South America'
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;


-- Looking at Countries with Highest Infection Rate to Population in Europe

SELECT continent,Location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PopulationInfectedPercentage 
FROM CovidDeaths
WHERE continent = 'Europe'
GROUP BY continent,Location, population
ORDER BY PopulationInfectedPercentage DESC;


-- Showing Countries with Highest Death Count per Population

SELECT Location, MAX(total_deaths) as HighestDeathCount, population, MAX((total_deaths/population))*100 as PopulationDeathPercentage 
FROM CovidDeaths
GROUP BY Location, population
ORDER BY PopulationDeathPercentage DESC;


-- Showing the countries with the highest death count per population

SELECT continent, Location, MAX(CAST(total_deaths as INT)) as TotalDeathCount, population
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent, Location, population
ORDER BY TotalDeathCount DESC;


-- let's break things by continent
-- Showing the continent with the highest death count per population

SELECT location, MAX(CAST(total_deaths as INT)) as TotalDeathCount
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- GLOBAL FIGURES
-- Looking by date

SELECT date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))*100/SUM(new_cases) as Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


-- Overall figures

SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))*100/SUM(new_cases) as Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations

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


-- Temp Table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated 
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccination numeric,
RollingPeopleVaccinated numeric
) 

INSERT INTO #PercentPopulationVaccinated
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(cast(cv.new_vaccinations as int)) OVER (PARTITION BY  cd.location ORDER BY cd.location, cd.date) as RollingPeopleVaccinated
FROM CovidDeaths cd
JOIN CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
-- WHERE cd.continent IS NOT NULL --AND cd.location = 'Brazil'
-- ORDER BY 1,2,3
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated
ORDER BY Continent, Location, Date


-- Creating View to store data for later visualization

CREATE VIEW PercentPopulationVaccinated AS
(SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(cast(cv.new_vaccinations as int)) OVER (PARTITION BY  cd.location ORDER BY cd.location, cd.date) as RollingPeopleVaccinated
FROM CovidDeaths cd
JOIN CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL)

SELECT *
FROM PercentPopulationVaccinated
