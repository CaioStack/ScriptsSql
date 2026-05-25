-- ============================================
-- FUNÇÃO: AVG
-- ============================================
-- 
-- DESCRIÇÃO:
-- A função AVG (Average) retorna a média aritmética
-- de uma coluna numérica. Ignora valores NULL.
--
-- SINTAXE BÁSICA:
-- SELECT AVG(coluna) FROM tabela;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Média simples
-- ============================================
-- Preço médio dos produtos
SELECT AVG(preco) AS preco_medio FROM produtos;

-- ============================================
-- EXEMPLO 2: AVG com WHERE
-- ============================================
-- Preço médio de eletrônicos
SELECT AVG(preco) AS preco_medio_eletronicos
FROM produtos
WHERE categoria = 'Eletrônicos';

-- Valor médio de pedidos do ano
SELECT AVG(valor_total) AS ticket_medio
FROM pedidos
WHERE YEAR(data_pedido) = YEAR(CURDATE());

-- ============================================
-- EXEMPLO 3: AVG com GROUP BY
-- ============================================
-- Preço médio por categoria
SELECT 
    categoria,
    AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
ORDER BY preco_medio DESC;

-- Ticket médio por cliente
SELECT 
    c.nome,
    AVG(p.valor_total) AS ticket_medio
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;

-- ============================================
-- EXEMPLO 4: AVG com HAVING
-- ============================================
-- Categorias com preço médio acima de R$ 200
SELECT 
    categoria,
    AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > 200;

-- ============================================
-- EXEMPLO 5: AVG com ROUND (arredondamento)
-- ============================================
-- Média com 2 casas decimais
SELECT ROUND(AVG(preco), 2) AS preco_medio
FROM produtos;

-- Média formatada por categoria
SELECT 
    categoria,
    ROUND(AVG(preco), 2) AS preco_medio,
    ROUND(AVG(estoque), 0) AS estoque_medio
FROM produtos
GROUP BY categoria;

-- ============================================
-- EXEMPLO 6: AVG vs SUM/COUNT
-- ============================================
-- AVG é equivalente a SUM/COUNT
SELECT 
    AVG(preco) AS media_funcao,
    SUM(preco) / COUNT(preco) AS media_calculada
FROM produtos;

-- ============================================
-- EXEMPLO 7: AVG com DISTINCT
-- ============================================
-- Média de valores únicos de preço
SELECT AVG(DISTINCT preco) AS media_precos_unicos
FROM produtos;

-- ============================================
-- EXEMPLO 8: Comparar com a média
-- ============================================
-- Produtos acima da média
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- Produtos abaixo da média de sua categoria
SELECT p1.nome, p1.preco, p1.categoria
FROM produtos p1
WHERE p1.preco < (
    SELECT AVG(p2.preco) 
    FROM produtos p2 
    WHERE p2.categoria = p1.categoria
);

-- ============================================
-- EXEMPLO 9: AVG com múltiplas métricas
-- ============================================
SELECT 
    categoria,
    COUNT(*) AS total_produtos,
    AVG(preco) AS preco_medio,
    MIN(preco) AS preco_minimo,
    MAX(preco) AS preco_maximo,
    MAX(preco) - MIN(preco) AS amplitude
FROM produtos
GROUP BY categoria;

-- ============================================
-- EXEMPLO 10: Média móvel (Rolling Average)
-- ============================================
-- MySQL 8+ / PostgreSQL / SQL Server
SELECT 
    data_pedido,
    valor_total,
    AVG(valor_total) OVER (
        ORDER BY data_pedido 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS media_movel_7_dias
FROM pedidos;

-- ============================================
-- EXEMPLO 11: Média ponderada
-- ============================================
-- AVG normal não considera pesos
-- Para média ponderada, use SUM/SUM
SELECT 
    SUM(preco * quantidade) / SUM(quantidade) AS preco_medio_ponderado
FROM itens_pedido;

-- Comparando média simples e ponderada
SELECT
    AVG(preco_unitario) AS media_simples,
    SUM(preco_unitario * quantidade) / SUM(quantidade) AS media_ponderada
FROM itens_pedido;

-- ============================================
-- EXEMPLO 12: AVG por período
-- ============================================
-- Ticket médio por mês
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
    ROUND(AVG(valor_total), 2) AS ticket_medio,
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY DATE_FORMAT(data_pedido, '%Y-%m')
ORDER BY mes;

-- ============================================
-- CUIDADOS COM AVG:
-- ============================================
-- 1. AVG ignora NULL (não conta como zero!)
-- 2. Se todos os valores são NULL, AVG retorna NULL
-- 3. Para incluir NULL como zero, use COALESCE antes
-- 4. Média pode ter muitas casas decimais - use ROUND

-- Exemplo do comportamento com NULL:
-- Dados: 10, 20, NULL
-- AVG = (10 + 20) / 2 = 15 (não 10!)

-- Para tratar NULL como zero:
SELECT AVG(COALESCE(valor, 0)) AS media_com_zeros
FROM tabela;
