-- ============================================================================
-- SUBQUERY - Subconsultas / Consultas Aninhadas
-- ============================================================================
-- 
-- DESCRICAO:
-- Uma SUBQUERY (subconsulta) e uma consulta SQL inserida dentro de outra
-- consulta. Pode ser usada em SELECT, FROM, WHERE, HAVING, INSERT, UPDATE
-- e DELETE. Permite criar consultas complexas de forma modular.
--
-- TIPOS DE SUBQUERY:
-- 1. Escalar: Retorna um unico valor
-- 2. Linha: Retorna uma linha com multiplas colunas
-- 3. Tabela: Retorna multiplas linhas e colunas
-- 4. Correlacionada: Referencia colunas da consulta externa
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Subquery escalar no SELECT
-- ----------------------------------------------------------------------------
-- Retornando um valor calculado

SELECT 
    nome,
    salario,
    (SELECT AVG(salario) FROM funcionarios) AS media_geral,
    salario - (SELECT AVG(salario) FROM funcionarios) AS diferenca_media
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Subquery no WHERE
-- ----------------------------------------------------------------------------
-- Filtrando com base em outra consulta

-- Funcionarios com salario acima da media:
SELECT nome, salario
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);

-- Clientes que fizeram pedidos:
SELECT *
FROM clientes
WHERE id IN (SELECT DISTINCT cliente_id FROM pedidos);

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Subquery no FROM (Derived Table)
-- ----------------------------------------------------------------------------
-- Usando resultado como tabela temporaria

SELECT 
    departamento,
    AVG(total_vendas) AS media_vendas_vendedores
FROM (
    SELECT 
        vendedor_id,
        departamento,
        SUM(valor) AS total_vendas
    FROM vendas
    GROUP BY vendedor_id, departamento
) AS vendas_por_vendedor
GROUP BY departamento;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Subquery correlacionada
-- ----------------------------------------------------------------------------
-- Referenciando a consulta externa

-- Funcionarios com maior salario em cada departamento:
SELECT f1.nome, f1.departamento, f1.salario
FROM funcionarios f1
WHERE f1.salario = (
    SELECT MAX(f2.salario)
    FROM funcionarios f2
    WHERE f2.departamento = f1.departamento
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Subquery com EXISTS
-- ----------------------------------------------------------------------------
-- Verificando existencia de registros relacionados

SELECT c.nome, c.email
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
    AND p.data_pedido >= '2024-01-01'
);

-- Clientes SEM pedidos:
SELECT c.nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Subquery com ANY/SOME
-- ----------------------------------------------------------------------------
-- Comparando com qualquer valor retornado

SELECT *
FROM produtos
WHERE preco > ANY (
    SELECT preco FROM produtos WHERE categoria = 'Eletronicos'
);

-- Preco maior que QUALQUER produto da categoria Eletronicos

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Subquery com ALL
-- ----------------------------------------------------------------------------
-- Comparando com todos os valores retornados

SELECT *
FROM produtos
WHERE preco > ALL (
    SELECT preco FROM produtos WHERE categoria = 'Eletronicos'
);

-- Preco maior que TODOS os produtos da categoria Eletronicos

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: Subquery em INSERT
-- ----------------------------------------------------------------------------
-- Inserindo dados de outra consulta

INSERT INTO clientes_vip (nome, email, total_compras)
SELECT nome, email, total_compras
FROM clientes
WHERE total_compras > 10000;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Subquery em UPDATE
-- ----------------------------------------------------------------------------
-- Atualizando com base em outra tabela

UPDATE produtos p
SET preco = preco * 1.10
WHERE categoria_id IN (
    SELECT id FROM categorias WHERE nome = 'Importados'
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Subquery em DELETE
-- ----------------------------------------------------------------------------
-- Deletando com base em outra tabela

DELETE FROM logs
WHERE usuario_id NOT IN (
    SELECT id FROM usuarios WHERE ativo = 1
);

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Subqueries correlacionadas podem ser lentas (executam para cada linha)
-- 2. Considere usar JOINs quando possivel (geralmente mais eficientes)
-- 3. Use alias para subqueries no FROM (obrigatorio na maioria dos SGBDs)
-- 4. EXISTS e geralmente mais eficiente que IN para grandes conjuntos
-- 5. Teste performance comparando subquery vs JOIN
--
-- ============================================================================
