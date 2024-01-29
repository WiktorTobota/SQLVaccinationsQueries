--SELECT *
--FROM ProcjektPortfolio..CovidDeaths
--WHERE continent is not null
--ORDER BY 3,4

--SELECT *
--FROM ProcjektPortfolio..CovidVaccinations
--ORDER BY 3,4

--Selecting data to use
SELECT Location, Date, total_cases, new_cases, total_deaths, population
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
ORDER BY 1,2

-- Total cases to Total Deaths
-- Shows likelihood of dying if you get covid in Poland
SELECT Location, Date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathPercentage
FROM ProcjektPortfolio..CovidDeaths
Where location like '%poland%'
ORDER BY 1,2

--Total cases to population
--shows pertentage of population of Poland that got covid
SELECT Location, Date, total_cases, population, (total_cases / population) * 100 as PopulationPercentage
FROM ProcjektPortfolio..CovidDeaths
Where location like '%Poland%'
ORDER BY 1,2

--Countries with highest Total cases to population
SELECT Location, MAX(total_cases) as HighestInfection, population, MAX((total_cases / population)) * 100 
	as PopulationPercentage
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
GROUP BY population, location
ORDER BY PopulationPercentage DESC 

-- Countries with hightest death count per population

SELECT Location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
GROUP BY population, location
ORDER BY TotalDeathCount DESC 

-- Continents with hightest death count per population

SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount DESC 



-- Global numbers per day

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
  SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as DeathPercentage
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--Global number total (up to 30-04-2021)

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
  SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as DeathPercentage
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
ORDER BY 1,2

--Joining two tables

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From ProcjektPortfolio..CovidDeaths dea
Join ProcjektPortfolio..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- Using CTE to perform Calculation

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From ProcjektPortfolio..CovidDeaths dea
Join ProcjektPortfolio..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- Using Temp Table to perform Calculation

Drop Table if exists #PercentPopulationVaccinated
Create Table.#PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From ProcjektPortfolio..CovidDeaths dea
Join ProcjektPortfolio..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating viev to store data

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From ProcjektPortfolio..CovidDeaths dea
Join ProcjektPortfolio..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3 

Create View GlobalNumbersPerDay as
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
  SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as DeathPercentage
FROM ProcjektPortfolio..CovidDeaths
WHERE continent is not null
GROUP BY date
--ORDER BY 1,2
