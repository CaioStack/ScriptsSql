-- ============================================
-- COMANDO: DROP
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando DROP é usado para remover/excluir permanentemente
-- objetos do banco de dados, como tabelas, índices, views,
-- databases, etc. ATENÇÃO: Esta ação é irreversível!
-- É um comando DDL (Data Definition Language).
--
-- SINTAXE BÁSICA:
-- DROP OBJETO nome_objeto;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Excluir uma tabela
-- ============================================
DROP TABLE clientes;

-- ============================================
-- EXEMPLO 2: Excluir tabela se existir (evita erro)
-- ============================================
DROP TABLE IF EXISTS clientes;

-- ============================================
-- EXEMPLO 3: Excluir múltiplas tabelas
-- ============================================
DROP TABLE IF EXISTS pedidos, itens_pedido, clientes;

-- ============================================
-- EXEMPLO 4: Excluir um banco de dados
-- ============================================
DROP DATABASE loja_virtual;

-- Com verificação de existência
DROP DATABASE IF EXISTS loja_virtual;

-- ============================================
-- EXEMPLO 5: Excluir um índice
-- ============================================
-- MySQL
DROP INDEX idx_nome ON clientes;

-- PostgreSQL / SQL Server
DROP INDEX idx_nome;

-- ============================================
-- EXEMPLO 6: Excluir uma view
-- ============================================
DROP VIEW IF EXISTS view_clientes_ativos;

-- ============================================
-- EXEMPLO 7: Excluir uma procedure
-- ============================================
DROP PROCEDURE IF EXISTS calcular_total;

-- ============================================
-- EXEMPLO 8: Excluir uma function
-- ============================================
DROP FUNCTION IF EXISTS formatar_cpf;

-- ============================================
-- EXEMPLO 9: Excluir um trigger
-- ============================================
DROP TRIGGER IF EXISTS trigger_atualiza_estoque;

-- ============================================
-- CUIDADOS IMPORTANTES:
-- ============================================
-- 1. DROP é IRREVERSÍVEL - todos os dados são perdidos
-- 2. Sempre use IF EXISTS para evitar erros
-- 3. Verifique dependências antes de excluir
-- 4. Faça backup antes de executar DROP em produção
-- 5. DROP TABLE também remove índices e triggers associados

-- ============================================
-- DIFERENÇA ENTRE DROP, DELETE E TRUNCATE:
-- ============================================
-- DROP     - Remove a tabela inteira (estrutura + dados)
-- DELETE   - Remove linhas específicas (mantém estrutura)
-- TRUNCATE - Remove todos os dados (mantém estrutura)
