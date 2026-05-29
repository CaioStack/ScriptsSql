-- ============================================================================
-- AS - Alias (Apelidos)
-- ============================================================================
-- 
-- DESCRICAO:
-- A palavra-chave AS e usada para criar ALIASES (apelidos) para colunas e
-- tabelas. Aliases tornam os resultados mais legiveis e sao essenciais em
-- JOINs e subconsultas. A palavra AS e opcional na maioria dos SGBDs.
--
-- USOS:
-- - Renomear colunas no resultado
-- - Dar nomes significativos a expressoes calculadas
-- - Abreviar nomes de tabelas em JOINs
-- - Obrigatorio para subqueries no FROM
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Alias de coluna
-- ----------------------------------------------------------------------------

SELECT 
    primeiro_nome AS nome,
    sobrenome AS "Sobrenome do Cliente",
    email AS contato_email
FROM clientes;

-- Resultado:
-- | nome  | Sobrenome do Cliente | contato_email     |
-- |-------|----------------------|-------------------|
-- | Maria | Silva                | maria@email.com   |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Alias para expressoes
-- ----------------------------------------------------------------------------

SELECT 
    nome,
    preco,
    quantidade,
    preco * quantidade AS subtotal,
    preco * quantidade * 0.9 AS subtotal_com_desconto
FROM itens_pedido;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Alias de tabela (essencial para JOINs)
-- ----------------------------------------------------------------------------

SELECT 
    c.nome AS cliente,
    p.id AS pedido_id,
    p.data_pedido
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- Sem alias seria necessario escrever o nome completo:
-- clientes.nome, pedidos.id, etc.

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Alias obrigatorio em SELF JOIN
-- ----------------------------------------------------------------------------

SELECT 
    f.nome AS funcionario,
    g.nome AS gerente
FROM funcionarios f
LEFT JOIN funcionarios g ON f.gerente_id = g.id;

-- Mesma tabela referenciada duas vezes - alias obrigatorio

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Alias em subquery
-- ----------------------------------------------------------------------------

SELECT 
    vendedor,
    total_vendas
FROM (
    SELECT 
        vendedor_id,
        nome AS vendedor,
        SUM(valor) AS total_vendas
    FROM vendas v
    INNER JOIN vendedores ve ON v.vendedor_id = ve.id
    GROUP BY vendedor_id, nome
) AS vendas_resumo  -- Alias obrigatorio para subquery no FROM
WHERE total_vendas > 10000;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Alias com espacos ou caracteres especiais
-- ----------------------------------------------------------------------------

-- Use aspas duplas ou colchetes para nomes especiais:

-- MySQL (backticks):
SELECT nome AS `Nome do Cliente`, email AS `E-mail` FROM clientes;

-- PostgreSQL/Oracle (aspas duplas):
SELECT nome AS "Nome do Cliente", email AS "E-mail" FROM clientes;

-- SQL Server (colchetes ou aspas):
SELECT nome AS [Nome do Cliente], email AS [E-mail] FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: AS e opcional
-- ----------------------------------------------------------------------------

-- Com AS (explicito):
SELECT nome AS cliente_nome FROM clientes;

-- Sem AS (implicito):
SELECT nome cliente_nome FROM clientes;

-- Ambos funcionam, mas AS e mais legivel

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Alias em funcoes agregadas
-- ----------------------------------------------------------------------------

SELECT 
    categoria,
    COUNT(*) AS total_produtos,
    AVG(preco) AS preco_medio,
    SUM(estoque) AS estoque_total,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produtos
GROUP BY categoria;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Alias para diferenciar colunas ambiguas
-- ----------------------------------------------------------------------------

SELECT 
    c.id AS cliente_id,
    c.nome AS cliente_nome,
    p.id AS pedido_id,
    p.data AS pedido_data
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- Sem alias, haveria ambiguidade em 'id' e 'nome'

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Alias usado em ORDER BY
-- ----------------------------------------------------------------------------

SELECT 
    nome,
    preco * quantidade AS total
FROM itens
ORDER BY total DESC;

-- Pode usar o alias na clausula ORDER BY

-- ATENCAO: Em WHERE, o alias NAO pode ser usado (ainda nao foi definido):
-- ERRADO: WHERE total > 100
-- CERTO: WHERE preco * quantidade > 100

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre use alias em JOINs para codigo mais limpo
-- 2. Use alias descritivos para expressoes calculadas
-- 3. AS e opcional mas melhora legibilidade
-- 4. Alias pode ser usado em ORDER BY mas NAO em WHERE
-- 5. Subqueries no FROM PRECISAM de alias
-- 6. Use aspas/colchetes para alias com espacos
-- 7. Mantenha aliases curtos em JOINs (c, p, f) e descritivos em SELECT
--
-- ============================================================================
