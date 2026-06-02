-- ============================================
-- FUNÇÃO: MIN
-- ============================================
-- 
-- Descrição:
-- A função MIN retorna o menor valor de uma coluna.
-- Funciona com números, textos (ordem alfabética) e datas.
-- Ignora valores NULL.
--
-- Sintaxe básica:
-- SELECT MIN(coluna) FROM tabela;
--
-- ============================================

-- ============================================
-- Exemplo 1: Menor valor numérico
-- ============================================
-- Produto mais barato
SELECT MIN(preco) AS menor_preco FROM produtos;

-- ============================================
-- Exemplo 2: MIN com WHERE
-- ============================================
-- Menor preço de eletrônicos
SELECT MIN(preco) AS menor_preco_eletronico
FROM produtos
WHERE categoria = 'Eletrônicos';

-- Menor pedido do ano
SELECT MIN(valor_total) AS menor_pedido
FROM pedidos
WHERE YEAR(data_pedido) = YEAR(CURDATE());

-- ============================================
-- Exemplo 3: MIN com datas
-- ============================================
-- Data do primeiro pedido
SELECT MIN(data_pedido) AS primeiro_pedido
FROM pedidos;

-- Cliente mais antigo
SELECT MIN(data_cadastro) AS cliente_mais_antigo
FROM clientes;

-- ============================================
-- Exemplo 4: MIN com strings (alfabético)
-- ============================================
-- Primeiro nome alfabeticamente
SELECT MIN(nome) AS primeiro_nome
FROM clientes;
-- 'Ana' vem antes de 'Zélia'

-- ============================================
-- Exemplo 5: MIN com GROUP BY
-- ============================================
-- Menor preço por categoria
SELECT 
    categoria,
    MIN(preco) AS menor_preco
FROM produtos
GROUP BY categoria;

-- Primeiro pedido de cada cliente
SELECT 
    cliente_id,
    MIN(data_pedido) AS primeiro_pedido
FROM pedidos
GROUP BY cliente_id;

-- ============================================
-- Exemplo 6: Encontrar o registro com menor valor
-- ============================================
-- Produto mais barato (registro completo)
SELECT * FROM produtos
WHERE preco = (SELECT MIN(preco) FROM produtos);

-- Usando LIMIT (mais simples)
SELECT * FROM produtos
ORDER BY preco ASC
LIMIT 1;

-- ============================================
-- Exemplo 7: MIN com múltiplas métricas
-- ============================================
SELECT 
    categoria,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco,
    MAX(preco) - MIN(preco) AS amplitude,
    AVG(preco) AS media
FROM produtos
GROUP BY categoria;

-- ============================================
-- Exemplo 8: MIN em subquery
-- ============================================
-- Pedidos do dia com menor volume de vendas
SELECT * FROM pedidos
WHERE DATE(data_pedido) = (
    SELECT DATE(data_pedido)
    FROM pedidos
    GROUP BY DATE(data_pedido)
    ORDER BY SUM(valor_total)
    LIMIT 1
);

-- ============================================
-- Exemplo 9: MIN com HAVING
-- ============================================
-- Categorias onde o menor preço é acima de R$ 50
SELECT categoria, MIN(preco) AS menor_preco
FROM produtos
GROUP BY categoria
HAVING MIN(preco) > 50;

-- ============================================
-- Exemplo 10: MIN por período
-- ============================================
-- Menor venda por mês
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
    MIN(valor_total) AS menor_venda,
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY DATE_FORMAT(data_pedido, '%Y-%m')
ORDER BY mes;

-- ============================================
-- Exemplo 11: Primeiro e último registro
-- ============================================
SELECT 
    MIN(data_cadastro) AS primeiro_cadastro,
    MAX(data_cadastro) AS ultimo_cadastro,
    DATEDIFF(MAX(data_cadastro), MIN(data_cadastro)) AS dias_operacao
FROM clientes;

-- ============================================
-- Exemplo 12: MIN com COALESCE
-- ============================================
-- Se não houver valores, retorna um padrão
SELECT COALESCE(MIN(preco), 0) AS menor_preco
FROM produtos
WHERE categoria = 'Inexistente';

-- ============================================
-- MIN EM WINDOW FUNCTIONS:
-- ============================================
-- Menor valor até o momento (running min)
SELECT 
    data_pedido,
    valor_total,
    MIN(valor_total) OVER (ORDER BY data_pedido) AS menor_ate_agora
FROM pedidos;

-- Menor valor da categoria (sem GROUP BY)
SELECT 
    nome,
    categoria,
    preco,
    MIN(preco) OVER (PARTITION BY categoria) AS menor_da_categoria
FROM produtos;

-- ============================================
-- OBSERVAÇÕES:
-- ============================================
-- 1. MIN ignora valores NULL
-- 2. MIN de coluna vazia retorna NULL
-- 3. Para strings, compara alfabeticamente
-- 4. Para datas, retorna a data mais antiga
-- 5. MIN de uma única linha retorna o próprio valor
