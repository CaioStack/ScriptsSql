-- ============================================
-- FUNÇÃO: SUM
-- ============================================
-- 
-- Descrição:
-- A função SUM retorna a soma total de uma coluna numérica.
-- Ignora valores NULL automaticamente.
--
-- Sintaxe básica:
-- SELECT SUM(coluna) FROM tabela;
--
-- ============================================

-- ============================================
-- Exemplo 1: Soma simples
-- ============================================
-- Total de estoque de todos os produtos
SELECT SUM(estoque) AS estoque_total FROM produtos;

-- ============================================
-- Exemplo 2: SUM com WHERE
-- ============================================
-- Valor total de pedidos do mês
SELECT SUM(valor_total) AS vendas_mes
FROM pedidos
WHERE MONTH(data_pedido) = MONTH(CURDATE());

-- Total de estoque de eletrônicos
SELECT SUM(estoque) AS estoque_eletronicos
FROM produtos
WHERE categoria = 'Eletrônicos';

-- ============================================
-- Exemplo 3: SUM com GROUP BY
-- ============================================
-- Vendas por categoria
SELECT 
    categoria,
    SUM(preco * quantidade) AS total_vendas
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.id
GROUP BY categoria;

-- Total de pedidos por cliente
SELECT 
    c.nome,
    SUM(p.valor_total) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC;

-- ============================================
-- Exemplo 4: SUM com HAVING
-- ============================================
-- Clientes que gastaram mais de R$ 10.000
SELECT 
    c.nome,
    SUM(p.valor_total) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
HAVING SUM(p.valor_total) > 10000;

-- ============================================
-- Exemplo 5: SUM com expressões
-- ============================================
-- Valor total dos itens (preço * quantidade)
SELECT SUM(preco_unitario * quantidade) AS valor_total
FROM itens_pedido;

-- Valor com desconto
SELECT SUM(preco_unitario * quantidade * (1 - desconto/100)) AS valor_com_desconto
FROM itens_pedido;

-- ============================================
-- Exemplo 6: Múltiplos SUM na mesma query
-- ============================================
SELECT 
    SUM(valor_total) AS total_vendas,
    SUM(CASE WHEN status = 'pago' THEN valor_total ELSE 0 END) AS total_pago,
    SUM(CASE WHEN status = 'pendente' THEN valor_total ELSE 0 END) AS total_pendente
FROM pedidos;

-- ============================================
-- Exemplo 7: SUM com DISTINCT
-- ============================================
-- Soma apenas valores únicos
SELECT SUM(DISTINCT preco) AS soma_precos_unicos
FROM produtos;

-- ============================================
-- Exemplo 8: SUM em subquery
-- ============================================
-- Clientes com compras acima da média
SELECT * FROM clientes c
WHERE (
    SELECT SUM(valor_total) FROM pedidos p
    WHERE p.cliente_id = c.id
) > (
    SELECT AVG(total_por_cliente) FROM (
        SELECT SUM(valor_total) AS total_por_cliente
        FROM pedidos GROUP BY cliente_id
    ) AS subq
);

-- ============================================
-- Exemplo 9: SUM por período
-- ============================================
-- Vendas por mês
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
    SUM(valor_total) AS total_vendas
FROM pedidos
WHERE YEAR(data_pedido) = 2024
GROUP BY DATE_FORMAT(data_pedido, '%Y-%m')
ORDER BY mes;

-- ============================================
-- Exemplo 10: SUM com COALESCE (tratar NULL)
-- ============================================
-- Se não houver pedidos, retorna 0 em vez de NULL
SELECT COALESCE(SUM(valor_total), 0) AS total_vendas
FROM pedidos
WHERE cliente_id = 999;  -- Cliente que pode não ter pedidos

-- ============================================
-- Exemplo 11: Running Total (soma acumulada)
-- ============================================
-- MySQL 8+ / PostgreSQL / SQL Server
SELECT 
    data_pedido,
    valor_total,
    SUM(valor_total) OVER (ORDER BY data_pedido) AS total_acumulado
FROM pedidos
ORDER BY data_pedido;

-- ============================================
-- Exemplo 12: SUM com CASE para métricas
-- ============================================
-- Dashboard de vendas
SELECT
    SUM(valor_total) AS total_geral,
    SUM(CASE WHEN data_pedido >= CURDATE() - INTERVAL 7 DAY 
        THEN valor_total ELSE 0 END) AS ultimos_7_dias,
    SUM(CASE WHEN data_pedido >= CURDATE() - INTERVAL 30 DAY 
        THEN valor_total ELSE 0 END) AS ultimos_30_dias,
    SUM(CASE WHEN YEAR(data_pedido) = YEAR(CURDATE()) 
        THEN valor_total ELSE 0 END) AS ano_atual
FROM pedidos;

-- ============================================
-- OBSERVAÇÕES:
-- ============================================
-- 1. SUM ignora valores NULL
-- 2. SUM de coluna vazia retorna NULL, não 0
-- 3. Use COALESCE(SUM(...), 0) para garantir retorno numérico
-- 4. SUM só funciona com valores numéricos
-- 5. Para somas grandes, cuidado com overflow
