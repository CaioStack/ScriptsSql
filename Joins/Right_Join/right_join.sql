-- ============================================
-- COMANDO: RIGHT JOIN (RIGHT OUTER JOIN)
-- ============================================
-- 
-- DESCRIÇÃO:
-- RIGHT JOIN retorna TODOS os registros da tabela da direita
-- e os registros correspondentes da tabela da esquerda.
-- Se não houver correspondência, as colunas da tabela da esquerda
-- terão valores NULL. É o inverso do LEFT JOIN.
--
-- SINTAXE BÁSICA:
-- SELECT colunas
-- FROM tabela_esquerda
-- RIGHT JOIN tabela_direita ON tabela_esquerda.coluna = tabela_direita.coluna;
--
-- ============================================

-- ============================================
-- EXEMPLO 1: RIGHT JOIN simples
-- ============================================
-- Todos os departamentos e funcionários associados
SELECT 
    f.nome AS funcionario,
    d.nome AS departamento
FROM funcionarios f
RIGHT JOIN departamentos d ON f.departamento_id = d.id;

-- Departamentos sem funcionários terão NULL nas colunas de funcionários

-- ============================================
-- EXEMPLO 2: Encontrar registros sem correspondência
-- ============================================
-- Departamentos sem funcionários
SELECT d.*
FROM funcionarios f
RIGHT JOIN departamentos d ON f.departamento_id = d.id
WHERE f.id IS NULL;

-- ============================================
-- EXEMPLO 3: Produtos em todas as categorias
-- ============================================
SELECT 
    p.nome AS produto,
    p.preco,
    c.nome AS categoria
FROM produtos p
RIGHT JOIN categorias c ON p.categoria_id = c.id;

-- ============================================
-- EXEMPLO 4: Contagem por categoria (incluindo vazias)
-- ============================================
SELECT 
    c.nome AS categoria,
    COUNT(p.id) AS total_produtos
FROM produtos p
RIGHT JOIN categorias c ON p.categoria_id = c.id
GROUP BY c.id, c.nome;

-- ============================================
-- EXEMPLO 5: RIGHT JOIN vs LEFT JOIN
-- ============================================
-- Estas duas queries retornam o mesmo resultado:

-- Usando RIGHT JOIN
SELECT p.nome, c.nome AS categoria
FROM produtos p
RIGHT JOIN categorias c ON p.categoria_id = c.id;

-- Equivalente usando LEFT JOIN (invertendo as tabelas)
SELECT p.nome, c.nome AS categoria
FROM categorias c
LEFT JOIN produtos p ON c.id = p.categoria_id;

-- ============================================
-- EXEMPLO 6: Fornecedores e seus produtos
-- ============================================
SELECT 
    p.nome AS produto,
    p.preco,
    f.nome AS fornecedor,
    f.contato
FROM produtos p
RIGHT JOIN fornecedores f ON p.fornecedor_id = f.id;

-- ============================================
-- EXEMPLO 7: RIGHT OUTER JOIN (sintaxe completa)
-- ============================================
-- RIGHT JOIN e RIGHT OUTER JOIN são idênticos
SELECT f.nome, d.nome
FROM funcionarios f
RIGHT OUTER JOIN departamentos d ON f.departamento_id = d.id;

-- ============================================
-- EXEMPLO 8: RIGHT JOIN com múltiplas tabelas
-- ============================================
SELECT 
    f.nome AS funcionario,
    d.nome AS departamento,
    e.nome AS empresa
FROM funcionarios f
RIGHT JOIN departamentos d ON f.departamento_id = d.id
RIGHT JOIN empresas e ON d.empresa_id = e.id;

-- ============================================
-- EXEMPLO 9: RIGHT JOIN com condição adicional
-- ============================================
SELECT 
    p.nome AS produto,
    c.nome AS categoria,
    c.descricao
FROM produtos p
RIGHT JOIN categorias c ON p.categoria_id = c.id
    AND p.ativo = TRUE;

-- ============================================
-- EXEMPLO 10: Pedidos e todos os status possíveis
-- ============================================
SELECT 
    s.nome AS status,
    COUNT(p.id) AS total_pedidos
FROM pedidos p
RIGHT JOIN status_pedido s ON p.status_id = s.id
GROUP BY s.id, s.nome;

-- ============================================
-- VISUALIZAÇÃO DO RIGHT JOIN:
-- ============================================
--
--     TABELA A          TABELA B
--    ┌───────┐         ┌───────┐
--    │   A   │         │███████│
--    │ ┌───┐─┼─────────┼─███┌──┤
--    │ │███│ │         │███│██│
--    │ └───┘─┼─────────┼─███└──┤
--    │       │         │███████│
--    └───────┘         └───────┘
--
--    RIGHT JOIN retorna tudo de B (███) + interseção com A
--    Registros de A sem correspondência em B não aparecem
--
-- ============================================

-- ============================================
-- RIGHT JOIN vs LEFT JOIN - QUAL USAR?
-- ============================================
-- 
-- Na prática, RIGHT JOIN é pouco usado porque:
-- 1. LEFT JOIN é mais intuitivo (tabela principal primeiro)
-- 2. Qualquer RIGHT JOIN pode ser reescrito como LEFT JOIN
-- 3. A maioria dos desenvolvedores prefere LEFT JOIN
--
-- Estas duas queries são equivalentes:
-- RIGHT JOIN: SELECT * FROM A RIGHT JOIN B ON A.id = B.a_id
-- LEFT JOIN:  SELECT * FROM B LEFT JOIN A ON B.a_id = A.id
--
-- ============================================

-- ============================================
-- QUANDO USAR RIGHT JOIN:
-- ============================================
-- 1. Quando faz mais sentido semântico na leitura
-- 2. Em queries complexas onde a ordem das tabelas importa
-- 3. Ao manter compatibilidade com código existente
-- 4. Raramente - prefira LEFT JOIN invertendo as tabelas
