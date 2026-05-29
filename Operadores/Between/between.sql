-- ============================================
-- OPERADOR: BETWEEN
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador BETWEEN seleciona valores dentro de um intervalo.
-- Os valores podem ser números, textos ou datas.
-- BETWEEN é INCLUSIVO, ou seja, inclui os valores inicial e final.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela 
-- WHERE coluna BETWEEN valor_inicial AND valor_final;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: BETWEEN com números
-- ============================================
-- Produtos com preço entre R$ 100 e R$ 500
SELECT * FROM produtos
WHERE preco BETWEEN 100 AND 500;

-- Equivalente usando >= e <=
SELECT * FROM produtos
WHERE preco >= 100 AND preco <= 500;

-- ============================================
-- EXEMPLO 2: BETWEEN com inteiros
-- ============================================
-- Produtos com estoque entre 10 e 50 unidades
SELECT * FROM produtos
WHERE estoque BETWEEN 10 AND 50;

-- ============================================
-- EXEMPLO 3: BETWEEN com datas
-- ============================================
-- Pedidos de janeiro de 2024
SELECT * FROM pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-01-31';

-- Pedidos do ano de 2024
SELECT * FROM pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-12-31';

-- ============================================
-- EXEMPLO 4: NOT BETWEEN
-- ============================================
-- Produtos FORA da faixa de preço 100-500
SELECT * FROM produtos
WHERE preco NOT BETWEEN 100 AND 500;

-- Equivalente:
SELECT * FROM produtos
WHERE preco < 100 OR preco > 500;

-- ============================================
-- EXEMPLO 5: BETWEEN com strings (alfabético)
-- ============================================
-- Clientes com nomes entre 'A' e 'M' (alfabeticamente)
SELECT * FROM clientes
WHERE nome BETWEEN 'A' AND 'M';

-- Isso inclui 'Ana', 'João', 'Maria', mas não 'Pedro', 'Zélia'

-- ============================================
-- EXEMPLO 6: BETWEEN com hora/datetime
-- ============================================
-- Logs entre 8h e 18h
SELECT * FROM logs
WHERE TIME(data_hora) BETWEEN '08:00:00' AND '18:00:00';

-- Pedidos da última semana
SELECT * FROM pedidos
WHERE data_pedido BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE();

-- ============================================
-- EXEMPLO 7: BETWEEN em relatórios
-- ============================================
-- Vendas do trimestre
SELECT 
    produto_id,
    SUM(quantidade) AS total_vendido,
    SUM(quantidade * preco_unitario) AS valor_total
FROM itens_pedido ip
JOIN pedidos p ON ip.pedido_id = p.id
WHERE p.data_pedido BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY produto_id;

-- ============================================
-- EXEMPLO 8: BETWEEN com idade
-- ============================================
-- Clientes adultos (18-60 anos)
SELECT * FROM clientes
WHERE idade BETWEEN 18 AND 60;

-- Usando data de nascimento
SELECT * FROM clientes
WHERE YEAR(CURDATE()) - YEAR(data_nascimento) BETWEEN 18 AND 60;

-- ============================================
-- EXEMPLO 9: BETWEEN em UPDATE
-- ============================================
-- Aplicar desconto em produtos de determinada faixa de preço
UPDATE produtos
SET preco = preco * 0.9
WHERE preco BETWEEN 50 AND 100;

-- ============================================
-- EXEMPLO 10: BETWEEN em DELETE
-- ============================================
-- Deletar logs antigos (mais de 1 ano)
DELETE FROM logs
WHERE data_criacao BETWEEN '2022-01-01' AND '2022-12-31';

-- ============================================
-- EXEMPLO 11: Faixas de classificação
-- ============================================
SELECT 
    nome,
    preco,
    CASE 
        WHEN preco BETWEEN 0 AND 50 THEN 'Econômico'
        WHEN preco BETWEEN 51 AND 200 THEN 'Intermediário'
        WHEN preco BETWEEN 201 AND 1000 THEN 'Premium'
        ELSE 'Luxo'
    END AS faixa
FROM produtos;

-- ============================================
-- EXEMPLO 12: BETWEEN vs comparações
-- ============================================
-- BETWEEN é INCLUSIVO (inclui os limites)
SELECT * FROM produtos WHERE preco BETWEEN 100 AND 200;
-- Retorna produtos com preco >= 100 E preco <= 200

-- Para EXCLUIR os limites, use comparações:
SELECT * FROM produtos WHERE preco > 100 AND preco < 200;
-- Retorna produtos com preco > 100 E preco < 200

-- ============================================
-- CUIDADOS COM DATAS E BETWEEN:
-- ============================================
-- Se a coluna é DATETIME e você usa apenas DATE no BETWEEN:
-- WHERE data_hora BETWEEN '2024-01-01' AND '2024-01-31'
-- Isso inclui '2024-01-31 00:00:00' mas NÃO '2024-01-31 23:59:59'!

-- Solução 1: Inclua a hora
WHERE data_hora BETWEEN '2024-01-01 00:00:00' AND '2024-01-31 23:59:59'

-- Solução 2: Use < para o limite superior
WHERE data_hora >= '2024-01-01' AND data_hora < '2024-02-01'

-- ============================================
-- DICAS:
-- ============================================
-- 1. BETWEEN inclui os valores inicial e final
-- 2. O valor inicial deve ser <= valor final
-- 3. Funciona com números, datas, strings
-- 4. Para datas, cuidado com a hora!
-- 5. NOT BETWEEN exclui o intervalo (incluindo os limites)
