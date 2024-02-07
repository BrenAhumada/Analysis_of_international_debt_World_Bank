-- creación de base de datos

CREATE DATABASE international_debt_statistics;

-- selección de la base con la cual trabajaré

USE international_debt_statistics;

-- creación de tablas

CREATE TABLE international_debt (
	country_name TEXT (500) not null,
    country_code TEXT (500) not null,
    indicator_name VARCHAR (500) not null,
    indicator_code VARCHAR (500) not null,
    debt FLOAT not null
);

-- validación de la migración

SELECT *
FROM international_debt;

-- Pregunta 1: ¿Cuántos países diferentes se encuentran en la base de datos?
-- Question 1: What is the number of distinct countries present in the database? 

SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt;

-- Pregunta 2: ¿Cuáles son los distintos indicadores de deuda?
-- Question 2: What are the distinct debt indicators?

SELECT DISTINCT indicator_name
FROM international_debt;

-- Pregunta 3: ¿Cuál es el monto total de la deuda de todos los países presentes en la tabla, en millones? Lo redondearemos con 2 decimales, a efectos de faciliar su comprensión.
-- Question 3: What is the total amount of debt owed by all the countries present in the table, in millions?

SELECT ROUND (sum(debt) / 1000000, 2) AS total_debt
FROM international_debt;

-- Pregunta 4: ¿Cuál es país que tiene mayor deuda? Lo redondearemos con 2 decimales, a efectos de faciliar su comprensión.
-- Question 4: What country has the highest amount of debt?

SELECT country_name AS country, ROUND(SUM(debt), 2) AS total_debt_by_country
FROM international_debt
GROUP BY country_name
ORDER BY total_debt_by_country DESC
LIMIT 1;

-- Pregunta 5: ¿Cuál es el monto promedio de deuda según los diferentes indicadores de deuda?
-- Question 5: What is the average amount of debt across different debt indicators?

SELECT indicator_name, indicator_code, ROUND(AVG(debt), 2) AS avg_debt_by_indicators
FROM international_debt
GROUP BY indicator_name, indicator_code
ORDER BY avg_debt_by_indicators DESC;

-- Pregunta 6: ¿Cuál es el importe máximo de reembolsos de principal en la categoría "DT.AMT.DLXF.CD"?
-- Question 6: What is the highest amount of principal repayments in the "DT.AMT.DLXF.CD" category?

SELECT country_name, indicator_name, MAX(debt) AS max_amount_debt
FROM international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY max_amount_debt DESC
LIMIT 1;

