-- ============================================
-- FUNÇÃO: COUNT
-- ============================================
-- 
-- Descrição:
-- A função COUNT retorna o número de linhas que correspondem
-- a um critério especificado. É a função de agregação mais
-- básica e frequentemente utilizada.
--
-- Variações:
-- COUNT(*) - Conta TODAS as linhas (incluindo NULL)
-- COUNT(coluna) - Conta linhas onde a coluna NÃO é NULL
-- COUNT(DISTINCT coluna) - Conta valores únicos (não NULL)
--
-- Sintaxe básica:
-- SELECT COUNT(*) FROM tabela;
--
-- ============================================

-- ============================================
-- Exemplo 1: Contar todas as linhas
-- ============================================
-- Total de clientes na tabela
SELECT COUNT(*) AS total_clientes FROM clientes;

-- ============================================
-- Exemplo 2: COUNT com WHERE
-- ============================================
-- Total de clientes ativos
SELECT COUNT(*) AS clientes_ativos
FROM clientes
WHERE ativo = TRUE;

-- Total de pedidos do mês
SELECT COUNT(*) AS pedidos_mes
FROM pedidos
WHERE MONTH(data_pedido) = MONTH(CURDATE());

-- ============================================
-- Exemplo 3: COUNT(coluna) - ignora NULL
-- ============================================
-- Conta apenas linhas onde telefone NÃO é NULL
SELECT COUNT(telefone) AS clientes_com_telefone
FROM clientes;

-- Comparando COUNT(*) e COUNT(coluna)
SELECT 
    COUNT(*) AS total,
    COUNT(telefone) AS com_telefone,
    COUNT(*) - COUNT(telefone) AS sem_telefone
FROM clientes;

-- ============================================
-- Exemplo 4: COUNT(DISTINCT) - valores únicos
-- ============================================
-- Quantas cidades diferentes têm clientes
SELECT COUNT(DISTINCT cidade) AS total_cidades
FROM clientes;

-- Quantos clientes fizeram pedidos
SELECT COUNT(DISTINCT cliente_id) AS clientes_compradores
FROM pedidos;

-- ============================================
-- Exemplo 5: COUNT com GROUP BY
-- ============================================
-- Quantidade de clientes por cidade
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade
ORDER BY total DESC;

-- Quantidade de produtos por categoria
SELECT categoria, COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria;

-- ============================================
-- Exemplo 6: COUNT com HAVING
-- ============================================
-- Cidades com mais de 100 clientes
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade
HAVING COUNT(*) > 100;

-- ============================================
-- Exemplo 7: COUNT com JOIN
-- ============================================
-- Total de pedidos por cliente
SELECT 
    c.nome,
    COUNT(p.id) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;

-- ============================================
-- Exemplo 8: Múltiplos COUNT na mesma query
-- ============================================
SELECT 
    COUNT(*) AS total_produtos,
    COUNT(CASE WHEN ativo = TRUE THEN 1 END) AS ativos,
    COUNT(CASE WHEN ativo = FALSE THEN 1 END) AS inativos,
    COUNT(CASE WHEN estoque = 0 THEN 1 END) AS sem_estoque
FROM produtos;

-- ============================================
-- Exemplo 9: COUNT em subquery
-- ============================================
-- Clientes com mais de 5 pedidos
SELECT * FROM clientes c
WHERE (
    SELECT COUNT(*) FROM pedidos p
    WHERE p.cliente_id = c.id
) > 5;

-- ============================================
-- Exemplo 10: COUNT com condição (condicional)
-- ============================================
-- Contar por condições diferentes
SELECT
    COUNT(CASE WHEN preco < 50 THEN 1 END) AS baratos,
    COUNT(CASE WHEN preco BETWEEN 50 AND 200 THEN 1 END) AS medios,
    COUNT(CASE WHEN preco > 200 THEN 1 END) AS caros
FROM produtos;

-- ============================================
-- Exemplo 11: COUNT por período
-- ============================================
-- Pedidos por mês
SELECT 
    YEAR(data_pedido) AS ano,
    MONTH(data_pedido) AS mes,
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY YEAR(data_pedido), MONTH(data_pedido)
ORDER BY ano, mes;

-- ============================================
-- Exemplo 12: Verificar se existe pelo menos um
-- ============================================
-- Forma simples de verificar existência
SELECT 
    CASE WHEN COUNT(*) > 0 THEN 'Sim' ELSE 'Não' END AS tem_pedidos
FROM pedidos
WHERE cliente_id = 1;

-- ============================================
-- PERFORMANCE:
-- ============================================
-- 1. COUNT(*) é geralmente mais rápido que COUNT(coluna)
-- 2. COUNT com índice na coluna do WHERE é eficiente
-- 3. COUNT(DISTINCT) pode ser mais lento em grandes volumes
-- 4. Evite COUNT(*) em tabelas muito grandes sem WHERE

-- ============================================
-- COUNT(*) vs COUNT(1) vs COUNT(coluna):
-- ============================================
-- COUNT(*) e COUNT(1) são equivalentes e otimizados
-- COUNT(coluna) ignora NULLs
-- Use COUNT(*) por clareza e performance
