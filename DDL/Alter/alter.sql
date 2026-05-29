-- ============================================
-- COMANDO: ALTER
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando ALTER é usado para modificar a estrutura de objetos
-- existentes no banco de dados, como adicionar, modificar ou
-- remover colunas de uma tabela.
-- É um comando DDL (Data Definition Language).
--
-- SINTAXE BÁSICA:
-- ALTER TABLE nome_tabela
-- ADD/MODIFY/DROP ...;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Adicionar uma nova coluna
-- ============================================
ALTER TABLE clientes
ADD telefone VARCHAR(20);

-- ============================================
-- EXEMPLO 2: Adicionar múltiplas colunas
-- ============================================
ALTER TABLE clientes
ADD endereco VARCHAR(255),
ADD cidade VARCHAR(100),
ADD cep VARCHAR(10);

-- ============================================
-- EXEMPLO 3: Modificar o tipo de uma coluna
-- ============================================
-- MySQL
ALTER TABLE clientes
MODIFY nome VARCHAR(200);

-- SQL Server
ALTER TABLE clientes
ALTER COLUMN nome VARCHAR(200);

-- ============================================
-- EXEMPLO 4: Renomear uma coluna
-- ============================================
-- MySQL
ALTER TABLE clientes
CHANGE telefone celular VARCHAR(20);

-- PostgreSQL / SQL Server
ALTER TABLE clientes
RENAME COLUMN telefone TO celular;

-- ============================================
-- EXEMPLO 5: Remover uma coluna
-- ============================================
ALTER TABLE clientes
DROP COLUMN endereco;

-- ============================================
-- EXEMPLO 6: Adicionar uma chave primária
-- ============================================
ALTER TABLE clientes
ADD PRIMARY KEY (id);

-- ============================================
-- EXEMPLO 7: Adicionar uma chave estrangeira
-- ============================================
ALTER TABLE pedidos
ADD CONSTRAINT fk_cliente
FOREIGN KEY (cliente_id) REFERENCES clientes(id);

-- ============================================
-- EXEMPLO 8: Remover uma constraint
-- ============================================
ALTER TABLE pedidos
DROP CONSTRAINT fk_cliente;

-- MySQL (para chave estrangeira)
ALTER TABLE pedidos
DROP FOREIGN KEY fk_cliente;

-- ============================================
-- EXEMPLO 9: Adicionar índice único
-- ============================================
ALTER TABLE clientes
ADD UNIQUE (email);

-- ============================================
-- EXEMPLO 10: Renomear uma tabela
-- ============================================
ALTER TABLE clientes
RENAME TO customers;

-- MySQL alternativo
RENAME TABLE clientes TO customers;

-- ============================================
-- EXEMPLO 11: Adicionar valor padrão
-- ============================================
ALTER TABLE produtos
ALTER COLUMN estoque SET DEFAULT 0;

-- ============================================
-- EXEMPLO 12: Remover valor padrão
-- ============================================
ALTER TABLE produtos
ALTER COLUMN estoque DROP DEFAULT;
