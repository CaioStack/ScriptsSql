-- ============================================
-- COMANDO: TRUNCATE
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando TRUNCATE remove TODOS os registros de uma tabela
-- de forma rápida, mas mantém a estrutura da tabela intacta.
-- É mais rápido que DELETE pois não gera logs de transação
-- para cada linha removida.
-- É um comando DDL (Data Definition Language).
--
-- SINTAXE BÁSICA:
-- TRUNCATE TABLE nome_tabela;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Truncar uma tabela simples
-- ============================================
TRUNCATE TABLE logs_acesso;

-- ============================================
-- EXEMPLO 2: Truncar e resetar auto_increment
-- ============================================
-- MySQL - TRUNCATE já reseta o AUTO_INCREMENT automaticamente
TRUNCATE TABLE pedidos;

-- Após TRUNCATE, o próximo ID será 1 novamente

-- ============================================
-- EXEMPLO 3: Truncar múltiplas tabelas (MySQL)
-- ============================================
-- Deve ser feito separadamente
TRUNCATE TABLE itens_pedido;
TRUNCATE TABLE pedidos;

-- ============================================
-- EXEMPLO 4: TRUNCATE com CASCADE (PostgreSQL)
-- ============================================
-- Remove dados da tabela e de todas as tabelas
-- que referenciam ela via chave estrangeira
TRUNCATE TABLE clientes CASCADE;

-- ============================================
-- EXEMPLO 5: TRUNCATE com RESTART IDENTITY (PostgreSQL)
-- ============================================
-- Reseta as sequências (auto increment)
TRUNCATE TABLE produtos RESTART IDENTITY;

-- ============================================
-- COMPARAÇÃO: TRUNCATE vs DELETE vs DROP
-- ============================================

-- DELETE: Remove linhas específicas ou todas
-- - Pode usar WHERE
-- - Gera log para cada linha (mais lento)
-- - Pode ser revertido com ROLLBACK
-- - Não reseta AUTO_INCREMENT
DELETE FROM produtos;
DELETE FROM produtos WHERE estoque = 0;

-- TRUNCATE: Remove todos os dados rapidamente
-- - NÃO pode usar WHERE
-- - Não gera log por linha (mais rápido)
-- - Geralmente não pode ser revertido
-- - RESETA AUTO_INCREMENT
TRUNCATE TABLE produtos;

-- DROP: Remove a tabela inteira
-- - Remove estrutura + dados
-- - Irreversível
DROP TABLE produtos;

-- ============================================
-- QUANDO USAR TRUNCATE:
-- ============================================
-- 1. Limpar tabelas de log/temporárias
-- 2. Resetar dados de teste
-- 3. Quando precisa remover TODOS os registros rapidamente
-- 4. Quando quer resetar o contador AUTO_INCREMENT

-- ============================================
-- LIMITAÇÕES DO TRUNCATE:
-- ============================================
-- 1. Não pode usar WHERE (remove TUDO)
-- 2. Não ativa triggers DELETE
-- 3. Não pode truncar tabelas referenciadas por FK
--    (a menos que use CASCADE no PostgreSQL)
-- 4. Não pode ser usado em tabelas que participam
--    de uma view indexada (SQL Server)
