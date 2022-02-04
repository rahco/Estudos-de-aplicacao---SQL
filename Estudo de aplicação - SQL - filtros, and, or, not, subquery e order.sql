
-- Exemplo de filtro
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.tripduration < 600
LIMIT 5;

-- Exemplo de filtro + AND
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.tripduration < 600 and citibike_trips.tripduration >= 300 and citibike_trips.gender = 'female'
LIMIT 5;

-- Exemplo de filtro + AND + OR
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE (citibike_trips.tripduration < 600 and citibike_trips.gender = 'female') OR citibike_trips.gender = 'male'
LIMIT 5;

-- Exemplo de filtro + AND + OR + NOT
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE (NOT (citibike_trips.tripduration < 600 and citibike_trips.gender = 'female')) OR (citibike_trips.gender = 'male')
LIMIT 5;

-- Exemplo de subquery utilizando o Alias para filtrar a query o que somente é possível em uma subquery
SELECT * FROM (SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips)
WHERE duration_minutes < 10
LIMIT 5;

-- Outro formato de utilizar uma subquery para filtrar informações utilizando o Alias
WITH all_trips AS (SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips)
SELECT * FROM all_trips WHERE duration_minutes < 10
LIMIT 5;

-- Exemplo de ORDER para ordenar os registros apresentados
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.gender = 'female'
ORDER BY duration_minutes DESC 
LIMIT 5;

-- Exemplo de ORDER para ordenar os registros apresentados com dois parâmetros de ordenamento
SELECT citibike_trips.gender, citibike_trips.tripduration/60 AS duration_minutes
FROM `bigquery-public-data`.new_york.citibike_trips citibike_trips
WHERE citibike_trips.gender = 'female'
ORDER BY citibike_trips.gender, duration_minutes DESC 
LIMIT 5;










