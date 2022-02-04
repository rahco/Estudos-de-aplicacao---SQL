
-- Exemplos montando expressões lógicas utilizando AND e OR

WITH example AS (
    SELECT true AS is_valid, 'a' AS letter, 1 AS position
    UNION ALL SELECT false, 'b', 2
    UNION ALL SELECT false, 'c', 3)
SELECT * FROM example
WHERE is_valid != false AND position > 0;

WITH example AS (
    SELECT true AS is_valid, 'a' AS letter, 1 AS position
    UNION ALL SELECT false, 'b', 2
    UNION ALL SELECT false, 'c', 3)
SELECT * FROM example
WHERE is_valid = true AND position > 0;

SELECT 
    gender, tripduration
FROM 
    `bigquery-public-data`.new_york_citibike.citibike_trips
    WHERE (tripduration < 600 AND gender = 'female')
    LIMIT 100;

---------------------------------------------------------------------

-- Exemplo de função lógica utilizando IF + ROUND
WITH catalog AS (
    SELECT 30.0 AS costPrice, 0.15 AS margin, 0.1 AS taxRate
    UNION ALL SELECT null, 0.21,0.15
    UNION ALL SELECT 30.0, null,0.09
    UNION ALL SELECT 30.0, 0.30,null
    UNION ALL SELECT 30.0, null,null)
SELECT ROUND(
    IF(costPrice IS NULL, 30.0, costPrice) * 
    IF(margin IS NULL, 0.10, margin) * 
    IF(taxRate IS NULL, 0.15, taxRate),2) AS formula 
FROM catalog;

---------------------------------------------------------------------

-- COALESCE - Função lógica que retorna o primeiro número não nulo em uma lista
WITH catalog AS (
    SELECT 30.0 AS costPrice, 0.15 AS margin, 0.1 AS taxRate
    UNION ALL SELECT NULL, 0.21,0.15
    UNION ALL SELECT 30.0, NULL,0.09
    UNION ALL SELECT 30.0, 0.30,NULL
    UNION ALL SELECT 30.0, NULL,0.10)
SELECT 
    IF(costPrice IS NULL, 30.0, costPrice) * 
    IF(margin IS NULL, 0.10, margin) * 
    IF(taxRate IS NULL, 0.15, taxRate) AS formula1, 
    COALESCE (
    costPrice * margin * taxRate,
    30.0 * margin * taxRate,
    costPrice * 0.10 * taxRate,
    costPrice * margin * 0.15) AS formula2 
FROM catalog;

---------------------------------------------------------------------

-- CAST - função utilizada para transformar o tipo de um dado (como no exemplo convertendo string para int64). O SAFE é aplicado junto ao exemplo para tornar NULL valores diferentes de numérico
WITH example AS (
    SELECT 'John' AS employee, 'Doente' AS Hours_work
    UNION ALL SELECT 'Jean', '100'
    UNION ALL SELECT 'Peter', 'De férias'
    UNION ALL SELECT 'Mary', '80')
SELECT * FROM example;

WITH example AS (
    SELECT 'John' AS employee, 'Doente' AS Hours_work
    UNION ALL SELECT 'Jean', '100'
    UNION ALL SELECT 'Peter', 'De férias'
    UNION ALL SELECT 'Mary', '80')
SELECT SUM(SAFE_CAST(Hours_work AS INT64)) AS total FROM example;

---------------------------------------------------------------------

-- Exemplos de uso do CASE WHEN

WITH Numbers AS
(
    SELECT 90 AS A, 2 AS B
    UNION ALL SELECT 50,8
    UNION ALL SELECT 60,6
    UNION ALL SELECT 50,10
) SELECT A, B,
CASE WHEN A = 90 THEN 'red'
WHEN A = 50 THEN 'blue'
ELSE 'green' END AS Color
FROM Numbers;

WITH Numbers AS
(
    SELECT 90 AS A, 2 AS B
    UNION ALL SELECT 50,8
    UNION ALL SELECT 60,6
    UNION ALL SELECT 50,10
) SELECT A, B,
CASE A 
WHEN 90 THEN 'red'
WHEN 50 THEN 'blue'
ELSE 'green' END AS Color
FROM Numbers;

WITH Numbers AS
(
    SELECT 90 AS A, 2 AS B
    UNION ALL SELECT 50,8
    UNION ALL SELECT 60,6
    UNION ALL SELECT 50,10
) SELECT A, B,
CASE WHEN (A = 90 AND B > 2) THEN 'red'
WHEN A = 50 THEN 'blue'
ELSE 'green' END AS Color
FROM Numbers;

WITH Students AS
(SELECT 'A1' AS ALUNO, 11 AS AGE
UNION ALL SELECT 'A2', 12
UNION ALL SELECT 'A3', 11
UNION ALL SELECT 'A4', 14
UNION ALL SELECT 'A5', 17
UNION ALL SELECT 'A6', 17
UNION ALL SELECT 'A7', 18
UNION ALL SELECT 'A8', 16
UNION ALL SELECT 'A9', 11
UNION ALL SELECT 'A10', 12
UNION ALL SELECT 'A11', 13
UNION ALL SELECT 'A12', 13
UNION ALL SELECT 'A13', 16)
SELECT ALUNO, RANGE_BUCKET(AGE, [9,13,15,18]), 
CASE 
WHEN AGE >= 9 AND AGE < 13 THEN '1'
WHEN AGE >= 13 AND AGE < 15 THEN '2'
WHEN AGE >= 15 AND AGE < 18 THEN '3'
ELSE '4' END
FROM Students

---------------------------------------------------------------------



































