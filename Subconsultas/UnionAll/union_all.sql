-- ============================================================================
-- UNION ALL - Combinando Resultados (Com Duplicatas)
-- ============================================================================
-- 
-- DESCRICAO:
-- O UNION ALL combina os resultados de consultas SELECT mantendo TODAS as
-- linhas, inclusive duplicatas. E mais rapido que UNION porque nao precisa
-- verificar e remover duplicatas.
--
-- SINTAXE BASICA:
-- SELECT ... FROM tabela1
-- UNION ALL
-- SELECT ... FROM tabela2
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: UNION ALL basico
-- ----------------------------------------------------------------------------
-- Combinando todas as transacoes de contas

SELECT data, valor, 'Conta Corrente' AS conta FROM transacoes_cc
UNION ALL
SELECT data, valor, 'Poupanca' AS conta FROM transacoes_poupanca;

-- Resultado inclui todas as linhas de ambas as tabelas

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Performance - UNION vs UNION ALL
-- ----------------------------------------------------------------------------
-- UNION ALL e mais eficiente quando duplicatas sao aceitaveis ou impossiveis

-- Lento (verifica duplicatas):
SELECT produto_id FROM vendas_janeiro
UNION
SELECT produto_id FROM vendas_fevereiro;

-- Rapido (nao verifica):
SELECT produto_id FROM vendas_janeiro
UNION ALL
SELECT produto_id FROM vendas_fevereiro;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Consolidando logs
-- ----------------------------------------------------------------------------
-- Juntando logs de diferentes servidores

SELECT timestamp, mensagem, 'Servidor1' AS origem FROM logs_servidor1
UNION ALL
SELECT timestamp, mensagem, 'Servidor2' AS origem FROM logs_servidor2
UNION ALL
SELECT timestamp, mensagem, 'Servidor3' AS origem FROM logs_servidor3
ORDER BY timestamp DESC;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Historico de movimentacoes
-- ----------------------------------------------------------------------------
-- Entradas e saidas em uma unica lista

SELECT 
    data,
    valor,
    'Entrada' AS tipo
FROM entradas
UNION ALL
SELECT 
    data,
    -valor,  -- Negativo para saidas
    'Saida' AS tipo
FROM saidas
ORDER BY data;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Prefira UNION ALL quando duplicatas nao sao problema
-- 2. Use para consolidar dados de tabelas particionadas
-- 3. Ideal para logs e historicos onde cada registro e unico
-- 4. Significativamente mais rapido que UNION em grandes volumes
-- 5. Use UNION (sem ALL) apenas quando realmente precisar remover duplicatas
--
-- ============================================================================
