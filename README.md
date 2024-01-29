# COVID-19 Data Analysis Repository

This repository contains SQL queries and data analysis scripts related to global COVID-19 statistics. The provided queries leverage datasets from the "ProcjektPortfolio" database, specifically focusing on the "CovidDeaths" and "CovidVaccinations" tables. The queries cover a range of analyses, including:

## 1. Filtering and Sorting

- Selecting data from the "CovidDeaths" table where the continent is not null and ordering by specified columns.
- Selecting data from the "CovidVaccinations" table and ordering by specified columns.

## 2. Statistical Analysis on Poland

- Calculating the likelihood of death if one contracts COVID-19 in Poland.
- Determining the percentage of the population in Poland that has contracted COVID-19.

## 3. Global Analysis

- Identifying countries with the highest total cases to population percentage.
- Identifying countries with the highest death count per population.
- Identifying continents with the highest death count per population.
- Analyzing global numbers per day, including total cases, total deaths, and death percentage.

## 4. Joining Tables

- Joining the "CovidDeaths" and "CovidVaccinations" tables to obtain data on COVID-19 deaths and vaccinations.
- Calculating the rolling sum of new vaccinations per location and date.

## 5. Using CTE (Common Table Expressions) for Calculations

- Creating a CTE named "PopvsVac" to perform calculations on COVID-19 deaths and vaccinations data.
- Calculating the percentage of the population vaccinated.

## 6. Using Temporary Table for Calculations

- Creating and populating a temporary table "#PercentPopulationVaccinated" to perform calculations.
- Calculating the percentage of the population vaccinated.

## 7. Creating Views to Store Data

- Creating views named "PercentPopulationVaccinated" and "GlobalNumbersPerDay" to store and retrieve specific data sets from the "CovidDeaths" and "CovidVaccinations" tables, respectively.

This repository provides a comprehensive set of SQL queries and analyses, showcasing different approaches to extract valuable insights from COVID-19 data, with a focus on population percentages, death rates, and vaccination trends across various regions.
I'm also providing a data sets that i was working with
