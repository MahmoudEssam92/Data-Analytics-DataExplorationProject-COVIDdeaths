--SELECT *
--FROM PortfolioProject..CovidDeaths
--ORDER BY 3,4
--SELECT *
--FROM PortfolioProject..CovidVaccinations$
--ORDER BY 3,4

SELECT Location,date,total_cases, new_cases,total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- The total cases and total deaths

SELECT Location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE LOCATION LIKE '%states%'
ORDER BY 1,2

-- Total cases vs population
SELECT Location,date, Population,total_cases, (total_cases/Population)*100 AS CasesPercentage
FROM PortfolioProject..CovidDeaths
WHERE LOCATION LIKE '%states%'
ORDER BY 1,2

-- Countries with highest infection rate compared to population

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/Population))*100 AS PercentopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE LOCATION LIKE '%Egypt%'
GROUP BY location,population
ORDER BY PercentopulationInfected desc

-- Countries with highest death rate

SELECT Location, population, MAX(total_deaths) AS HighestDeaths, MAX((Total_Deaths/population))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
GROUP BY location,population
ORDER BY DeathPercentage DESC

-- Countries with highest death rate

SELECT Location, MAX(cast(total_deaths as int)) AS HighestDeaths
FROM PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY location
ORDER BY HighestDeaths DESC

-- Continent with highest death rate

SELECT continent, MAX(cast(total_deaths as int)) AS HighestDeaths
FROM PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY continent
ORDER BY HighestDeaths DESC

-- Continent with the highest death count per population
SELECT continent, MAX(cast(total_deaths as int)) AS HighestDeaths
FROM PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY continent
ORDER BY HighestDeaths DESC

-- Total population and vaccinatons
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location)
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3
