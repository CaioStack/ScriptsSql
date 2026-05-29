-- ============================================================================
-- YEAR - Extraindo o Ano de uma Data
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao YEAR() extrai o componente de ano de uma data ou datetime.
-- Retorna um numero inteiro de 4 digitos representando o ano.
--
-- SINTAXE BASICA:
-- YEAR(data)
--
-- PARAMETROS:
-- - data : Valor DATE, DATETIME ou TIMESTAMP
--
-- RETORNO:
-- - Inteiro representando o ano (ex: 2024)
-- - Retorna NULL se a entrada for NULL
--
-- COMPATIBILIDADE:
-- - MySQL: YEAR(data)
-- - PostgreSQL: EXTRACT(YEAR FROM data), DATE_PART('year', data)
-- - SQL Server: YEAR(data), DATEPART(year, data)
-- - Oracle: EXTRACT(YEAR FROM data), TO_CHAR(data, 'YYYY')
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Extraindo ano basico
-- ----------------------------------------------------------------------------
-- Obtendo o ano de nascimento

SELECT 
    nome,
    data_nascimento,
    YEAR(data_nascimento) AS ano_nascimento
FROM clientes;

-- Resultado esperado:
-- | nome        | data_nascimento | ano_nascimento |
-- |-------------|-----------------|----------------|
-- | Maria Silva | 1990-05-15      | 1990           |
-- | Joao Santos | 1985-12-20      | 1985           |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Filtrando por ano
-- ----------------------------------------------------------------------------
-- Pedidos de um ano especifico

SELECT *
FROM pedidos
WHERE YEAR(data_pedido) = 2024;

-- Pedidos do ano atual:
SELECT *
FROM pedidos
WHERE YEAR(data_pedido) = YEAR(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Agrupando por ano
-- ----------------------------------------------------------------------------
-- Vendas totais por ano

SELECT 
    YEAR(data_venda) AS ano,
    COUNT(*) AS quantidade_vendas,
    SUM(valor) AS total_vendas
FROM vendas
GROUP BY YEAR(data_venda)
ORDER BY ano;

-- Resultado esperado:
-- | ano  | quantidade_vendas | total_vendas |
-- |------|-------------------|--------------|
-- | 2022 | 1500              | 250000.00    |
-- | 2023 | 2100              | 380000.00    |
-- | 2024 | 800               | 150000.00    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Calculando idade
-- ----------------------------------------------------------------------------
-- Idade aproximada dos clientes

SELECT 
    nome,
    data_nascimento,
    YEAR(CURDATE()) - YEAR(data_nascimento) AS idade_aproximada
FROM clientes;

-- Calculo mais preciso (considera mes e dia):
SELECT 
    nome,
    data_nascimento,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade
FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Comparando anos
-- ----------------------------------------------------------------------------
-- Clientes nascidos antes de 1990

SELECT *
FROM clientes
WHERE YEAR(data_nascimento) < 1990;

-- Clientes nascidos entre 1980 e 1995:
SELECT *
FROM clientes
WHERE YEAR(data_nascimento) BETWEEN 1980 AND 1995;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Variacoes por SGBD
-- ----------------------------------------------------------------------------

-- MySQL:
SELECT YEAR('2024-03-15') AS ano;

-- PostgreSQL:
SELECT EXTRACT(YEAR FROM '2024-03-15'::DATE) AS ano;
SELECT DATE_PART('year', '2024-03-15'::DATE) AS ano;

-- SQL Server:
SELECT YEAR('2024-03-15') AS ano;
SELECT DATEPART(year, '2024-03-15') AS ano;

-- Oracle:
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') AS ano FROM DUAL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Relatorios anuais
-- ----------------------------------------------------------------------------
-- Comparando vendas ano a ano

SELECT 
    YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes,
    SUM(valor) AS total
FROM vendas
WHERE YEAR(data_venda) IN (2023, 2024)
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY ano, mes;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Evite YEAR(coluna) em WHERE se possivel (prejudica indices)
-- 2. Prefira: WHERE data BETWEEN '2024-01-01' AND '2024-12-31'
-- 3. Use YEAR() principalmente em SELECT e GROUP BY
-- 4. Para PostgreSQL, EXTRACT e mais padrao ANSI
-- 5. Considere criar coluna computada para consultas frequentes
--
-- ============================================================================
