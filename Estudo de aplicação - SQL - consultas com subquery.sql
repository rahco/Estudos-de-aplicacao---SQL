
SELECT * FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` LIMIT 1000;

SELECT * FROM `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` LIMIT 1000;

SELECT * FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO;

SELECT NF.CPF, NF.DATA_VENDA, INF.QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO;

SELECT NF.CPF, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, EXTRACT(MONTH FROM NF.DATA_VENDA) AS MES, INF.QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO;

SELECT NF.CPF, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, EXTRACT(MONTH FROM NF.DATA_VENDA) AS MES, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF, ANO, MES;

SELECT TC.CPF, TC.VOLUME_DE_COMPRA AS QUANTIDADE_MAXIMA FROM `curso-big-query-336522.sucos_vendas.tabela_de_clientes` TC;

SELECT NF.CPF, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, EXTRACT(MONTH FROM NF.DATA_VENDA) AS MES, SUM(INF.QUANTIDADE) AS QUANTIDADE, MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_MAXIMA 
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN `curso-big-query-336522.sucos_vendas.tabela_de_clientes` TC
ON NF.CPF = TC.CPF
GROUP BY NF.CPF, ANO, MES;


SELECT NF.CPF, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, 
EXTRACT(MONTH FROM NF.DATA_VENDA) AS MES, 
SUM(INF.QUANTIDADE) AS QUANTIDADE, 
MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_MAXIMA,
(MAX(TC.VOLUME_DE_COMPRA)-SUM(INF.QUANTIDADE)) AS DIFERENCA
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN `curso-big-query-336522.sucos_vendas.tabela_de_clientes` TC
ON NF.CPF = TC.CPF
GROUP BY NF.CPF, ANO, MES;

-- Query modelo de caso onde é solicitado a validação da uma condição de limite de venda mensal por cliente
SELECT X.CPF,
X.ANO,
X.MES,
X.QUANTIDADE,
X.QUANTIDADE_MAXIMA,
X.DIFERENCA,
CASE WHEN X.DIFERENCA >= 0 THEN 'VÁLIDA'
ELSE  'INVÁLIDA' END AS STATUS
FROM 
(SELECT NF.CPF, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, 
EXTRACT(MONTH FROM NF.DATA_VENDA) AS MES, 
SUM(INF.QUANTIDADE) AS QUANTIDADE, 
MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_MAXIMA,
(MAX(TC.VOLUME_DE_COMPRA)-SUM(INF.QUANTIDADE)) AS DIFERENCA
FROM `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN `curso-big-query-336522.sucos_vendas.tabela_de_clientes` TC
ON NF.CPF = TC.CPF
GROUP BY NF.CPF, ANO, MES) X
ORDER BY X.CPF, X.ANO, X.MES;


--`curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
--`curso-big-query-336522.sucos_vendas.notas_fiscais` NF
--`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP

SELECT * FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO;

SELECT TP.SABOR, INF.QUANTIDADE FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO;

SELECT TP.SABOR, NF.DATA_VENDA, INF.QUANTIDADE FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO;

SELECT TP.SABOR, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, ANO
ORDER BY QUANTIDADE DESC;

SELECT EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY ANO;

WITH VENDAS_POR_SABOR AS (
SELECT TP.SABOR, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, ANO
ORDER BY QUANTIDADE DESC),
VENDAS_TOTAIS AS (
SELECT EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY ANO)
SELECT VENDAS_POR_SABOR.SABOR, VENDAS_POR_SABOR.QUANTIDADE, VENDAS_TOTAIS.QUANTIDADE AS QUANTIDADE_TOTAL
FROM VENDAS_POR_SABOR
INNER JOIN VENDAS_TOTAIS
ON VENDAS_POR_SABOR.ANO = VENDAS_TOTAIS.ANO;

-- Exemplo de consulta para atender ao desafio de buscar a soma da quantidade vendidade de 2016 por sabor com o percentual de participação de venda de cada sabor
WITH VENDAS_POR_SABOR AS (
SELECT TP.SABOR, EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
`curso-big-query-336522.sucos_vendas.tabela_de_produtos` TP
INNER JOIN `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, ANO
ORDER BY QUANTIDADE DESC),
VENDAS_TOTAIS AS (
SELECT EXTRACT(YEAR FROM NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM `curso-big-query-336522.sucos_vendas.itens_notas_fiscais` INF
INNER JOIN `curso-big-query-336522.sucos_vendas.notas_fiscais` NF
ON INF.NUMERO = NF.NUMERO
WHERE EXTRACT(YEAR FROM NF.DATA_VENDA) = 2016
GROUP BY ANO)
SELECT VENDAS_POR_SABOR.SABOR, VENDAS_POR_SABOR.QUANTIDADE,
(VENDAS_POR_SABOR.QUANTIDADE / VENDAS_TOTAIS.QUANTIDADE)*100 AS PERCENTUAL_PARTICIPACAO
FROM VENDAS_POR_SABOR
INNER JOIN VENDAS_TOTAIS
ON VENDAS_POR_SABOR.ANO = VENDAS_TOTAIS.ANO
ORDER BY VENDAS_POR_SABOR.QUANTIDADE DESC










