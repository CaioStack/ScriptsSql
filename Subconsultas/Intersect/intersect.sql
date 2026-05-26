-- ============================================================================
-- INTERSECT - Interseccao de Consultas
-- ============================================================================
-- 
-- DESCRICAO:
-- O INTERSECT retorna apenas as linhas que aparecem em AMBOS os resultados
-- das consultas. E a interseccao de conjuntos - somente registros comuns.
--
-- SINTAXE BASICA:
-- SELECT ... FROM tabela1
-- INTERSECT
-- SELECT ... FROM tabela2
--
-- COMPATIBILIDADE:
-- - PostgreSQL: Sim
-- - SQL Server: Sim
-- - Oracle: Sim
-- - MySQL: NAO suporta nativamente (use INNER JOIN como alternativa)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: INTERSECT basico
-- ----------------------------------------------------------------------------
-- Clientes que sao tambem fornecedores

SELECT nome, email FROM clientes
INTERSECT
SELECT nome, email FROM fornecedores;

-- Retorna apenas pessoas que existem em ambas as tabelas

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Produtos em comum
-- ----------------------------------------------------------------------------
-- Produtos vendidos em ambas as lojas

SELECT produto_id FROM vendas_loja_a
INTERSECT
SELECT produto_id FROM vendas_loja_b;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Alternativa no MySQL (que nao suporta INTERSECT)
-- ----------------------------------------------------------------------------
-- Usando INNER JOIN para simular INTERSECT

SELECT DISTINCT c.nome, c.email
FROM clientes c
INNER JOIN fornecedores f ON c.nome = f.nome AND c.email = f.email;

-- Ou usando EXISTS:
SELECT nome, email
FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM fornecedores f 
    WHERE f.nome = c.nome AND f.email = c.email
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Encontrando usuarios ativos em multiplos sistemas
-- ----------------------------------------------------------------------------

SELECT user_id FROM sistema_crm
INTERSECT
SELECT user_id FROM sistema_erp
INTERSECT
SELECT user_id FROM sistema_bi;

-- Usuarios que tem acesso aos 3 sistemas

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. MySQL nao suporta INTERSECT - use JOINs ou IN
-- 2. Remove duplicatas automaticamente
-- 3. Colunas devem ter tipos compativeis
-- 4. Util para encontrar dados em comum entre conjuntos
-- 5. Pode ser menos eficiente que INNER JOIN em alguns casos
--
-- ============================================================================
