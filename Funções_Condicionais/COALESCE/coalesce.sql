-- ============================================================================
-- COALESCE - Primeiro Valor Nao NULL (Padrao ANSI)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao COALESCE() retorna o primeiro valor nao NULL de uma lista de
-- expressoes. E a funcao padrao ANSI SQL para tratamento de valores NULL,
-- funcionando em todos os principais bancos de dados.
--
-- SINTAXE BASICA:
-- COALESCE(expressao1, expressao2, expressao3, ...)
--
-- PARAMETROS:
-- - expressao1, expressao2, ... : Lista de valores a serem verificados
--
-- RETORNO:
-- - Retorna o primeiro valor da lista que NAO seja NULL
-- - Se todos forem NULL, retorna NULL
--
-- COMPATIBILIDADE:
-- - MySQL: Sim (padrao ANSI)
-- - PostgreSQL: Sim (padrao ANSI)
-- - SQL Server: Sim (padrao ANSI)
-- - Oracle: Sim (padrao ANSI)
-- - SQLite: Sim (padrao ANSI)
--
-- VANTAGEM: Por ser padrao ANSI, funciona em TODOS os SGBDs!
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico com 2 valores
-- ----------------------------------------------------------------------------
-- Equivalente a IFNULL/ISNULL/NVL

SELECT 
    nome,
    COALESCE(telefone, 'Nao informado') AS telefone
FROM clientes;

-- Resultado esperado:
-- | nome        | telefone       |
-- |-------------|----------------|
-- | Maria Silva | (11) 99999-0000|
-- | Joao Santos | Nao informado  |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Multiplos valores alternativos
-- ----------------------------------------------------------------------------
-- Principal vantagem: aceita muitos argumentos

SELECT 
    nome,
    COALESCE(
        telefone_celular, 
        telefone_residencial, 
        telefone_comercial, 
        'Sem telefone'
    ) AS telefone_contato
FROM contatos;

-- Retorna o primeiro telefone disponivel, ou 'Sem telefone' se todos forem NULL

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Em calculos
-- ----------------------------------------------------------------------------
-- Tratando NULL em operacoes matematicas

SELECT 
    produto,
    preco,
    COALESCE(desconto, 0) AS desconto,
    preco * (1 - COALESCE(desconto, 0)) AS preco_final
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Com valores de diferentes colunas
-- ----------------------------------------------------------------------------
-- Priorizando informacoes

SELECT 
    id_cliente,
    COALESCE(nome_fantasia, razao_social, 'Cliente sem nome') AS nome_exibicao,
    COALESCE(email_comercial, email_pessoal, 'sem@email.com') AS email_principal
FROM empresas;

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Em agregacoes
-- ----------------------------------------------------------------------------
-- Garantindo valores em somas e medias

SELECT 
    departamento,
    SUM(COALESCE(bonus, 0)) AS total_bonus,
    AVG(COALESCE(bonus, 0)) AS media_bonus,
    COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY departamento;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: COALESCE vs funcoes especificas
-- ----------------------------------------------------------------------------
-- Comparando com equivalentes de cada SGBD

-- COALESCE (funciona em TODOS):
SELECT COALESCE(campo, 'padrao') FROM tabela;

-- MySQL (IFNULL - apenas 2 args):
SELECT IFNULL(campo, 'padrao') FROM tabela;

-- SQL Server (ISNULL - apenas 2 args):
SELECT ISNULL(campo, 'padrao') FROM tabela;

-- Oracle (NVL - apenas 2 args):
SELECT NVL(campo, 'padrao') FROM tabela;

-- COALESCE e a UNICA que aceita multiplos argumentos em todos!

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Em concatenacao
-- ----------------------------------------------------------------------------
-- Montando strings sem NULL

SELECT 
    CONCAT(
        COALESCE(primeiro_nome, ''),
        ' ',
        COALESCE(nome_meio, ''),
        ' ',
        COALESCE(sobrenome, '')
    ) AS nome_completo
FROM pessoas;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Com subqueries
-- ----------------------------------------------------------------------------
-- Valor padrao quando subquery retorna NULL

SELECT 
    p.nome,
    COALESCE(
        (SELECT AVG(nota) FROM avaliacoes WHERE produto_id = p.id),
        0
    ) AS media_avaliacoes
FROM produtos p;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Em UPDATE
-- ----------------------------------------------------------------------------
-- Definindo valores padrao

UPDATE configuracoes
SET 
    valor = COALESCE(valor_personalizado, valor_padrao_sistema, valor_padrao_global)
WHERE valor IS NULL;

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Priorizando fontes de dados
-- ----------------------------------------------------------------------------
-- Exemplo pratico: obtendo preco mais recente

SELECT 
    produto_id,
    COALESCE(
        preco_promocional,     -- Primeiro: preco promocional
        preco_cliente_vip,     -- Segundo: preco VIP
        preco_atacado,         -- Terceiro: preco atacado
        preco_tabela           -- Ultimo: preco padrao
    ) AS preco_aplicado
FROM produtos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 11: Tratando datas
-- ----------------------------------------------------------------------------
-- Usando data padrao quando NULL

SELECT 
    nome_tarefa,
    COALESCE(data_inicio, CURRENT_DATE) AS data_inicio_efetiva,
    COALESCE(data_fim, '9999-12-31') AS data_fim_efetiva
FROM tarefas;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. USE COALESCE para codigo portavel entre diferentes SGBDs
-- 2. Aceita quantidade ilimitada de argumentos (diferente de IFNULL/NVL)
-- 3. Avalia argumentos da esquerda para direita, para no primeiro nao-NULL
-- 4. Se TODOS os argumentos forem NULL, retorna NULL
-- 5. Tipos devem ser compativeis ou implicitamente conversiveis
-- 6. E mais lento que IFNULL/ISNULL para apenas 2 argumentos (minimo)
--
-- ============================================================================
