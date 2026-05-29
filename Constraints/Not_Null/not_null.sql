-- ============================================================================
-- NOT NULL - Valores Obrigatorios
-- ============================================================================
-- 
-- DESCRICAO:
-- A constraint NOT NULL impede que uma coluna aceite valores NULL, tornando
-- o preenchimento obrigatorio. E uma das constraints mais basicas e
-- frequentemente usadas.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: NOT NULL na criacao da tabela
-- ----------------------------------------------------------------------------

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20)  -- Permite NULL (opcional)
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: NOT NULL com DEFAULT
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pendente',
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Adicionando NOT NULL a tabela existente
-- ----------------------------------------------------------------------------

-- Primeiro, atualize valores NULL existentes:
UPDATE clientes SET telefone = 'Nao informado' WHERE telefone IS NULL;

-- Depois, adicione a constraint:
ALTER TABLE clientes
MODIFY COLUMN telefone VARCHAR(20) NOT NULL;

-- SQL Server:
ALTER TABLE clientes
ALTER COLUMN telefone VARCHAR(20) NOT NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Removendo NOT NULL
-- ----------------------------------------------------------------------------

ALTER TABLE clientes
MODIFY COLUMN telefone VARCHAR(20) NULL;

-- SQL Server:
ALTER TABLE clientes
ALTER COLUMN telefone VARCHAR(20) NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Combinando constraints
-- ----------------------------------------------------------------------------

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    estoque INT NOT NULL DEFAULT 0
);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use NOT NULL para campos obrigatorios do negocio
-- 2. Combine NOT NULL com DEFAULT para garantir sempre haver valor
-- 3. PRIMARY KEY ja inclui NOT NULL implicitamente
-- 4. Antes de adicionar NOT NULL, trate NULLs existentes
-- 5. Evite NOT NULL em campos opcionais (pode complicar insercoes)
--
-- ============================================================================
