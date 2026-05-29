-- ============================================================================
-- UPPER - Conversao para Maiusculas
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao UPPER converte todos os caracteres de uma string para maiusculas
-- (caixa alta). E util para padronizar dados, fazer comparacoes case-insensitive
-- e formatar saidas de relatorios.
--
-- SINTAXE BASICA:
-- UPPER(string)
--
-- PARAMETROS:
-- - string : Texto a ser convertido para maiusculas
--
-- RETORNO:
-- - String com todos os caracteres alfabeticos em maiusculo
-- - Caracteres nao alfabeticos permanecem inalterados
-- - Retorna NULL se a entrada for NULL
--
-- COMPATIBILIDADE:
-- - Disponivel em todos os principais SGBDs
-- - MySQL, PostgreSQL, SQL Server, Oracle: UPPER(str)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Conversao basica
-- ----------------------------------------------------------------------------
-- Convertendo nomes para maiusculas

SELECT 
    nome,
    UPPER(nome) AS nome_maiusculo
FROM clientes;

-- Resultado esperado:
-- | nome          | nome_maiusculo |
-- |---------------|----------------|
-- | Maria Silva   | MARIA SILVA    |
-- | joao santos   | JOAO SANTOS    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Comparacao case-insensitive
-- ----------------------------------------------------------------------------
-- Buscando registros ignorando maiusculas/minusculas

SELECT *
FROM produtos
WHERE UPPER(nome) = UPPER('notebook');

-- Encontra: 'Notebook', 'NOTEBOOK', 'notebook', 'NoTeBoOk'

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Padronizando siglas de estado
-- ----------------------------------------------------------------------------
-- Garantindo que estados estejam sempre em maiusculas

SELECT 
    cidade,
    UPPER(estado) AS estado
FROM enderecos;

-- Resultado esperado:
-- | cidade      | estado |
-- |-------------|--------|
-- | Sao Paulo   | SP     |
-- | Curitiba    | PR     |

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Formatando codigos
-- ----------------------------------------------------------------------------
-- Padronizando codigos de produto

UPDATE produtos
SET codigo = UPPER(codigo)
WHERE codigo != UPPER(codigo);

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Em clausula ORDER BY
-- ----------------------------------------------------------------------------
-- Ordenando de forma case-insensitive

SELECT nome
FROM clientes
ORDER BY UPPER(nome);

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Combinando com outras funcoes
-- ----------------------------------------------------------------------------
-- Criando iniciais maiusculas

SELECT 
    UPPER(LEFT(primeiro_nome, 1)) AS inicial_nome,
    UPPER(LEFT(sobrenome, 1)) AS inicial_sobrenome,
    CONCAT(
        UPPER(LEFT(primeiro_nome, 1)),
        UPPER(LEFT(sobrenome, 1))
    ) AS iniciais
FROM funcionarios;

-- Resultado esperado:
-- | inicial_nome | inicial_sobrenome | iniciais |
-- |--------------|-------------------|----------|
-- | M            | S                 | MS       |
-- | J            | O                 | JO       |

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Validacao de dados
-- ----------------------------------------------------------------------------
-- Verificando se um campo ja esta em maiusculas

SELECT *
FROM produtos
WHERE codigo != UPPER(codigo);

-- Retorna produtos com codigos que contem minusculas

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Em INSERT para padronizacao
-- ----------------------------------------------------------------------------
-- Inserindo dados ja padronizados

INSERT INTO estados (sigla, nome)
VALUES (UPPER('sp'), UPPER('sao paulo'));

-- Insere: 'SP', 'SAO PAULO'

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use UPPER para comparacoes case-insensitive em vez de COLLATE
-- 2. Considere criar indices funcionais em UPPER(coluna) para buscas frequentes
-- 3. Padronize na insercao para evitar conversoes em cada consulta
-- 4. UPPER nao afeta numeros ou caracteres especiais
-- 5. Para converter apenas a primeira letra, combine com LOWER e CONCAT
--
-- ============================================================================
