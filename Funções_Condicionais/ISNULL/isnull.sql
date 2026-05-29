-- ============================================================================
-- ISNULL - Tratamento de Valores NULL (SQL Server)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao ISNULL() do SQL Server verifica se uma expressao e NULL e retorna
-- um valor de substituicao caso seja. E a funcao nativa do SQL Server para
-- tratamento de valores nulos, equivalente ao IFNULL do MySQL.
--
-- ATENCAO: No MySQL, ISNULL() e uma funcao DIFERENTE que retorna 1 se o valor
-- for NULL e 0 se nao for (funcao de teste, nao de substituicao).
--
-- SINTAXE BASICA (SQL Server):
-- ISNULL(expressao, valor_substituicao)
--
-- PARAMETROS:
-- - expressao : Valor ou coluna a ser verificada
-- - valor_substituicao : Valor retornado se expressao for NULL
--
-- RETORNO:
-- - Se expressao NAO for NULL: retorna a propria expressao
-- - Se expressao FOR NULL: retorna valor_substituicao
--
-- COMPATIBILIDADE:
-- - SQL Server: ISNULL(expr, valor) - substituicao
-- - MySQL: ISNULL(expr) - retorna 1 ou 0 (teste)
-- - MySQL: IFNULL(expr, valor) - substituicao
-- - PostgreSQL: COALESCE(expr, valor)
-- - Oracle: NVL(expr, valor)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- SQL SERVER - ISNULL como substituicao
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico (SQL Server)
-- ----------------------------------------------------------------------------
-- Substituindo NULL por valor padrao

-- SQL Server:
SELECT 
    nome,
    ISNULL(telefone, 'Nao informado') AS telefone
FROM clientes;

-- Resultado esperado:
-- | nome        | telefone       |
-- |-------------|----------------|
-- | Maria Silva | (11) 99999-0000|
-- | Joao Santos | Nao informado  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Em calculos (SQL Server)
-- ----------------------------------------------------------------------------
-- Tratando NULL em operacoes matematicas

-- SQL Server:
SELECT 
    produto,
    preco,
    ISNULL(desconto, 0) AS desconto,
    preco * (1 - ISNULL(desconto, 0)) AS preco_final
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Com valores numericos (SQL Server)
-- ----------------------------------------------------------------------------
-- Substituindo comissao NULL por zero

-- SQL Server:
SELECT 
    nome_vendedor,
    total_vendas,
    ISNULL(comissao, 0) AS comissao,
    total_vendas + ISNULL(comissao, 0) AS total_ganhos
FROM vendedores;

-- ----------------------------------------------------------------------------
-- MYSQL - ISNULL como teste (funcao diferente!)
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: ISNULL no MySQL (teste booleano)
-- ----------------------------------------------------------------------------
-- No MySQL, ISNULL() TESTA se o valor e NULL (retorna 0 ou 1)

-- MySQL:
SELECT 
    nome,
    telefone,
    ISNULL(telefone) AS telefone_nulo
FROM clientes;

-- Resultado esperado:
-- | nome        | telefone       | telefone_nulo |
-- |-------------|----------------|---------------|
-- | Maria Silva | (11) 99999-0000| 0             |
-- | Joao Santos | NULL           | 1             |

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Usando ISNULL em WHERE (MySQL)
-- ----------------------------------------------------------------------------
-- Filtrando registros com valores NULL

-- MySQL:
SELECT *
FROM clientes
WHERE ISNULL(telefone) = 1;  -- Onde telefone e NULL

-- Equivalente a:
SELECT *
FROM clientes
WHERE telefone IS NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Comparando ISNULL entre SGBDs
-- ----------------------------------------------------------------------------

-- SQL Server - substituicao:
-- SELECT ISNULL(campo, 'padrao') FROM tabela;

-- MySQL - teste (0 ou 1):
-- SELECT ISNULL(campo) FROM tabela;  -- Retorna 1 se NULL, 0 se nao

-- Para SUBSTITUICAO no MySQL, use IFNULL:
-- SELECT IFNULL(campo, 'padrao') FROM tabela;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: ISNULL com tipo de dado (SQL Server)
-- ----------------------------------------------------------------------------
-- O tipo do resultado segue o tipo do primeiro argumento

-- SQL Server:
SELECT 
    ISNULL(CAST(preco AS VARCHAR(10)), 'N/A') AS preco_texto
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: ISNULL vs COALESCE (SQL Server)
-- ----------------------------------------------------------------------------

-- ISNULL - apenas 2 argumentos:
-- SQL Server:
SELECT ISNULL(campo1, 'padrao') FROM tabela;

-- COALESCE - multiplos argumentos (mais flexivel):
-- SQL Server:
SELECT COALESCE(campo1, campo2, campo3, 'padrao') FROM tabela;

-- COALESCE e padrao ANSI e funciona em todos os SGBDs

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: ISNULL em JOIN (SQL Server)
-- ----------------------------------------------------------------------------
-- Tratando NULL em condicoes de JOIN

-- SQL Server:
SELECT 
    p.nome AS produto,
    ISNULL(c.nome, 'Sem categoria') AS categoria
FROM produtos p
LEFT JOIN categorias c ON p.categoria_id = c.id;

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Tabela de equivalencia entre SGBDs
-- ----------------------------------------------------------------------------
/*
+------------------+------------------+------------------+------------------+
|    Operacao      |    SQL Server    |      MySQL       |   PostgreSQL     |
+------------------+------------------+------------------+------------------+
| Substituir NULL  | ISNULL(x, val)   | IFNULL(x, val)   | COALESCE(x, val) |
| Testar se NULL   | x IS NULL        | ISNULL(x)        | x IS NULL        |
| Multiplos vals   | COALESCE(...)    | COALESCE(...)    | COALESCE(...)    |
+------------------+------------------+------------------+------------------+
*/

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. CUIDADO: ISNULL tem comportamento DIFERENTE em SQL Server e MySQL
-- 2. SQL Server: ISNULL substitui NULL por valor
-- 3. MySQL: ISNULL testa se e NULL (retorna 0 ou 1)
-- 4. Para portabilidade, use COALESCE (padrao ANSI)
-- 5. ISNULL do SQL Server aceita apenas 2 argumentos
-- 6. No SQL Server, ISNULL converte ao tipo do primeiro argumento
--
-- ============================================================================
