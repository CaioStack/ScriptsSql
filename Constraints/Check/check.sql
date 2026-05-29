-- ============================================================================
-- CHECK - Validacao de Valores
-- ============================================================================
-- 
-- DESCRICAO:
-- A constraint CHECK limita os valores que podem ser inseridos em uma coluna,
-- baseado em uma condicao logica. E util para garantir integridade de dados
-- em nivel de banco de dados.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: CHECK simples
-- ----------------------------------------------------------------------------

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2) CHECK (preco > 0),
    estoque INT CHECK (estoque >= 0)
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: CHECK com nome de constraint
-- ----------------------------------------------------------------------------

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    salario DECIMAL(10,2),
    CONSTRAINT chk_idade CHECK (idade >= 18 AND idade <= 120),
    CONSTRAINT chk_salario CHECK (salario >= 0)
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: CHECK com lista de valores
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    status VARCHAR(20),
    prioridade VARCHAR(10),
    CHECK (status IN ('pendente', 'aprovado', 'enviado', 'entregue', 'cancelado')),
    CHECK (prioridade IN ('baixa', 'media', 'alta'))
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: CHECK com multiplas colunas
-- ----------------------------------------------------------------------------

CREATE TABLE eventos (
    id INT PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT chk_datas CHECK (data_fim >= data_inicio)
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Adicionando CHECK a tabela existente
-- ----------------------------------------------------------------------------

ALTER TABLE produtos
ADD CONSTRAINT chk_preco_positivo CHECK (preco > 0);

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Validacoes comuns com CHECK
-- ----------------------------------------------------------------------------

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    email VARCHAR(150) CHECK (email LIKE '%@%.%'),
    cpf CHAR(11) CHECK (LENGTH(cpf) = 11),
    data_nascimento DATE CHECK (data_nascimento < CURRENT_DATE),
    sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O'))
);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. CHECK e ignorado em versoes antigas do MySQL (< 8.0.16)
-- 2. Use para regras de negocio simples
-- 3. Validacoes complexas sao melhor tratadas na aplicacao
-- 4. Nomeie constraints para identificar erros facilmente
-- 5. CHECK nao pode referenciar outras tabelas (use TRIGGER)
--
-- ============================================================================
