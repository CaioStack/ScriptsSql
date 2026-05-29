-- ============================================================================
-- DROP VIEW - Removendo Visoes
-- ============================================================================
-- 
-- DESCRICAO:
-- O comando DROP VIEW remove uma VIEW existente do banco de dados. Nao afeta
-- as tabelas base de onde a VIEW obtem seus dados.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: DROP VIEW basico
-- ----------------------------------------------------------------------------

DROP VIEW vw_clientes_ativos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: DROP VIEW IF EXISTS
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_clientes_ativos;

-- Evita erro se a view nao existir

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Removendo multiplas views
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_vendas_mes, vw_vendas_ano, vw_vendas_total;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: DROP VIEW com dependencias
-- ----------------------------------------------------------------------------

-- Se outra VIEW depende desta, use CASCADE (PostgreSQL):
DROP VIEW vw_base CASCADE;

-- Isso remove tambem views que dependem de vw_base

-- Para ver dependencias antes de remover:
-- PostgreSQL:
SELECT 
    dependent.relname AS view_dependente
FROM pg_depend d
JOIN pg_class base ON d.refobjid = base.oid
JOIN pg_class dependent ON d.objid = dependent.oid
WHERE base.relname = 'vw_base';

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Listando views existentes
-- ----------------------------------------------------------------------------

-- MySQL:
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- PostgreSQL:
SELECT viewname FROM pg_views WHERE schemaname = 'public';

-- SQL Server:
SELECT name FROM sys.views;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Recriando uma VIEW (DROP + CREATE)
-- ----------------------------------------------------------------------------

-- Metodo 1: DROP e CREATE separados
DROP VIEW IF EXISTS vw_produtos;
CREATE VIEW vw_produtos AS SELECT * FROM produtos WHERE ativo = TRUE;

-- Metodo 2: CREATE OR REPLACE (sem DROP)
CREATE OR REPLACE VIEW vw_produtos AS 
SELECT * FROM produtos WHERE ativo = TRUE;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre use IF EXISTS para evitar erros em scripts
-- 2. Verifique dependencias antes de remover views
-- 3. Faca backup do codigo da view antes de remover
-- 4. Prefira CREATE OR REPLACE quando possivel
-- 5. DROP VIEW nao afeta as tabelas originais
--
-- ============================================================================
