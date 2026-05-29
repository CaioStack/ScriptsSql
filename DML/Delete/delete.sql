-- ============================================
-- Comando: Delete
-- ============================================
-- 
-- DESCRIÇÃO:
-- O comando DELETE é usado para remover registros (linhas)
-- de uma tabela. Diferente do DROP, DELETE mantém a
-- estrutura da tabela intacta.
-- ATENÇÃO: Sempre use WHERE para evitar deletar TODAS as linhas!
-- É um comando DML (Data Manipulation Language).
--
-- Sintaxe básica:
-- DELETE FROM tabela
-- WHERE condição;
--
-- ============================================

-- ============================================
-- Exemplo 1: Deletar um registro específico
-- ============================================
DELETE FROM clientes
WHERE id = 5;

-- ============================================
-- Exemplo 2: Deletar por condição
-- ============================================
DELETE FROM produtos
WHERE estoque = 0;

-- ============================================
-- Exemplo 3: Deletar com múltiplas condições
-- ============================================
DELETE FROM logs
WHERE data_criacao < '2023-01-01'
AND tipo = 'debug';

-- ============================================
-- Exemplo 4: Deletar usando IN
-- ============================================
DELETE FROM clientes
WHERE id IN (1, 5, 10, 15);

DELETE FROM produtos
WHERE categoria IN ('Descontinuado', 'Obsoleto');

-- ============================================
-- Exemplo 5: Deletar com subquery
-- ============================================
-- Deletar clientes que nunca fizeram pedidos
DELETE FROM clientes
WHERE id NOT IN (
    SELECT DISTINCT cliente_id FROM pedidos
);

-- ============================================
-- Exemplo 6: DELETE com JOIN (MySQL)
-- ============================================
-- Deletar itens de pedidos cancelados
DELETE itens_pedido
FROM itens_pedido
INNER JOIN pedidos ON itens_pedido.pedido_id = pedidos.id
WHERE pedidos.status = 'cancelado';

-- ============================================
-- Exemplo 7: DELETE com USING (PostgreSQL)
-- ============================================
DELETE FROM itens_pedido
USING pedidos
WHERE itens_pedido.pedido_id = pedidos.id
AND pedidos.status = 'cancelado';

-- ============================================
-- Exemplo 8: DELETE com LIMIT (MySQL)
-- ============================================
-- Deletar apenas os 100 primeiros registros antigos
DELETE FROM logs
WHERE data_criacao < '2023-01-01'
ORDER BY data_criacao
LIMIT 100;

-- ============================================
-- Exemplo 9: DELETE com RETURNING (PostgreSQL)
-- ============================================
-- Retorna os registros deletados
DELETE FROM sessoes
WHERE expira_em < NOW()
RETURNING id, usuario_id;

-- ============================================
-- Exemplo 10: Deletar TODOS os registros
-- ============================================
-- Remove todas as linhas, mas mantém a tabela
DELETE FROM logs_temporarios;

-- TRUNCATE é mais rápido para limpar tabela inteira
TRUNCATE TABLE logs_temporarios;

-- ============================================
-- CUIDADOS IMPORTANTES:
-- ============================================

-- PERIGO: DELETE sem WHERE apaga TODAS as linhas!
-- NÃO FAÇA ISSO (a menos que seja intencional):
-- DELETE FROM clientes;  -- Isso apaga TODOS os clientes!

-- CORRETO: Sempre use WHERE
DELETE FROM clientes WHERE id = 5;

-- ============================================
-- DELETE vs TRUNCATE vs DROP:
-- ============================================

-- DELETE:
-- - Remove linhas específicas (usa WHERE)
-- - Pode ser revertido com ROLLBACK (em transação)
-- - Gera log para cada linha (mais lento)
-- - Não reseta AUTO_INCREMENT
-- - Ativa triggers

-- TRUNCATE:
-- - Remove TODAS as linhas (sem WHERE)
-- - Geralmente não pode ser revertido
-- - Mais rápido (não gera log por linha)
-- - Reseta AUTO_INCREMENT
-- - Não ativa triggers

-- DROP:
-- - Remove a tabela inteira (estrutura + dados)
-- - Irreversível

-- ============================================
-- BOAS PRÁTICAS:
-- ============================================
-- 1. SEMPRE use WHERE (exceto se quiser deletar tudo)
-- 2. Teste o WHERE com SELECT antes do DELETE
-- 3. Faça backup antes de DELETEs em massa
-- 4. Use transações para poder reverter se necessário
-- 5. Considere "soft delete" (marcar como inativo) em vez de deletar

-- ============================================
-- DICA: Soft Delete (exclusão lógica)
-- ============================================
-- Em vez de deletar, marque como excluído:
UPDATE clientes
SET deletado = TRUE, deletado_em = NOW()
WHERE id = 5;

-- E filtre nas consultas:
SELECT * FROM clientes WHERE deletado = FALSE;
