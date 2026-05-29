-- ============================================================================
-- DROP INDEX - Removendo Indices
-- ============================================================================
-- 
-- DESCRICAO:
-- O comando DROP INDEX remove um indice existente de uma tabela. Use quando
-- um indice nao e mais necessario, esta prejudicando a performance de escrita,
-- ou precisa ser recriado.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: DROP INDEX basico
-- ----------------------------------------------------------------------------

-- MySQL:
DROP INDEX idx_clientes_nome ON clientes;

-- PostgreSQL:
DROP INDEX idx_clientes_nome;

-- SQL Server:
DROP INDEX idx_clientes_nome ON clientes;

-- Oracle:
DROP INDEX idx_clientes_nome;

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: DROP INDEX IF EXISTS
-- ----------------------------------------------------------------------------

-- PostgreSQL / MySQL 8.0+:
DROP INDEX IF EXISTS idx_clientes_nome ON clientes;

-- Evita erro se o indice nao existir

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Removendo indice unico
-- ----------------------------------------------------------------------------

DROP INDEX idx_usuarios_email ON usuarios;

-- ATENCAO: Isso remove a restricao de unicidade tambem

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Listando indices antes de remover
-- ----------------------------------------------------------------------------

-- MySQL:
SHOW INDEX FROM clientes;

-- PostgreSQL:
SELECT indexname FROM pg_indexes WHERE tablename = 'clientes';

-- SQL Server:
SELECT name FROM sys.indexes WHERE object_id = OBJECT_ID('clientes');

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Quando remover um indice
-- ----------------------------------------------------------------------------

-- 1. Indice nunca usado (verifique estatisticas)
-- 2. Indice duplicado (coberto por outro)
-- 3. Tabela pequena onde indice nao ajuda
-- 4. Muitas operacoes de escrita sendo prejudicadas

-- PostgreSQL - verificar uso de indices:
SELECT 
    schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0;  -- Indices nunca usados

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre verifique o impacto antes de remover indices
-- 2. Faca backup ou tenha o script de criacao antes de remover
-- 3. Remova indices nao utilizados para economizar espaco
-- 4. Analise estatisticas de uso antes de decidir
-- 5. Indices de PRIMARY KEY e UNIQUE precisam de tratamento especial
--
-- ============================================================================
