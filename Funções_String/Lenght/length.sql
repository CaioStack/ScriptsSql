-- ============================================================================
-- LENGTH - Tamanho de uma String
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao LENGTH retorna o numero de caracteres em uma string. E util para
-- validacoes, calculos condicionais e manipulacao de dados textuais.
--
-- SINTAXE BASICA:
-- LENGTH(string)
--
-- PARAMETROS:
-- - string : Texto cujo comprimento sera calculado
--
-- RETORNO:
-- - Numero inteiro representando a quantidade de caracteres
-- - Retorna NULL se a entrada for NULL
-- - Espacos sao contados como caracteres
--
-- COMPATIBILIDADE:
-- - MySQL: LENGTH(str) retorna bytes, CHAR_LENGTH(str) retorna caracteres
-- - PostgreSQL: LENGTH(str) ou CHAR_LENGTH(str)
-- - SQL Server: LEN(str) ignora espacos finais, DATALENGTH(str) conta bytes
-- - Oracle: LENGTH(str)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Obtendo tamanho basico
-- ----------------------------------------------------------------------------
-- Calculando o comprimento de nomes

SELECT 
    nome,
    LENGTH(nome) AS tamanho
FROM clientes;

-- Resultado esperado:
-- | nome          | tamanho |
-- |---------------|---------|
-- | Maria Silva   | 11      |
-- | Ana           | 3       |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Validando tamanho minimo
-- ----------------------------------------------------------------------------
-- Encontrando senhas muito curtas

SELECT *
FROM usuarios
WHERE LENGTH(senha) < 8;

-- Retorna usuarios com senhas menores que 8 caracteres

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Validando tamanho maximo
-- ----------------------------------------------------------------------------
-- Verificando campos que excedem o limite

SELECT 
    nome,
    LENGTH(descricao) AS tamanho_descricao
FROM produtos
WHERE LENGTH(descricao) > 255;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Truncando com base no tamanho
-- ----------------------------------------------------------------------------
-- Adicionando reticencias se texto for muito longo

SELECT 
    titulo,
    CASE 
        WHEN LENGTH(titulo) > 20 
        THEN CONCAT(LEFT(titulo, 20), '...')
        ELSE titulo
    END AS titulo_curto
FROM artigos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Estatisticas de texto
-- ----------------------------------------------------------------------------
-- Calculando media de tamanho dos comentarios

SELECT 
    AVG(LENGTH(comentario)) AS media_caracteres,
    MIN(LENGTH(comentario)) AS menor_comentario,
    MAX(LENGTH(comentario)) AS maior_comentario
FROM avaliacoes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: LENGTH vs CHAR_LENGTH (MySQL)
-- ----------------------------------------------------------------------------
-- Diferenca com caracteres multibyte (UTF-8)

SELECT 
    texto,
    LENGTH(texto) AS bytes,           -- Conta bytes
    CHAR_LENGTH(texto) AS caracteres  -- Conta caracteres
FROM textos;

-- Para 'cafe': bytes = 5, caracteres = 4 (e com acento = 2 bytes)

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: LEN vs DATALENGTH (SQL Server)
-- ----------------------------------------------------------------------------
-- Diferenca no tratamento de espacos finais

SELECT 
    LEN('teste   ') AS len_result,        -- Retorna 5 (ignora espacos)
    DATALENGTH('teste   ') AS data_result; -- Retorna 8 (conta espacos)

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Validacao de CPF/CNPJ
-- ----------------------------------------------------------------------------
-- Verificando se documento tem tamanho correto

SELECT 
    documento,
    CASE 
        WHEN LENGTH(REPLACE(documento, '.', '')) = 11 THEN 'CPF'
        WHEN LENGTH(REPLACE(documento, '.', '')) = 14 THEN 'CNPJ'
        ELSE 'Invalido'
    END AS tipo_documento
FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Agrupando por faixa de tamanho
-- ----------------------------------------------------------------------------
-- Categorizando produtos por tamanho da descricao

SELECT 
    CASE 
        WHEN LENGTH(descricao) < 50 THEN 'Curta'
        WHEN LENGTH(descricao) < 150 THEN 'Media'
        ELSE 'Longa'
    END AS categoria_descricao,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY 
    CASE 
        WHEN LENGTH(descricao) < 50 THEN 'Curta'
        WHEN LENGTH(descricao) < 150 THEN 'Media'
        ELSE 'Longa'
    END;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Em MySQL, use CHAR_LENGTH para contar caracteres UTF-8 corretamente
-- 2. Em SQL Server, LEN ignora espacos finais - use DATALENGTH se precisar
-- 3. Sempre valide tamanhos antes de INSERT/UPDATE
-- 4. Considere o tamanho em bytes para campos BLOB/TEXT
-- 5. LENGTH de NULL retorna NULL, nao zero
--
-- ============================================================================
