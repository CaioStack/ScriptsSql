-- ============================================================================
-- NVL - Tratamento de Valores NULL (Oracle)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao NVL() e a funcao nativa do Oracle para tratamento de valores NULL.
-- Ela verifica se uma expressao e NULL e retorna um valor alternativo caso
-- seja. O nome vem de "Null Value Logic" ou "Null Value".
--
-- SINTAXE BASICA:
-- NVL(expressao, valor_se_null)
--
-- PARAMETROS:
-- - expressao : Valor ou coluna a ser verificada
-- - valor_se_null : Valor retornado se expressao for NULL
--
-- RETORNO:
-- - Se expressao NAO for NULL: retorna a propria expressao
-- - Se expressao FOR NULL: retorna valor_se_null
--
-- COMPATIBILIDADE:
-- - Oracle: NVL(expr, valor), NVL2(expr, val_not_null, val_null)
-- - MySQL: IFNULL(expr, valor)
-- - SQL Server: ISNULL(expr, valor)
-- - PostgreSQL: COALESCE(expr, valor)
--
-- IMPORTANTE: NVL e especifico do Oracle. O equivalente padrao ANSI e COALESCE.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico
-- ----------------------------------------------------------------------------
-- Substituindo NULL por valor padrao

-- Oracle:
SELECT 
    nome,
    NVL(telefone, 'Nao informado') AS telefone
FROM clientes;

-- Resultado esperado:
-- | nome        | telefone       |
-- |-------------|----------------|
-- | Maria Silva | (11) 99999-0000|
-- | Joao Santos | Nao informado  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Em calculos numericos
-- ----------------------------------------------------------------------------
-- Tratando NULL em operacoes matematicas

-- Oracle:
SELECT 
    nome_funcionario,
    salario,
    NVL(comissao, 0) AS comissao,
    salario + NVL(comissao, 0) AS total
FROM funcionarios;

-- Sem NVL: 5000 + NULL = NULL
-- Com NVL: 5000 + 0 = 5000

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: NVL com diferentes tipos
-- ----------------------------------------------------------------------------
-- O valor de substituicao deve ser compativel com o tipo da coluna

-- Oracle:
SELECT 
    NVL(preco, 0) AS preco,                    -- Numerico
    NVL(descricao, 'Sem descricao') AS desc,   -- Texto
    NVL(data_entrega, SYSDATE) AS data_entrega -- Data
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: NVL2 - Versao estendida (Oracle exclusivo)
-- ----------------------------------------------------------------------------
-- NVL2 retorna um valor se NAO for NULL e outro se FOR NULL

-- Oracle:
-- Sintaxe: NVL2(expr, valor_se_nao_null, valor_se_null)

SELECT 
    nome,
    bonus,
    NVL2(bonus, 'Tem bonus', 'Sem bonus') AS status_bonus,
    NVL2(bonus, salario + bonus, salario) AS total
FROM funcionarios;

-- Se bonus = 1000: retorna 'Tem bonus' e salario + 1000
-- Se bonus = NULL: retorna 'Sem bonus' e apenas salario

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: NVL em agregacoes
-- ----------------------------------------------------------------------------
-- Somando valores tratando NULL como zero

-- Oracle:
SELECT 
    departamento,
    SUM(NVL(horas_extras, 0)) AS total_horas_extras,
    AVG(NVL(horas_extras, 0)) AS media_horas_extras
FROM funcionarios
GROUP BY departamento;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: NVL em concatenacao
-- ----------------------------------------------------------------------------
-- Evitando NULL em strings

-- Oracle:
SELECT 
    primeiro_nome || ' ' || NVL(nome_meio, '') || ' ' || sobrenome AS nome_completo
FROM pessoas;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: NVL aninhado
-- ----------------------------------------------------------------------------
-- Multiplas verificacoes em cascata

-- Oracle:
SELECT 
    nome,
    NVL(telefone_celular, 
        NVL(telefone_residencial, 
            NVL(telefone_comercial, 'Sem telefone')
        )
    ) AS telefone_contato
FROM contatos;

-- Mais elegante com COALESCE:
SELECT 
    nome,
    COALESCE(telefone_celular, telefone_residencial, telefone_comercial, 'Sem telefone') AS telefone_contato
FROM contatos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: NVL em UPDATE
-- ----------------------------------------------------------------------------
-- Definindo valor padrao durante atualizacao

-- Oracle:
UPDATE produtos
SET estoque_minimo = NVL(estoque_minimo, 10)
WHERE estoque_minimo IS NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: NVL em ORDER BY
-- ----------------------------------------------------------------------------
-- Tratando NULL na ordenacao

-- Oracle:
SELECT *
FROM tarefas
ORDER BY NVL(data_conclusao, DATE '9999-12-31');

-- NULL vai para o final

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Tabela de equivalencia entre SGBDs
-- ----------------------------------------------------------------------------
/*
+------------------+------------------+------------------+------------------+------------------+
|    Funcao        |     Oracle       |      MySQL       |   SQL Server     |   PostgreSQL     |
+------------------+------------------+------------------+------------------+------------------+
| Substituir NULL  | NVL(x, val)      | IFNULL(x, val)   | ISNULL(x, val)   | COALESCE(x, val) |
| Se/Senao NULL    | NVL2(x, v1, v2)  | IF(x IS NULL...) | IIF(x IS NULL..) | CASE WHEN...     |
| Multiplos vals   | COALESCE(...)    | COALESCE(...)    | COALESCE(...)    | COALESCE(...)    |
+------------------+------------------+------------------+------------------+------------------+
*/

-- Para codigo portavel entre todos os SGBDs, use COALESCE:
SELECT 
    nome,
    COALESCE(telefone, 'Nao informado') AS telefone
FROM clientes;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. NVL e especifico do Oracle - use COALESCE para portabilidade
-- 2. NVL aceita apenas 2 argumentos (use COALESCE para mais)
-- 3. NVL2 e exclusivo do Oracle - util para logica if/else
-- 4. O tipo de retorno de NVL segue o tipo do primeiro argumento
-- 5. Sempre trate NULL em calculos para evitar resultados inesperados
-- 6. Oracle trata string vazia ('') como NULL - atencao a isso!
--
-- ============================================================================
