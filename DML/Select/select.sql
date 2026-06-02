-- ============================================
-- COMANDO: SELECT
-- ============================================
-- 
-- Descrição:
-- O comando SELECT é usado para consultar/recuperar dados
-- de uma ou mais tabelas do banco de dados.
-- É o comando mais utilizado em SQL.
-- É um comando DML (Data Manipulation Language).
--
-- Sintaxe básica:
-- SELECT coluna1, coluna2, ...
-- FROM tabela
-- [WHERE condição]
-- [ORDER BY coluna];
--
-- ============================================

-- ============================================
-- Exemplo 1: Selecionar todas as colunas
-- ============================================
-- O asterisco (*) seleciona TODAS as colunas
SELECT * FROM clientes;

-- ============================================
-- Exemplo 2: Selecionar colunas específicas
-- ============================================
SELECT nome, email FROM clientes;

-- ============================================
-- Exemplo 3: Selecionar com alias (apelido)
-- ============================================
SELECT 
    nome AS nome_cliente,
    email AS email_contato
FROM clientes;

-- ============================================
-- Exemplo 4: Selecionar com condição WHERE
-- ============================================
SELECT * FROM clientes
WHERE cidade = 'São Paulo';

-- ============================================
-- Exemplo 5: Selecionar com múltiplas condições
-- ============================================
SELECT * FROM produtos
WHERE preco > 100 AND estoque > 0;

SELECT * FROM produtos
WHERE categoria = 'Eletrônicos' OR categoria = 'Informática';

-- ============================================
-- Exemplo 6: Selecionar com ordenação
-- ============================================
-- Ordem crescente (padrão)
SELECT * FROM produtos ORDER BY preco;

-- Ordem decrescente
SELECT * FROM produtos ORDER BY preco DESC;

-- Múltiplas colunas
SELECT * FROM produtos ORDER BY categoria, preco DESC;

-- ============================================
-- Exemplo 7: Limitar resultados
-- ============================================
-- MySQL / PostgreSQL
SELECT * FROM produtos LIMIT 10;

-- Com offset (pular primeiros 5, pegar 10)
SELECT * FROM produtos LIMIT 10 OFFSET 5;

-- SQL Server
SELECT TOP 10 * FROM produtos;

-- ============================================
-- Exemplo 8: Valores únicos (sem duplicatas)
-- ============================================
SELECT DISTINCT categoria FROM produtos;

SELECT DISTINCT cidade, estado FROM clientes;

-- ============================================
-- Exemplo 9: Cálculos e expressões
-- ============================================
SELECT 
    nome,
    preco,
    quantidade,
    preco * quantidade AS valor_total
FROM itens_pedido;

-- ============================================
-- Exemplo 10: Concatenação de strings
-- ============================================
-- MySQL
SELECT CONCAT(nome, ' - ', cidade) AS cliente_local
FROM clientes;

-- SQL Server
SELECT nome + ' - ' + cidade AS cliente_local
FROM clientes;

-- ============================================
-- Exemplo 11: Selecionar com funções de agregação
-- ============================================
SELECT 
    COUNT(*) AS total_produtos,
    SUM(estoque) AS estoque_total,
    AVG(preco) AS preco_medio,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produtos;

-- ============================================
-- Exemplo 12: Selecionar de múltiplas tabelas (JOIN)
-- ============================================
SELECT 
    c.nome AS cliente,
    p.data_pedido,
    p.valor_total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- Exemplo 13: Subquery no SELECT
-- ============================================
SELECT 
    nome,
    preco,
    (SELECT AVG(preco) FROM produtos) AS media_geral
FROM produtos;
