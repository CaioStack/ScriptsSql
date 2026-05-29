-- ============================================================================
-- UNION - Combinando Resultados de Consultas
-- ============================================================================
-- 
-- DESCRICAO:
-- O UNION combina os resultados de duas ou mais consultas SELECT em um unico
-- conjunto de resultados. Remove automaticamente linhas duplicadas.
-- Use UNION ALL para manter duplicatas (mais rapido).
--
-- SINTAXE BASICA:
-- SELECT ... FROM tabela1
-- UNION
-- SELECT ... FROM tabela2
--
-- REGRAS:
-- - Todas as consultas devem ter o mesmo numero de colunas
-- - Colunas correspondentes devem ter tipos compativeis
-- - Nomes das colunas vem da primeira consulta
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: UNION basico
-- ----------------------------------------------------------------------------
-- Combinando clientes de diferentes regioes

SELECT nome, email, 'Sul' AS regiao FROM clientes_sul
UNION
SELECT nome, email, 'Norte' AS regiao FROM clientes_norte;

-- Remove duplicatas automaticamente

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: UNION ALL (com duplicatas)
-- ----------------------------------------------------------------------------
-- Mantendo todas as linhas, inclusive duplicadas

SELECT nome, email FROM clientes_sul
UNION ALL
SELECT nome, email FROM clientes_norte;

-- Mais rapido que UNION (nao precisa verificar duplicatas)

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Multiplos UNIONs
-- ----------------------------------------------------------------------------
-- Combinando varias tabelas

SELECT nome, 'Cliente' AS tipo FROM clientes
UNION
SELECT nome, 'Fornecedor' AS tipo FROM fornecedores
UNION
SELECT nome, 'Funcionario' AS tipo FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: UNION com ORDER BY
-- ----------------------------------------------------------------------------
-- Ordenando o resultado final

SELECT nome, data_cadastro FROM clientes
UNION
SELECT nome, data_cadastro FROM leads
ORDER BY data_cadastro DESC;

-- ORDER BY aplica-se ao resultado combinado (vai no final)

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: UNION para criar listas
-- ----------------------------------------------------------------------------
-- Gerando lista de opcoes

SELECT 1 AS valor, 'Janeiro' AS mes
UNION SELECT 2, 'Fevereiro'
UNION SELECT 3, 'Marco'
UNION SELECT 4, 'Abril'
UNION SELECT 5, 'Maio'
UNION SELECT 6, 'Junho';

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: UNION com agregacao
-- ----------------------------------------------------------------------------
-- Combinando totais de diferentes fontes

SELECT 'Vendas Online' AS fonte, SUM(valor) AS total 
FROM vendas_online
UNION
SELECT 'Vendas Loja', SUM(valor) 
FROM vendas_loja
UNION
SELECT 'Vendas Telefone', SUM(valor) 
FROM vendas_telefone;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use UNION ALL quando souber que nao ha duplicatas (melhor performance)
-- 2. ORDER BY so pode aparecer uma vez, no final
-- 3. Numero e tipos de colunas devem ser compativeis
-- 4. Use alias na primeira consulta para nomear colunas
-- 5. UNION pode ser mais lento que JOINs em alguns casos
--
-- ============================================================================
