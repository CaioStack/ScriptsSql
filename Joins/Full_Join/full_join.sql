-- ============================================
-- COMANDO: FULL JOIN (FULL OUTER JOIN)
-- ============================================
-- 
-- DESCRIÇÃO:
-- FULL JOIN retorna TODOS os registros quando há correspondência
-- em qualquer uma das tabelas. Combina o resultado do LEFT JOIN
-- e RIGHT JOIN. Registros sem correspondência terão NULL
-- nas colunas da outra tabela.
--
-- NOTA: MySQL não suporta FULL JOIN diretamente, mas pode ser
-- simulado com UNION de LEFT e RIGHT JOIN.
--
-- SINTAXE BÁSICA:
-- SELECT colunas
-- FROM tabela1
-- FULL JOIN tabela2 ON tabela1.coluna = tabela2.coluna;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: FULL JOIN simples (PostgreSQL/SQL Server)
-- ============================================
-- Todos os clientes e todos os pedidos
SELECT 
    c.id AS cliente_id,
    c.nome AS cliente,
    p.id AS pedido_id,
    p.valor_total
FROM clientes c
FULL JOIN pedidos p ON c.id = p.cliente_id;

-- Resultado inclui:
-- - Clientes COM pedidos
-- - Clientes SEM pedidos (pedido_id = NULL)
-- - Pedidos SEM cliente válido (cliente = NULL) - dados órfãos

-- ============================================
-- EXEMPLO 2: Funcionários e Projetos
-- ============================================
SELECT 
    f.nome AS funcionario,
    p.nome AS projeto
FROM funcionarios f
FULL OUTER JOIN projetos p ON f.projeto_id = p.id;

-- ============================================
-- EXEMPLO 3: Encontrar registros sem correspondência
-- ============================================
-- Registros que existem em apenas UMA das tabelas
SELECT 
    c.id AS cliente_id,
    c.nome AS cliente,
    p.id AS pedido_id
FROM clientes c
FULL JOIN pedidos p ON c.id = p.cliente_id
WHERE c.id IS NULL OR p.id IS NULL;

-- ============================================
-- EXEMPLO 4: Simular FULL JOIN no MySQL
-- ============================================
-- MySQL não tem FULL JOIN, use UNION:
SELECT 
    c.id AS cliente_id,
    c.nome,
    p.id AS pedido_id,
    p.valor_total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id

UNION

SELECT 
    c.id AS cliente_id,
    c.nome,
    p.id AS pedido_id,
    p.valor_total
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 5: FULL JOIN com WHERE
-- ============================================
-- Apenas clientes sem pedidos OU pedidos sem cliente
SELECT 
    COALESCE(c.nome, 'Cliente não encontrado') AS cliente,
    COALESCE(p.id, 0) AS pedido_id
FROM clientes c
FULL JOIN pedidos p ON c.id = p.cliente_id
WHERE c.id IS NULL OR p.cliente_id IS NULL;

-- ============================================
-- EXEMPLO 6: Comparar duas listas
-- ============================================
-- Comparar produtos no catálogo vs produtos vendidos
SELECT 
    cat.codigo AS codigo_catalogo,
    cat.nome AS nome_catalogo,
    vend.codigo AS codigo_vendido,
    vend.quantidade_vendida
FROM produtos_catalogo cat
FULL JOIN produtos_vendidos vend ON cat.codigo = vend.codigo;

-- ============================================
-- EXEMPLO 7: Reconciliação de dados
-- ============================================
-- Encontrar discrepâncias entre duas tabelas
SELECT 
    a.id AS id_sistema_a,
    b.id AS id_sistema_b,
    COALESCE(a.valor, 0) AS valor_a,
    COALESCE(b.valor, 0) AS valor_b,
    COALESCE(a.valor, 0) - COALESCE(b.valor, 0) AS diferenca
FROM sistema_a a
FULL JOIN sistema_b b ON a.referencia = b.referencia
WHERE a.id IS NULL OR b.id IS NULL 
    OR a.valor <> b.valor;

-- ============================================
-- EXEMPLO 8: FULL OUTER JOIN (sintaxe completa)
-- ============================================
-- FULL JOIN e FULL OUTER JOIN são idênticos
SELECT c.nome, p.id
FROM clientes c
FULL OUTER JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- EXEMPLO 9: Contagem com FULL JOIN
-- ============================================
SELECT 
    COALESCE(c.regiao, 'Sem região') AS regiao,
    COUNT(DISTINCT c.id) AS total_clientes,
    COUNT(DISTINCT p.id) AS total_pedidos
FROM clientes c
FULL JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.regiao;

-- ============================================
-- VISUALIZAÇÃO DO FULL JOIN:
-- ============================================
--
--     TABELA A          TABELA B
--    ┌───────┐         ┌───────┐
--    │███████│         │███████│
--    │███┌───┼─────────┼───┐███│
--    │███│███│         │███│███│
--    │███└───┼─────────┼───┘███│
--    │███████│         │███████│
--    └───────┘         └───────┘
--
--    FULL JOIN retorna TUDO de A + TUDO de B
--    - Registros com correspondência
--    - Registros de A sem correspondência em B (B = NULL)
--    - Registros de B sem correspondência em A (A = NULL)
--
-- ============================================

-- ============================================
-- QUANDO USAR FULL JOIN:
-- ============================================
-- 1. Comparar duas fontes de dados
-- 2. Encontrar dados órfãos ou inconsistências
-- 3. Reconciliação entre sistemas
-- 4. Relatórios que precisam de TODOS os registros de ambas as tabelas
-- 5. Auditorias de integridade de dados
