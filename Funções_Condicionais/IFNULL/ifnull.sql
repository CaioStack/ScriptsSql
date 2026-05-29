-- ============================================================================
-- IFNULL - Tratamento de Valores NULL (MySQL/MariaDB)
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao IFNULL() verifica se uma expressao e NULL e retorna um valor
-- alternativo caso seja. E uma forma simples e direta de substituir valores
-- nulos por um valor padrao, evitando exibicao de NULL em resultados.
--
-- SINTAXE BASICA:
-- IFNULL(expressao, valor_se_null)
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
-- - MySQL/MariaDB: IFNULL(expr, valor)
-- - SQL Server: ISNULL(expr, valor)
-- - PostgreSQL: COALESCE(expr, valor)
-- - Oracle: NVL(expr, valor)
--
-- IMPORTANTE: IFNULL e especifico do MySQL. Para portabilidade entre
-- diferentes bancos de dados, use COALESCE (padrao SQL ANSI).
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Uso basico - Substituindo NULL
-- ----------------------------------------------------------------------------
-- Exibindo "Nao informado" quando email for NULL

SELECT 
    nome,
    email,
    IFNULL(email, 'Nao informado') AS email_display
FROM clientes;

-- Resultado esperado:
-- | nome        | email            | email_display    |
-- |-------------|------------------|------------------|
-- | Maria Silva | maria@email.com  | maria@email.com  |
-- | Joao Santos | NULL             | Nao informado    |
-- | Ana Lima    | ana@email.com    | ana@email.com    |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Valores numericos
-- ----------------------------------------------------------------------------
-- Substituindo NULL por zero em calculos

SELECT 
    produto,
    preco,
    quantidade,
    IFNULL(desconto, 0) AS desconto,
    preco * quantidade * (1 - IFNULL(desconto, 0)) AS total
FROM itens_pedido;

-- Sem IFNULL, qualquer operacao com NULL resulta em NULL!
-- 100 * 2 * (1 - NULL) = NULL
-- 100 * 2 * (1 - 0) = 200

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Em calculos agregados
-- ----------------------------------------------------------------------------
-- Somando valores tratando NULL como zero

SELECT 
    SUM(IFNULL(bonus, 0)) AS total_bonus,
    AVG(IFNULL(bonus, 0)) AS media_bonus
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Concatenacao segura
-- ----------------------------------------------------------------------------
-- Evitando que NULL "quebre" a concatenacao

SELECT 
    CONCAT(
        primeiro_nome, 
        ' ', 
        IFNULL(nome_meio, ''),
        ' ',
        sobrenome
    ) AS nome_completo
FROM pessoas;

-- Sem IFNULL, se nome_meio for NULL, todo o CONCAT retorna NULL em alguns SGBDs

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: IFNULL com subquery
-- ----------------------------------------------------------------------------
-- Valor padrao quando subquery retorna NULL

SELECT 
    p.nome,
    IFNULL(
        (SELECT AVG(nota) FROM avaliacoes WHERE produto_id = p.id),
        0
    ) AS media_avaliacoes
FROM produtos p;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: IFNULL em UPDATE
-- ----------------------------------------------------------------------------
-- Atualizando apenas valores NULL

UPDATE clientes
SET telefone = IFNULL(telefone, 'Nao cadastrado')
WHERE telefone IS NULL;

-- Ou definindo valor padrao durante atualizacao:
UPDATE produtos
SET estoque_minimo = IFNULL(estoque_minimo, 10);

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: IFNULL aninhado
-- ----------------------------------------------------------------------------
-- Verificando multiplas colunas em cascata

SELECT 
    nome,
    IFNULL(telefone_celular, 
        IFNULL(telefone_residencial, 
            IFNULL(telefone_comercial, 'Sem telefone')
        )
    ) AS telefone_contato
FROM contatos;

-- Melhor usar COALESCE para multiplos valores:
SELECT 
    nome,
    COALESCE(telefone_celular, telefone_residencial, telefone_comercial, 'Sem telefone') AS telefone_contato
FROM contatos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: IFNULL com datas
-- ----------------------------------------------------------------------------
-- Tratando datas nulas

SELECT 
    nome_tarefa,
    data_inicio,
    IFNULL(data_conclusao, 'Em andamento') AS status_conclusao
FROM tarefas;

-- Para retornar data atual se NULL:
SELECT 
    nome_tarefa,
    IFNULL(data_conclusao, CURDATE()) AS data_conclusao_efetiva
FROM tarefas;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: IFNULL em ORDER BY
-- ----------------------------------------------------------------------------
-- Ordenando com tratamento de NULL

SELECT *
FROM produtos
ORDER BY IFNULL(data_promocao, '9999-12-31');

-- NULL vai para o final da ordenacao

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Comparacao com outras funcoes
-- ----------------------------------------------------------------------------
-- IFNULL vs COALESCE vs IF

-- IFNULL - apenas 2 argumentos:
SELECT IFNULL(valor, 0) FROM tabela;

-- COALESCE - multiplos argumentos (padrao ANSI):
SELECT COALESCE(valor1, valor2, valor3, 0) FROM tabela;

-- IF - mais verboso:
SELECT IF(valor IS NULL, 0, valor) FROM tabela;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. IFNULL e especifico do MySQL - use COALESCE para portabilidade
-- 2. Sempre trate NULL em calculos matematicos (NULL + 10 = NULL)
-- 3. Use em relatorios para evitar exibir "NULL" ao usuario
-- 4. Para multiplas colunas alternativas, prefira COALESCE
-- 5. IFNULL so aceita 2 argumentos, diferente de COALESCE
-- 6. O tipo de retorno segue o tipo do primeiro argumento
--
-- ============================================================================
