-- ============================================
-- COMANDO: INSERT
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando INSERT é usado para adicionar novos registros
-- (linhas) em uma tabela do banco de dados.
-- É um comando DML (Data Manipulation Language).
--
-- SINTAXE BÁSICA:
-- INSERT INTO tabela (coluna1, coluna2, ...)
-- VALUES (valor1, valor2, ...);
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Inserir especificando colunas
-- ============================================
INSERT INTO clientes (nome, email, cidade)
VALUES ('João Silva', 'joao@email.com', 'São Paulo');

-- ============================================
-- EXEMPLO 2: Inserir sem especificar colunas
-- ============================================
-- Deve fornecer valores para TODAS as colunas na ordem correta
-- Não recomendado - pode quebrar se a estrutura mudar
INSERT INTO clientes
VALUES (1, 'Maria Santos', 'maria@email.com', 'Rio de Janeiro');

-- ============================================
-- EXEMPLO 3: Inserir múltiplos registros
-- ============================================
INSERT INTO produtos (nome, preco, estoque) VALUES
    ('Notebook Dell', 3500.00, 10),
    ('Mouse Logitech', 89.90, 50),
    ('Teclado Mecânico', 299.00, 25),
    ('Monitor 24"', 899.00, 15);

-- ============================================
-- EXEMPLO 4: Inserir com valores padrão
-- ============================================
-- Se a coluna tem DEFAULT, pode omiti-la
INSERT INTO usuarios (username, email)
VALUES ('joao123', 'joao@email.com');
-- status e data_cadastro usarão valores DEFAULT

-- Ou usar DEFAULT explicitamente
INSERT INTO usuarios (username, email, status)
VALUES ('maria456', 'maria@email.com', DEFAULT);

-- ============================================
-- EXEMPLO 5: Inserir com NULL
-- ============================================
INSERT INTO clientes (nome, email, telefone)
VALUES ('Carlos Souza', 'carlos@email.com', NULL);

-- ============================================
-- EXEMPLO 6: Inserir dados de outra tabela
-- ============================================
-- Copia dados de uma tabela para outra
INSERT INTO clientes_backup (nome, email, cidade)
SELECT nome, email, cidade
FROM clientes
WHERE ativo = TRUE;

-- ============================================
-- EXEMPLO 7: Inserir com SELECT completo
-- ============================================
INSERT INTO relatorio_vendas (produto, quantidade_vendida, total)
SELECT 
    p.nome,
    SUM(ip.quantidade),
    SUM(ip.quantidade * ip.preco_unitario)
FROM produtos p
INNER JOIN itens_pedido ip ON p.id = ip.produto_id
GROUP BY p.nome;

-- ============================================
-- EXEMPLO 8: INSERT com RETURNING (PostgreSQL)
-- ============================================
-- Retorna os dados inseridos (útil para pegar ID gerado)
INSERT INTO clientes (nome, email)
VALUES ('Ana Costa', 'ana@email.com')
RETURNING id, nome;

-- ============================================
-- EXEMPLO 9: INSERT IGNORE (MySQL)
-- ============================================
-- Ignora o INSERT se violar constraint (ex: UNIQUE)
INSERT IGNORE INTO clientes (email, nome)
VALUES ('joao@email.com', 'João Duplicado');

-- ============================================
-- EXEMPLO 10: INSERT ON DUPLICATE KEY UPDATE (MySQL)
-- ============================================
-- Se já existe (violação de UNIQUE/PRIMARY), atualiza
INSERT INTO produtos (codigo, nome, preco, estoque)
VALUES ('PROD001', 'Produto X', 99.90, 10)
ON DUPLICATE KEY UPDATE
    preco = VALUES(preco),
    estoque = estoque + VALUES(estoque);

-- ============================================
-- EXEMPLO 11: INSERT ON CONFLICT (PostgreSQL)
-- ============================================
-- Similar ao ON DUPLICATE KEY do MySQL
INSERT INTO produtos (codigo, nome, preco)
VALUES ('PROD001', 'Produto X', 99.90)
ON CONFLICT (codigo) 
DO UPDATE SET preco = EXCLUDED.preco;

-- ============================================
-- BOAS PRÁTICAS:
-- ============================================
-- 1. Sempre especifique as colunas no INSERT
-- 2. Use transações para múltiplos INSERTs relacionados
-- 3. Valide os dados antes de inserir
-- 4. Trate possíveis erros de constraint
-- 5. Use INSERT em lote para melhor performance
