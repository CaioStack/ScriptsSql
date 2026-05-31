-- ============================================
-- Claúsula: WHERE
-- ============================================
-- 
-- Descrição:
-- A cláusula WHERE é usada para filtrar registros,
-- retornando apenas aqueles que atendem a uma condição
-- especificada. Pode ser usada com SELECT, UPDATE e DELETE.
--
-- Sintaxe básica:
-- SELECT colunas FROM tabela WHERE condição;
--
-- ============================================

-- ============================================
-- Exemplo 1: Comparação simples
-- ============================================
-- Igual
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- Diferente
SELECT * FROM produtos WHERE categoria <> 'Eletrônicos';
SELECT * FROM produtos WHERE categoria != 'Eletrônicos';

-- Maior que
SELECT * FROM produtos WHERE preco > 100;

-- Menor que
SELECT * FROM produtos WHERE estoque < 10;

-- Maior ou igual
SELECT * FROM clientes WHERE idade >= 18;

-- Menor ou igual
SELECT * FROM produtos WHERE preco <= 50;

-- ============================================
-- Exemplo 2: Múltiplas condições com AND
-- ============================================
-- Todas as condições devem ser verdadeiras
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos'
AND preco < 1000
AND estoque > 0;

-- ============================================
-- Exemplo 3: Múltiplas condições com OR
-- ============================================
-- Pelo menos uma condição deve ser verdadeira
SELECT * FROM clientes
WHERE cidade = 'São Paulo'
OR cidade = 'Rio de Janeiro'
OR cidade = 'Belo Horizonte';

-- ============================================
-- Exemplo 4: Combinando AND e OR
-- ============================================
-- Use parênteses para definir a precedência
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos'
AND (preco < 500 OR estoque > 100);

-- ============================================
-- Exemplo 5: WHERE com IN
-- ============================================
SELECT * FROM clientes
WHERE cidade IN ('São Paulo', 'Rio de Janeiro', 'Curitiba');

SELECT * FROM pedidos
WHERE status IN ('pendente', 'processando');

-- ============================================
-- Exemplo 6: WHERE com NOT IN
-- ============================================
SELECT * FROM produtos
WHERE categoria NOT IN ('Descontinuado', 'Esgotado');

-- ============================================
-- Exemplo 7: WHERE com BETWEEN
-- ============================================
SELECT * FROM produtos
WHERE preco BETWEEN 100 AND 500;

SELECT * FROM pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-12-31';

-- ============================================
-- Exemplo 8: WHERE com LIKE (padrões de texto)
-- ============================================
-- Começa com 'Jo'
SELECT * FROM clientes WHERE nome LIKE 'Jo%';

-- Termina com 'Silva'
SELECT * FROM clientes WHERE nome LIKE '%Silva';

-- Contém 'Santos'
SELECT * FROM clientes WHERE nome LIKE '%Santos%';

-- Segundo caractere é 'a'
SELECT * FROM clientes WHERE nome LIKE '_a%';

-- ============================================
-- Exemplo 9: WHERE com IS NULL / IS NOT NULL
-- ============================================
SELECT * FROM clientes WHERE telefone IS NULL;

SELECT * FROM clientes WHERE telefone IS NOT NULL;

-- ============================================
-- Exemplo 10: WHERE com NOT
-- ============================================
SELECT * FROM clientes WHERE NOT cidade = 'São Paulo';

SELECT * FROM produtos WHERE NOT (preco > 100 AND estoque < 50);

-- ============================================
-- Exemplo 11: WHERE com EXISTS
-- ============================================
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);

-- ============================================
-- Exemplo 12: WHERE com subquery
-- ============================================
SELECT * FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

SELECT * FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos WHERE valor_total > 1000);

-- ============================================
-- Exemplo 13: WHERE em UPDATE
-- ============================================
UPDATE produtos
SET preco = preco * 0.9
WHERE categoria = 'Promocional';

-- ============================================
-- Exemplo 14: WHERE em DELETE
-- ============================================
DELETE FROM logs
WHERE data_criacao < '2023-01-01';

-- ============================================
-- OPERADORES DE COMPARAÇÃO:
-- ============================================
-- =        Igual
-- <> ou != Diferente
-- >        Maior que
-- <        Menor que
-- >=       Maior ou igual
-- <=       Menor ou igual
-- BETWEEN  Entre dois valores (inclusive)
-- LIKE     Padrão de texto
-- IN       Lista de valores
-- IS NULL  É nulo
