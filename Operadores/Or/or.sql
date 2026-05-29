-- ============================================
-- OPERADOR: OR
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador OR combina duas ou mais condições e retorna
-- TRUE quando PELO MENOS UMA das condições é verdadeira.
-- É usado para criar filtros mais abrangentes.
--
-- TABELA VERDADE:
-- TRUE  OR TRUE  = TRUE
-- TRUE  OR FALSE = TRUE
-- FALSE OR TRUE  = TRUE
-- FALSE OR FALSE = FALSE
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE condição1 OR condição2;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Duas condições simples
-- ============================================
-- Clientes de SP ou RJ
SELECT * FROM clientes
WHERE estado = 'SP' OR estado = 'RJ';

-- ============================================
-- EXEMPLO 2: Múltiplas condições OR
-- ============================================
-- Produtos de várias categorias
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos'
OR categoria = 'Informática'
OR categoria = 'Games';

-- Equivalente usando IN (mais limpo)
SELECT * FROM produtos
WHERE categoria IN ('Eletrônicos', 'Informática', 'Games');

-- ============================================
-- EXEMPLO 3: OR com valores diferentes
-- ============================================
-- Produtos muito baratos ou muito caros
SELECT * FROM produtos
WHERE preco < 10 OR preco > 1000;

-- ============================================
-- EXEMPLO 4: OR com diferentes colunas
-- ============================================
-- Buscar em nome ou descrição
SELECT * FROM produtos
WHERE nome LIKE '%smartphone%'
OR descricao LIKE '%smartphone%';

-- ============================================
-- EXEMPLO 5: Combinando OR com AND
-- ============================================
-- Produtos ativos que são eletrônicos OU premium
SELECT * FROM produtos
WHERE ativo = TRUE
AND (categoria = 'Eletrônicos' OR tipo = 'Premium');

-- ⚠️ Cuidado com a precedência! AND tem prioridade sobre OR
-- SEM parênteses, o resultado seria diferente:
-- WHERE ativo = TRUE AND categoria = 'Eletrônicos' OR tipo = 'Premium'
-- Seria interpretado como:
-- WHERE (ativo = TRUE AND categoria = 'Eletrônicos') OR tipo = 'Premium'

-- ============================================
-- EXEMPLO 6: OR em busca por contato
-- ============================================
-- Clientes com email ou telefone cadastrado
SELECT * FROM clientes
WHERE email IS NOT NULL OR telefone IS NOT NULL;

-- ============================================
-- EXEMPLO 7: OR com datas
-- ============================================
-- Pedidos de janeiro ou dezembro
SELECT * FROM pedidos
WHERE MONTH(data_pedido) = 1
OR MONTH(data_pedido) = 12;

-- ============================================
-- EXEMPLO 8: OR para status múltiplos
-- ============================================
-- Pedidos pendentes ou em processamento
SELECT * FROM pedidos
WHERE status = 'pendente'
OR status = 'processando'
OR status = 'aguardando_pagamento';

-- Melhor com IN:
SELECT * FROM pedidos
WHERE status IN ('pendente', 'processando', 'aguardando_pagamento');

-- ============================================
-- EXEMPLO 9: OR em UPDATE
-- ============================================
-- Inativar produtos sem estoque ou descontinuados
UPDATE produtos
SET ativo = FALSE
WHERE estoque = 0 OR descontinuado = TRUE;

-- ============================================
-- EXEMPLO 10: OR com LIKE
-- ============================================
-- Buscar clientes pelo nome ou sobrenome
SELECT * FROM clientes
WHERE nome LIKE 'João%'
OR nome LIKE '%Silva';

-- ============================================
-- EXEMPLO 11: OR para tratamento de erros
-- ============================================
-- Logs de erro ou warning
SELECT * FROM logs
WHERE nivel = 'ERROR'
OR nivel = 'WARNING'
OR nivel = 'CRITICAL'
ORDER BY data_criacao DESC;

-- ============================================
-- EXEMPLO 12: OR com subconsulta
-- ============================================
-- Clientes VIP ou que fizeram pedidos grandes
SELECT * FROM clientes
WHERE tipo = 'VIP'
OR id IN (
    SELECT cliente_id FROM pedidos
    WHERE valor_total > 5000
);

-- ============================================
-- PRECEDÊNCIA DE OPERADORES:
-- ============================================
-- 1. NOT (maior precedência)
-- 2. AND
-- 3. OR (menor precedência)
--
-- SEMPRE use parênteses ao combinar AND e OR!

-- ============================================
-- OR vs IN:
-- ============================================
-- OR é mais verboso para múltiplos valores do mesmo campo
-- IN é mais limpo e legível

-- Usando OR (verboso)
SELECT * FROM clientes WHERE estado = 'SP' OR estado = 'RJ' OR estado = 'MG';

-- Usando IN (limpo)
SELECT * FROM clientes WHERE estado IN ('SP', 'RJ', 'MG');
