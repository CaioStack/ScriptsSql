-- ============================================
-- COMANDO: CROSS JOIN
-- ============================================
-- 
-- DESCRIÇÃO:
-- CROSS JOIN retorna o produto cartesiano entre duas tabelas,
-- ou seja, combina CADA linha da primeira tabela com TODAS
-- as linhas da segunda tabela. Não usa condição ON.
--
-- Se tabela A tem 10 linhas e tabela B tem 5 linhas,
-- o CROSS JOIN retorna 10 × 5 = 50 linhas.
--
-- SINTAXE BÁSICA:
-- SELECT colunas FROM tabela1 CROSS JOIN tabela2;
-- ou
-- SELECT colunas FROM tabela1, tabela2;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: CROSS JOIN simples
-- ============================================
-- Todas as combinações de cores e tamanhos
SELECT cor, tamanho
FROM cores
CROSS JOIN tamanhos;

-- Se cores = (Vermelho, Azul, Verde) e tamanhos = (P, M, G)
-- Resultado: 9 combinações (3 × 3)
-- Vermelho-P, Vermelho-M, Vermelho-G,
-- Azul-P, Azul-M, Azul-G,
-- Verde-P, Verde-M, Verde-G

-- ============================================
-- EXEMPLO 2: Sintaxe alternativa (vírgula)
-- ============================================
-- Equivalente ao CROSS JOIN
SELECT cor, tamanho
FROM cores, tamanhos;

-- ============================================
-- EXEMPLO 3: Gerar combinações de produtos
-- ============================================
-- Criar variações de um produto
SELECT 
    p.nome AS produto,
    c.nome AS cor,
    t.nome AS tamanho,
    CONCAT(p.codigo, '-', c.codigo, '-', t.codigo) AS sku
FROM produtos_base p
CROSS JOIN cores c
CROSS JOIN tamanhos t;

-- ============================================
-- EXEMPLO 4: Calendário × Lista de tarefas
-- ============================================
-- Criar matriz de planejamento
SELECT 
    d.data,
    t.nome AS tarefa,
    t.responsavel
FROM dias d
CROSS JOIN tarefas_diarias t
WHERE d.data BETWEEN '2024-01-01' AND '2024-01-31';

-- ============================================
-- EXEMPLO 5: Comparação todos-contra-todos
-- ============================================
-- Todos os pares possíveis de funcionários
SELECT 
    f1.nome AS funcionario_1,
    f2.nome AS funcionario_2
FROM funcionarios f1
CROSS JOIN funcionarios f2
WHERE f1.id < f2.id;  -- Evita duplicatas e auto-comparação

-- ============================================
-- EXEMPLO 6: Matriz de preços
-- ============================================
-- Preço por quantidade para diferentes produtos
SELECT 
    p.nome AS produto,
    p.preco_unitario,
    q.quantidade,
    p.preco_unitario * q.quantidade AS preco_total
FROM produtos p
CROSS JOIN (
    SELECT 1 AS quantidade UNION ALL
    SELECT 5 UNION ALL
    SELECT 10 UNION ALL
    SELECT 25 UNION ALL
    SELECT 100
) q;

-- ============================================
-- EXEMPLO 7: Gerar série de datas
-- ============================================
-- Combinação de anos e meses
SELECT 
    a.ano,
    m.mes,
    CONCAT(a.ano, '-', LPAD(m.mes, 2, '0'), '-01') AS primeiro_dia
FROM 
    (SELECT 2023 AS ano UNION SELECT 2024 UNION SELECT 2025) a
CROSS JOIN 
    (SELECT 1 AS mes UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8
     UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) m
ORDER BY a.ano, m.mes;

-- ============================================
-- EXEMPLO 8: Tabela de multiplicação
-- ============================================
SELECT 
    a.numero AS x,
    b.numero AS y,
    a.numero * b.numero AS resultado
FROM 
    (SELECT 1 AS numero UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) a
CROSS JOIN 
    (SELECT 1 AS numero UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) b
ORDER BY a.numero, b.numero;

-- ============================================
-- EXEMPLO 9: CROSS JOIN com filtro WHERE
-- ============================================
-- Encontrar combinações válidas
SELECT 
    p.nome AS produto,
    f.nome AS fornecedor
FROM produtos p
CROSS JOIN fornecedores f
WHERE p.categoria = f.especialidade;
-- Isso é equivalente a um INNER JOIN

-- ============================================
-- VISUALIZAÇÃO DO CROSS JOIN:
-- ============================================
--
--     TABELA A          CROSS JOIN          RESULTADO
--    ┌───┐             
--    │ 1 │──────┬──────┬──────> 1,A  1,B  1,C
--    │ 2 │──────┼──────┼──────> 2,A  2,B  2,C
--    │ 3 │──────┼──────┼──────> 3,A  3,B  3,C
--    └───┘      │      │
--               ▼      ▼
--           TABELA B
--          ┌───┬───┬───┐
--          │ A │ B │ C │
--          └───┴───┴───┘
--
--    3 linhas × 3 linhas = 9 combinações
--
-- ============================================

-- ============================================
-- CUIDADOS COM CROSS JOIN:
-- ============================================
-- 1. O resultado cresce EXPONENCIALMENTE!
--    - 100 × 100 = 10.000 linhas
--    - 1000 × 1000 = 1.000.000 linhas
-- 2. Pode consumir muita memória e tempo
-- 3. Use apenas quando realmente precisa de TODAS as combinações
-- 4. Considere adicionar WHERE para filtrar resultados

-- ============================================
-- QUANDO USAR CROSS JOIN:
-- ============================================
-- 1. Gerar todas as combinações possíveis
-- 2. Criar variações de produtos (cor, tamanho)
-- 3. Construir calendários ou séries temporais
-- 4. Comparações todos-contra-todos
-- 5. Testes com dados combinatoriais
