-- ============================================================================
-- CREATE VIEW - Criando Visoes
-- ============================================================================
-- 
-- DESCRICAO:
-- Uma VIEW e uma tabela virtual baseada no resultado de uma consulta SELECT.
-- Nao armazena dados fisicamente (exceto Materialized Views), mas apresenta
-- dados de uma ou mais tabelas de forma organizada.
--
-- USOS COMUNS:
-- - Simplificar consultas complexas
-- - Restringir acesso a dados sensiveis
-- - Apresentar dados de forma diferente
-- - Criar camada de abstracao
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: VIEW simples
-- ----------------------------------------------------------------------------

CREATE VIEW vw_clientes_ativos AS
SELECT id, nome, email, telefone
FROM clientes
WHERE ativo = TRUE;

-- Uso:
SELECT * FROM vw_clientes_ativos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: VIEW com JOIN
-- ----------------------------------------------------------------------------

CREATE VIEW vw_pedidos_completos AS
SELECT 
    p.id AS pedido_id,
    p.data_pedido,
    c.nome AS cliente,
    c.email,
    p.valor_total,
    p.status
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: VIEW com agregacao
-- ----------------------------------------------------------------------------

CREATE VIEW vw_vendas_por_mes AS
SELECT 
    YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes,
    COUNT(*) AS quantidade,
    SUM(valor) AS total
FROM vendas
GROUP BY YEAR(data_venda), MONTH(data_venda);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: VIEW para ocultar dados sensiveis
-- ----------------------------------------------------------------------------

CREATE VIEW vw_funcionarios_publico AS
SELECT 
    id,
    nome,
    departamento,
    cargo
    -- Oculta: salario, cpf, data_nascimento
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: VIEW com CREATE OR REPLACE
-- ----------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_produtos_estoque AS
SELECT 
    id,
    nome,
    estoque,
    CASE 
        WHEN estoque = 0 THEN 'Esgotado'
        WHEN estoque < 10 THEN 'Baixo'
        ELSE 'Normal'
    END AS status_estoque
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: VIEW atualizavel (simples)
-- ----------------------------------------------------------------------------

CREATE VIEW vw_clientes_sp AS
SELECT id, nome, email, cidade
FROM clientes
WHERE estado = 'SP'
WITH CHECK OPTION;

-- WITH CHECK OPTION: Impede INSERT/UPDATE que viole o WHERE

-- Pode fazer:
UPDATE vw_clientes_sp SET email = 'novo@email.com' WHERE id = 1;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Consultando informacoes da VIEW
-- ----------------------------------------------------------------------------

-- MySQL:
SHOW CREATE VIEW vw_clientes_ativos;

-- PostgreSQL:
SELECT definition FROM pg_views WHERE viewname = 'vw_clientes_ativos';

-- SQL Server:
SELECT definition FROM sys.sql_modules 
WHERE object_id = OBJECT_ID('vw_clientes_ativos');

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use prefixo (vw_, v_) para identificar views facilmente
-- 2. Views nao melhoram performance (a query ainda e executada)
-- 3. Para performance, considere Materialized Views (PostgreSQL, Oracle)
-- 4. Views complexas podem nao ser atualizaveis
-- 5. Use views para criar camada de seguranca/abstracao
-- 6. Documente o proposito de cada view
--
-- ============================================================================
