-- ============================================================================
-- TRIM - Remocao de Espacos e Caracteres
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao TRIM remove espacos em branco (ou outros caracteres especificados)
-- do inicio e/ou fim de uma string. E essencial para limpeza e padronizacao
-- de dados, especialmente quando recebidos de formularios ou importacoes.
--
-- SINTAXE BASICA:
-- TRIM(string)
-- TRIM(BOTH caractere FROM string)
-- TRIM(LEADING caractere FROM string)
-- TRIM(TRAILING caractere FROM string)
--
-- PARAMETROS:
-- - string : Texto a ser limpo
-- - BOTH : Remove de ambos os lados (padrao)
-- - LEADING : Remove apenas do inicio
-- - TRAILING : Remove apenas do final
-- - caractere : Caractere especifico a remover (padrao: espaco)
--
-- VARIACOES:
-- - LTRIM(string) : Remove espacos do inicio (left)
-- - RTRIM(string) : Remove espacos do final (right)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Remocao basica de espacos
-- ----------------------------------------------------------------------------
-- Limpando espacos de ambos os lados

SELECT 
    CONCAT('[', nome, ']') AS original,
    CONCAT('[', TRIM(nome), ']') AS limpo
FROM clientes;

-- Resultado esperado:
-- | original          | limpo         |
-- |-------------------|---------------|
-- | [  Maria Silva  ] | [Maria Silva] |
-- | [ Joao ]          | [Joao]        |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: LTRIM - Apenas espacos do inicio
-- ----------------------------------------------------------------------------
-- Removendo espacos a esquerda

SELECT 
    CONCAT('[', LTRIM('   texto   '), ']') AS resultado;

-- Resultado: [texto   ]

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: RTRIM - Apenas espacos do final
-- ----------------------------------------------------------------------------
-- Removendo espacos a direita

SELECT 
    CONCAT('[', RTRIM('   texto   '), ']') AS resultado;

-- Resultado: [   texto]

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Removendo caracteres especificos
-- ----------------------------------------------------------------------------
-- Removendo zeros a esquerda

SELECT 
    TRIM(LEADING '0' FROM '000123') AS numero_limpo;

-- Resultado: 123

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Removendo caracteres especiais
-- ----------------------------------------------------------------------------
-- Limpando prefixos e sufixos

SELECT 
    TRIM(BOTH '-' FROM '--produto-teste--') AS resultado;

-- Resultado: produto-teste

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Limpeza de dados de importacao
-- ----------------------------------------------------------------------------
-- Padronizando dados ao importar

UPDATE clientes
SET 
    nome = TRIM(nome),
    email = TRIM(LOWER(email)),
    telefone = TRIM(telefone)
WHERE 
    nome != TRIM(nome) OR
    email != TRIM(LOWER(email)) OR
    telefone != TRIM(telefone);

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Validacao com TRIM
-- ----------------------------------------------------------------------------
-- Verificando campos que sao apenas espacos

SELECT *
FROM clientes
WHERE TRIM(nome) = '' OR TRIM(nome) IS NULL;

-- Encontra registros com nomes vazios ou so espacos

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Limpeza na insercao
-- ----------------------------------------------------------------------------
-- Garantindo dados limpos desde a insercao

INSERT INTO clientes (nome, email)
VALUES (
    TRIM('  Maria Silva  '),
    TRIM(LOWER('  Maria@Email.com  '))
);

-- Insere: 'Maria Silva', 'maria@email.com'

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Removendo quebras de linha
-- ----------------------------------------------------------------------------
-- Limpando caracteres de nova linha (MySQL)

SELECT 
    TRIM(BOTH '\n' FROM descricao) AS descricao_limpa
FROM produtos;

-- Em SQL Server:
SELECT 
    REPLACE(REPLACE(descricao, CHAR(13), ''), CHAR(10), '') AS descricao_limpa
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Combinando com outras funcoes
-- ----------------------------------------------------------------------------
-- Pipeline de limpeza completo

SELECT 
    UPPER(TRIM(REPLACE(nome, '  ', ' '))) AS nome_padronizado
FROM clientes;

-- Remove espacos extras, duplos, e converte para maiusculas

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre aplique TRIM em dados de entrada do usuario
-- 2. Use TRIM junto com LOWER/UPPER para padronizacao completa
-- 3. Considere criar triggers para limpar dados automaticamente
-- 4. TRIM nao remove espacos no MEIO da string (use REPLACE para isso)
-- 5. Valide se o campo apos TRIM nao fica vazio
--
-- ============================================================================
