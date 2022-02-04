
-- Exemplo de uso do EXTRACT para extrair parte de uma informação de tempo em uma determinada data
SELECT 
gender, EXTRACT(YEAR FROM starttime) AS year, COUNT(1) AS numtrips
FROM `bigquery-public-data`.new_york_citibike.citibike_trips citibike_trips
WHERE gender != 'unknown' AND starttime IS NOT NULL
GROUP BY gender, year
HAVING year > 2016;

-- Exemplo de subquery com ARRAY_AGG que cria uma lista com agregação para agrupar dados em linhas
SELECT gender, ARRAY_AGG(numtrips ORDER BY year) FROM 
(SELECT 
gender, EXTRACT(YEAR FROM starttime) AS year, COUNT(1) AS numtrips
FROM `bigquery-public-data`.new_york_citibike.citibike_trips citibike_trips
WHERE gender != 'unknown' AND starttime IS NOT NULL
GROUP BY gender, year
HAVING year > 2016)
GROUP BY gender;

-- Exemplo de uso do STRUCT para criar uma ARRAY
SELECT [
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
] AS bikerides;

-- Exemplo de subquery com uso do STRUCT junto com ARRAY_LENGTH para coleta do número de linhas disponíveis na array
SELECT ARRAY_LENGTH(bikerides) FROM 
(SELECT [
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
] AS bikerides);

-- Exemplo de subquery com uso do STRUCT + ARRAY_LENGTH + função para buscar um item da lista
SELECT ARRAY_LENGTH(bikerides), bikerides[OFFSET(0)].gender AS first_gender FROM 
(SELECT [
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
] AS bikerides);

-- Exemplo de subquery com uso do STRUCT + ARRAY_LENGTH + função para buscar um item da lista relacionado a outra ARRAY
SELECT ARRAY_LENGTH(bikerides), bikerides[OFFSET(1)].numtrips[OFFSET (0)] AS first_gender FROM 
(SELECT [
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
] AS bikerides);

-- Exemplo de uso do UNNEST para representar em uma tabala os dados criados em uma ARRAY
SELECT * FROM UNNEST ([
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
]);

-- Exemplo de uso do UNNEST para representar em uma tabala os dados criados em uma ARRAY, selecionando apenas uma coluna
SELECT gender  FROM UNNEST ([
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
]);

-- Exemplo de uso do UNNEST para representar em uma tabala os dados criados em uma ARRAY, selecionando apenas uma coluna
SELECT gender, numtrips [OFFSET(0)] AS first_element FROM UNNEST ([
    STRUCT ('MALE' AS gender, [9306602,3955871] AS numtrips),
    STRUCT ('FEMALE' AS gender, [3236735,1260893] AS numtrips)
]);











