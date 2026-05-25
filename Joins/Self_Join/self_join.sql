-- ============================================
-- COMANDO: SELF JOIN
-- ============================================
-- 
-- DESCRIÇÃO:
-- SELF JOIN é quando uma tabela faz JOIN consigo mesma.
-- É útil para comparar registros dentro da mesma tabela
-- ou para trabalhar com dados hierárquicos (ex: funcionário/gerente).
-- Usa aliases obrigatoriamente para diferenciar as duas "cópias" da tabela.
--
-- SINTAXE BÁSICA:
-- SELECT colunas
-- FROM tabela t1
-- JOIN tabela t2 ON t1.coluna = t2.coluna;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Hierarquia funcionário-gerente
-- ============================================
-- Cada funcionário tem um gerente (que também é funcionário)
SELECT 
    f.nome AS funcionario,
    f.cargo,
    g.nome AS gerente
FROM funcionarios f
LEFT JOIN funcionarios g ON f.gerente_id = g.id;

-- ============================================
-- EXEMPLO 2: Encontrar funcionários do mesmo departamento
-- ============================================
SELECT 
    f1.nome AS funcionario_1,
    f2.nome AS funcionario_2,
    f1.departamento_id
FROM funcionarios f1
INNER JOIN funcionarios f2 
    ON f1.departamento_id = f2.departamento_id
    AND f1.id < f2.id;  -- Evita duplicatas e auto-comparação

-- ============================================
-- EXEMPLO 3: Clientes da mesma cidade
-- ============================================
SELECT 
    c1.nome AS cliente_1,
    c2.nome AS cliente_2,
    c1.cidade
FROM clientes c1
INNER JOIN clientes c2 
    ON c1.cidade = c2.cidade
    AND c1.id <> c2.id;  -- Exclui comparação consigo mesmo

-- ============================================
-- EXEMPLO 4: Hierarquia multinível
-- ============================================
-- Funcionário, gerente e diretor
SELECT 
    f.nome AS funcionario,
    g.nome AS gerente,
    d.nome AS diretor
FROM funcionarios f
LEFT JOIN funcionarios g ON f.gerente_id = g.id
LEFT JOIN funcionarios d ON g.gerente_id = d.id;

-- ============================================
-- EXEMPLO 5: Produtos com preço similar
-- ============================================
-- Encontrar produtos com diferença de preço <= 10%
SELECT 
    p1.nome AS produto_1,
    p1.preco AS preco_1,
    p2.nome AS produto_2,
    p2.preco AS preco_2,
    ABS(p1.preco - p2.preco) AS diferenca
FROM produtos p1
INNER JOIN produtos p2 
    ON p1.id < p2.id
    AND ABS(p1.preco - p2.preco) / p1.preco <= 0.10;

-- ============================================
-- EXEMPLO 6: Pedidos consecutivos do mesmo cliente
-- ============================================
SELECT 
    p1.id AS pedido_anterior,
    p1.data_pedido AS data_anterior,
    p2.id AS pedido_posterior,
    p2.data_pedido AS data_posterior,
    DATEDIFF(p2.data_pedido, p1.data_pedido) AS dias_entre
FROM pedidos p1
INNER JOIN pedidos p2 
    ON p1.cliente_id = p2.cliente_id
    AND p2.data_pedido > p1.data_pedido
    AND NOT EXISTS (
        SELECT 1 FROM pedidos p3 
        WHERE p3.cliente_id = p1.cliente_id
        AND p3.data_pedido > p1.data_pedido
        AND p3.data_pedido < p2.data_pedido
    );

-- ============================================
-- EXEMPLO 7: Categorias e subcategorias
-- ============================================
-- Estrutura hierárquica de categorias
SELECT 
    c1.nome AS categoria_pai,
    c2.nome AS subcategoria
FROM categorias c1
LEFT JOIN categorias c2 ON c1.id = c2.categoria_pai_id;

-- ============================================
-- EXEMPLO 8: Encontrar referências duplicadas
-- ============================================
SELECT 
    p1.id AS id_1,
    p2.id AS id_2,
    p1.email
FROM pessoas p1
INNER JOIN pessoas p2 
    ON p1.email = p2.email
    AND p1.id < p2.id;

-- ============================================
-- EXEMPLO 9: Calcular comissão por indicação
-- ============================================
-- Cliente que indicou outro cliente
SELECT 
    c1.nome AS cliente_indicador,
    c2.nome AS cliente_indicado,
    COUNT(p.id) AS pedidos_indicado,
    SUM(p.valor_total) * 0.05 AS comissao
FROM clientes c1
INNER JOIN clientes c2 ON c1.id = c2.indicado_por_id
LEFT JOIN pedidos p ON c2.id = p.cliente_id
GROUP BY c1.id, c1.nome, c2.id, c2.nome;

-- ============================================
-- EXEMPLO 10: Árvore organizacional completa
-- ============================================
-- Com CTE recursivo (PostgreSQL, SQL Server, MySQL 8+)
WITH RECURSIVE hierarquia AS (
    -- Caso base: funcionários sem gerente (diretores)
    SELECT id, nome, gerente_id, 1 AS nivel
    FROM funcionarios
    WHERE gerente_id IS NULL
    
    UNION ALL
    
    -- Caso recursivo: funcionários com gerente
    SELECT f.id, f.nome, f.gerente_id, h.nivel + 1
    FROM funcionarios f
    INNER JOIN hierarquia h ON f.gerente_id = h.id
)
SELECT * FROM hierarquia ORDER BY nivel, nome;

-- ============================================
-- VISUALIZAÇÃO DO SELF JOIN:
-- ============================================
--
--    TABELA FUNCIONÁRIOS
--    ┌────┬──────────┬────────────┐
--    │ ID │  NOME    │ GERENTE_ID │
--    ├────┼──────────┼────────────┤
--    │ 1  │ Carlos   │ NULL       │  ← Diretor (sem gerente)
--    │ 2  │ Maria    │ 1          │  ← Gerente → Carlos
--    │ 3  │ João     │ 2          │  ← Func → Maria → Carlos
--    │ 4  │ Ana      │ 2          │  ← Func → Maria → Carlos
--    └────┴──────────┴────────────┘
--
--    O SELF JOIN conecta cada linha com outra da mesma tabela
--
-- ============================================

-- ============================================
-- QUANDO USAR SELF JOIN:
-- ============================================
-- 1. Estruturas hierárquicas (funcionário/gerente)
-- 2. Categorias pai/filho
-- 3. Comparar registros da mesma tabela
-- 4. Encontrar duplicatas
-- 5. Dados de indicação/referência
-- 6. Relacionamentos entre entidades do mesmo tipo
