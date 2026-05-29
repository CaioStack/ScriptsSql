-- ============================================================================
-- NULLIF - Retorna NULL se Valores Forem Iguais
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao NULLIF() compara duas expressoes e retorna NULL se forem iguais.
-- Se forem diferentes, retorna a primeira expressao. E util para evitar
-- divisao por zero e para transformar valores especificos em NULL.
--
-- SINTAXE BASICA:
-- NULLIF(expressao1, expressao2)
--
-- PARAMETROS:
-- - expressao1 : Primeiro valor a ser comparado
-- - expressao2 : Segundo valor a ser comparado
--
-- RETORNO:
-- - NULL se expressao1 = expressao2
-- - expressao1 se expressao1 != expressao2
--
-- COMPATIBILIDADE:
-- - MySQL: Sim (padrao ANSI)
-- - PostgreSQL: Sim (padrao ANSI)
-- - SQL Server: Sim (padrao ANSI)
-- - Oracle: Sim (padrao ANSI)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico
-- ----------------------------------------------------------------------------
-- Retorna NULL se valores forem iguais

SELECT 
    NULLIF(10, 10) AS resultado1,  -- Retorna NULL
    NULLIF(10, 20) AS resultado2;  -- Retorna 10

-- | resultado1 | resultado2 |
-- |------------|------------|
-- | NULL       | 10         |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Evitando divisao por zero
-- ----------------------------------------------------------------------------
-- Uso mais comum: prevenir erro de divisao por zero

SELECT 
    produto,
    total_vendas,
    quantidade_vendas,
    total_vendas / NULLIF(quantidade_vendas, 0) AS ticket_medio
FROM relatorio_vendas;

-- Se quantidade_vendas = 0:
-- Sem NULLIF: total_vendas / 0 = ERRO!
-- Com NULLIF: total_vendas / NULL = NULL (sem erro)

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Calculando porcentagem segura
-- ----------------------------------------------------------------------------
-- Evitando divisao por zero em porcentagens

SELECT 
    departamento,
    funcionarios_ativos,
    total_funcionarios,
    (funcionarios_ativos * 100.0 / NULLIF(total_funcionarios, 0)) AS porcentagem_ativos
FROM departamentos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Transformando valor especial em NULL
-- ----------------------------------------------------------------------------
-- Tratando valor sentinela como NULL

SELECT 
    nome,
    NULLIF(ano_nascimento, 0) AS ano_nascimento,
    NULLIF(salario, -1) AS salario
FROM funcionarios;

-- Se ano_nascimento = 0 (valor invalido), retorna NULL
-- Se salario = -1 (indicador de "nao informado"), retorna NULL

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Combinando com COALESCE
-- ----------------------------------------------------------------------------
-- Substituindo valores invalidos

SELECT 
    nome,
    COALESCE(NULLIF(telefone, ''), 'Nao informado') AS telefone
FROM clientes;

-- Se telefone = '' (vazio), NULLIF retorna NULL
-- Entao COALESCE substitui NULL por 'Nao informado'

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Tratando strings vazias
-- ----------------------------------------------------------------------------
-- Convertendo string vazia para NULL

SELECT 
    nome,
    NULLIF(TRIM(observacao), '') AS observacao
FROM pedidos;

-- Remove espacos e, se ficar vazio, retorna NULL

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Em calculos condicionais
-- ----------------------------------------------------------------------------
-- Media apenas de valores validos

SELECT 
    AVG(NULLIF(nota, 0)) AS media_notas_validas
FROM avaliacoes;

-- Notas = 0 sao ignoradas na media (tratadas como NULL)

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: NULLIF em comparacoes
-- ----------------------------------------------------------------------------
-- Comparando valores com tratamento de igualdade

SELECT 
    produto,
    preco_antigo,
    preco_novo,
    NULLIF(preco_novo, preco_antigo) AS preco_alterado
FROM produtos;

-- Se preco nao mudou (novo = antigo), retorna NULL
-- Se mudou, retorna o novo preco

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Combinacao complexa
-- ----------------------------------------------------------------------------
-- Calculando variacao percentual segura

SELECT 
    mes,
    vendas_atual,
    vendas_anterior,
    ((vendas_atual - vendas_anterior) * 100.0 / 
        NULLIF(vendas_anterior, 0)
    ) AS variacao_percentual
FROM comparativo_vendas;

-- Evita divisao por zero quando vendas_anterior = 0

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: NULLIF vs CASE
-- ----------------------------------------------------------------------------
-- NULLIF e um atalho para CASE

-- Usando NULLIF:
SELECT NULLIF(valor, 0) FROM tabela;

-- Equivalente com CASE:
SELECT 
    CASE 
        WHEN valor = 0 THEN NULL 
        ELSE valor 
    END
FROM tabela;

-- NULLIF e mais conciso e legivel

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Use NULLIF para evitar divisao por zero (caso mais comum)
-- 2. Combine com COALESCE para substituir valores problematicos
-- 3. Util para transformar valores "sentinela" (0, -1, '') em NULL
-- 4. NULLIF(a, b) retorna a se a != b, NULL se a = b
-- 5. Funciona com qualquer tipo de dado comparavel
-- 6. E padrao ANSI - funciona em todos os SGBDs principais
--
-- ============================================================================
