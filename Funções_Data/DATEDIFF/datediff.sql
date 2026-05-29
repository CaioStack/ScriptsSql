-- ============================================================================
-- DATEDIFF - Diferenca Entre Datas
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao DATEDIFF() calcula a diferenca entre duas datas. O resultado
-- representa a quantidade de dias, meses ou outra unidade de tempo entre
-- as datas especificadas.
--
-- SINTAXE BASICA:
-- MySQL: DATEDIFF(data_fim, data_inicio)
-- SQL Server: DATEDIFF(unidade, data_inicio, data_fim)
--
-- PARAMETROS:
-- - data_fim : Data final do calculo
-- - data_inicio : Data inicial do calculo
-- - unidade (SQL Server) : year, month, day, hour, minute, second
--
-- RETORNO:
-- - Inteiro representando a diferenca
-- - Positivo se data_fim > data_inicio
-- - Negativo se data_fim < data_inicio
--
-- COMPATIBILIDADE:
-- - MySQL: DATEDIFF(d1, d2) retorna dias
-- - PostgreSQL: data1 - data2 ou AGE(d1, d2)
-- - SQL Server: DATEDIFF(unidade, d1, d2)
-- - Oracle: data1 - data2 (retorna dias)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Diferenca em dias (MySQL)
-- ----------------------------------------------------------------------------
-- Calculando dias entre duas datas

SELECT DATEDIFF('2024-03-15', '2024-03-01') AS dias_diferenca;

-- Resultado: 14

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Idade do pedido em dias
-- ----------------------------------------------------------------------------
-- Quantos dias desde que o pedido foi feito

SELECT 
    id_pedido,
    data_pedido,
    DATEDIFF(CURDATE(), data_pedido) AS dias_desde_pedido
FROM pedidos;

-- Resultado esperado:
-- | id_pedido | data_pedido | dias_desde_pedido |
-- |-----------|-------------|-------------------|
-- | 1         | 2024-03-01  | 14                |
-- | 2         | 2024-03-10  | 5                 |

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Dias ate o vencimento
-- ----------------------------------------------------------------------------
-- Verificando quanto tempo falta para vencer

SELECT 
    id_fatura,
    data_vencimento,
    DATEDIFF(data_vencimento, CURDATE()) AS dias_para_vencer,
    CASE 
        WHEN DATEDIFF(data_vencimento, CURDATE()) < 0 THEN 'Vencida'
        WHEN DATEDIFF(data_vencimento, CURDATE()) = 0 THEN 'Vence Hoje'
        WHEN DATEDIFF(data_vencimento, CURDATE()) <= 7 THEN 'Vence em Breve'
        ELSE 'No Prazo'
    END AS status
FROM faturas;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: SQL Server - Varias unidades
-- ----------------------------------------------------------------------------
-- Calculando diferenca em diferentes unidades

-- SQL Server:
SELECT 
    DATEDIFF(day, '2024-01-01', '2024-03-15') AS dias,
    DATEDIFF(month, '2024-01-01', '2024-03-15') AS meses,
    DATEDIFF(year, '2024-01-01', '2024-03-15') AS anos,
    DATEDIFF(hour, '2024-01-01', '2024-03-15') AS horas
FROM dual;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: PostgreSQL - Usando subtracao
-- ----------------------------------------------------------------------------
-- Em PostgreSQL, use operador de subtracao

-- PostgreSQL:
SELECT 
    '2024-03-15'::DATE - '2024-03-01'::DATE AS dias_diferenca;

-- Usando AGE para resultado detalhado:
SELECT 
    AGE('2024-03-15'::DATE, '2024-01-01'::DATE) AS diferenca_detalhada;
-- Resultado: '2 months 14 days'

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Calculando tempo de entrega
-- ----------------------------------------------------------------------------
-- Media de dias para entrega

SELECT 
    AVG(DATEDIFF(data_entrega, data_pedido)) AS media_dias_entrega,
    MIN(DATEDIFF(data_entrega, data_pedido)) AS menor_prazo,
    MAX(DATEDIFF(data_entrega, data_pedido)) AS maior_prazo
FROM pedidos
WHERE data_entrega IS NOT NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Filtrando por idade
-- ----------------------------------------------------------------------------
-- Registros mais antigos que 30 dias

SELECT *
FROM logs
WHERE DATEDIFF(CURDATE(), data_registro) > 30;

-- Registros das ultimas 2 semanas:
SELECT *
FROM atividades
WHERE DATEDIFF(CURDATE(), data_atividade) <= 14;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Calculando idade em anos
-- ----------------------------------------------------------------------------
-- Idade completa de clientes

-- MySQL (aproximado):
SELECT 
    nome,
    data_nascimento,
    FLOOR(DATEDIFF(CURDATE(), data_nascimento) / 365) AS idade_anos
FROM clientes;

-- Mais preciso com TIMESTAMPDIFF (MySQL):
SELECT 
    nome,
    data_nascimento,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade_anos
FROM clientes;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. A ordem dos parametros varia entre SGBDs - atencao!
-- 2. MySQL: DATEDIFF(maior, menor) = positivo
-- 3. SQL Server: DATEDIFF(unidade, menor, maior) = positivo
-- 4. Use TIMESTAMPDIFF no MySQL para unidades diferentes de dias
-- 5. Valores NULL em qualquer data resultam em NULL
--
-- ============================================================================
