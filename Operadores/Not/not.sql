-- ============================================
-- OPERADOR: NOT
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador NOT inverte o valor lógico de uma condição.
-- Se a condição é TRUE, NOT a torna FALSE, e vice-versa.
-- Pode ser usado com outros operadores como IN, LIKE, BETWEEN, etc.
--
-- TABELA VERDADE:
-- NOT TRUE  = FALSE
-- NOT FALSE = TRUE
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE NOT condição;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: NOT com condição simples
-- ============================================
-- Clientes que NÃO são de São Paulo
SELECT * FROM clientes
WHERE NOT estado = 'SP';

-- Equivalente a:
SELECT * FROM clientes
WHERE estado <> 'SP';

-- ============================================
-- EXEMPLO 2: NOT com IN
-- ============================================
-- Produtos que NÃO são das categorias especificadas
SELECT * FROM produtos
WHERE categoria NOT IN ('Eletrônicos', 'Informática', 'Games');

-- ============================================
-- EXEMPLO 3: NOT com LIKE
-- ============================================
-- Clientes cujo nome NÃO começa com 'A'
SELECT * FROM clientes
WHERE nome NOT LIKE 'A%';

-- Emails que NÃO são do Gmail
SELECT * FROM clientes
WHERE email NOT LIKE '%@gmail.com';

-- ============================================
-- EXEMPLO 4: NOT com BETWEEN
-- ============================================
-- Produtos com preço FORA do intervalo 100-500
SELECT * FROM produtos
WHERE preco NOT BETWEEN 100 AND 500;

-- Equivalente a:
SELECT * FROM produtos
WHERE preco < 100 OR preco > 500;

-- ============================================
-- EXEMPLO 5: NOT com EXISTS
-- ============================================
-- Clientes que NUNCA fizeram pedidos
SELECT * FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
);

-- ============================================
-- EXEMPLO 6: NOT com NULL
-- ============================================
-- IS NOT NULL - campo preenchido
SELECT * FROM clientes
WHERE telefone IS NOT NULL;

-- ⚠️ CUIDADO: NOT com NULL
-- NOT (campo = NULL) NÃO funciona como esperado!
-- Sempre use IS NOT NULL

-- ============================================
-- EXEMPLO 7: NOT com condição booleana
-- ============================================
-- Produtos inativos
SELECT * FROM produtos
WHERE NOT ativo;

-- Equivalente a:
SELECT * FROM produtos
WHERE ativo = FALSE;

-- ============================================
-- EXEMPLO 8: NOT com múltiplas condições
-- ============================================
-- NÃO (eletrônicos E caros)
SELECT * FROM produtos
WHERE NOT (categoria = 'Eletrônicos' AND preco > 1000);

-- Isso retorna:
-- - Produtos que NÃO são eletrônicos
-- - OU produtos eletrônicos com preço <= 1000

-- ============================================
-- EXEMPLO 9: NOT com AND e OR
-- ============================================
-- Clientes que não são (VIP ou Premium)
SELECT * FROM clientes
WHERE NOT (tipo = 'VIP' OR tipo = 'Premium');

-- Equivalente a:
SELECT * FROM clientes
WHERE tipo NOT IN ('VIP', 'Premium');

-- ============================================
-- EXEMPLO 10: Dupla negação
-- ============================================
-- NOT NOT é igual ao valor original
SELECT * FROM produtos
WHERE NOT NOT ativo;  -- Igual a: WHERE ativo

-- ============================================
-- EXEMPLO 11: NOT em subquery
-- ============================================
-- Categorias que NÃO têm produtos
SELECT * FROM categorias c
WHERE c.id NOT IN (
    SELECT DISTINCT categoria_id FROM produtos
);

-- ============================================
-- EXEMPLO 12: NOT com ANY/ALL
-- ============================================
-- Produtos com preço NÃO maior que qualquer produto premium
SELECT * FROM produtos p1
WHERE NOT p1.preco > ANY (
    SELECT preco FROM produtos WHERE tipo = 'Premium'
);

-- ============================================
-- PRECEDÊNCIA DO NOT:
-- ============================================
-- NOT tem a MAIOR precedência entre os operadores lógicos
-- 1. NOT (primeiro a ser avaliado)
-- 2. AND
-- 3. OR

-- Exemplo:
-- NOT a AND b    é interpretado como (NOT a) AND b
-- NOT (a AND b)  é diferente! Nega toda a expressão

-- ============================================
-- NOT vs operadores de negação:
-- ============================================
-- NOT IN      vs  usando <> com AND
-- NOT LIKE    vs  usando <> (não equivalente para padrões)
-- NOT BETWEEN vs  usando < e >
-- NOT EXISTS  vs  usando NOT IN (cuidado com NULL)

-- ============================================
-- DICAS:
-- ============================================
-- 1. NOT com IN é geralmente mais legível
-- 2. Cuidado com NOT em subqueries com NULL
-- 3. Use parênteses para clareza
-- 4. Às vezes, inverter a lógica é mais simples que usar NOT
