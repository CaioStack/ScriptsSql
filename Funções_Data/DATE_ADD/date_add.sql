-- ============================================================================
-- DATE_ADD - Adicionar Intervalo a uma Data
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao DATE_ADD() adiciona um intervalo de tempo especificado a uma data.
-- E util para calcular datas futuras como vencimentos, prazos e agendamentos.
--
-- SINTAXE BASICA:
-- MySQL: DATE_ADD(data, INTERVAL valor unidade)
-- MySQL: data + INTERVAL valor unidade
--
-- PARAMETROS:
-- - data : Data base para o calculo
-- - valor : Quantidade a adicionar
-- - unidade : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND, WEEK, etc.
--
-- COMPATIBILIDADE:
-- - MySQL: DATE_ADD(), DATE_SUB(), + INTERVAL, - INTERVAL
-- - PostgreSQL: data + INTERVAL 'valor unidade'
-- - SQL Server: DATEADD(unidade, valor, data)
-- - Oracle: data + INTERVAL 'valor' unidade, ADD_MONTHS()
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Adicionar dias
-- ----------------------------------------------------------------------------
-- Calculando data de entrega

SELECT 
    data_pedido,
    DATE_ADD(data_pedido, INTERVAL 5 DAY) AS previsao_entrega
FROM pedidos;

-- Sintaxe alternativa MySQL:
SELECT 
    data_pedido,
    data_pedido + INTERVAL 5 DAY AS previsao_entrega
FROM pedidos;

-- Resultado esperado:
-- | data_pedido | previsao_entrega |
-- |-------------|------------------|
-- | 2024-03-15  | 2024-03-20       |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Adicionar meses
-- ----------------------------------------------------------------------------
-- Calculando data de vencimento

SELECT 
    data_compra,
    DATE_ADD(data_compra, INTERVAL 1 MONTH) AS vencimento
FROM financiamentos;

-- Parcelas mensais:
SELECT 
    DATE_ADD(data_inicio, INTERVAL 1 MONTH) AS parcela_1,
    DATE_ADD(data_inicio, INTERVAL 2 MONTH) AS parcela_2,
    DATE_ADD(data_inicio, INTERVAL 3 MONTH) AS parcela_3
FROM contratos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Adicionar anos
-- ----------------------------------------------------------------------------
-- Data de renovacao de contrato

SELECT 
    data_assinatura,
    DATE_ADD(data_assinatura, INTERVAL 1 YEAR) AS renovacao
FROM contratos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Subtrair com DATE_SUB
-- ----------------------------------------------------------------------------
-- Calcular data no passado

SELECT 
    CURDATE() AS hoje,
    DATE_SUB(CURDATE(), INTERVAL 7 DAY) AS semana_passada,
    DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AS mes_passado,
    DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AS ano_passado;

-- Ou usando operador de subtracao:
SELECT 
    CURDATE() - INTERVAL 7 DAY AS semana_passada;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Adicionar horas/minutos
-- ----------------------------------------------------------------------------
-- Calculando horario de termino

SELECT 
    data_hora_inicio,
    DATE_ADD(data_hora_inicio, INTERVAL 2 HOUR) AS termino_previsto
FROM reunioes;

-- Adicionar 30 minutos:
SELECT 
    DATE_ADD(NOW(), INTERVAL 30 MINUTE) AS daqui_30_min;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: SQL Server - DATEADD
-- ----------------------------------------------------------------------------
-- Sintaxe do SQL Server

-- SQL Server:
SELECT 
    DATEADD(day, 5, data_pedido) AS previsao_entrega,
    DATEADD(month, 1, data_pedido) AS proximo_mes,
    DATEADD(year, 1, data_pedido) AS proximo_ano
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: PostgreSQL - INTERVAL
-- ----------------------------------------------------------------------------
-- Sintaxe do PostgreSQL

-- PostgreSQL:
SELECT 
    data_pedido + INTERVAL '5 days' AS previsao_entrega,
    data_pedido + INTERVAL '1 month' AS proximo_mes,
    data_pedido + INTERVAL '1 year 2 months' AS futuro
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Calculando vencimentos escalonados
-- ----------------------------------------------------------------------------
-- Gerando datas de parcelas

SELECT 
    numero_parcela,
    DATE_ADD(data_inicio, INTERVAL (numero_parcela - 1) MONTH) AS data_vencimento
FROM (
    SELECT 1 AS numero_parcela UNION SELECT 2 UNION SELECT 3 
    UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
) parcelas
CROSS JOIN contratos
WHERE contratos.id = 1;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Promocoes com prazo
-- ----------------------------------------------------------------------------
-- Calculando fim de promocao

UPDATE promocoes
SET data_fim = DATE_ADD(data_inicio, INTERVAL 7 DAY)
WHERE data_fim IS NULL;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. DATE_ADD para somar, DATE_SUB para subtrair
-- 2. INTERVAL aceita valores negativos tambem
-- 3. Atencao com meses: 31 jan + 1 mes = 28/29 fev (ultimo dia)
-- 4. Para horas/minutos, use DATETIME, nao DATE
-- 5. SQL Server usa ordem diferente: DATEADD(unidade, valor, data)
--
-- ============================================================================
