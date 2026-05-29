-- ============================================
-- OPERADOR: LIKE
-- ============================================
-- 
-- DESCRIÇÃO:
-- O operador LIKE é usado para buscar padrões em textos.
-- Utiliza caracteres curinga para representar caracteres
-- desconhecidos ou variáveis.
--
-- CURINGAS:
-- %  - Representa zero, um ou mais caracteres
-- _  - Representa exatamente um caractere
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela WHERE coluna LIKE 'padrão';
--
-- ============================================

-- ============================================
-- EXEMPLO 1: Começar com (prefixo)
-- ============================================
-- Nomes que começam com 'Jo'
SELECT * FROM clientes
WHERE nome LIKE 'Jo%';
-- Retorna: João, José, Joana, Jorge...

-- ============================================
-- EXEMPLO 2: Terminar com (sufixo)
-- ============================================
-- Nomes que terminam com 'Silva'
SELECT * FROM clientes
WHERE nome LIKE '%Silva';
-- Retorna: João Silva, Maria Silva, Carlos da Silva...

-- ============================================
-- EXEMPLO 3: Contém (substring)
-- ============================================
-- Nomes que contêm 'Santos'
SELECT * FROM clientes
WHERE nome LIKE '%Santos%';
-- Retorna: Santos, Ana Santos, Santos Junior, José dos Santos...

-- ============================================
-- EXEMPLO 4: Underscore - um caractere específico
-- ============================================
-- Nomes com exatamente 4 letras
SELECT * FROM clientes
WHERE nome LIKE '____';  -- 4 underscores
-- Retorna: Ana, João, José, Maria (se tiverem 4 letras)

-- Segundo caractere é 'a'
SELECT * FROM clientes
WHERE nome LIKE '_a%';
-- Retorna: Maria, Paulo, Carlos...

-- ============================================
-- EXEMPLO 5: Combinando % e _
-- ============================================
-- Nomes que começam com 'M', têm 'a' na 3ª posição
SELECT * FROM clientes
WHERE nome LIKE 'M_a%';
-- Retorna: Maria, Moacir...

-- ============================================
-- EXEMPLO 6: NOT LIKE
-- ============================================
-- Emails que NÃO são do Gmail
SELECT * FROM clientes
WHERE email NOT LIKE '%@gmail.com';

-- ============================================
-- EXEMPLO 7: LIKE com números (em strings)
-- ============================================
-- CEPs que começam com '01'
SELECT * FROM enderecos
WHERE cep LIKE '01%';

-- Telefones com DDD 11
SELECT * FROM clientes
WHERE telefone LIKE '11%';

-- ============================================
-- EXEMPLO 8: Múltiplos LIKE com OR
-- ============================================
-- Buscar em várias colunas
SELECT * FROM produtos
WHERE nome LIKE '%smartphone%'
OR descricao LIKE '%smartphone%'
OR tags LIKE '%smartphone%';

-- ============================================
-- EXEMPLO 9: LIKE case-insensitive
-- ============================================
-- MySQL: LIKE é case-insensitive por padrão
SELECT * FROM clientes WHERE nome LIKE 'maria%';

-- PostgreSQL: use ILIKE para case-insensitive
-- SELECT * FROM clientes WHERE nome ILIKE 'maria%';

-- Forçar case-insensitive com LOWER/UPPER
SELECT * FROM clientes
WHERE LOWER(nome) LIKE LOWER('%Silva%');

-- ============================================
-- EXEMPLO 10: Escapar caracteres especiais
-- ============================================
-- Buscar pelo caractere % literal
SELECT * FROM descontos
WHERE descricao LIKE '%10\%%' ESCAPE '\';
-- Encontra: "10% de desconto"

-- Buscar pelo caractere _ literal
SELECT * FROM codigos
WHERE codigo LIKE '%\_CODE%' ESCAPE '\';
-- Encontra: "ABC_CODE_123"

-- ============================================
-- EXEMPLO 11: LIKE em diferentes contextos
-- ============================================
-- Arquivos de imagem
SELECT * FROM arquivos
WHERE nome LIKE '%.jpg'
OR nome LIKE '%.png'
OR nome LIKE '%.gif';

-- Domínios de email
SELECT * FROM clientes
WHERE email LIKE '%@%.com.br';

-- ============================================
-- EXEMPLO 12: LIKE em UPDATE
-- ============================================
-- Padronizar domínio de email
UPDATE clientes
SET email = REPLACE(email, '@empresa.com', '@novaempresa.com')
WHERE email LIKE '%@empresa.com';

-- ============================================
-- PADRÕES COMUNS:
-- ============================================
-- LIKE 'abc%'     - Começa com 'abc'
-- LIKE '%abc'     - Termina com 'abc'
-- LIKE '%abc%'    - Contém 'abc'
-- LIKE 'a_c'      - 'a', qualquer caractere, 'c'
-- LIKE '_a%'      - Segundo caractere é 'a'
-- LIKE 'a%c'      - Começa com 'a' e termina com 'c'
-- LIKE '[abc]%'   - Começa com 'a', 'b' ou 'c' (SQL Server)

-- ============================================
-- PERFORMANCE:
-- ============================================
-- 1. LIKE 'abc%' pode usar índice (busca por prefixo)
-- 2. LIKE '%abc' NÃO usa índice eficientemente
-- 3. LIKE '%abc%' NÃO usa índice eficientemente
-- 4. Para buscas complexas, considere Full-Text Search

-- ============================================
-- DICAS:
-- ============================================
-- 1. % no início = performance ruim (não usa índice)
-- 2. Use ESCAPE para buscar % ou _ literais
-- 3. ILIKE (PostgreSQL) para case-insensitive
-- 4. Para buscas complexas, use Full-Text Search
