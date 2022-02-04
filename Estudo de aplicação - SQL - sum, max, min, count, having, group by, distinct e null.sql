
-- Exemplo de agregação de média (AVG) com agrupamento (GROUP BY)
SELECT citibike_trips.gender, AVG(citibike_trips.tripduration/60) AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
GROUP BY citibike_trips.gender
ORDER BY duration_minutes DESC;

-- Exemplo de agregações filtrando máximo (MAX), mínimo (MIN) e somando (SUM)
SELECT 
citibike_trips.gender, 
MAX(citibike_trips.tripduration/60) AS duration_minutes_MAX, 
MIN(citibike_trips.tripduration/60) AS duration_minutes_MIN, 
SUM(citibike_trips.tripduration/60) AS duration_minutes_SUM
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
GROUP BY citibike_trips.gender;

-- Exemplo de agregação de contagem (COUNT)
SELECT citibike_trips.gender, COUNT(*) AS Rides, AVG(citibike_trips.tripduration/60) AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
GROUP BY citibike_trips.gender
ORDER BY duration_minutes DESC;

SELECT COUNT(*) FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips;

-- Exemplo utilizando o comando HAVING para filtrar o resultado de uma agregação com GROUP BY
SELECT citibike_trips.gender, AVG(citibike_trips.tripduration/60) AS duration_minutes_AVG
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
GROUP BY citibike_trips.gender
HAVING AVG(citibike_trips.tripduration/60) <= 18;

-- Exemplo utilizando o comando HAVING para filtrar o resultado de uma agregação com GROUP BY utilizando o Alias
SELECT citibike_trips.gender, AVG(citibike_trips.tripduration/60) AS duration_minutes_AVG
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
GROUP BY citibike_trips.gender
HAVING duration_minutes_AVG <= 18;

-- Exemplo de filtro de duplicatas em colunas utilizando o camando DISTINCT
SELECT DISTINCT citibike_trips.gender FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips;

-- Exemplo de filtro de duplicatas em colunas utilizando o camando DISTINCT + comando IS NOT FULL para remover vazios
SELECT DISTINCT citibike_trips.gender FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.bikeid IS NOT NULL;

-- Exemplo de filtro de duplicatas em colunas utilizando o camando DISTINCT aplicado a duas colunas + comando IS NOT FULL para remover vazios
SELECT DISTINCT citibike_trips.gender, citibike_trips.usertype FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.bikeid IS NOT NULL;









