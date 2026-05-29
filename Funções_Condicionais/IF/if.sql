-- ============================================================================
-- IF - Condicional Simples (MySQL)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao IF() e uma funcao condicional do MySQL que retorna um valor se a
-- condicao for verdadeira e outro valor se for falsa. E equivalente ao
-- operador ternario de linguagens de programacao.
--
-- SINTAXE BASICA:
-- IF(condicao, valor_se_verdadeiro, valor_se_falso)
--
-- PARAMETROS:
-- - condicao : Expressao que sera avaliada como TRUE ou FALSE
-- - valor_se_verdadeiro : Retornado quando condicao = TRUE
-- - valor_se_falso : Retornado quando condicao = FALSE ou NULL
--
-- COMPATIBILIDADE:
-- - MySQL: IF(cond, true_val, false_val)
-- - SQL Server: IIF(cond, true_val, false_val)
-- - PostgreSQL: Nao tem IF, use CASE
-- - Oracle: Nao tem IF em SELECT, use CASE ou DECODE
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico
-- ----------------------------------------------------------------------------
-- Verificando se valor e positivo

SELECT 
    valor,
    IF(valor > 0, 'Positivo', 'Negativo ou Zero') AS classificacao
FROM transacoes;

-- Resultado esperado:
-- | valor | classificacao      |
-- |-------|--------------------|
-- | 150   | Positivo           |
-- | -50   | Negativo ou Zero   |
-- | 0     | Negativo ou Zero   |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Verificando disponibilidade
-- ----------------------------------------------------------------------------
-- Status de estoque

SELECT 
    nome,
    estoque,
    IF(estoque > 0, 'Disponivel', 'Esgotado') AS disponibilidade
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Calculo condicional
-- ----------------------------------------------------------------------------
-- Aplicando desconto baseado em condicao

SELECT 
    id_pedido,
    valor,
    IF(valor > 500, valor * 0.9, valor) AS valor_com_desconto
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: IF aninhado
-- ----------------------------------------------------------------------------
-- Multiplas condicoes (semelhante a if-else-if)

SELECT 
    nota,
    IF(nota >= 7, 'Aprovado', 
        IF(nota >= 5, 'Recuperacao', 'Reprovado')
    ) AS situacao
FROM alunos;

-- Equivalente com CASE (mais legivel):
SELECT 
    nota,
    CASE
        WHEN nota >= 7 THEN 'Aprovado'
        WHEN nota >= 5 THEN 'Recuperacao'
        ELSE 'Reprovado'
    END AS situacao
FROM alunos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: IF com agregacao
-- ----------------------------------------------------------------------------
-- Contagem condicional

SELECT 
    SUM(IF(status = 'ativo', 1, 0)) AS ativos,
    SUM(IF(status = 'inativo', 1, 0)) AS inativos,
    SUM(IF(status = 'pendente', 1, 0)) AS pendentes
FROM usuarios;

-- Equivalente:
SELECT 
    COUNT(IF(status = 'ativo', 1, NULL)) AS ativos,
    COUNT(IF(status = 'inativo', 1, NULL)) AS inativos
FROM usuarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: SQL Server - IIF
-- ----------------------------------------------------------------------------
-- Funcao equivalente no SQL Server

-- SQL Server:
SELECT 
    valor,
    IIF(valor > 0, 'Positivo', 'Negativo ou Zero') AS classificacao
FROM transacoes;

-- Sintaxe identica ao IF do MySQL

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: IF com NULL
-- ----------------------------------------------------------------------------
-- Tratando valores nulos

SELECT 
    nome,
    email,
    IF(email IS NOT NULL, email, 'Nao informado') AS email_display
FROM clientes;

-- Melhor usar IFNULL ou COALESCE para este caso:
SELECT 
    nome,
    IFNULL(email, 'Nao informado') AS email_display
FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: IF em UPDATE
-- ----------------------------------------------------------------------------
-- Atualizacao condicional

UPDATE produtos
SET preco = IF(categoria = 'promocao', preco * 0.8, preco);

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: IF para formatacao
-- ----------------------------------------------------------------------------
-- Formatando saida baseada em condicao

SELECT 
    nome,
    idade,
    IF(idade >= 18, 'Maior de idade', 'Menor de idade') AS classificacao
FROM pessoas;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. IF e especifico do MySQL/MariaDB - use CASE para portabilidade
-- 2. Para mais de 2 opcoes, prefira CASE ao inves de IF aninhado
-- 3. Use IFNULL/COALESCE especificamente para tratar NULL
-- 4. IF com agregacao e util para criar pivot tables simples
-- 5. IIF do SQL Server funciona igual ao IF do MySQL
--
-- ============================================================================
