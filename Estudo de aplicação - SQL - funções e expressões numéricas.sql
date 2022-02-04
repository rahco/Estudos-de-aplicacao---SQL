
-- Exemplo de aplicação do ROUND para arrendondar casas decimais
WITH example AS
(SELECT 'Sat' AS Day, 1451 AS numrides, 1018 AS oneways
UNION ALL SELECT 'Sun', 2376,936)
SELECT *, (oneways/numrides) AS frac_oneway, ROUND(oneways/numrides, 2) AS frac_oneway_round
FROM example;

-- Exemplo de solução de divisão por zero utilizando a função IEEE_Divide que permite a execução da divisão retornando no lugar NaN (não numerico)
WITH example AS
(SELECT 'Sat' AS Day, 1451 AS numrides, 1018 AS oneways
UNION ALL SELECT 'Sun', 2376,936
UNION ALL SELECT 'Wed', 0,0)
SELECT *, ROUND(IEEE_Divide(oneways,numrides), 2) AS frac_oneway_round
FROM example;

-- Exemplo de solução para execução de operações matemáticas com erro utilizado a função SAFE que inseri o retorno de null para resultados não possíveis de serem processados
SELECT SAFE.LOG (10,-3), SAFE.LOG (10,3);

-- Exemplos do comportamento da função IEEE_DIVIDE com diferentes situações
WITH example AS
(SELECT 'Sat' AS Day, 1451 AS numrides, 1018 AS oneways
UNION ALL SELECT 'Sun', 2376,936
UNION ALL SELECT 'Mon', NULL,NULL
UNION ALL SELECT 'Tue', IEEE_DIVIDE(-3,0),0
UNION ALL SELECT 'Wed', IEEE_DIVIDE(3,0),0
)
SELECT * FROM example WHERE numrides < 2000;

-- Exemplos do comportamento de divisões utilizando o NUMERIC
WITH example AS
    (
    SELECT 1.23 AS PAYMENT
    UNION ALL SELECT 7.89
    UNION ALL SELECT 12.43
    )
SELECT SUM (PAYMENT) AS TOTAL_PAYMENT, AVG (PAYMENT) AS AVG_PAYMENT
FROM example;

WITH example AS
    (
    SELECT NUMERIC '1.23' AS PAYMENT
    UNION ALL SELECT NUMERIC '7.89'
    UNION ALL SELECT NUMERIC '12.43'
    )
SELECT SUM (PAYMENT) AS TOTAL_PAYMENT, AVG (PAYMENT) AS AVG_PAYMENT
FROM example;

-- Função SIGN - retorna um numero 1 ou -1 sendo 1 se for positivo e -1 se for negativo
SELECT SIGN(-3.45);

-- Função IS_INF - checa se um número é infinito ou não
SELECT IS_INF(IEEE_DIVIDE(3,0)), IEEE_DIVIDE(3,0);

-- Função IS_NAN - checa se um número é NAN ou não
SELECT IS_NAN(IEEE_DIVIDE(0,0)), IEEE_DIVIDE(0,0);

-- Função RAND - gera um número aleatório sendo >= 0 < 1
SELECT RAND();

-- Função SQRT - raiz quatrada
SELECT SQRT(25);

-- Função POW - número elevado a potência
SELECT POW(2,4);

-- Função logarítimicas - LN, LOG, LOG10
SELECT LOG10(5);

-- GREATEST - retorna o maior número dentro de um array
SELECT GREATEST (1,2,5,8,1,0,2,5,6,11,25,1,2,3,5,99,112);

-- LEAST - retorna o menor número dentro de um array
SELECT LEAST (1,2,5,8,1,0,2,5,6,11,25,1,2,3,5,99,112);

-- EXPRESSÕES MATEMATICAS - SAFE_ADD, SAFE_SUBSTRACT, SAFE_DIVIDE, SAVE_NEGATIVE - serve para a programação prever o estouro das casas decimais do INT64
SELECT SAFE_MULTIPLY(300000000000000000,1000000000000000);

-- MOD - retorna o resto de uma divisão
SELECT MOD (14,6);

-- Funções de arredondamento - ROUND, TRUNC
SELECT ROUND(3.48,1), TRUNC(3.48,1);

-- CEIL e FLOOR - retorna o respectivamente o maior e o menor número interio antes do número
SELECT CEIL(3.48), FLOOR(3.48);

-- SEN, COS, TAG, ACOS, ASEN, ATAG, SENH, (...)

-- RANGE_BUCKET - função que retorna a posição de um número dentro de um array ordenado
-- Esta função pode ser utilizada para buscar quantidades entre faixas de ocorrência em algum indicador
-- Como exemplo de aplicação temos a contagem de alunos de uma escola por faixa de idade
-- Quantos alunos eu tenho entre 10 e 13, entre 13 e 15 e entre 15 e 18

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
SELECT RANGE_BUCKET(AGE, [9,13,15,19]), COUNT(*) FROM Students
GROUP BY 1;
























