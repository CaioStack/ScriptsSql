-- ============================================================================
-- REPLACE - Substituicao de Texto
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao REPLACE substitui todas as ocorrencias de uma substring por outra
-- dentro de uma string. E util para correcoes em massa, formatacao de dados
-- e limpeza de caracteres indesejados.
--
-- SINTAXE BASICA:
-- REPLACE(string, texto_antigo, texto_novo)
--
-- PARAMETROS:
-- - string : Texto original onde a substituicao sera feita
-- - texto_antigo : Substring a ser encontrada e substituida
-- - texto_novo : Texto que substituira o antigo
--
-- RETORNO:
-- - String com todas as ocorrencias substituidas
-- - Se texto_antigo nao for encontrado, retorna a string original
-- - A substituicao e case-sensitive na maioria dos SGBDs
--
-- COMPATIBILIDADE:
-- - Disponivel em todos os principais SGBDs com a mesma sintaxe
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Substituicao basica
-- ----------------------------------------------------------------------------
-- Corrigindo um termo em descricoes

SELECT 
    descricao,
    REPLACE(descricao, 'antigo', 'novo') AS descricao_atualizada
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Removendo caracteres
-- ----------------------------------------------------------------------------
-- Substituindo por string vazia para remover

SELECT 
    telefone,
    REPLACE(REPLACE(REPLACE(telefone, '(', ''), ')', ''), '-', '') AS telefone_numerico
FROM clientes;

-- Resultado esperado:
-- | telefone        | telefone_numerico |
-- |-----------------|-------------------|
-- | (11) 99999-8888 | 11 999998888      |

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Formatando CPF
-- ----------------------------------------------------------------------------
-- Adicionando pontuacao ao CPF

SELECT 
    cpf,
    CONCAT(
        SUBSTRING(cpf, 1, 3), '.',
        SUBSTRING(cpf, 4, 3), '.',
        SUBSTRING(cpf, 7, 3), '-',
        SUBSTRING(cpf, 10, 2)
    ) AS cpf_formatado
FROM clientes;

-- Ou removendo formatacao:
SELECT 
    REPLACE(REPLACE(cpf, '.', ''), '-', '') AS cpf_numerico
FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Corrigindo dados em massa
-- ----------------------------------------------------------------------------
-- Atualizando endereco com erro de digitacao

UPDATE enderecos
SET rua = REPLACE(rua, 'Rua', 'R.')
WHERE rua LIKE 'Rua %';

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Criando slugs para URLs
-- ----------------------------------------------------------------------------
-- Substituindo espacos por hifens

SELECT 
    titulo,
    LOWER(REPLACE(titulo, ' ', '-')) AS slug
FROM artigos;

-- Resultado esperado:
-- | titulo              | slug                |
-- |---------------------|---------------------|
-- | Meu Primeiro Post   | meu-primeiro-post   |

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Multiplas substituicoes encadeadas
-- ----------------------------------------------------------------------------
-- Limpando caracteres especiais

SELECT 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(nome, '@', ''),
                '#', ''
            ),
            '$', ''
        ),
        '%', ''
    ) AS nome_limpo
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Substituindo quebras de linha
-- ----------------------------------------------------------------------------
-- Convertendo quebras de linha em espacos

SELECT 
    REPLACE(REPLACE(comentario, CHAR(13), ' '), CHAR(10), ' ') AS comentario_linha_unica
FROM avaliacoes;

-- MySQL:
SELECT 
    REPLACE(REPLACE(comentario, '\r', ' '), '\n', ' ') AS comentario_linha_unica
FROM avaliacoes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Mascarando dados sensiveis
-- ----------------------------------------------------------------------------
-- Escondendo parte do email

SELECT 
    email,
    CONCAT(
        LEFT(email, 2),
        REPLACE(
            SUBSTRING(email, 3, POSITION('@' IN email) - 3),
            SUBSTRING(email, 3, POSITION('@' IN email) - 3),
            '****'
        ),
        SUBSTRING(email, POSITION('@' IN email))
    ) AS email_mascarado
FROM usuarios;

-- Resultado: jo****@gmail.com

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Padronizando separadores
-- ----------------------------------------------------------------------------
-- Convertendo diferentes separadores para um padrao

SELECT 
    REPLACE(REPLACE(REPLACE(tags, ';', ','), '|', ','), ' ', ',') AS tags_padronizadas
FROM produtos;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. REPLACE e case-sensitive - use com UPPER/LOWER se necessario
-- 2. Para muitas substituicoes, considere usar TRANSLATE (se disponivel)
-- 3. Teste suas substituicoes com SELECT antes de UPDATE
-- 4. Cuidado com substituicoes parciais indesejadas
-- 5. Use expressoes regulares (REGEXP_REPLACE) para padroes complexos
--
-- ============================================================================
