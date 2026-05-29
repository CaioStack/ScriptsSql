-- ============================================================================
-- CURDATE - Data Atual (Sem Hora)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao CURDATE() retorna apenas a data atual, sem o componente de hora.
-- E util quando voce precisa trabalhar apenas com datas, ignorando o horario.
--
-- SINTAXE BASICA:
-- CURDATE()
--
-- RETORNO:
-- - DATE no formato 'YYYY-MM-DD'
-- - Nao inclui informacoes de hora
--
-- COMPATIBILIDADE:
-- - MySQL: CURDATE(), CURRENT_DATE, CURRENT_DATE()
-- - PostgreSQL: CURRENT_DATE
-- - SQL Server: CAST(GETDATE() AS DATE), CONVERT(DATE, GETDATE())
-- - Oracle: TRUNC(SYSDATE)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Obtendo data atual
-- ----------------------------------------------------------------------------
-- Retornando apenas a data de hoje

SELECT CURDATE() AS data_hoje;

-- Resultado esperado:
-- | data_hoje   |
-- |-------------|
-- | 2024-03-15  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Comparando datas
-- ----------------------------------------------------------------------------
-- Encontrando pedidos de hoje

SELECT *
FROM pedidos
WHERE DATE(data_criacao) = CURDATE();

-- Ou mais eficiente (usa indice):
SELECT *
FROM pedidos
WHERE data_criacao >= CURDATE() 
  AND data_criacao < CURDATE() + INTERVAL 1 DAY;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Aniversariantes do dia
-- ----------------------------------------------------------------------------
-- Encontrando clientes que fazem aniversario hoje

SELECT nome, data_nascimento
FROM clientes
WHERE MONTH(data_nascimento) = MONTH(CURDATE())
  AND DAY(data_nascimento) = DAY(CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Verificando vencimentos
-- ----------------------------------------------------------------------------
-- Encontrando faturas vencidas

SELECT *
FROM faturas
WHERE data_vencimento < CURDATE() AND status = 'pendente';

-- Faturas que vencem hoje:
SELECT *
FROM faturas
WHERE data_vencimento = CURDATE();

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Calculando dias
-- ----------------------------------------------------------------------------
-- Dias desde a ultima compra

SELECT 
    cliente_id,
    MAX(data_pedido) AS ultima_compra,
    DATEDIFF(CURDATE(), MAX(data_pedido)) AS dias_sem_comprar
FROM pedidos
GROUP BY cliente_id;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Variacoes por SGBD
-- ----------------------------------------------------------------------------

-- MySQL:
SELECT CURDATE() AS hoje;
SELECT CURRENT_DATE AS hoje;

-- PostgreSQL:
SELECT CURRENT_DATE AS hoje;

-- SQL Server:
SELECT CAST(GETDATE() AS DATE) AS hoje;
SELECT CONVERT(DATE, GETDATE()) AS hoje;

-- Oracle:
SELECT TRUNC(SYSDATE) FROM DUAL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Inserindo com data atual
-- ----------------------------------------------------------------------------
-- Registrando eventos com data de hoje

INSERT INTO eventos (nome, data_evento)
VALUES ('Reuniao Semanal', CURDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Filtros com intervalo
-- ----------------------------------------------------------------------------
-- Registros da ultima semana

SELECT *
FROM vendas
WHERE data_venda BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE();

-- Registros deste mes:
SELECT *
FROM vendas
WHERE YEAR(data_venda) = YEAR(CURDATE())
  AND MONTH(data_venda) = MONTH(CURDATE());

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. CURDATE() e mais eficiente que DATE(NOW()) para comparacoes
-- 2. Use CURRENT_DATE para maior portabilidade entre SGBDs
-- 3. Evite usar funcoes na coluna da tabela (quebra uso de indices)
-- 4. Considere o fuso horario do servidor
-- 5. Para comparacoes, prefira intervalos ao inves de DATE(coluna)
--
-- ============================================================================
