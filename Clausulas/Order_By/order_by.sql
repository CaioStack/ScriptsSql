-- ============================================
-- Claúsula: ORDER BY
-- ============================================
-- 
-- Descrição:
-- A cláusula ORDER BY é usada para ordenar os resultados
-- de uma consulta em ordem crescente (ASC) ou decrescente (DESC).
-- Por padrão, a ordenação é crescente (ASC).
--
-- Sintaxe básica:
-- SELECT colunas FROM tabela
-- ORDER BY coluna [ASC|DESC];
--
-- ============================================

-- ============================================
-- Exemplo 1: Ordenação crescente (padrão)
-- ============================================
-- ASC é opcional, pois é o padrão
SELECT * FROM clientes ORDER BY nome;
SELECT * FROM clientes ORDER BY nome ASC;

-- ============================================
-- Exemplo 2: Ordenação decrescente
-- ============================================
SELECT * FROM produtos ORDER BY preco DESC;

-- Produtos mais recentes primeiro
SELECT * FROM produtos ORDER BY data_cadastro DESC;

-- ============================================
-- Exemplo 3: Ordenar por múltiplas colunas
-- ============================================
-- Primeiro por categoria (A-Z), depois por preço (maior para menor)
SELECT * FROM produtos
ORDER BY categoria ASC, preco DESC;

-- Primeiro por estado, depois por cidade, depois por nome
SELECT * FROM clientes
ORDER BY estado, cidade, nome;

-- ============================================
-- Exemplo 4: Ordenar por posição da coluna
-- ============================================
-- Ordena pela segunda coluna do SELECT
SELECT nome, preco, estoque FROM produtos
ORDER BY 2 DESC;  -- Ordena por preco

-- ============================================
-- Exemplo 5: Ordenar por alias
-- ============================================
SELECT 
    nome,
    preco * quantidade AS valor_total
FROM itens_pedido
ORDER BY valor_total DESC;

-- ============================================
-- Exemplo 6: Ordenar por expressão
-- ============================================
-- Ordenar pelo comprimento do nome
SELECT * FROM clientes
ORDER BY LENGTH(nome);

-- Ordenar por ano de nascimento
SELECT * FROM clientes
ORDER BY YEAR(data_nascimento);

-- ============================================
-- Exemplo 7: ORDER BY com WHERE
-- ============================================
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos'
ORDER BY preco DESC;

-- ============================================
-- Exemplo 8: ORDER BY com LIMIT
-- ============================================
-- Top 5 produtos mais caros
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- Top 10 clientes mais recentes
SELECT * FROM clientes
ORDER BY data_cadastro DESC
LIMIT 10;

-- ============================================
-- Exemplo 9: ORDER BY com NULL
-- ============================================
-- Por padrão, NULLs aparecem primeiro (ASC) ou último (DESC)

-- MySQL: NULLS por último em ordem crescente
SELECT * FROM clientes
ORDER BY telefone IS NULL, telefone ASC;

-- PostgreSQL: Controle explícito de NULLs
SELECT * FROM clientes
ORDER BY telefone ASC NULLS LAST;

SELECT * FROM clientes
ORDER BY telefone DESC NULLS FIRST;

-- ============================================
-- Exemplo 10: ORDER BY com CASE
-- ============================================
-- Ordenação personalizada
SELECT * FROM pedidos
ORDER BY CASE status
    WHEN 'urgente' THEN 1
    WHEN 'normal' THEN 2
    WHEN 'baixa' THEN 3
    ELSE 4
END;

-- ============================================
-- Exemplo 11: ORDER BY com FIELD (MySQL)
-- ============================================
-- Ordenação em ordem específica
SELECT * FROM pedidos
ORDER BY FIELD(status, 'urgente', 'normal', 'baixa', 'concluido');

-- ============================================
-- Exemplo 12: Ordenação aleatória
-- ============================================
-- MySQL
SELECT * FROM produtos ORDER BY RAND() LIMIT 5;

-- PostgreSQL
SELECT * FROM produtos ORDER BY RANDOM() LIMIT 5;

-- SQL Server
SELECT * FROM produtos ORDER BY NEWID();

-- ============================================
-- DICAS E OBSERVAÇÕES:
-- ============================================
-- 1. ORDER BY sempre vem depois de WHERE, GROUP BY e HAVING
-- 2. ORDER BY vem antes de LIMIT
-- 3. Ordenar por colunas indexadas é mais rápido
-- 4. Evite ORDER BY em tabelas muito grandes sem LIMIT
-- 5. Para resultados consistentes, sempre especifique ORDER BY