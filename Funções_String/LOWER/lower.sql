-- ============================================================================
-- LOWER - Conversao para Minusculas
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao LOWER converte todos os caracteres de uma string para minusculas
-- (caixa baixa). E util para padronizar dados, fazer comparacoes case-insensitive
-- e normalizar entradas de usuarios.
--
-- SINTAXE BASICA:
-- LOWER(string)
--
-- PARAMETROS:
-- - string : Texto a ser convertido para minusculas
--
-- RETORNO:
-- - String com todos os caracteres alfabeticos em minusculo
-- - Caracteres nao alfabeticos permanecem inalterados
-- - Retorna NULL se a entrada for NULL
--
-- COMPATIBILIDADE:
-- - Disponivel em todos os principais SGBDs
-- - MySQL, PostgreSQL, SQL Server, Oracle: LOWER(str)
-- - Oracle tambem aceita: LCASE(str)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Conversao basica
-- ----------------------------------------------------------------------------
-- Convertendo nomes para minusculas

SELECT 
    nome,
    LOWER(nome) AS nome_minusculo
FROM clientes;

-- Resultado esperado:
-- | nome          | nome_minusculo |
-- |---------------|----------------|
-- | MARIA SILVA   | maria silva    |
-- | Joao Santos   | joao santos    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Normalizando emails
-- ----------------------------------------------------------------------------
-- Emails devem ser armazenados em minusculas

SELECT 
    email,
    LOWER(email) AS email_normalizado
FROM usuarios;

-- Resultado esperado:
-- | email              | email_normalizado  |
-- |--------------------|--------------------|
-- | Joao@Gmail.COM     | joao@gmail.com     |
-- | MARIA@Empresa.com  | maria@empresa.com  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Comparacao case-insensitive
-- ----------------------------------------------------------------------------
-- Buscando usuario por email ignorando maiusculas

SELECT *
FROM usuarios
WHERE LOWER(email) = LOWER('JOAO@GMAIL.COM');

-- Encontra: 'joao@gmail.com', 'Joao@Gmail.com', etc.

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Padronizando na insercao
-- ----------------------------------------------------------------------------
-- Garantindo que emails sejam sempre minusculos

INSERT INTO usuarios (nome, email)
VALUES ('Maria Silva', LOWER('Maria@Empresa.COM'));

-- Insere email como: 'maria@empresa.com'

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Atualizando dados existentes
-- ----------------------------------------------------------------------------
-- Normalizando todos os emails da tabela

UPDATE usuarios
SET email = LOWER(email)
WHERE email != LOWER(email);

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Criando usernames
-- ----------------------------------------------------------------------------
-- Gerando username a partir do nome

SELECT 
    primeiro_nome,
    sobrenome,
    LOWER(CONCAT(primeiro_nome, '.', sobrenome)) AS username
FROM funcionarios;

-- Resultado esperado:
-- | primeiro_nome | sobrenome | username       |
-- |---------------|-----------|----------------|
-- | Maria         | Silva     | maria.silva    |
-- | Joao          | Santos    | joao.santos    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Criando slugs para URLs
-- ----------------------------------------------------------------------------
-- Convertendo titulos em slugs amigaveis

SELECT 
    titulo,
    LOWER(REPLACE(titulo, ' ', '-')) AS slug
FROM artigos;

-- Resultado esperado:
-- | titulo              | slug                |
-- |---------------------|---------------------|
-- | Meu Primeiro Post   | meu-primeiro-post   |
-- | Tutorial de SQL     | tutorial-de-sql     |

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Combinando com TRIM
-- ----------------------------------------------------------------------------
-- Limpando e normalizando dados

SELECT 
    LOWER(TRIM(email)) AS email_limpo
FROM usuarios;

-- Remove espacos e converte para minusculas

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre normalize emails para minusculas ao armazenar
-- 2. Use LOWER para buscas case-insensitive
-- 3. Combine com TRIM para limpeza completa de dados
-- 4. Considere normalizar na aplicacao antes de enviar ao banco
-- 5. Crie indices funcionais em LOWER(coluna) para buscas frequentes
--
-- ============================================================================
