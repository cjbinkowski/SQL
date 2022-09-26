--This code analyzes data uploaded from https://ourworldindata.org/covid-deaths which contains data about global Covid-19 infections and deaths and vaccinations 
--Performed in SQL Server

--Death percentage per case of Covid in United States
SELECT Location, date, total_cases, total_deaths, total_deaths/total_cases*100 AS DeathPercentage
FROM [Covid Data]..CovidDeaths
WHERE Location LIKE '%states'
ORDER BY 1,2 desc

--Percent of Population in US that have been infected with Covid
SELECT Location, date, total_cases, population, total_cases/population*100 AS PercentInfected
FROM [Covid Data]..CovidDeaths
WHERE Location LIKE '%states'
ORDER BY 1,2 

--Infection rate per population by country
SELECT location, population, MAX(total_cases) AS CaseCount, MAX(total_cases/population*100) AS InfectionRate
FROM [Covid Data]..CovidDeaths
GROUP BY location, population
ORDER BY InfectionRate desc

--Death count by country
Select location, MAX(CAST(total_deaths AS int)) AS DeathCount
FROM [Covid Data]..CovidDeaths
WHERE Continent IS NOT NULL
GROUP BY location
ORDER BY DeathCount desc

--Death count by continent
SELECT location, MAX(CAST(total_deaths AS int)) AS DeathCount
FROM [Covid Data]..CovidDeaths
WHERE Continent IS NULL
GROUP BY location
ORDER BY DeathCount desc

--Cases and Deaths to date and Death Percentage by date
Select date, SUM(CAST(total_deaths as int)) AS DeathsToDate, SUM(CAST (total_cases AS int)) AS CasesToDate
, SUM(CAST(total_deaths AS float))/SUM(CAST (total_cases AS float))*100 AS DeathPercentage
FROM [Covid Data]..CovidDeaths
WHERE Continent is not null
GROUP BY date
ORDER BY 1 desc, 2

-- Percent Population Vaccinated
SELECT d.location, d.population, MAX(CAST(v.people_fully_vaccinated AS int)) AS FullyVaxxed
	--	people_fully_vaccinated is a rolling count
,MAX(CAST(v.people_fully_vaccinated AS int))/d.population*100 AS PercentFullyVaxxed
FROM [Covid Data]..CovidDeaths d
JOIN [Covid Data]..CovidVaccinations v
	ON D.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL
GROUP BY d.location, d.population
ORDER BY 4 desc

-- Alternative way to display vaccinations vs population
	-- This Query used the new_vaccinations field and takes the sum, as opposed to the query above which takes the max of the total number of fully vaccinated people
	-- This leads to a different statistic being output which is number of vaccinations vs. population rather than people vaccinated vs. population since two doses are required by some vaccine treatments to be fully vaccinated
SELECT d.location, d.population, SUM(CAST( v.new_vaccinations AS int))/d.population AS VaccsAdministeredPerPerson
FROM [Covid Data]..CovidDeaths d
JOIN [Covid Data]..CovidVaccinations v
	ON D.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL
GROUP BY d.location, d.population
ORDER BY 3 desc;

--This query institutes a Rolling Count of new vaccinations as a CTE and then finds the max of the new count
WITH VaxCount (location, population, new_vaccinations, VaccinationsToDate)
AS
(SELECT d.location, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations AS int)) OVER (Partition by d.location ORDER BY d.location, d.date) AS VaccinationsToDate
FROM [Covid Data]..CovidDeaths d
JOIN [Covid Data]..CovidVaccinations v
	ON D.location = v.location
	and d.date = v.date
WHERE d.continent IS NOT NULL)

SELECT *, VaccinationsToDate/population AS VaccsPerPerson
FROM VaxCount
	--Percent of Population Fully Vaccinated is approximately 50 times the VaccsPerPerson (0.1 VaccsPerPerson is roughly 5% of population fully vaccinated)

--This query uses the same data selection as the CTE query but uses a Temp Table in place of the CTE
DROP TABLE if exists	#VaccinationsToDate
	--Dropping table allows changes to be made to the temp table and called again
CREATE TABLE #VaccinationsToDate
(Location nvarchar(255)
, Population numeric
, New_Vaccinations numeric
, VaccinationsToDate numeric)

INSERT INTO #VaccinationsToDate
SELECT d.location, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations AS int)) OVER (Partition by d.location ORDER BY d.location, d.date) AS VaccinationsToDate
FROM [Covid Data]..CovidDeaths d
JOIN [Covid Data]..CovidVaccinations v
	ON D.location = v.location
	and d.date = v.date
WHERE d.continent IS NOT NULL

SELECT *, VaccinationsToDate/population AS VaccsPerPerson
FROM #VaccinationsToDate

--Views
CREATE VIEW Deaths_by_Country
AS
SELECT location, MAX(CAST(total_deaths AS int)) AS DeathCount
FROM [Covid Data]..CovidDeaths
WHERE Continent IS NOT NULL
GROUP BY location

CREATE VIEW PopulationVaccinated
AS
SELECT d.location, d.population, MAX(CAST(v.people_fully_vaccinated AS int)) AS FullyVaxxed
,MAX(CAST(v.people_fully_vaccinated AS int))/d.population*100 AS PercentFullyVaxxed
FROM [Covid Data]..CovidDeaths d
JOIN [Covid Data]..CovidVaccinations v
	ON D.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL
GROUP BY d.location, d.population

