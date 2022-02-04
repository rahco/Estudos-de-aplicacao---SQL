
-- Exemplos de aplicação do LOWER, UPPER e INITCAP que tornam strings com letras minúsculas, maiúsculas e com a inicial maiúscula respectivamente

WITH items AS
 (SELECT 'FOO' AS ITEM
 UNION ALL SELECT 'BAR'
 UNION ALL SELECT 'BAZ')
 SELECT LOWER(ITEM) FROM items;

WITH items AS
 (SELECT 'foo' AS ITEM
 UNION ALL SELECT 'bar'
 UNION ALL SELECT 'baz')
 SELECT UPPER(ITEM) FROM items;

WITH items AS
 (SELECT 'rUA Antonio Carlos' AS ITEM
 UNION ALL SELECT 'AVENIDA sÃO pAULO'
 UNION ALL SELECT 'tv atroS DO aLTO')
 SELECT ITEM, UPPER(ITEM), LOWER(ITEM) FROM items;

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso"
 UNION ALL SELECT "maça&laranja&pera"
 UNION ALL SELECT "tata ta tavendo a tatia")
 SELECT FRASES, INITCAP(FRASES) FROM examples;

-- Com o INITCAP é possível utilizar uma variável para determinar seu delimitador

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES, " " AS DELIMITER
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso", "+"
 UNION ALL SELECT "maça&laranja&pera", "&"
 UNION ALL SELECT "tata ta tavendo a tatia", "t")
 SELECT FRASES, INITCAP(FRASES), INITCAP(FRASES, DELIMITER) FROM examples;

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES, " " AS DELIMITER
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso", " "
 UNION ALL SELECT "maça&laranja&pera", " "
 UNION ALL SELECT "tata ta tavendo a tatia", " ")
 SELECT FRASES, INITCAP(FRASES), INITCAP(FRASES, DELIMITER) FROM examples;

------------------------------------------------------------------------------------

-- Exemplos de uso das funções LTRIM(remove os espaços a esquerda), RTRIM (remove os espaços a direita) e TRIM (remove os espaços em ambos os lados da palavra)

WITH items AS
 (SELECT "     MAÇA     " AS ITEM
 UNION ALL SELECT "     BANANA     "
 UNION ALL SELECT "     LARANJA     ")
 SELECT ITEM, LTRIM(ITEM), RTRIM(ITEM), TRIM(ITEM) FROM items;

-- Exemplo de uso da função LEFT (extrai partes a esquerda de uma palavra) e o RIGHT (extrai partes a direita de uma palavra)

 WITH items AS
 (SELECT "     MAÇA     " AS ITEM
 UNION ALL SELECT "     BANANA     "
 UNION ALL SELECT "     LARANJA     ")
 SELECT TRIM(ITEM), LEFT(TRIM(ITEM), 2), RIGHT(TRIM(ITEM),2) FROM items;

------------------------------------------------------------------------------------

-- Exemplos com CHAR_LENGTH, ENDS_WITH, STARTS_WITH, CONCAT

-- CHAR_LENGTH: retorna o número de caracteres que o string possui
-- ENDS_WITH: retorna TRUE se o string possui um determinado sufixo
-- STARTS_WITH: retorna TRUE se o string possui um determinado prefixo
-- CONCAT: concatena uma string

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome) FROM examples;

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome), 
CHAR_LENGTH(CONCAT (Titulo, " ", Nome, " ", Sobrenome)) FROM examples;

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome), 
CHAR_LENGTH(CONCAT (Titulo, " ", Nome, " ", Sobrenome)),
STARTS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "DR"), 
ENDS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "Dr") FROM examples;

------------------------------------------------------------------------------------

-- Exemplos de uso do INSTR, SUBSTR, STRPOS, REVERSE, REPLACE, SPLIT

-- INSTR: retorna a posição de um conjunto de caracteres dentro do string
-- SUBSTR: extrai uma parte do string de outro string com relação a posição
-- STRPOS: extrai um sub string do string a partir de um caracter
-- REVERSE: escreve o string de tras para frente
-- REPLACE: substitui um string por outro
-- SPLIT: transforma um string em array baseado num delimitador

WITH example AS
(SELECT 'banana' AS source_value, 'an' AS search_value, 1 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'an' AS search_value, 3 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'xx' AS search_value, 1 as position, 2 as occcurrence)
SELECT *, INSTR(source_value, search_value, position, occcurrence) FROM example;

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3,3) FROM example;

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, STRPOS(source_value, "@") FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SUBSTR(source_value,1, STRPOS(source_value, "@") - 1) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REVERSE(source_value) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REPLACE(source_value, "@","XXXXXX") FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SPLIT(source_value, "@") FROM example;

------------------------------------------------------------------------------------

-- Exemplos de uso do REGEXP_CONTAINS e REGEXP_EXTRACT

-- REGEXP_CONTAINS: retorna TRUE se existe no string algum conjunto de caracteres que respeite uma expressão regular
-- REGEXP_EXTRACT: extrai o campo que atente a uma expressão regular
-- REGEXP_EXTRACT_ALL: extrai todos os campo que atente a uma expressão regular criando um array caso tenha mais ocorrências
-- REGEXP_REPLACE: serve para substituir parte de um string que atenda a uma expressão regular por qualquer outro caracter

SELECT FIELD,
REGEXP_CONTAINS(FIELD, r'[0-9]{5}-[0-9]{3}') AS TEM_CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 1) AS CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 2) AS CEP2,
REGEXP_EXTRACT_ALL(FIELD, r'[0-9]{5}-[0-9]{3}') AS CEP3,
REGEXP_REPLACE(FIELD, r'[0-9]{5}-[0-9]{3}', 'XXXXX-XXX') AS CEP2,
FROM
(SELECT * from UNNEST
(["22222-22","     22222-222  ","Meu CEP é 222222-22", "Do CEP 22222-222 ATÉ O 22333-222"]) AS FIELD);

------------------------------------------------------------------------------------

-- FORMAT ("FORMATO", NUMERO)

SELECT FORMAT("%d", 10);
SELECT FORMAT("%15d", 10);
SELECT FORMAT("%015d", 10);

SELECT FORMAT("%015d", 10) AS RESULT
UNION ALL SELECT FORMAT("%015d", 10000000);

SELECT FORMAT("%'15d", 10000000);

SELECT FORMAT("%.*f", 3, 10.34548484548);

SELECT FORMAT("%'.*f", 3, 1054654654.34548484548);

SELECT FORMAT("%'.*e", 3, 1054654654.34548484548);

SELECT FORMAT("+%'.*e", 3, 1054654654.34548484548);


------------------------------------------------------------------------------------












