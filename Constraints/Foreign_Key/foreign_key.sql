-- ============================================================================
-- FOREIGN KEY - Chave Estrangeira
-- ============================================================================
-- 
-- Descrição:
-- A FOREIGN KEY estabelece um relacionamento entre duas tabelas, garantindo
-- integridade referencial. A coluna FK em uma tabela referencia a PK (ou UK)
-- de outra tabela.
--
-- Características:
-- - Garante que o valor exista na tabela referenciada
-- - Pode ter acoes para UPDATE e DELETE (CASCADE, SET NULL, etc.)
-- - Uma tabela pode ter multiplas FOREIGN KEYS
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Exemplo 1: FOREIGN KEY basica
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- ----------------------------------------------------------------------------
-- Exemplo 2: FOREIGN KEY com nome de constraint
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido DATE,
    CONSTRAINT fk_pedido_cliente 
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- ----------------------------------------------------------------------------
-- Exemplo 3: FOREIGN KEY com ON DELETE
-- ----------------------------------------------------------------------------

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        ON DELETE CASCADE  -- Deleta pedidos se cliente for deletado
);

-- Opcoes de ON DELETE:
-- CASCADE     : Deleta registros filhos
-- SET NULL    : Define como NULL
-- SET DEFAULT : Define valor padrao
-- RESTRICT    : Impede delecao (padrao)
-- NO ACTION   : Igual a RESTRICT

-- ----------------------------------------------------------------------------
-- Exemplo 4: FOREIGN KEY com ON UPDATE
-- ----------------------------------------------------------------------------

CREATE TABLE itens_pedido (
    id INT PRIMARY KEY,
    produto_id INT,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
        ON UPDATE CASCADE   -- Atualiza se produto_id mudar
        ON DELETE RESTRICT  -- Impede deletar produto com itens
);

-- ----------------------------------------------------------------------------
-- Exemplo 5: Multiplas FOREIGN KEYS
-- ----------------------------------------------------------------------------

CREATE TABLE itens_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Exemplo 6: Adicionando FOREIGN KEY a tabela existente
-- ----------------------------------------------------------------------------

ALTER TABLE pedidos
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (cliente_id) REFERENCES clientes(id);

-- ----------------------------------------------------------------------------
-- Exemplo 7: Removendo FOREIGN KEY
-- ----------------------------------------------------------------------------

-- MySQL:
ALTER TABLE pedidos
DROP FOREIGN KEY fk_pedido_cliente;

-- SQL Server / PostgreSQL:
ALTER TABLE pedidos
DROP CONSTRAINT fk_pedido_cliente;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre nomeie suas constraints para facilitar manutencao
-- 2. Defina acoes ON DELETE/UPDATE adequadas ao negocio
-- 3. CASCADE pode causar delecoes em massa - use com cuidado
-- 4. Foreign keys podem impactar performance em INSERT/UPDATE/DELETE
-- 5. Crie indices nas colunas FK para melhorar JOINs
--
-- ============================================================================
