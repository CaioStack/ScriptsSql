-- ============================================
-- COMANDO: DROP
-- ============================================
-- 
-- Descrição:
-- O comando DROP é usado para remover/excluir permanentemente
-- objetos do banco de dados, como tabelas, índices, views,
-- databases, etc. ATENÇÃO: Esta ação é irreversível!
-- É um comando DDL (Data Definition Language).
--
-- Sintaxe básica:
-- DROP OBJETO nome_objeto;
--
-- ============================================

-- ============================================
-- Exemplo 1: Excluir uma tabela
-- ============================================
DROP TABLE clientes;

-- ============================================
-- Exemplo 2: Excluir tabela se existir (evita erro)
-- ============================================
DROP TABLE IF EXISTS clientes;

-- ============================================
-- Exemplo 3: Excluir múltiplas tabelas
-- ============================================
DROP TABLE IF EXISTS pedidos, itens_pedido, clientes;

-- ============================================
-- Exemplo 4: Excluir um banco de dados
-- ============================================
DROP DATABASE loja_virtual;

-- Com verificação de existência
DROP DATABASE IF EXISTS loja_virtual;

-- ============================================
-- Exemplo 5: Excluir um índice
-- ============================================
-- MySQL
DROP INDEX idx_nome ON clientes;

-- PostgreSQL / SQL Server
DROP INDEX idx_nome;

-- ============================================
-- Exemplo 6: Excluir uma view
-- ============================================
DROP VIEW IF EXISTS view_clientes_ativos;

-- ============================================
-- Exemplo 7: Excluir uma procedure
-- ============================================
DROP PROCEDURE IF EXISTS calcular_total;

-- ============================================
-- Exemplo 8: Excluir uma function
-- ============================================
DROP FUNCTION IF EXISTS formatar_cpf;

-- ============================================
-- Exemplo 9: Excluir um trigger
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
