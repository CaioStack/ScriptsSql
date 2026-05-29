-- ============================================
-- OPERADOR: IS NULL / IS NOT NULL
-- ============================================
-- 
-- DESCRIÇÃO:
-- IS NULL verifica se um valor é nulo (ausente/indefinido).
-- IS NOT NULL verifica se um valor NÃO é nulo (existe).
-- 
-- IMPORTANTE: NULL não pode ser comparado com = ou <>!
-- NULL = NULL retorna NULL (desconhecido), não TRUE!
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE coluna IS NULL;
-- SELECT colunas FROM tabela WHERE coluna IS NOT NULL;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Encontrar valores NULL
-- ============================================
-- Clientes sem telefone cadastrado
SELECT * FROM clientes
WHERE telefone IS NULL;

-- ============================================
-- EXEMPLO 2: Encontrar valores NOT NULL
-- ============================================
-- Clientes com email cadastrado
SELECT * FROM clientes
WHERE email IS NOT NULL;

-- ============================================
-- EXEMPLO 3: Por que não usar = NULL?
-- ============================================
-- ⚠️ ERRADO - Nunca funciona!
SELECT * FROM clientes WHERE telefone = NULL;
-- Retorna: 0 registros (sempre!)

-- ✅ CORRETO
SELECT * FROM clientes WHERE telefone IS NULL;

-- O mesmo para diferente
-- ⚠️ ERRADO
SELECT * FROM clientes WHERE telefone <> NULL;

-- ✅ CORRETO
SELECT * FROM clientes WHERE telefone IS NOT NULL;

-- ============================================
-- EXEMPLO 4: Combinando com outras condições
-- ============================================
-- Clientes de SP sem telefone
SELECT * FROM clientes
WHERE estado = 'SP'
AND telefone IS NULL;

-- Produtos ativos com desconto definido
SELECT * FROM produtos
WHERE ativo = TRUE
AND desconto IS NOT NULL;

-- ============================================
-- EXEMPLO 5: Verificar múltiplas colunas
-- ============================================
-- Clientes com informações incompletas
SELECT * FROM clientes
WHERE telefone IS NULL
OR email IS NULL
OR endereco IS NULL;

-- Clientes com todas as informações preenchidas
SELECT * FROM clientes
WHERE telefone IS NOT NULL
AND email IS NOT NULL
AND endereco IS NOT NULL;

-- ============================================
-- EXEMPLO 6: COUNT com NULL
-- ============================================
-- COUNT(*) conta todas as linhas (incluindo NULL)
-- COUNT(coluna) conta apenas valores NOT NULL

SELECT 
    COUNT(*) AS total_clientes,
    COUNT(telefone) AS com_telefone,
    COUNT(*) - COUNT(telefone) AS sem_telefone
FROM clientes;

-- ============================================
-- EXEMPLO 7: IS NULL em UPDATE
-- ============================================
-- Definir valor padrão onde está NULL
UPDATE clientes
SET telefone = 'Não informado'
WHERE telefone IS NULL;

-- Limpar valores vazios para NULL
UPDATE clientes
SET telefone = NULL
WHERE telefone = '' OR telefone = 'N/A';

-- ============================================
-- EXEMPLO 8: IS NULL em DELETE
-- ============================================
-- Remover registros incompletos
DELETE FROM logs
WHERE mensagem IS NULL;

-- ============================================
-- EXEMPLO 9: COALESCE para tratar NULL
-- ============================================
-- Substituir NULL por valor padrão na consulta
SELECT 
    nome,
    COALESCE(telefone, 'Não informado') AS telefone,
    COALESCE(email, 'Sem email') AS email
FROM clientes;

-- ============================================
-- EXEMPLO 10: NULL em JOINs
-- ============================================
-- LEFT JOIN pode gerar NULL em colunas da tabela direita
SELECT c.nome, p.id AS pedido_id
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;
-- Clientes sem pedidos terão pedido_id = NULL

-- Filtrar apenas os que têm NULL (sem pedidos)
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- ============================================
-- EXEMPLO 11: NULL em ordenação
-- ============================================
-- Por padrão, NULLs podem aparecer primeiro ou último
SELECT * FROM clientes ORDER BY telefone;

-- Forçar NULLs no final
SELECT * FROM clientes 
ORDER BY telefone IS NULL, telefone;

-- PostgreSQL: controle explícito
-- SELECT * FROM clientes ORDER BY telefone NULLS LAST;

-- ============================================
-- EXEMPLO 12: Verificar se é vazio ou NULL
-- ============================================
-- String vazia é diferente de NULL!
SELECT * FROM clientes
WHERE telefone IS NULL OR telefone = '';

-- Tratar ambos como "sem telefone"
SELECT * FROM clientes
WHERE COALESCE(telefone, '') = '';

-- ============================================
-- NULL EM OPERAÇÕES:
-- ============================================
-- Qualquer operação com NULL resulta em NULL:
-- 5 + NULL = NULL
-- 'texto' || NULL = NULL (concatenação)
-- NULL AND TRUE = NULL
-- NULL OR TRUE = TRUE (exceção!)

-- ============================================
-- BOAS PRÁTICAS:
-- ============================================
-- 1. Use IS NULL, nunca = NULL
-- 2. Use COALESCE para valores padrão
-- 3. Defina NOT NULL em colunas obrigatórias
-- 4. Documente o significado de NULL em cada contexto
-- 5. Teste suas queries com dados que contêm NULL
