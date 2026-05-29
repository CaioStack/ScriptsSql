-- ============================================
-- OPERADOR: AND
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador AND combina duas ou mais condições e retorna
-- TRUE apenas quando TODAS as condições são verdadeiras.
-- É usado para criar filtros mais restritivos.
--
-- TABELA VERDADE:
-- TRUE  AND TRUE  = TRUE
-- TRUE  AND FALSE = FALSE
-- FALSE AND TRUE  = FALSE
-- FALSE AND FALSE = FALSE
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE condição1 AND condição2;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Duas condições simples
-- ============================================
-- Produtos ativos E com estoque
SELECT * FROM produtos
WHERE ativo = TRUE AND estoque > 0;

-- ============================================
-- EXEMPLO 2: Múltiplas condições AND
-- ============================================
-- Clientes de SP, maiores de idade, com email cadastrado
SELECT * FROM clientes
WHERE estado = 'SP'
AND idade >= 18
AND email IS NOT NULL;

-- ============================================
-- EXEMPLO 3: AND com comparações numéricas
-- ============================================
-- Produtos entre R$ 100 e R$ 500
SELECT * FROM produtos
WHERE preco >= 100 AND preco <= 500;

-- Equivalente usando BETWEEN
SELECT * FROM produtos
WHERE preco BETWEEN 100 AND 500;

-- ============================================
-- EXEMPLO 4: AND com datas
-- ============================================
-- Pedidos de janeiro de 2024
SELECT * FROM pedidos
WHERE data_pedido >= '2024-01-01'
AND data_pedido < '2024-02-01';

-- ============================================
-- EXEMPLO 5: AND com texto
-- ============================================
-- Funcionários do departamento de TI com cargo de analista
SELECT * FROM funcionarios
WHERE departamento = 'TI'
AND cargo LIKE '%Analista%';

-- ============================================
-- EXEMPLO 6: Combinando AND com OR
-- ============================================
-- Produtos eletrônicos baratos OU qualquer produto premium
SELECT * FROM produtos
WHERE (categoria = 'Eletrônicos' AND preco < 100)
OR tipo = 'Premium';

-- ============================================
-- EXEMPLO 7: AND em UPDATE
-- ============================================
-- Atualizar produtos que atendem múltiplos critérios
UPDATE produtos
SET destaque = TRUE
WHERE categoria = 'Lançamentos'
AND preco > 500
AND estoque > 10;

-- ============================================
-- EXEMPLO 8: AND em DELETE
-- ============================================
-- Deletar logs antigos de tipo debug
DELETE FROM logs
WHERE tipo = 'debug'
AND data_criacao < '2023-01-01';

-- ============================================
-- EXEMPLO 9: AND com JOIN
-- ============================================
-- Pedidos de clientes VIP acima de R$ 1000
SELECT p.*, c.nome
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE c.tipo = 'VIP'
AND p.valor_total > 1000;

-- ============================================
-- EXEMPLO 10: AND com IS NULL / IS NOT NULL
-- ============================================
-- Clientes com email mas sem telefone
SELECT * FROM clientes
WHERE email IS NOT NULL
AND telefone IS NULL;

-- ============================================
-- EXEMPLO 11: AND com funções
-- ============================================
-- Produtos cadastrados este ano com nome curto
SELECT * FROM produtos
WHERE YEAR(data_cadastro) = YEAR(CURDATE())
AND LENGTH(nome) <= 20;

-- ============================================
-- EXEMPLO 12: Verificação de intervalo
-- ============================================
-- Funcionários com salário entre 3000 e 5000 no setor comercial
SELECT * FROM funcionarios
WHERE salario >= 3000
AND salario <= 5000
AND setor = 'Comercial';

-- ============================================
-- PRECEDÊNCIA DE OPERADORES:
-- ============================================
-- 1. NOT (maior precedência)
-- 2. AND
-- 3. OR (menor precedência)
--
-- Use parênteses para clareza:
-- WHERE a = 1 AND b = 2 OR c = 3  -- Pode confundir
-- WHERE (a = 1 AND b = 2) OR c = 3  -- Mais claro

-- ============================================
-- DICAS:
-- ============================================
-- 1. Coloque condições mais restritivas primeiro (performance)
-- 2. Use parênteses ao combinar AND e OR
-- 3. AND com muitas condições pode ser substituído por IN
-- 4. Condições sempre devem retornar booleano
