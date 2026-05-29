-- ============================================================================
-- DEFAULT - Valor Padrao
-- ============================================================================
-- 
-- DESCRICAO:
-- A constraint DEFAULT define um valor automatico para uma coluna quando
-- nenhum valor e especificado durante o INSERT. E util para definir
-- padroes como datas de criacao, status iniciais, etc.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: DEFAULT simples
-- ----------------------------------------------------------------------------

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    nivel INT DEFAULT 1
);

-- INSERT sem especificar 'ativo' e 'nivel':
INSERT INTO usuarios (nome) VALUES ('Joao');
-- Resultado: ativo = TRUE, nivel = 1

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: DEFAULT com data/hora atual
-- ----------------------------------------------------------------------------

-- MySQL:
CREATE TABLE logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- PostgreSQL:
CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    mensagem TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: DEFAULT com texto
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'pendente',
    observacao TEXT DEFAULT 'Nenhuma observacao'
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: DEFAULT com valores numericos
-- ----------------------------------------------------------------------------

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2) DEFAULT 0.00,
    estoque INT DEFAULT 0,
    desconto DECIMAL(5,2) DEFAULT 0.00
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Adicionando DEFAULT a tabela existente
-- ----------------------------------------------------------------------------

-- MySQL:
ALTER TABLE produtos
ALTER COLUMN estoque SET DEFAULT 0;

-- SQL Server:
ALTER TABLE produtos
ADD CONSTRAINT df_estoque DEFAULT 0 FOR estoque;

-- PostgreSQL:
ALTER TABLE produtos
ALTER COLUMN estoque SET DEFAULT 0;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Removendo DEFAULT
-- ----------------------------------------------------------------------------

ALTER TABLE produtos
ALTER COLUMN estoque DROP DEFAULT;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use DEFAULT para campos que quase sempre tem o mesmo valor inicial
-- 2. CURRENT_TIMESTAMP e ideal para campos de auditoria
-- 3. DEFAULT so se aplica quando a coluna NAO e mencionada no INSERT
-- 4. INSERT com valor NULL explicitamente NAO usa o DEFAULT
-- 5. Combine com NOT NULL quando o campo sempre deve ter valor
--
-- ============================================================================
