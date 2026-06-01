-- ============================================================================
-- UNIQUE - Valores Unicos
-- ============================================================================
-- 
-- Descrição:
-- A constraint UNIQUE garante que todos os valores em uma coluna (ou conjunto
-- de colunas) sejam diferentes. Diferente da PRIMARY KEY, permite valores NULL
-- e uma tabela pode ter multiplas constraints UNIQUE.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Exemplo 1: UNIQUE simples
-- ----------------------------------------------------------------------------

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    email VARCHAR(150) UNIQUE,
    username VARCHAR(50) UNIQUE
);

-- ----------------------------------------------------------------------------
-- Exemplo 2: UNIQUE com nome de constraint
-- ----------------------------------------------------------------------------

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    email VARCHAR(150),
    cpf VARCHAR(11),
    CONSTRAINT uk_usuarios_email UNIQUE (email),
    CONSTRAINT uk_usuarios_cpf UNIQUE (cpf)
);

-- ----------------------------------------------------------------------------
-- Exemplo 3: UNIQUE composta
-- ----------------------------------------------------------------------------
-- Combinacao de colunas deve ser unica

CREATE TABLE matriculas (
    id INT PRIMARY KEY,
    aluno_id INT,
    curso_id INT,
    UNIQUE (aluno_id, curso_id)  -- Aluno nao pode se matricular 2x no mesmo curso
);

-- ----------------------------------------------------------------------------
-- Exemplo 4: Adicionando UNIQUE a tabela existente
-- ----------------------------------------------------------------------------

ALTER TABLE produtos
ADD CONSTRAINT uk_produtos_codigo UNIQUE (codigo);

-- ----------------------------------------------------------------------------
-- Exemplo 5: UNIQUE vs PRIMARY KEY
-- ----------------------------------------------------------------------------

CREATE TABLE Exemplo (
    id INT PRIMARY KEY,           -- Apenas uma por tabela, NOT NULL
    email VARCHAR(150) UNIQUE,    -- Pode ter varias, permite NULL
    cpf VARCHAR(11) UNIQUE        -- Pode ter varias, permite NULL
);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use UNIQUE para campos que devem ser unicos alem da PK (email, CPF)
-- 2. UNIQUE permite NULL, mas apenas um NULL por coluna na maioria dos SGBDs
-- 3. UNIQUE cria um indice automaticamente
-- 4. Nomeie constraints para facilitar manutencao
-- 5. UNIQUE composta permite valores individuais repetidos
--
-- ============================================================================
