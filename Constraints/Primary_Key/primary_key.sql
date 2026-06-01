-- ============================================================================
-- PRIMARY KEY - Chave Primaria
-- ============================================================================
-- 
-- Descrição:
-- A PRIMARY KEY e uma constraint que identifica de forma UNICA cada registro
-- em uma tabela. Combina as restricoes UNIQUE e NOT NULL automaticamente.
-- Cada tabela pode ter apenas UMA chave primaria.
--
-- Características:
-- - Valores devem ser unicos
-- - Nao permite valores NULL
-- - Cria um indice automaticamente
-- - Pode ser simples (1 coluna) ou composta (varias colunas)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Exemplo 1: PRIMARY KEY simples na criacao da tabela
-- ----------------------------------------------------------------------------

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(150)
);

-- Ou com constraint nomeada:
CREATE TABLE clientes (
    id INT,
    nome VARCHAR(100),
    email VARCHAR(150),
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);

-- ----------------------------------------------------------------------------
-- Exemplo 2: PRIMARY KEY com AUTO_INCREMENT
-- ----------------------------------------------------------------------------

-- MySQL:
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

-- PostgreSQL:
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

-- SQL Server:
CREATE TABLE produtos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

-- ----------------------------------------------------------------------------
-- Exemplo 3: PRIMARY KEY composta
-- ----------------------------------------------------------------------------
-- Chave formada por multiplas colunas

CREATE TABLE itens_pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (pedido_id, produto_id)
);

-- Cada combinacao pedido_id + produto_id deve ser unica

-- ----------------------------------------------------------------------------
-- Exemplo 4: Adicionando PRIMARY KEY a tabela existente
-- ----------------------------------------------------------------------------

ALTER TABLE usuarios
ADD PRIMARY KEY (id);

-- Com nome para a constraint:
ALTER TABLE usuarios
ADD CONSTRAINT pk_usuarios PRIMARY KEY (id);

-- ----------------------------------------------------------------------------
-- Exemplo 5: Removendo PRIMARY KEY
-- ----------------------------------------------------------------------------

-- MySQL:
ALTER TABLE usuarios
DROP PRIMARY KEY;

-- SQL Server / PostgreSQL:
ALTER TABLE usuarios
DROP CONSTRAINT pk_usuarios;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre defina uma PRIMARY KEY para cada tabela
-- 2. Prefira chaves simples e numericas (melhor performance)
-- 3. Use AUTO_INCREMENT/SERIAL/IDENTITY para IDs automaticos
-- 4. Chaves compostas sao uteis em tabelas associativas (N:N)
-- 5. O nome da constraint facilita manutencao futura
--
-- ============================================================================
