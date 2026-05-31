-- ============================================
-- Claúsula: DISTINCT
-- ============================================
-- 
-- Descrição:
-- A cláusula DISTINCT é usada para remover registros duplicados
-- dos resultados de uma consulta, retornando apenas valores únicos.
--
-- Sinrtaxe básica:
-- SELECT DISTINCT coluna FROM tabela;
--
-- ============================================

-- ============================================
-- Exemplo 1: Valores únicos de uma coluna
-- ============================================
-- Lista todas as cidades (sem repetição)
SELECT DISTINCT cidade FROM clientes;

-- Lista todas as categorias de produtos
SELECT DISTINCT categoria FROM produtos;

-- ============================================
-- Exemplo 2: DISTINCT com múltiplas colunas
-- ============================================
-- Combinações únicas de cidade e estado
SELECT DISTINCT cidade, estado FROM clientes;

-- Combinações únicas de categoria e marca
SELECT DISTINCT categoria, marca FROM produtos;

-- ============================================
-- Exemplo 3: DISTINCT com ORDER BY
-- ============================================
-- Cidades únicas ordenadas alfabeticamente
SELECT DISTINCT cidade FROM clientes
ORDER BY cidade;

-- ============================================
-- Exemplo 4: DISTINCT com WHERE
-- ============================================
-- Categorias únicas de produtos ativos
SELECT DISTINCT categoria FROM produtos
WHERE ativo = TRUE;

-- ============================================
-- Exemplo 5: COUNT com DISTINCT
-- ============================================
-- Quantas cidades diferentes têm clientes
SELECT COUNT(DISTINCT cidade) AS total_cidades
FROM clientes;

-- Quantos clientes diferentes fizeram pedidos
SELECT COUNT(DISTINCT cliente_id) AS clientes_com_pedidos
FROM pedidos;

-- ============================================
-- Exemplo 6: DISTINCT vs GROUP BY
-- ============================================
-- Ambos retornam o mesmo resultado neste caso:

-- Usando DISTINCT
SELECT DISTINCT categoria FROM produtos;

-- Usando GROUP BY (equivalente)
SELECT categoria FROM produtos GROUP BY categoria;

-- A diferença: GROUP BY permite usar funções de agregação
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria;

-- ============================================
-- Exemplo 7: DISTINCT com NULL
-- ============================================
-- DISTINCT considera NULL como um valor único
SELECT DISTINCT telefone FROM clientes;
-- Se houver vários registros com NULL, apenas um NULL aparecerá

-- ============================================
-- Exemplo 8: DISTINCT em todas as colunas
-- ============================================
-- Linhas completamente únicas
SELECT DISTINCT * FROM logs;

-- ============================================
-- Exemplo 9: DISTINCT com JOIN
-- ============================================
-- Clientes que já fizeram pedidos (sem repetição)
SELECT DISTINCT c.id, c.nome
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- ============================================
-- Exemplo 10: DISTINCT ON (PostgreSQL)
-- ============================================
-- Retorna a primeira linha de cada grupo
-- SELECT DISTINCT ON (categoria) categoria, nome, preco
-- FROM produtos
-- ORDER BY categoria, preco DESC;
-- Retorna o produto mais caro de cada categoria

-- ============================================
-- Exemplo 11: SUM, AVG com DISTINCT
-- ============================================
-- Soma apenas valores únicos
SELECT SUM(DISTINCT preco) AS soma_precos_unicos
FROM produtos;

-- Média apenas de valores únicos
SELECT AVG(DISTINCT preco) AS media_precos_unicos
FROM produtos;

-- ============================================
-- Exemplo 12: Verificar duplicatas
-- ============================================
-- Encontrar emails duplicados
SELECT email, COUNT(*) AS quantidade
FROM clientes
GROUP BY email
HAVING COUNT(*) > 1;

-- Comparar total vs únicos
SELECT 
    COUNT(*) AS total_registros,
    COUNT(DISTINCT email) AS emails_unicos,
    COUNT(*) - COUNT(DISTINCT email) AS duplicatas
FROM clientes;

-- ============================================
-- PERFORMANCE:
-- ============================================
-- 1. DISTINCT pode ser lento em grandes tabelas
-- 2. Índices nas colunas do DISTINCT melhoram performance
-- 3. GROUP BY às vezes é mais eficiente
-- 4. Evite SELECT DISTINCT * em tabelas grandes
-- 5. Use DISTINCT apenas quando necessário