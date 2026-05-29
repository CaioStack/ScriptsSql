-- ============================================================================
-- CONCAT - Concatenacao de Strings
-- ============================================================================
-- 
-- DESCRICAO:
-- O CONCAT e uma funcao que une (concatena) duas ou mais strings em uma unica
-- string. E utilizada para combinar valores de texto de diferentes colunas
-- ou combinar texto literal com valores de colunas.
--
-- SINTAXE BASICA:
-- CONCAT(string1, string2, ...)
--
-- PARAMETROS:
-- - string1, string2, ... : Strings ou colunas a serem concatenadas
--
-- COMPATIBILIDADE:
-- - MySQL: CONCAT(str1, str2, ...)
-- - PostgreSQL: CONCAT(str1, str2, ...) ou str1 || str2
-- - SQL Server: CONCAT(str1, str2, ...) ou str1 + str2
-- - Oracle: CONCAT(str1, str2) ou str1 || str2
--
-- OBSERVACOES:
-- - Em MySQL, CONCAT retorna NULL se qualquer argumento for NULL
-- - Use CONCAT_WS para concatenar com separador
-- - O operador || e uma alternativa em alguns SGBDs
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Concatenacao basica de colunas
-- ----------------------------------------------------------------------------
-- Combinando nome e sobrenome de funcionarios

SELECT 
    CONCAT(primeiro_nome, ' ', sobrenome) AS nome_completo
FROM funcionarios;

-- Resultado esperado:
-- | nome_completo    |
-- |------------------|
-- | Maria Silva      |
-- | Joao Santos      |
-- | Ana Oliveira     |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Concatenacao com texto literal
-- ----------------------------------------------------------------------------
-- Criando uma saudacao personalizada

SELECT 
    CONCAT('Ola, ', primeiro_nome, '! Bem-vindo(a).') AS saudacao
FROM clientes;

-- Resultado esperado:
-- | saudacao                        |
-- |---------------------------------|
-- | Ola, Carlos! Bem-vindo(a).      |
-- | Ola, Patricia! Bem-vindo(a).    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Formatando enderecos
-- ----------------------------------------------------------------------------
-- Combinando campos de endereco em uma unica string

SELECT 
    CONCAT(rua, ', ', numero, ' - ', cidade, '/', estado) AS endereco_completo
FROM enderecos;

-- Resultado esperado:
-- | endereco_completo                      |
-- |----------------------------------------|
-- | Rua das Flores, 123 - Sao Paulo/SP     |
-- | Av. Brasil, 456 - Rio de Janeiro/RJ    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: CONCAT_WS (With Separator) - MySQL
-- ----------------------------------------------------------------------------
-- Concatenacao com separador automatico

SELECT 
    CONCAT_WS(' - ', codigo, nome, categoria) AS produto_info
FROM produtos;

-- Resultado esperado:
-- | produto_info               |
-- |----------------------------|
-- | P001 - Notebook - Eletro   |
-- | P002 - Mouse - Periferico  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Usando operador || (PostgreSQL/Oracle)
-- ----------------------------------------------------------------------------
-- Alternativa ao CONCAT usando operador de concatenacao

SELECT 
    primeiro_nome || ' ' || sobrenome AS nome_completo
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Usando operador + (SQL Server)
-- ----------------------------------------------------------------------------
-- Alternativa ao CONCAT no SQL Server

SELECT 
    primeiro_nome + ' ' + sobrenome AS nome_completo
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Concatenacao com conversao de tipos
-- ----------------------------------------------------------------------------
-- Combinando strings com numeros (conversao implicita em alguns SGBDs)

SELECT 
    CONCAT('Pedido #', id_pedido, ' - Total: R$ ', valor_total) AS resumo_pedido
FROM pedidos;

-- Em SQL Server, pode ser necessario CAST:
SELECT 
    CONCAT('Pedido #', CAST(id_pedido AS VARCHAR), ' - Total: R$ ', CAST(valor_total AS VARCHAR)) AS resumo_pedido
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Criando codigos ou identificadores
-- ----------------------------------------------------------------------------
-- Gerando codigo de produto combinando campos

SELECT 
    CONCAT(
        UPPER(LEFT(categoria, 3)),
        '-',
        LPAD(id_produto, 5, '0')
    ) AS codigo_produto
FROM produtos;

-- Resultado esperado:
-- | codigo_produto |
-- |----------------|
-- | ELE-00001      |
-- | MOV-00002      |

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use CONCAT_WS quando precisar de separador consistente
-- 2. Trate valores NULL com COALESCE ou IFNULL antes de concatenar
-- 3. Para melhor legibilidade, quebre concatenacoes longas em varias linhas
-- 4. Considere criar VIEWS para concatenacoes frequentemente usadas
-- 5. Atencao ao limite de tamanho da string resultante
--
-- ============================================================================
