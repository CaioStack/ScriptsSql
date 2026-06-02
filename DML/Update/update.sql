-- ============================================
-- COMANDO: UPDATE
-- ============================================
-- 
-- Descrição:
-- O comando UPDATE é usado para modificar dados existentes
-- em uma ou mais linhas de uma tabela.
-- ATENÇÃO: Sempre use WHERE para evitar atualizar TODAS as linhas!
-- É um comando DML (Data Manipulation Language).
--
-- Sintaxe básica:
-- UPDATE tabela
-- SET coluna1 = valor1, coluna2 = valor2, ...
-- WHERE condição;
--
-- ============================================

-- ============================================
-- Exemplo 1: Atualizar uma coluna específica
-- ============================================
UPDATE clientes
SET telefone = '11999999999'
WHERE id = 1;

-- ============================================
-- Exemplo 2: Atualizar múltiplas colunas
-- ============================================
UPDATE clientes
SET 
    nome = 'João da Silva Santos',
    email = 'joao.santos@email.com',
    cidade = 'Campinas'
WHERE id = 1;

-- ============================================
-- Exemplo 3: Atualizar com cálculo
-- ============================================
-- Aumentar preço em 10%
UPDATE produtos
SET preco = preco * 1.10
WHERE categoria = 'Eletrônicos';

-- Diminuir estoque
UPDATE produtos
SET estoque = estoque - 1
WHERE id = 5;

-- ============================================
-- Exemplo 4: Atualizar múltiplos registros
-- ============================================
-- Inativar todos os clientes sem pedidos há 1 ano
UPDATE clientes
SET ativo = FALSE
WHERE ultimo_pedido < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- ============================================
-- Exemplo 5: UPDATE com subquery
-- ============================================
-- Atualizar com valor de outra tabela
UPDATE produtos
SET preco = (
    SELECT AVG(preco) 
    FROM produtos 
    WHERE categoria = 'Eletrônicos'
)
WHERE id = 10;

-- ============================================
-- Exemplo 6: UPDATE com JOIN (MySQL)
-- ============================================
UPDATE pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
SET p.desconto = 10
WHERE c.tipo = 'VIP';

-- ============================================
-- Exemplo 7: UPDATE com FROM (PostgreSQL/SQL Server)
-- ============================================
UPDATE pedidos
SET desconto = 10
FROM clientes
WHERE pedidos.cliente_id = clientes.id
AND clientes.tipo = 'VIP';

-- ============================================
-- Exemplo 8: UPDATE com CASE
-- ============================================
UPDATE produtos
SET categoria = CASE
    WHEN preco < 50 THEN 'Econômico'
    WHEN preco BETWEEN 50 AND 200 THEN 'Intermediário'
    ELSE 'Premium'
END;

-- ============================================
-- Exemplo 9: UPDATE com LIMIT (MySQL)
-- ============================================
-- Atualizar apenas os primeiros 10 registros
UPDATE produtos
SET destaque = TRUE
ORDER BY vendas DESC
LIMIT 10;

-- ============================================
-- Exemplo 10: UPDATE com RETURNING (PostgreSQL)
-- ============================================
-- Retorna os registros atualizados
UPDATE clientes
SET status = 'premium'
WHERE total_compras > 10000
RETURNING id, nome, status;

-- ============================================
-- CUIDADOS IMPORTANTES:
-- ============================================

-- ⚠️ PERIGO: UPDATE sem WHERE atualiza TODAS as linhas!
-- NÃO FAÇA ISSO (a menos que seja intencional):
-- UPDATE produtos SET preco = 0;  -- Isso zera TODOS os preços!

-- ✅ CORRETO: Sempre use WHERE
UPDATE produtos SET preco = 0 WHERE id = 5;

-- ============================================
-- BOAS PRÁTICAS:
-- ============================================
-- 1. SEMPRE use WHERE (exceto se quiser atualizar tudo)
-- 2. Teste o WHERE com SELECT antes do UPDATE
-- 3. Faça backup antes de UPDATEs em massa
-- 4. Use transações para poder reverter se necessário
-- 5. Limite o número de linhas afetadas quando possível

-- ============================================
-- DICA: Testar antes de executar
-- ============================================
-- Primeiro, verifique quais linhas serão afetadas:
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- Depois, execute o UPDATE:
UPDATE clientes SET estado = 'SP' WHERE cidade = 'São Paulo';
