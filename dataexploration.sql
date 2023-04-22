/*Preparing data for visualization*/

/* Calculate the percentage of population infected with covid */

SELECT CovidDeaths.Location, CovidDeaths.Date, CovidDeaths.population, CovidDeaths.total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE (CovidDeaths.Location Like "*states*") AND continent is NOT NULL
ORDER BY 1, 2;

/* Show the highest vaccinated count per location with covid */

SELECT CovidDeaths.location, MAX(CovidVaccinations.people_vaccinated) AS Vaccinated
FROM CovidDeaths, CovidVaccinations
WHERE CovidDeaths.locations = CovidVaccinations.locations AND CovidDeaths.date = CovidVaccinations.date AND CovidDeaths.locations is NOT NULL
GROUP BY CovidDeaths.location;

/* Show the highest vaccinated count per continent with covid */

SELECT CovidDeaths.continent, MAX(CovidDeaths.total_deaths) AS Deaths
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY CovidDeaths.continent;

/* Calculate the death percenetage for United States */

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE Location LIKE "*states*" AND continent is NOT NULL
ORDER BY 1, 2;

/* Calculate the total new cases, new deaths and death percentage */

SELECT sum(new_cases) AS TotalCases, sum(new_deaths) AS TotalDeaths, (sum(new_deaths)/sum(new_cases))*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent is NOT NULL;

/* Calculate the total new cases, new deaths and death percentage according to each date */

SELECT date, sum(new_cases) AS TotalCases, sum(new_deaths) AS TotalDeaths, (sum(new_deaths)/sum(new_cases))*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 1, 2;

