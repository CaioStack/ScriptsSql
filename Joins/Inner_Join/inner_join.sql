-- ============================================
-- COMANDO: INNER JOIN
-- ============================================
-- 
-- DESCRIÇÃO:
-- INNER JOIN retorna apenas os registros que têm correspondência
-- em AMBAS as tabelas. Se não houver match, a linha não aparece
-- no resultado. É o tipo de JOIN mais comum.
--
-- SINTAXE BÁSICA:
-- SELECT colunas
-- FROM tabela1
-- INNER JOIN tabela2 ON tabela1.coluna = tabela2.coluna;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: JOIN simples entre duas tabelas
-- ============================================
-- Pedidos com informações do cliente
SELECT 
    p.id AS pedido_id,
    p.data_pedido,
    c.nome AS cliente,
    c.email
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- ============================================
-- EXEMPLO 2: JOIN com seleção de colunas específicas
-- ============================================
SELECT 
    clientes.nome,
    pedidos.valor_total,
    pedidos.data_pedido
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id;

-- ============================================
-- EXEMPLO 3: JOIN com alias (apelidos)
-- ============================================
-- Usando aliases para simplificar a query
SELECT 
    c.nome AS cliente,
    p.id AS numero_pedido,
    p.valor_total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 4: JOIN com WHERE
-- ============================================
-- Pedidos de um cliente específico
SELECT p.*, c.nome
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE c.nome = 'João Silva';

-- Pedidos acima de R$ 1000
SELECT p.*, c.nome
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE p.valor_total > 1000;

-- ============================================
-- EXEMPLO 5: JOIN com múltiplas condições
-- ============================================
SELECT *
FROM produtos p
INNER JOIN categorias c ON p.categoria_id = c.id 
    AND c.ativa = TRUE;

-- ============================================
-- EXEMPLO 6: JOIN entre três tabelas
-- ============================================
-- Pedidos com cliente e itens
SELECT 
    c.nome AS cliente,
    p.id AS pedido,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
INNER JOIN itens_pedido ip ON p.id = ip.pedido_id
INNER JOIN produtos pr ON ip.produto_id = pr.id;

-- ============================================
-- EXEMPLO 7: JOIN com funções de agregação
-- ============================================
-- Total gasto por cliente
SELECT 
    c.nome,
    COUNT(p.id) AS total_pedidos,
    SUM(p.valor_total) AS valor_total_gasto
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY valor_total_gasto DESC;

-- ============================================
-- EXEMPLO 8: JOIN com ORDER BY
-- ============================================
SELECT 
    c.nome,
    p.data_pedido,
    p.valor_total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
ORDER BY p.data_pedido DESC;

-- ============================================
-- EXEMPLO 9: SELF JOIN (tabela consigo mesma)
-- ============================================
-- Funcionários e seus gerentes (mesma tabela)
SELECT 
    f.nome AS funcionario,
    g.nome AS gerente
FROM funcionarios f
INNER JOIN funcionarios g ON f.gerente_id = g.id;

-- ============================================
-- EXEMPLO 10: JOIN sem a palavra INNER
-- ============================================
-- JOIN é equivalente a INNER JOIN
SELECT c.nome, p.valor_total
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 11: Sintaxe antiga (não recomendada)
-- ============================================
-- Forma antiga usando WHERE para join (evitar)
SELECT c.nome, p.valor_total
FROM clientes c, pedidos p
WHERE c.id = p.cliente_id;

-- ============================================
-- VISUALIZAÇÃO DO INNER JOIN:
-- ============================================
--
--     TABELA A          TABELA B
--    ┌───────┐         ┌───────┐
--    │   A   │         │   B   │
--    │ ┌───┐ │         │ ┌───┐ │
--    │ │███│─┼─────────┼─│███│ │
--    │ └───┘ │         │ └───┘ │
--    └───────┘         └───────┘
--
--    INNER JOIN retorna apenas a interseção (███)
--    Registros que existem em AMBAS as tabelas
--
-- ============================================

-- ============================================
-- QUANDO USAR INNER JOIN:
-- ============================================
-- 1. Quando precisa apenas de registros com correspondência
-- 2. Para combinar dados relacionados de múltiplas tabelas
-- 3. Para relatórios onde dados incompletos não são úteis
-- 4. Quando a integridade referencial garante a correspondência
