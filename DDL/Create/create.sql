-- ============================================
-- COMANDO: CREATE
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando CREATE é usado para criar novos objetos no banco de dados,
-- como tabelas, índices, views, databases, procedures, etc.
-- É um comando DDL (Data Definition Language).
--
-- SINTAXE BÁSICA:
-- CREATE TABLE nome_tabela (
--     coluna1 tipo_dado [constraints],
--     coluna2 tipo_dado [constraints],
--     ...
-- );
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Criar um banco de dados
-- ============================================
CREATE DATABASE loja_virtual;

-- ============================================
-- EXEMPLO 2: Criar uma tabela simples
-- ============================================
CREATE TABLE clientes (
    id INT,
    nome VARCHAR(100),
    email VARCHAR(150)
);

-- ============================================
-- EXEMPLO 3: Criar tabela com constraints
-- ============================================
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,    -- Chave primária com auto incremento
    nome VARCHAR(200) NOT NULL,           -- Campo obrigatório
    preco DECIMAL(10, 2) NOT NULL,        -- Decimal com 2 casas
    estoque INT DEFAULT 0,                -- Valor padrão é 0
    ativo BOOLEAN DEFAULT TRUE,           -- Valor padrão é TRUE
    data_cadastro DATETIME DEFAULT NOW()  -- Data atual como padrão
);

-- ============================================
-- EXEMPLO 4: Criar tabela com chave estrangeira
-- ============================================
CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT NOW(),
    valor_total DECIMAL(10, 2),
    
    -- Definindo a chave estrangeira
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- ============================================
-- EXEMPLO 5: Criar tabela com múltiplas constraints
-- ============================================
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,  -- Único e obrigatório
    email VARCHAR(150) NOT NULL UNIQUE,
    idade INT CHECK (idade >= 18),         -- Deve ser maior ou igual a 18
    status ENUM('ativo', 'inativo', 'pendente') DEFAULT 'pendente'
);

-- ============================================
-- TIPOS DE DADOS COMUNS:
-- ============================================
-- INT          - Números inteiros
-- VARCHAR(n)   - Texto com tamanho máximo n
-- TEXT         - Texto longo
-- DECIMAL(p,s) - Números decimais (precisão, escala)
-- DATE         - Data (YYYY-MM-DD)
-- DATETIME     - Data e hora
-- BOOLEAN      - Verdadeiro ou falso
-- ENUM         - Lista de valores permitidos
