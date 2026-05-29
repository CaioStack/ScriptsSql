-- ============================================================================
-- CREATE INDEX - Criando Indices
-- ============================================================================
-- 
-- DESCRICAO:
-- Indices sao estruturas de dados que melhoram a velocidade de operacoes de
-- leitura (SELECT, WHERE, JOIN) em troca de mais espaco em disco e lentidao
-- em operacoes de escrita (INSERT, UPDATE, DELETE).
--
-- TIPOS DE INDICES:
-- - B-Tree: Padrao, bom para comparacoes (=, <, >, BETWEEN)
-- - Hash: Bom para igualdade exata (=)
-- - Full-Text: Para buscas textuais
-- - Spatial: Para dados geograficos
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Indice simples
-- ----------------------------------------------------------------------------

CREATE INDEX idx_clientes_nome ON clientes(nome);

-- Melhora buscas como:
-- SELECT * FROM clientes WHERE nome = 'Maria';

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Indice unico
-- ----------------------------------------------------------------------------

CREATE UNIQUE INDEX idx_usuarios_email ON usuarios(email);

-- Garante unicidade E melhora performance de buscas

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Indice composto
-- ----------------------------------------------------------------------------

CREATE INDEX idx_pedidos_cliente_data ON pedidos(cliente_id, data_pedido);

-- Otimiza buscas que usam ambas as colunas:
-- SELECT * FROM pedidos WHERE cliente_id = 1 AND data_pedido > '2024-01-01';

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Indice com ordem
-- ----------------------------------------------------------------------------

-- MySQL 8.0+ / SQL Server / PostgreSQL:
CREATE INDEX idx_pedidos_data_desc ON pedidos(data_pedido DESC);

-- Otimiza: SELECT * FROM pedidos ORDER BY data_pedido DESC;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Indice parcial/filtrado (PostgreSQL/SQL Server)
-- ----------------------------------------------------------------------------

-- PostgreSQL:
CREATE INDEX idx_pedidos_pendentes ON pedidos(data_pedido)
WHERE status = 'pendente';

-- SQL Server:
CREATE INDEX idx_pedidos_pendentes ON pedidos(data_pedido)
WHERE status = 'pendente';

-- Indice menor, apenas para pedidos pendentes

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Indice de texto completo
-- ----------------------------------------------------------------------------

-- MySQL:
CREATE FULLTEXT INDEX idx_produtos_descricao ON produtos(descricao);

-- Uso:
-- SELECT * FROM produtos WHERE MATCH(descricao) AGAINST('notebook');

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Verificando indices existentes
-- ----------------------------------------------------------------------------

-- MySQL:
SHOW INDEX FROM clientes;

-- PostgreSQL:
SELECT * FROM pg_indexes WHERE tablename = 'clientes';

-- SQL Server:
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('clientes');

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Indices para Foreign Keys
-- ----------------------------------------------------------------------------
-- Crie indices em colunas usadas em JOINs

CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_itens_produto ON itens_pedido(produto_id);
CREATE INDEX idx_itens_pedido ON itens_pedido(pedido_id);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Crie indices para colunas usadas em WHERE, JOIN e ORDER BY
-- 2. Nao crie indices em excesso (prejudica INSERT/UPDATE/DELETE)
-- 3. Colunas com poucos valores distintos (ex: status) podem nao se beneficiar
-- 4. Indice composto: coluna mais seletiva primeiro
-- 5. Analise o plano de execucao (EXPLAIN) para otimizar
-- 6. Indices sao criados automaticamente para PRIMARY KEY e UNIQUE
--
-- ============================================================================
