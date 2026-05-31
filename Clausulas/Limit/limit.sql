-- ============================================
-- Claúsula: LIMIT
-- ============================================
-- 
-- Descrição:
-- A cláusula LIMIT é usada para limitar o número de registros
-- retornados por uma consulta. É muito útil para paginação
-- e para obter os primeiros N resultados.
-- 
-- Nota: A sintaxe varia entre SGBDs:
-- - MySQL/PostgreSQL: LIMIT
-- - SQL Server: TOP
-- - Oracle: ROWNUM ou FETCH FIRST
--
-- Sintaxe básica:
-- SELECT colunas FROM tabela LIMIT quantidade;
--
-- ============================================

-- ============================================
-- Exemplo 1: Limitar quantidade de resultados
-- ============================================
-- Retornar apenas os 10 primeiros registros
SELECT * FROM clientes
ORDER BY id
LIMIT 10;

-- ============================================
-- Exemplo 2: LIMIT com ORDER BY
-- ============================================
-- Top 5 produtos mais caros
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- 10 clientes mais recentes
SELECT * FROM clientes
ORDER BY data_cadastro DESC
LIMIT 10;

-- ============================================
-- Exemplo 3: LIMIT com OFFSET (paginação)
-- ============================================
-- OFFSET indica quantos registros pular

-- Página 1: registros 1-10
SELECT * FROM produtos ORDER BY id LIMIT 10 OFFSET 0;

-- Página 2: registros 11-20
SELECT * FROM produtos ORDER BY id LIMIT 10 OFFSET 10;

-- Página 3: registros 21-30
SELECT * FROM produtos ORDER BY id LIMIT 10 OFFSET 20;

-- ============================================
-- Exemplo 4: Sintaxe alternativa (MySQL)
-- ============================================
-- LIMIT offset, quantidade
SELECT * FROM produtos ORDER BY id LIMIT 10, 10;  -- Igual a LIMIT 10 OFFSET 10

-- ============================================
-- Exemplo 5: LIMIT com WHERE
-- ============================================
-- Os 5 produtos mais baratos da categoria Eletrônicos
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos'
ORDER BY preco ASC
LIMIT 5;

-- ============================================
-- Exemplo 6: LIMIT para verificação rápida
-- ============================================
-- Ver a estrutura dos dados rapidamente
SELECT * FROM clientes LIMIT 1;

-- ============================================
-- Exemplo 7: LIMIT com JOIN
-- ============================================
-- Os 10 maiores pedidos com informações do cliente
SELECT 
    p.id AS pedido_id,
    c.nome AS cliente,
    p.valor_total
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.valor_total DESC
LIMIT 10;

-- ============================================
-- Exemplo 8: LIMIT em subquery
-- ============================================
-- Clientes que fizeram os 5 maiores pedidos
SELECT * FROM clientes
WHERE id IN (
    SELECT cliente_id FROM pedidos
    ORDER BY valor_total DESC
    LIMIT 5
);

-- ============================================
-- Exemplo 9: TOP (SQL Server)
-- ============================================
-- SQL Server usa TOP em vez de LIMIT
-- SELECT TOP 10 * FROM clientes;
-- SELECT TOP 5 * FROM produtos ORDER BY preco DESC;

-- Com porcentagem
-- SELECT TOP 10 PERCENT * FROM clientes;

-- ============================================
-- Exemplo 10: FETCH FIRST (SQL padrão / Oracle)
-- ============================================
-- SELECT * FROM produtos
-- ORDER BY preco DESC
-- FETCH FIRST 10 ROWS ONLY;

-- Com OFFSET
-- SELECT * FROM produtos
-- ORDER BY preco DESC
-- OFFSET 10 ROWS
-- FETCH NEXT 10 ROWS ONLY;

-- ============================================
-- Exemplo 11: Paginação dinâmica  Exemplo prático)
-- ============================================
-- Para implementar paginação:
-- - page_size = 10 (itens por página)
-- - page_number = número da página (começando em 1)
-- - offset = (page_number - 1) * page_size

-- Página 1 (page_number = 1, offset = 0)
SELECT * FROM produtos ORDER BY id LIMIT 10 OFFSET 0;

-- Página 5 (page_number = 5, offset = 40)
SELECT * FROM produtos ORDER BY id LIMIT 10 OFFSET 40;

-- ============================================
-- Exemplo 12: LIMIT com GROUP BY
-- ============================================
-- As 5 categorias com mais produtos
SELECT categoria, COUNT(*) AS total
FROM produtos
GROUP BY categoria
ORDER BY total DESC
LIMIT 5;

-- ============================================
-- DICAS DE PERFORMANCE:
-- ============================================
-- 1. Sempre use ORDER BY com LIMIT para resultados consistentes
-- 2. LIMIT é aplicado DEPOIS de ORDER BY
-- 3. OFFSET alto pode ser lento em tabelas grandes
-- 4. Para paginação eficiente em grandes volumes, considere
--    "keyset pagination" (filtrar por ID do último item)