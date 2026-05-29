-- ============================================================================
-- MONTH - Extraindo o Mes de uma Data
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao MONTH() extrai o componente de mes de uma data ou datetime.
-- Retorna um numero inteiro de 1 a 12 representando o mes.
--
-- SINTAXE BASICA:
-- MONTH(data)
--
-- PARAMETROS:
-- - data : Valor DATE, DATETIME ou TIMESTAMP
--
-- RETORNO:
-- - Inteiro de 1 (janeiro) a 12 (dezembro)
-- - Retorna NULL se a entrada for NULL
--
-- COMPATIBILIDADE:
-- - MySQL: MONTH(data), MONTHNAME(data) para nome
-- - PostgreSQL: EXTRACT(MONTH FROM data), DATE_PART('month', data)
-- - SQL Server: MONTH(data), DATEPART(month, data), DATENAME(month, data)
-- - Oracle: EXTRACT(MONTH FROM data), TO_CHAR(data, 'MM')
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Extraindo mes basico
-- ----------------------------------------------------------------------------
-- Obtendo o mes de pedidos

SELECT 
    id_pedido,
    data_pedido,
    MONTH(data_pedido) AS mes_pedido
FROM pedidos;

-- Resultado esperado:
-- | id_pedido | data_pedido | mes_pedido |
-- |-----------|-------------|------------|
-- | 1         | 2024-03-15  | 3          |
-- | 2         | 2024-07-20  | 7          |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Filtrando por mes
-- ----------------------------------------------------------------------------
-- Vendas de marco

SELECT *
FROM vendas
WHERE MONTH(data_venda) = 3;

-- Vendas do mes atual:
SELECT *
FROM vendas
WHERE MONTH(data_venda) = MONTH(CURDATE())
  AND YEAR(data_venda) = YEAR(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Agrupando por mes
-- ----------------------------------------------------------------------------
-- Vendas totais por mes do ano atual

SELECT 
    MONTH(data_venda) AS mes,
    COUNT(*) AS quantidade,
    SUM(valor) AS total
FROM vendas
WHERE YEAR(data_venda) = YEAR(CURDATE())
GROUP BY MONTH(data_venda)
ORDER BY mes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Nome do mes (MySQL)
-- ----------------------------------------------------------------------------
-- Obtendo o nome do mes por extenso

SELECT 
    data_pedido,
    MONTHNAME(data_pedido) AS nome_mes
FROM pedidos;

-- Resultado: 'January', 'February', etc.

-- Em portugues (depende da configuracao do servidor):
-- SET lc_time_names = 'pt_BR';
-- SELECT MONTHNAME(data_pedido) AS nome_mes FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Aniversariantes do mes
-- ----------------------------------------------------------------------------
-- Clientes que fazem aniversario este mes

SELECT nome, data_nascimento
FROM clientes
WHERE MONTH(data_nascimento) = MONTH(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Relatorio mensal comparativo
-- ----------------------------------------------------------------------------
-- Comparando meses entre anos

SELECT 
    YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes,
    SUM(valor) AS total
FROM vendas
WHERE YEAR(data_venda) IN (2023, 2024)
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY mes, ano;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Variacoes por SGBD
-- ----------------------------------------------------------------------------

-- MySQL:
SELECT MONTH('2024-03-15') AS mes;
SELECT MONTHNAME('2024-03-15') AS nome_mes;

-- PostgreSQL:
SELECT EXTRACT(MONTH FROM '2024-03-15'::DATE) AS mes;
SELECT TO_CHAR('2024-03-15'::DATE, 'Month') AS nome_mes;

-- SQL Server:
SELECT MONTH('2024-03-15') AS mes;
SELECT DATENAME(month, '2024-03-15') AS nome_mes;

-- Oracle:
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') AS mes FROM DUAL;
SELECT TO_CHAR(DATE '2024-03-15', 'Month') AS nome_mes FROM DUAL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Formatando mes com zero a esquerda
-- ----------------------------------------------------------------------------
-- Garantindo formato MM

SELECT 
    LPAD(MONTH(data_pedido), 2, '0') AS mes_formatado
FROM pedidos;

-- Resultado: '01', '02', ... '12'

-- MySQL alternativa:
SELECT DATE_FORMAT(data_pedido, '%m') AS mes_formatado FROM pedidos;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre combine MONTH com YEAR para evitar misturar anos
-- 2. Use LPAD para garantir formato de 2 digitos
-- 3. MONTHNAME depende da configuracao de locale do servidor
-- 4. Evite MONTH(coluna) em clausulas WHERE (prejudica indices)
-- 5. Para relatorios, considere criar tabela de dimensao de tempo
--
-- ============================================================================
