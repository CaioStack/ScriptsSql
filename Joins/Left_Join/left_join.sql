-- ============================================
-- COMANDO: LEFT JOIN (LEFT OUTER JOIN)
-- ============================================
-- 
-- DESCRIÇÃO:
-- LEFT JOIN retorna TODOS os registros da tabela da esquerda
-- e os registros correspondentes da tabela da direita.
-- Se não houver correspondência, as colunas da tabela da direita
-- terão valores NULL.
--
-- SINTAXE BÁSICA:
-- SELECT colunas
-- FROM tabela_esquerda
-- LEFT JOIN tabela_direita ON tabela_esquerda.coluna = tabela_direita.coluna;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: LEFT JOIN simples
-- ============================================
-- Todos os clientes e seus pedidos (se existirem)
SELECT 
    c.id,
    c.nome,
    p.id AS pedido_id,
    p.valor_total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;

-- Clientes sem pedidos terão NULL nas colunas de pedidos

-- ============================================
-- EXEMPLO 2: Encontrar registros sem correspondência
-- ============================================
-- Clientes que NUNCA fizeram pedidos
SELECT c.*
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- ============================================
-- EXEMPLO 3: Produtos sem vendas
-- ============================================
SELECT pr.nome, pr.preco
FROM produtos pr
LEFT JOIN itens_pedido ip ON pr.id = ip.produto_id
WHERE ip.id IS NULL;

-- ============================================
-- EXEMPLO 4: LEFT JOIN com múltiplas tabelas
-- ============================================
SELECT 
    c.nome AS cliente,
    p.id AS pedido_id,
    p.data_pedido,
    COALESCE(SUM(ip.quantidade * ip.preco_unitario), 0) AS valor_calculado
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
LEFT JOIN itens_pedido ip ON p.id = ip.pedido_id
GROUP BY c.id, c.nome, p.id, p.data_pedido;

-- ============================================
-- EXEMPLO 5: LEFT JOIN com condição adicional
-- ============================================
-- Todos os clientes e pedidos do último mês
SELECT c.nome, p.data_pedido, p.valor_total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id 
    AND p.data_pedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- ============================================
-- EXEMPLO 6: LEFT JOIN vs INNER JOIN
-- ============================================
-- INNER JOIN: retorna apenas clientes COM pedidos
SELECT c.nome, COUNT(p.id) AS total_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;

-- LEFT JOIN: retorna TODOS os clientes, mesmo sem pedidos
SELECT c.nome, COUNT(p.id) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;

-- ============================================
-- EXEMPLO 7: Contagem incluindo zeros
-- ============================================
-- Total de pedidos por cliente (incluindo quem tem 0)
SELECT 
    c.nome,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.valor_total), 0) AS valor_total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY total_pedidos DESC;

-- ============================================
-- EXEMPLO 8: LEFT JOIN com COALESCE para NULLs
-- ============================================
SELECT 
    c.nome,
    COALESCE(p.status, 'Sem pedidos') AS status_pedido,
    COALESCE(p.valor_total, 0) AS valor
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 9: LEFT OUTER JOIN (sintaxe completa)
-- ============================================
-- LEFT JOIN e LEFT OUTER JOIN são idênticos
SELECT c.nome, p.id
FROM clientes c
LEFT OUTER JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 10: Categorias e quantidade de produtos
-- ============================================
SELECT 
    cat.nome AS categoria,
    COUNT(p.id) AS total_produtos,
    COALESCE(AVG(p.preco), 0) AS preco_medio
FROM categorias cat
LEFT JOIN produtos p ON cat.id = p.categoria_id
GROUP BY cat.id, cat.nome;

-- ============================================
-- VISUALIZAÇÃO DO LEFT JOIN:
-- ============================================
--
--     TABELA A          TABELA B
--    ┌───────┐         ┌───────┐
--    │███████│         │   B   │
--    │███┌───┼─────────┼─┐███│ │
--    │███│███│         │ │███│ │
--    │███└───┼─────────┼─┘   │ │
--    │███████│         │     │ │
--    └───────┘         └───────┘
--
--    LEFT JOIN retorna tudo de A (███) + interseção com B
--    Registros de B sem correspondência em A não aparecem
--
-- ============================================

-- ============================================
-- QUANDO USAR LEFT JOIN:
-- ============================================
-- 1. Quando precisa de TODOS os registros da tabela principal
-- 2. Para encontrar registros sem correspondência (WHERE ... IS NULL)
-- 3. Relatórios que incluem itens sem dados relacionados
-- 4. Contagens que devem incluir zero
