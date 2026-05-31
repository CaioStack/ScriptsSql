-- ============================================
-- Claúsula: HAVING
-- ============================================
-- 
-- Descrição:
-- A cláusula HAVING é usada para filtrar grupos de resultados
-- após o uso de GROUP BY. É similar ao WHERE, mas enquanto
-- WHERE filtra linhas ANTES do agrupamento, HAVING filtra
-- grupos DEPOIS do agrupamento.
-- HAVING pode usar funções de agregação, WHERE não pode.
--
-- Sintaxe básica:
-- SELECT coluna, função_agregação(coluna)
-- FROM tabela
-- GROUP BY coluna
-- HAVING condição;
--
-- ============================================

-- ============================================
-- Exemplo 1: Filtrar por contagem
-- ============================================
-- Cidades com mais de 100 clientes
SELECT cidade, COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade
HAVING COUNT(*) > 100;

-- ============================================
-- Exemplo 2: Filtrar por soma
-- ============================================
-- Categorias com vendas acima de R$ 10.000
SELECT categoria, SUM(preco * quantidade) AS total_vendas
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.id
GROUP BY categoria
HAVING SUM(preco * quantidade) > 10000;

-- ============================================
-- Exemplo 3: Filtrar por média
-- ============================================
-- Categorias com preço médio acima de R$ 200
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > 200;

-- ============================================
-- Exemplo 4: Usando alias no HAVING (alguns SGBDs)
-- ============================================
-- MySQL permite usar o alias
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING total_produtos > 5;

-- Em outros SGBDs, repita a função
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;

-- ============================================
-- Exemplo 5: HAVING com múltiplas condições
-- ============================================
SELECT categoria, COUNT(*) AS total, AVG(preco) AS media
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5 AND AVG(preco) < 500;

-- ============================================
-- Exemplo 6: HAVING com OR
-- ============================================
SELECT categoria, SUM(estoque) AS estoque_total
FROM produtos
GROUP BY categoria
HAVING SUM(estoque) > 1000 OR SUM(estoque) < 10;

-- ============================================
-- Exemplo 7: WHERE + HAVING juntos
-- ============================================
-- WHERE filtra as linhas, HAVING filtra os grupos
SELECT categoria, COUNT(*) AS total_ativos
FROM produtos
WHERE ativo = TRUE          -- Primeiro filtra produtos ativos
GROUP BY categoria
HAVING COUNT(*) > 10;       -- Depois filtra categorias com mais de 10

-- ============================================
-- Exemplo 8: HAVING com MIN/MAX
-- ============================================
-- Categorias onde o produto mais barato custa mais de R$ 50
SELECT categoria, MIN(preco) AS menor_preco
FROM produtos
GROUP BY categoria
HAVING MIN(preco) > 50;

-- Categorias onde o produto mais caro custa menos de R$ 1000
SELECT categoria, MAX(preco) AS maior_preco
FROM produtos
GROUP BY categoria
HAVING MAX(preco) < 1000;

-- ============================================
-- Exemplo 9: HAVING com BETWEEN
-- ============================================
SELECT 
    YEAR(data_pedido) AS ano,
    MONTH(data_pedido) AS mes,
    SUM(valor_total) AS total_vendas
FROM pedidos
GROUP BY YEAR(data_pedido), MONTH(data_pedido)
HAVING SUM(valor_total) BETWEEN 50000 AND 100000;

-- ============================================
-- Exemplo 10: HAVING com subquery
-- ============================================
-- Categorias com média acima da média geral
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > (SELECT AVG(preco) FROM produtos);

-- ============================================
-- Exemplo 11: Combinação completa
-- ============================================
SELECT 
    c.cidade,
    COUNT(p.id) AS total_pedidos,
    SUM(p.valor_total) AS valor_total,
    AVG(p.valor_total) AS ticket_medio
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.status = 'concluido'        -- Filtra pedidos concluídos
GROUP BY c.cidade
HAVING COUNT(p.id) >= 50            -- Cidades com 50+ pedidos
    AND AVG(p.valor_total) > 150    -- Ticket médio > R$ 150
ORDER BY valor_total DESC
LIMIT 10;

-- ============================================
-- WHERE vs HAVING - RESUMO:
-- ============================================
-- 
-- WHERE:
-- - Filtra LINHAS antes do GROUP BY
-- - NÃO pode usar funções de agregação
-- - Mais rápido (filtra antes de agrupar)
--
-- HAVING:
-- - Filtra GRUPOS depois do GROUP BY
-- - PODE usar funções de agregação
-- - Processa depois (trabalha com grupos)
--
-- ============================================

-- ERRADO: WHERE com função de agregação
-- SELECT categoria FROM produtos WHERE COUNT(*) > 5 GROUP BY categoria;

-- CORRETO: HAVING com função de agregação
SELECT categoria FROM produtos GROUP BY categoria HAVING COUNT(*) > 5;