-- ============================================
-- Claúsula: GROUP BY
-- ============================================
-- 
-- Descrição:
-- A cláusula GROUP BY agrupa linhas que têm o mesmo valor
-- em colunas especificadas. É frequentemente usada com
-- funções de agregação (COUNT, SUM, AVG, MAX, MIN) para
-- realizar cálculos em cada grupo.
--
-- Sintaxe básica:
-- SELECT coluna, função_agregação(coluna)
-- FROM tabela
-- GROUP BY coluna;
--
-- ============================================

-- ============================================
-- Exemplo 1: Contagem por grupo
-- ============================================
-- Quantos clientes por cidade
SELECT cidade, COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade;

-- ============================================
-- Exemplo 2: Soma por grupo
-- ============================================
-- Total de vendas por categoria
SELECT categoria, SUM(preco * quantidade) AS total_vendas
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.id
GROUP BY categoria;

-- ============================================
-- Exemplo 3: Média por grupo
-- ============================================
-- Preço médio por categoria
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria;

-- ============================================
-- Exemplo 4: Múltiplas funções de agregação
-- ============================================
SELECT 
    categoria,
    COUNT(*) AS quantidade_produtos,
    SUM(estoque) AS estoque_total,
    AVG(preco) AS preco_medio,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produtos
GROUP BY categoria;

-- ============================================
-- Exemplo 5: GROUP BY com múltiplas colunas
-- ============================================
-- Vendas por estado e cidade
SELECT estado, cidade, COUNT(*) AS total_clientes
FROM clientes
GROUP BY estado, cidade;

-- ============================================
-- Exemplo 6: GROUP BY com ORDER BY
-- ============================================
-- Categorias ordenadas por total de vendas
SELECT categoria, SUM(preco * quantidade) AS total_vendas
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.id
GROUP BY categoria
ORDER BY total_vendas DESC;

-- ============================================
-- Exemplo 7: GROUP BY com WHERE
-- ============================================
-- Total de vendas por categoria (apenas produtos ativos)
SELECT categoria, SUM(preco * quantidade) AS total_vendas
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.id
WHERE p.ativo = TRUE
GROUP BY categoria;

-- ============================================
-- Exemplo 8: GROUP BY com HAVING
-- ============================================
-- HAVING filtra os grupos (diferente de WHERE que filtra linhas)
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 10;

-- ============================================
-- Exemplo 9: GROUP BY por data
-- ============================================
-- Vendas por dia
SELECT DATE(data_pedido) AS dia, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY DATE(data_pedido);

-- Vendas por mês
SELECT 
    YEAR(data_pedido) AS ano,
    MONTH(data_pedido) AS mes,
    SUM(valor_total) AS total_vendas
FROM pedidos
GROUP BY YEAR(data_pedido), MONTH(data_pedido);

-- ============================================
-- Exemplo 10: GROUP BY com CASE
-- ============================================
-- Agrupar por faixa de preço
SELECT 
    CASE 
        WHEN preco < 50 THEN 'Barato'
        WHEN preco BETWEEN 50 AND 200 THEN 'Médio'
        ELSE 'Caro'
    END AS faixa_preco,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY CASE 
    WHEN preco < 50 THEN 'Barato'
    WHEN preco BETWEEN 50 AND 200 THEN 'Médio'
    ELSE 'Caro'
END;

-- ============================================
-- Exemplo 11: GROUP BY com ROLLUP (MySQL)
-- ============================================
-- Adiciona linha de total geral
SELECT categoria, SUM(preco) AS total
FROM produtos
GROUP BY categoria WITH ROLLUP;

-- ============================================
-- Exemplo 12: GROUP BY ALL (PostgreSQL 15+)
-- ============================================
-- Agrupa automaticamente por todas as colunas não agregadas
SELECT categoria, COUNT(*)
FROM produtos
GROUP BY ALL;

-- ============================================
-- DIFERENÇA ENTRE WHERE E HAVING:
-- ============================================
-- WHERE: Filtra LINHAS antes do agrupamento
-- HAVING: Filtra GRUPOS depois do agrupamento

-- WHERE não pode usar funções de agregação:
-- ERRADO: SELECT categoria, COUNT(*) FROM produtos WHERE COUNT(*) > 5 GROUP BY categoria;

-- HAVING pode usar funções de agregação:
-- CORRETO: 
SELECT categoria, COUNT(*) 
FROM produtos 
GROUP BY categoria 
HAVING COUNT(*) > 5;

-- ============================================
-- ORDEM DAS CLÁUSULAS:
-- ============================================
-- SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT