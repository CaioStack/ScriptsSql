-- ============================================
-- OPERADOR: IN
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador IN permite verificar se um valor corresponde
-- a qualquer valor em uma lista ou resultado de uma subquery.
-- É uma forma mais limpa de escrever múltiplas condições OR.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE coluna IN (valor1, valor2, ...);
-- SELECT colunas FROM tabela WHERE coluna IN (SELECT ...);
--
-- ============================================

-- ============================================
-- EXEMPLO 1: IN com lista de valores
-- ============================================
-- Clientes de estados específicos
SELECT * FROM clientes
WHERE estado IN ('SP', 'RJ', 'MG');

-- Equivalente usando OR (mais verboso)
SELECT * FROM clientes
WHERE estado = 'SP' OR estado = 'RJ' OR estado = 'MG';

-- ============================================
-- EXEMPLO 2: IN com números
-- ============================================
-- Produtos com IDs específicos
SELECT * FROM produtos
WHERE id IN (1, 5, 10, 15, 20);

-- ============================================
-- EXEMPLO 3: IN com subquery
-- ============================================
-- Clientes que já fizeram pedidos
SELECT * FROM clientes
WHERE id IN (
    SELECT DISTINCT cliente_id FROM pedidos
);

-- ============================================
-- EXEMPLO 4: NOT IN
-- ============================================
-- Clientes que NUNCA fizeram pedidos
SELECT * FROM clientes
WHERE id NOT IN (
    SELECT DISTINCT cliente_id FROM pedidos
    WHERE cliente_id IS NOT NULL  -- Importante para evitar problemas!
);

-- ============================================
-- EXEMPLO 5: IN com JOIN alternativo
-- ============================================
-- Produtos de categorias ativas
SELECT * FROM produtos
WHERE categoria_id IN (
    SELECT id FROM categorias WHERE ativa = TRUE
);

-- Equivalente com JOIN:
SELECT p.* FROM produtos p
INNER JOIN categorias c ON p.categoria_id = c.id
WHERE c.ativa = TRUE;

-- ============================================
-- EXEMPLO 6: IN com múltiplas colunas (alguns SGBDs)
-- ============================================
-- MySQL e PostgreSQL suportam
SELECT * FROM pedidos
WHERE (cliente_id, status) IN (
    (1, 'pendente'),
    (2, 'processando'),
    (3, 'enviado')
);

-- ============================================
-- EXEMPLO 7: IN em UPDATE
-- ============================================
-- Atualizar status de vários pedidos
UPDATE pedidos
SET status = 'enviado'
WHERE id IN (101, 102, 103, 104, 105);

-- ============================================
-- EXEMPLO 8: IN em DELETE
-- ============================================
-- Deletar categorias específicas
DELETE FROM categorias
WHERE nome IN ('Temporário', 'Teste', 'Rascunho');

-- ============================================
-- EXEMPLO 9: IN com CASE
-- ============================================
-- Classificar por região
SELECT 
    nome,
    estado,
    CASE 
        WHEN estado IN ('SP', 'RJ', 'MG', 'ES') THEN 'Sudeste'
        WHEN estado IN ('RS', 'SC', 'PR') THEN 'Sul'
        WHEN estado IN ('BA', 'PE', 'CE', 'MA', 'PI', 'RN', 'PB', 'SE', 'AL') THEN 'Nordeste'
        ELSE 'Outras'
    END AS regiao
FROM clientes;

-- ============================================
-- EXEMPLO 10: IN com valores calculados
-- ============================================
-- Clientes que fizeram pedidos nos últimos 3 meses
SELECT * FROM clientes
WHERE id IN (
    SELECT cliente_id FROM pedidos
    WHERE MONTH(data_pedido) IN (
        MONTH(CURDATE()),
        MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)),
        MONTH(DATE_SUB(CURDATE(), INTERVAL 2 MONTH))
    )
);

-- ============================================
-- EXEMPLO 11: IN com strings
-- ============================================
-- Buscar por extensão de arquivo
SELECT * FROM arquivos
WHERE SUBSTRING_INDEX(nome, '.', -1) IN ('jpg', 'png', 'gif', 'webp');

-- ============================================
-- CUIDADO COM NULL NO NOT IN:
-- ============================================
-- Se a subquery retorna NULL, NOT IN pode não funcionar como esperado!

-- ⚠️ Problema:
SELECT * FROM produtos
WHERE id NOT IN (SELECT produto_id FROM vendas);
-- Se vendas.produto_id contiver NULL, nenhum resultado será retornado!

-- ✅ Solução:
SELECT * FROM produtos
WHERE id NOT IN (
    SELECT produto_id FROM vendas WHERE produto_id IS NOT NULL
);

-- ✅ Ou use NOT EXISTS:
SELECT * FROM produtos p
WHERE NOT EXISTS (
    SELECT 1 FROM vendas v WHERE v.produto_id = p.id
);

-- ============================================
-- IN vs EXISTS - QUANDO USAR:
-- ============================================
-- IN: Melhor para listas pequenas e valores fixos
-- EXISTS: Melhor para subqueries correlacionadas e grandes volumes

-- ============================================
-- PERFORMANCE:
-- ============================================
-- 1. IN com lista pequena é muito rápido
-- 2. Para listas muito grandes, considere tabela temporária + JOIN
-- 3. Índices na coluna melhoram a performance
-- 4. EXISTS pode ser mais eficiente que IN com subqueries grandes
