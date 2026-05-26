-- ============================================================================
-- EXCEPT / MINUS - Diferenca Entre Consultas
-- ============================================================================
-- 
-- DESCRICAO:
-- O EXCEPT (ou MINUS no Oracle) retorna as linhas da primeira consulta que
-- NAO aparecem na segunda consulta. E a diferenca de conjuntos.
--
-- SINTAXE BASICA:
-- SELECT ... FROM tabela1
-- EXCEPT
-- SELECT ... FROM tabela2
--
-- COMPATIBILIDADE:
-- - PostgreSQL: EXCEPT
-- - SQL Server: EXCEPT
-- - Oracle: MINUS
-- - MySQL: NAO suporta nativamente (use LEFT JOIN ou NOT IN)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: EXCEPT basico
-- ----------------------------------------------------------------------------
-- Clientes que NAO sao fornecedores

SELECT nome, email FROM clientes
EXCEPT
SELECT nome, email FROM fornecedores;

-- Retorna clientes que nao existem na tabela de fornecedores

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Oracle - MINUS
-- ----------------------------------------------------------------------------
-- Mesma funcionalidade com sintaxe Oracle

-- Oracle:
SELECT nome, email FROM clientes
MINUS
SELECT nome, email FROM fornecedores;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Alternativa no MySQL
-- ----------------------------------------------------------------------------
-- Usando LEFT JOIN para simular EXCEPT

SELECT DISTINCT c.nome, c.email
FROM clientes c
LEFT JOIN fornecedores f ON c.nome = f.nome AND c.email = f.email
WHERE f.nome IS NULL;

-- Ou usando NOT IN:
SELECT nome, email
FROM clientes
WHERE (nome, email) NOT IN (SELECT nome, email FROM fornecedores);

-- Ou usando NOT EXISTS:
SELECT nome, email
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM fornecedores f 
    WHERE f.nome = c.nome AND f.email = c.email
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Produtos que nao foram vendidos
-- ----------------------------------------------------------------------------

SELECT id, nome FROM produtos
EXCEPT
SELECT DISTINCT p.id, p.nome 
FROM produtos p
INNER JOIN vendas v ON p.id = v.produto_id;

-- Produtos no catalogo sem nenhuma venda

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Encontrando dados faltantes
-- ----------------------------------------------------------------------------
-- Usuarios que nao completaram o cadastro

SELECT email FROM usuarios_cadastro_iniciado
EXCEPT
SELECT email FROM usuarios_cadastro_completo;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. EXCEPT e SQL Server/PostgreSQL; MINUS e Oracle
-- 2. MySQL nao suporta - use LEFT JOIN com IS NULL
-- 3. A ORDEM importa: A EXCEPT B != B EXCEPT A
-- 4. Remove duplicatas automaticamente
-- 5. NOT EXISTS geralmente tem melhor performance para grandes volumes
--
-- ============================================================================
