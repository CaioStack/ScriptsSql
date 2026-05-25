-- ============================================
-- FUNÇÃO: MAX
-- ============================================
-- 
-- DESCRIÇÃO:
-- A função MAX retorna o maior valor de uma coluna.
-- Funciona com números, textos (ordem alfabética) e datas.
-- Ignora valores NULL.
--
-- SINTAXE BÁSICA:
-- SELECT MAX(coluna) FROM tabela;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Maior valor numérico
-- ============================================
-- Produto mais caro
SELECT MAX(preco) AS maior_preco FROM produtos;

-- ============================================
-- EXEMPLO 2: MAX com WHERE
-- ============================================
-- Maior preço de eletrônicos
SELECT MAX(preco) AS maior_preco_eletronico
FROM produtos
WHERE categoria = 'Eletrônicos';

-- Maior pedido do ano
SELECT MAX(valor_total) AS maior_pedido
FROM pedidos
WHERE YEAR(data_pedido) = YEAR(CURDATE());

-- ============================================
-- EXEMPLO 3: MAX com datas
-- ============================================
-- Data do último pedido
SELECT MAX(data_pedido) AS ultimo_pedido
FROM pedidos;

-- Cliente mais recente
SELECT MAX(data_cadastro) AS ultimo_cadastro
FROM clientes;

-- Última atividade de cada usuário
SELECT 
    usuario_id,
    MAX(data_atividade) AS ultima_atividade
FROM logs_atividade
GROUP BY usuario_id;

-- ============================================
-- EXEMPLO 4: MAX com strings (alfabético)
-- ============================================
-- Último nome alfabeticamente
SELECT MAX(nome) AS ultimo_nome
FROM clientes;
-- 'Zélia' vem depois de 'Ana'

-- ============================================
-- EXEMPLO 5: MAX com GROUP BY
-- ============================================
-- Maior preço por categoria
SELECT 
    categoria,
    MAX(preco) AS maior_preco
FROM produtos
GROUP BY categoria;

-- Maior pedido de cada cliente
SELECT 
    cliente_id,
    MAX(valor_total) AS maior_pedido
FROM pedidos
GROUP BY cliente_id;

-- ============================================
-- EXEMPLO 6: Encontrar o registro com maior valor
-- ============================================
-- Produto mais caro (registro completo)
SELECT * FROM produtos
WHERE preco = (SELECT MAX(preco) FROM produtos);

-- Usando LIMIT (mais simples)
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 1;

-- ============================================
-- EXEMPLO 7: TOP N por categoria
-- ============================================
-- Produto mais caro de cada categoria
SELECT p1.* FROM produtos p1
WHERE p1.preco = (
    SELECT MAX(p2.preco) 
    FROM produtos p2 
    WHERE p2.categoria = p1.categoria
);

-- ============================================
-- EXEMPLO 8: MAX para encontrar recorde
-- ============================================
-- Recorde de vendas diárias
SELECT 
    DATE(data_pedido) AS dia,
    SUM(valor_total) AS total_dia
FROM pedidos
GROUP BY DATE(data_pedido)
HAVING SUM(valor_total) = (
    SELECT MAX(total_dia) FROM (
        SELECT SUM(valor_total) AS total_dia
        FROM pedidos
        GROUP BY DATE(data_pedido)
    ) AS vendas_diarias
);

-- ============================================
-- EXEMPLO 9: MAX com HAVING
-- ============================================
-- Categorias onde o maior preço é abaixo de R$ 1000
SELECT categoria, MAX(preco) AS maior_preco
FROM produtos
GROUP BY categoria
HAVING MAX(preco) < 1000;

-- ============================================
-- EXEMPLO 10: Estatísticas completas
-- ============================================
SELECT 
    categoria,
    COUNT(*) AS quantidade,
    MIN(preco) AS minimo,
    MAX(preco) AS maximo,
    AVG(preco) AS media,
    MAX(preco) - MIN(preco) AS amplitude
FROM produtos
GROUP BY categoria;

-- ============================================
-- EXEMPLO 11: MAX por período
-- ============================================
-- Maior venda por mês
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
    MAX(valor_total) AS maior_venda
FROM pedidos
GROUP BY DATE_FORMAT(data_pedido, '%Y-%m')
ORDER BY mes;

-- ============================================
-- EXEMPLO 12: MAX em dashboard
-- ============================================
SELECT
    MAX(valor_total) AS maior_pedido_historico,
    (SELECT MAX(valor_total) FROM pedidos 
     WHERE data_pedido >= CURDATE() - INTERVAL 30 DAY) AS maior_ultimos_30_dias,
    (SELECT MAX(valor_total) FROM pedidos 
     WHERE DATE(data_pedido) = CURDATE()) AS maior_hoje
FROM pedidos;

-- ============================================
-- MAX EM WINDOW FUNCTIONS:
-- ============================================
-- Maior valor até o momento (running max)
SELECT 
    data_pedido,
    valor_total,
    MAX(valor_total) OVER (ORDER BY data_pedido) AS maior_ate_agora
FROM pedidos;

-- Maior valor da categoria (sem GROUP BY)
SELECT 
    nome,
    categoria,
    preco,
    MAX(preco) OVER (PARTITION BY categoria) AS maior_da_categoria,
    preco / MAX(preco) OVER (PARTITION BY categoria) AS percentual_do_maior
FROM produtos;

-- ============================================
-- OBSERVAÇÕES:
-- ============================================
-- 1. MAX ignora valores NULL
-- 2. MAX de coluna vazia retorna NULL
-- 3. Para strings, compara alfabeticamente
-- 4. Para datas, retorna a data mais recente
-- 5. Use com LIMIT 1 como alternativa para pegar o registro
