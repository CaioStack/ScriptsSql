-- ============================================
-- OPERADOR: EXISTS
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador EXISTS verifica se uma subquery retorna algum resultado.
-- Retorna TRUE se a subquery retornar pelo menos uma linha,
-- FALSE se a subquery não retornar nenhuma linha.
-- É muito eficiente pois para a busca assim que encontra o primeiro match.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela1
-- WHERE EXISTS (SELECT 1 FROM tabela2 WHERE condição);
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Verificar existência básica
-- ============================================
-- Clientes que têm pelo menos um pedido
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
);

-- ============================================
-- EXEMPLO 2: NOT EXISTS
-- ============================================
-- Clientes que NUNCA fizeram pedidos
SELECT * FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
);

-- ============================================
-- EXEMPLO 3: EXISTS vs IN
-- ============================================
-- Usando IN:
SELECT * FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos);

-- Usando EXISTS (geralmente mais eficiente para tabelas grandes):
SELECT * FROM clientes c
WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id);

-- ============================================
-- EXEMPLO 4: EXISTS com múltiplas condições
-- ============================================
-- Clientes que fizeram pedidos acima de R$ 1000
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
    AND p.valor_total > 1000
);

-- ============================================
-- EXEMPLO 5: EXISTS com múltiplas tabelas
-- ============================================
-- Clientes que compraram produtos eletrônicos
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    JOIN itens_pedido ip ON p.id = ip.pedido_id
    JOIN produtos pr ON ip.produto_id = pr.id
    WHERE p.cliente_id = c.id
    AND pr.categoria = 'Eletrônicos'
);

-- ============================================
-- EXEMPLO 6: NOT EXISTS para encontrar órfãos
-- ============================================
-- Produtos que nunca foram vendidos
SELECT * FROM produtos p
WHERE NOT EXISTS (
    SELECT 1 FROM itens_pedido ip
    WHERE ip.produto_id = p.id
);

-- Categorias sem produtos
SELECT * FROM categorias c
WHERE NOT EXISTS (
    SELECT 1 FROM produtos p
    WHERE p.categoria_id = c.id
);

-- ============================================
-- EXEMPLO 7: EXISTS em UPDATE
-- ============================================
-- Marcar clientes como VIP se tiverem pedidos grandes
UPDATE clientes c
SET tipo = 'VIP'
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
    AND p.valor_total > 5000
);

-- ============================================
-- EXEMPLO 8: EXISTS em DELETE
-- ============================================
-- Deletar categorias vazias
DELETE FROM categorias c
WHERE NOT EXISTS (
    SELECT 1 FROM produtos p
    WHERE p.categoria_id = c.id
);

-- ============================================
-- EXEMPLO 9: EXISTS com data
-- ============================================
-- Clientes com pedidos no último mês
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
    AND p.data_pedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
);

-- ============================================
-- EXEMPLO 10: SELECT 1 vs SELECT *
-- ============================================
-- Ambos funcionam, mas SELECT 1 é mais claro
-- pois deixa explícito que não importa O QUE é retornado

-- Funciona:
WHERE EXISTS (SELECT * FROM pedidos p WHERE p.cliente_id = c.id)

-- Recomendado (mais explícito):
WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id)

-- ============================================
-- EXEMPLO 11: EXISTS com agregação
-- ============================================
-- Clientes com mais de 5 pedidos
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
    GROUP BY p.cliente_id
    HAVING COUNT(*) > 5
);

-- ============================================
-- EXISTS vs IN - QUANDO USAR:
-- ============================================
-- 
-- EXISTS:
-- + Para de buscar no primeiro resultado (eficiente)
-- + Melhor para subqueries correlacionadas
-- + Funciona bem com NULL
-- + Geralmente melhor para tabelas grandes
--
-- IN:
-- + Mais legível para listas simples
-- + Pode usar valores literais: IN (1, 2, 3)
-- + A subquery é executada primeiro (pode ser cacheada)
--
-- ⚠️ NOT IN tem problema com NULL!
-- NOT EXISTS é mais seguro

-- ============================================
-- EXEMPLO 12: Problema do NOT IN com NULL
-- ============================================
-- Se cliente_id na tabela pedidos puder ser NULL:

-- ⚠️ Pode retornar 0 resultados incorretamente:
SELECT * FROM clientes
WHERE id NOT IN (SELECT cliente_id FROM pedidos);

-- ✅ EXISTS sempre funciona corretamente:
SELECT * FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);
