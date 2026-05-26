-- ============================================
-- OPERADOR: ALL
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador ALL compara um valor com TODOS os valores
-- de uma lista/subquery. Retorna TRUE se a comparação
-- for verdadeira para TODOS os valores da lista.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela
-- WHERE coluna operador ALL (subquery);
--
-- Operadores: =, <>, <, >, <=, >=
--
-- ============================================

-- ============================================
-- EXEMPLO 1: ALL com >
-- ============================================
-- Produtos mais caros que TODOS os eletrônicos
SELECT * FROM produtos
WHERE preco > ALL (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);
-- Retorna apenas produtos com preço maior que o MAIOR eletrônico

-- ============================================
-- EXEMPLO 2: ALL com <
-- ============================================
-- Produtos mais baratos que TODOS os premium
SELECT * FROM produtos
WHERE preco < ALL (
    SELECT preco FROM produtos
    WHERE tipo = 'Premium'
);
-- Retorna produtos com preço menor que o MENOR premium

-- ============================================
-- EXEMPLO 3: ALL vs ANY - comparação visual
-- ============================================
-- Supondo que eletrônicos custam: 100, 500, 1000

-- > ANY (maior que algum): preco > 100 (o mínimo)
SELECT nome, preco FROM produtos
WHERE preco > ANY (SELECT preco FROM produtos WHERE categoria = 'Eletrônicos');
-- Retorna produtos com preço > 100

-- > ALL (maior que todos): preco > 1000 (o máximo)
SELECT nome, preco FROM produtos
WHERE preco > ALL (SELECT preco FROM produtos WHERE categoria = 'Eletrônicos');
-- Retorna produtos com preço > 1000

-- ============================================
-- EXEMPLO 4: ALL com =
-- ============================================
-- = ALL só retorna TRUE se TODOS os valores forem iguais
-- (o que raramente faz sentido)
SELECT * FROM produtos
WHERE preco = ALL (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);
-- Só retorna algo se TODOS os eletrônicos tiverem o mesmo preço

-- ============================================
-- EXEMPLO 5: ALL com <>
-- ============================================
-- Preço diferente de TODOS os eletrônicos
SELECT * FROM produtos
WHERE preco <> ALL (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);
-- Equivalente a NOT IN

-- ============================================
-- EXEMPLO 6: Funcionários mais bem pagos
-- ============================================
-- Funcionário com maior salário (maior que todos os outros)
SELECT nome, salario
FROM funcionarios f1
WHERE salario >= ALL (
    SELECT salario FROM funcionarios
);

-- ============================================
-- EXEMPLO 7: ALL em contexto prático
-- ============================================
-- Produtos mais baratos que todos os concorrentes
SELECT p.nome, p.preco
FROM produtos p
WHERE p.preco < ALL (
    SELECT pc.preco
    FROM produtos_concorrentes pc
    WHERE pc.produto_similar_id = p.id
);

-- ============================================
-- EXEMPLO 8: ALL com datas
-- ============================================
-- Clientes cujo último pedido é mais recente que todos os pedidos do mês passado
SELECT * FROM clientes c
WHERE (
    SELECT MAX(data_pedido) FROM pedidos WHERE cliente_id = c.id
) > ALL (
    SELECT data_pedido FROM pedidos
    WHERE data_pedido BETWEEN '2024-01-01' AND '2024-01-31'
);

-- ============================================
-- EXEMPLO 9: Equivalências com ALL
-- ============================================
-- > ALL é equivalente a > MAX
WHERE valor > ALL (SELECT ...) 
-- é igual a
WHERE valor > (SELECT MAX(...) FROM ...)

-- < ALL é equivalente a < MIN
WHERE valor < ALL (SELECT ...) 
-- é igual a
WHERE valor < (SELECT MIN(...) FROM ...)

-- <> ALL é equivalente a NOT IN
WHERE valor <> ALL (SELECT ...)
-- é igual a
WHERE valor NOT IN (SELECT ...)

-- ============================================
-- EXEMPLO 10: ALL com lista vazia
-- ============================================
-- Se a subquery não retorna nenhuma linha:
-- > ALL (lista vazia) = TRUE (vácuo é verdadeiro)
-- Isso pode ser surpreendente!

SELECT * FROM produtos
WHERE preco > ALL (
    SELECT preco FROM produtos
    WHERE categoria = 'Inexistente'  -- Categoria que não existe
);
-- Retorna TODOS os produtos! (lista vazia = TRUE)

-- ============================================
-- EXEMPLO 11: Verificar recorde
-- ============================================
-- Pedido com maior valor de todos os tempos
SELECT * FROM pedidos
WHERE valor_total >= ALL (SELECT valor_total FROM pedidos);

-- Equivalente (e mais comum):
SELECT * FROM pedidos
WHERE valor_total = (SELECT MAX(valor_total) FROM pedidos);

-- ============================================
-- TABELA RESUMO:
-- ============================================
-- 
-- | Expressão     | Equivalente a              |
-- |---------------|----------------------------|
-- | > ALL         | > MAX (maior que máximo)   |
-- | < ALL         | < MIN (menor que mínimo)   |
-- | >= ALL        | >= MAX                     |
-- | <= ALL        | <= MIN                     |
-- | = ALL         | Todos iguais (raro)        |
-- | <> ALL        | NOT IN                     |
--
-- ============================================

-- ============================================
-- QUANDO USAR ALL:
-- ============================================
-- 1. Comparações absolutas (maior/menor que todos)
-- 2. Encontrar valores extremos (máximo, mínimo)
-- 3. Validar que um valor supera todos os outros
-- 4. Substituir NOT IN com <> ALL
-- 5. Quando a lógica é "deve satisfazer TODAS as condições"
