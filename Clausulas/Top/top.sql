-- ============================================
-- CLÁUSULA: TOP
-- ============================================
-- 
-- DESCRIÇÃO:
-- A cláusula TOP é usada no SQL Server para limitar o número
-- de registros retornados por uma consulta. É equivalente
-- ao LIMIT usado no MySQL e PostgreSQL.
--
-- SINTAXE BÁSICA:
-- SELECT TOP quantidade colunas FROM tabela;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Selecionar os primeiros N registros
-- ============================================
-- Retornar os 10 primeiros clientes
SELECT TOP 10 * FROM clientes;

-- ============================================
-- EXEMPLO 2: TOP com ORDER BY
-- ============================================
-- Os 5 produtos mais caros
SELECT TOP 5 * FROM produtos
ORDER BY preco DESC;

-- Os 10 pedidos mais recentes
SELECT TOP 10 * FROM pedidos
ORDER BY data_pedido DESC;

-- ============================================
-- EXEMPLO 3: TOP com porcentagem
-- ============================================
-- Retorna 10% dos registros
SELECT TOP 10 PERCENT * FROM clientes;

-- Top 5% dos produtos mais vendidos
SELECT TOP 5 PERCENT * FROM produtos
ORDER BY quantidade_vendida DESC;

-- ============================================
-- EXEMPLO 4: TOP com WITH TIES
-- ============================================
-- WITH TIES inclui registros empatados
-- Os 3 produtos mais caros (incluindo empates)
SELECT TOP 3 WITH TIES nome, preco
FROM produtos
ORDER BY preco DESC;

-- Se houver 2 produtos com o mesmo 3º maior preço,
-- ambos serão retornados (totalizando 4 registros)

-- ============================================
-- EXEMPLO 5: TOP com WHERE
-- ============================================
-- Os 5 produtos mais baratos da categoria Eletrônicos
SELECT TOP 5 * FROM produtos
WHERE categoria = 'Eletrônicos'
ORDER BY preco ASC;

-- ============================================
-- EXEMPLO 6: TOP com JOIN
-- ============================================
-- Os 10 maiores pedidos com nome do cliente
SELECT TOP 10 
    p.id AS pedido_id,
    c.nome AS cliente,
    p.valor_total
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.valor_total DESC;

-- ============================================
-- EXEMPLO 7: TOP em subquery
-- ============================================
-- Clientes que fizeram os 5 maiores pedidos
SELECT * FROM clientes
WHERE id IN (
    SELECT TOP 5 cliente_id FROM pedidos
    ORDER BY valor_total DESC
);

-- ============================================
-- EXEMPLO 8: TOP com GROUP BY
-- ============================================
-- As 5 categorias com mais produtos
SELECT TOP 5 categoria, COUNT(*) AS total
FROM produtos
GROUP BY categoria
ORDER BY total DESC;

-- ============================================
-- COMPARAÇÃO: TOP vs LIMIT vs FETCH
-- ============================================

-- SQL Server: TOP
-- SELECT TOP 10 * FROM clientes;

-- MySQL/PostgreSQL: LIMIT
-- SELECT * FROM clientes LIMIT 10;

-- SQL Padrão (SQL:2008): FETCH
-- SELECT * FROM clientes
-- ORDER BY id
-- OFFSET 0 ROWS
-- FETCH NEXT 10 ROWS ONLY;

-- ============================================
-- EXEMPLO 9: Paginação com OFFSET FETCH (SQL Server 2012+)
-- ============================================
-- Página 1: registros 1-10
SELECT * FROM produtos
ORDER BY id
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Página 2: registros 11-20
SELECT * FROM produtos
ORDER BY id
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- ============================================
-- EXEMPLO 10: TOP com DELETE
-- ============================================
-- Deletar os 100 registros mais antigos
DELETE TOP (100) FROM logs
WHERE data_criacao < '2023-01-01';

-- ============================================
-- EXEMPLO 11: TOP com UPDATE
-- ============================================
-- Atualizar os 10 primeiros registros encontrados
UPDATE TOP (10) produtos
SET destaque = 1
WHERE categoria = 'Promoção';

-- ============================================
-- OBSERVAÇÕES:
-- ============================================
-- 1. TOP sempre usa parênteses quando em DELETE/UPDATE
-- 2. TOP sem ORDER BY retorna resultados imprevisíveis
-- 3. WITH TIES requer ORDER BY obrigatoriamente
-- 4. TOP PERCENT arredonda para cima
-- 5. Para paginação, prefira OFFSET FETCH (SQL Server 2012+)
