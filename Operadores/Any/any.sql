-- ============================================
-- OPERADOR: ANY / SOME
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador ANY (ou SOME, são sinônimos) compara um valor
-- com qualquer valor de uma lista/subquery.
-- Retorna TRUE se a comparação for verdadeira para
-- PELO MENOS UM valor da lista.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela
-- WHERE coluna operador ANY (subquery);
--
-- Operadores: =, <>, <, >, <=, >=
--
-- ============================================

-- ============================================
-- EXEMPLO 1: ANY com =
-- ============================================
-- Produtos com preço igual a qualquer produto eletrônico
SELECT * FROM produtos
WHERE preco = ANY (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);

-- Equivalente a IN:
SELECT * FROM produtos
WHERE preco IN (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);

-- ============================================
-- EXEMPLO 2: ANY com >
-- ============================================
-- Produtos mais caros que ALGUM produto eletrônico
SELECT * FROM produtos
WHERE preco > ANY (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);
-- Retorna produtos com preço maior que o MENOR eletrônico

-- ============================================
-- EXEMPLO 3: ANY com <
-- ============================================
-- Produtos mais baratos que ALGUM produto premium
SELECT * FROM produtos
WHERE preco < ANY (
    SELECT preco FROM produtos
    WHERE tipo = 'Premium'
);
-- Retorna produtos com preço menor que o MAIOR premium

-- ============================================
-- EXEMPLO 4: SOME (sinônimo de ANY)
-- ============================================
-- SOME funciona exatamente como ANY
SELECT * FROM produtos
WHERE preco > SOME (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);

-- ============================================
-- EXEMPLO 5: ANY vs ALL - diferença
-- ============================================
-- ANY: verdadeiro se a condição for verdadeira para QUALQUER valor
-- ALL: verdadeiro se a condição for verdadeira para TODOS os valores

-- > ANY: maior que o MENOR valor (pelo menos um)
-- > ALL: maior que o MAIOR valor (todos)

-- Mais caro que ALGUM eletrônico (> mínimo)
SELECT nome, preco FROM produtos
WHERE preco > ANY (
    SELECT preco FROM produtos WHERE categoria = 'Eletrônicos'
);

-- Mais caro que TODOS os eletrônicos (> máximo)
SELECT nome, preco FROM produtos
WHERE preco > ALL (
    SELECT preco FROM produtos WHERE categoria = 'Eletrônicos'
);

-- ============================================
-- EXEMPLO 6: ANY com <>
-- ============================================
-- Produtos com preço diferente de algum eletrônico
-- (praticamente todos, se houver mais de um preço de eletrônico)
SELECT * FROM produtos
WHERE preco <> ANY (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
);

-- ============================================
-- EXEMPLO 7: ANY em contexto prático
-- ============================================
-- Funcionários que ganham mais que algum gerente
SELECT nome, salario, cargo
FROM funcionarios
WHERE salario > ANY (
    SELECT salario FROM funcionarios
    WHERE cargo LIKE '%Gerente%'
);

-- ============================================
-- EXEMPLO 8: ANY com datas
-- ============================================
-- Pedidos feitos depois de algum pedido do cliente VIP
SELECT * FROM pedidos
WHERE data_pedido > ANY (
    SELECT data_pedido FROM pedidos p
    JOIN clientes c ON p.cliente_id = c.id
    WHERE c.tipo = 'VIP'
);

-- ============================================
-- EXEMPLO 9: Equivalências com ANY
-- ============================================
-- = ANY é equivalente a IN
WHERE valor = ANY (SELECT ...) 
-- é igual a
WHERE valor IN (SELECT ...)

-- > ANY é equivalente a > MIN
WHERE valor > ANY (SELECT ...) 
-- é igual a
WHERE valor > (SELECT MIN(...) FROM ...)

-- < ANY é equivalente a < MAX
WHERE valor < ANY (SELECT ...) 
-- é igual a
WHERE valor < (SELECT MAX(...) FROM ...)

-- ============================================
-- EXEMPLO 10: NOT com ANY
-- ============================================
-- NOT (= ANY) é diferente de (<> ANY)!

-- Produtos com preço NÃO encontrado entre eletrônicos
SELECT * FROM produtos
WHERE NOT (preco = ANY (
    SELECT preco FROM produtos
    WHERE categoria = 'Eletrônicos'
));

-- ============================================
-- TABELA RESUMO:
-- ============================================
-- 
-- | Expressão     | Equivalente a              |
-- |---------------|----------------------------|
-- | = ANY         | IN                         |
-- | > ANY         | > MIN (maior que mínimo)   |
-- | < ANY         | < MAX (menor que máximo)   |
-- | >= ANY        | >= MIN                     |
-- | <= ANY        | <= MAX                     |
-- | <> ANY        | Quase sempre TRUE (*)      |
--
-- (*) <> ANY é TRUE se existir QUALQUER valor diferente
--
-- ============================================

-- ============================================
-- QUANDO USAR ANY:
-- ============================================
-- 1. Comparações com > ou < contra um conjunto
-- 2. Quando a lógica é "maior que pelo menos um"
-- 3. Para queries mais expressivas que IN
-- 4. Em conjunto com ALL para diferentes lógicas
