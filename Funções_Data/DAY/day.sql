-- ============================================================================
-- DAY - Extraindo o Dia de uma Data
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao DAY() extrai o componente de dia do mes de uma data ou datetime.
-- Retorna um numero inteiro de 1 a 31 representando o dia.
--
-- SINTAXE BASICA:
-- DAY(data)
-- DAYOFMONTH(data)
--
-- PARAMETROS:
-- - data : Valor DATE, DATETIME ou TIMESTAMP
--
-- RETORNO:
-- - Inteiro de 1 a 31 representando o dia do mes
-- - Retorna NULL se a entrada for NULL
--
-- COMPATIBILIDADE:
-- - MySQL: DAY(data), DAYOFMONTH(data)
-- - PostgreSQL: EXTRACT(DAY FROM data), DATE_PART('day', data)
-- - SQL Server: DAY(data), DATEPART(day, data)
-- - Oracle: EXTRACT(DAY FROM data), TO_CHAR(data, 'DD')
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Extraindo dia basico
-- ----------------------------------------------------------------------------
-- Obtendo o dia de eventos

SELECT 
    nome_evento,
    data_evento,
    DAY(data_evento) AS dia_evento
FROM eventos;

-- Resultado esperado:
-- | nome_evento  | data_evento | dia_evento |
-- |--------------|-------------|------------|
-- | Reuniao      | 2024-03-15  | 15         |
-- | Conferencia  | 2024-03-28  | 28         |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Filtrando por dia
-- ----------------------------------------------------------------------------
-- Registros do dia 15 de qualquer mes

SELECT *
FROM pagamentos
WHERE DAY(data_vencimento) = 15;

-- Registros de hoje (mesmo dia do mes):
SELECT *
FROM lembretes
WHERE DAY(data_lembrete) = DAY(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Aniversariantes de hoje
-- ----------------------------------------------------------------------------
-- Encontrando clientes que fazem aniversario hoje

SELECT nome, data_nascimento
FROM clientes
WHERE DAY(data_nascimento) = DAY(CURDATE())
  AND MONTH(data_nascimento) = MONTH(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Agrupando por dia do mes
-- ----------------------------------------------------------------------------
-- Distribuicao de vendas por dia do mes

SELECT 
    DAY(data_venda) AS dia,
    COUNT(*) AS quantidade_vendas,
    SUM(valor) AS total
FROM vendas
GROUP BY DAY(data_venda)
ORDER BY dia;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Funcoes relacionadas ao dia
-- ----------------------------------------------------------------------------
-- Outras funcoes de dia em MySQL

SELECT 
    data_pedido,
    DAY(data_pedido) AS dia_mes,
    DAYOFWEEK(data_pedido) AS dia_semana,     -- 1=Domingo, 7=Sabado
    DAYOFYEAR(data_pedido) AS dia_ano,        -- 1-366
    DAYNAME(data_pedido) AS nome_dia          -- 'Monday', 'Tuesday'...
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Variacoes por SGBD
-- ----------------------------------------------------------------------------

-- MySQL:
SELECT DAY('2024-03-15') AS dia;
SELECT DAYOFMONTH('2024-03-15') AS dia;

-- PostgreSQL:
SELECT EXTRACT(DAY FROM '2024-03-15'::DATE) AS dia;
SELECT DATE_PART('day', '2024-03-15'::DATE) AS dia;

-- SQL Server:
SELECT DAY('2024-03-15') AS dia;
SELECT DATEPART(day, '2024-03-15') AS dia;

-- Oracle:
SELECT EXTRACT(DAY FROM DATE '2024-03-15') AS dia FROM DUAL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Primeiro e ultimo dia do mes
-- ----------------------------------------------------------------------------
-- Encontrando primeiro e ultimo dia

-- MySQL:
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m-01') AS primeiro_dia,
    LAST_DAY(data_pedido) AS ultimo_dia
FROM pedidos;

-- PostgreSQL:
SELECT 
    DATE_TRUNC('month', data_pedido) AS primeiro_dia,
    (DATE_TRUNC('month', data_pedido) + INTERVAL '1 month - 1 day')::DATE AS ultimo_dia
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Verificando fim de mes
-- ----------------------------------------------------------------------------
-- Registros do ultimo dia de cada mes

SELECT *
FROM fechamentos
WHERE data_fechamento = LAST_DAY(data_fechamento);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. DAY e DAYOFMONTH sao equivalentes no MySQL
-- 2. Use DAYOFWEEK ou WEEKDAY para dia da semana
-- 3. Combine DAY, MONTH e YEAR para comparacoes completas
-- 4. LAST_DAY e util para encontrar fim do mes
-- 5. Evite usar DAY(coluna) em WHERE (prejudica indices)
--
-- ============================================================================
