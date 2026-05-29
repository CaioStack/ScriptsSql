-- ============================================================================
-- SUBSTRING - Extracao de Parte de uma String
-- ============================================================================
-- 
-- DESCRICAO:
-- O SUBSTRING (ou SUBSTR) extrai uma parte de uma string, comecando em uma
-- posicao especificada e com um comprimento opcional. E util para extrair
-- codigos, prefixos, sufixos ou qualquer parte especifica de um texto.
--
-- SINTAXE BASICA:
-- SUBSTRING(string, posicao_inicial, comprimento)
-- SUBSTRING(string FROM posicao FOR comprimento)
--
-- PARAMETROS:
-- - string : Texto original de onde extrair
-- - posicao_inicial : Posicao onde comecar (1 = primeiro caractere)
-- - comprimento : Quantidade de caracteres a extrair (opcional)
--
-- COMPATIBILIDADE:
-- - MySQL: SUBSTRING(str, pos, len) ou SUBSTR(str, pos, len)
-- - PostgreSQL: SUBSTRING(str FROM pos FOR len)
-- - SQL Server: SUBSTRING(str, pos, len)
-- - Oracle: SUBSTR(str, pos, len)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Extraindo primeiros caracteres
-- ----------------------------------------------------------------------------
-- Obtendo as iniciais ou prefixo de um codigo

SELECT 
    codigo_produto,
    SUBSTRING(codigo_produto, 1, 3) AS prefixo
FROM produtos;

-- Resultado esperado:
-- | codigo_produto | prefixo |
-- |----------------|---------|
-- | ELE-12345      | ELE     |
-- | MOV-67890      | MOV     |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Extraindo parte do meio
-- ----------------------------------------------------------------------------
-- Obtendo o numero do codigo (pulando o prefixo)

SELECT 
    codigo_produto,
    SUBSTRING(codigo_produto, 5, 5) AS numero
FROM produtos;

-- Resultado esperado:
-- | codigo_produto | numero |
-- |----------------|--------|
-- | ELE-12345      | 12345  |
-- | MOV-67890      | 67890  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Extraindo do final (sem comprimento)
-- ----------------------------------------------------------------------------
-- Quando omitimos o comprimento, extrai ate o final

SELECT 
    email,
    SUBSTRING(email, POSITION('@' IN email) + 1) AS dominio
FROM usuarios;

-- Resultado esperado:
-- | email                  | dominio      |
-- |------------------------|--------------|
-- | joao@gmail.com         | gmail.com    |
-- | maria@empresa.com.br   | empresa.com.br|

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Extraindo ano de uma data em string
-- ----------------------------------------------------------------------------
-- Quando a data esta armazenada como texto

SELECT 
    data_texto,
    SUBSTRING(data_texto, 1, 4) AS ano,
    SUBSTRING(data_texto, 6, 2) AS mes,
    SUBSTRING(data_texto, 9, 2) AS dia
FROM registros;

-- Para data '2024-03-15':
-- | data_texto | ano  | mes | dia |
-- |------------|------|-----|-----|
-- | 2024-03-15 | 2024 | 03  | 15  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Mascarando dados sensiveis
-- ----------------------------------------------------------------------------
-- Mostrando apenas os ultimos 4 digitos do cartao

SELECT 
    CONCAT('****-****-****-', SUBSTRING(numero_cartao, 13, 4)) AS cartao_mascarado
FROM pagamentos;

-- Resultado esperado:
-- | cartao_mascarado     |
-- |----------------------|
-- | ****-****-****-1234  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Sintaxe SQL padrao (ANSI)
-- ----------------------------------------------------------------------------
-- Usando FROM e FOR (PostgreSQL)

SELECT 
    SUBSTRING(descricao FROM 1 FOR 50) AS descricao_curta
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Posicao negativa (MySQL/Oracle)
-- ----------------------------------------------------------------------------
-- Posicao negativa conta a partir do final

SELECT 
    nome_arquivo,
    SUBSTRING(nome_arquivo, -4) AS extensao  -- MySQL
FROM arquivos;

-- Em Oracle:
SELECT 
    nome_arquivo,
    SUBSTR(nome_arquivo, -4) AS extensao
FROM arquivos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Combinando com outras funcoes
-- ----------------------------------------------------------------------------
-- Extraindo nome do usuario do email

SELECT 
    email,
    SUBSTRING(email, 1, POSITION('@' IN email) - 1) AS nome_usuario
FROM usuarios;

-- Resultado esperado:
-- | email              | nome_usuario |
-- |--------------------|--------------|
-- | joao@gmail.com     | joao         |
-- | maria@empresa.com  | maria        |

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: LEFT e RIGHT como alternativas
-- ----------------------------------------------------------------------------
-- Funcoes mais simples para inicio e fim

SELECT 
    LEFT(codigo, 3) AS primeiros_3,   -- Primeiros 3 caracteres
    RIGHT(codigo, 4) AS ultimos_4     -- Ultimos 4 caracteres
FROM produtos;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Lembre-se: em SQL, a posicao começa em 1, nao em 0
-- 2. Use LEFT/RIGHT quando precisar apenas do inicio/fim
-- 3. Combine com LENGTH para calculos dinamicos
-- 4. Trate strings NULL para evitar resultados inesperados
-- 5. SUBSTR e SUBSTRING sao sinonimos em muitos SGBDs
--
-- ============================================================================
