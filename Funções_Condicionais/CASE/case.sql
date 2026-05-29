-- ============================================================================
-- CASE - Expressao Condicional
-- ============================================================================
-- 
-- DESCRICAO:
-- O CASE e uma expressao condicional que permite executar logica if-then-else
-- dentro de uma consulta SQL. Retorna valores diferentes com base em condicoes
-- avaliadas sequencialmente.
--
-- SINTAXE BASICA:
--
-- Forma Simples (comparacao de igualdade):
-- CASE expressao
--     WHEN valor1 THEN resultado1
--     WHEN valor2 THEN resultado2
--     ELSE resultado_padrao
-- END
--
-- Forma Pesquisada (condicoes complexas):
-- CASE
--     WHEN condicao1 THEN resultado1
--     WHEN condicao2 THEN resultado2
--     ELSE resultado_padrao
-- END
--
-- COMPATIBILIDADE:
-- - Disponivel em todos os principais SGBDs (padrao SQL)
-- - MySQL, PostgreSQL, SQL Server, Oracle: mesma sintaxe
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: CASE simples
-- ----------------------------------------------------------------------------
-- Traduzindo codigos para descricoes

SELECT 
    id_pedido,
    status,
    CASE status
        WHEN 'P' THEN 'Pendente'
        WHEN 'A' THEN 'Aprovado'
        WHEN 'E' THEN 'Enviado'
        WHEN 'C' THEN 'Cancelado'
        ELSE 'Desconhecido'
    END AS status_descricao
FROM pedidos;

-- Resultado esperado:
-- | id_pedido | status | status_descricao |
-- |-----------|--------|------------------|
-- | 1         | P      | Pendente         |
-- | 2         | A      | Aprovado         |
-- | 3         | E      | Enviado          |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: CASE pesquisado (com condicoes)
-- ----------------------------------------------------------------------------
-- Categorizando valores

SELECT 
    nome,
    salario,
    CASE
        WHEN salario < 3000 THEN 'Junior'
        WHEN salario >= 3000 AND salario < 7000 THEN 'Pleno'
        WHEN salario >= 7000 AND salario < 12000 THEN 'Senior'
        ELSE 'Especialista'
    END AS nivel
FROM funcionarios;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: CASE em ORDER BY
-- ----------------------------------------------------------------------------
-- Ordenacao personalizada

SELECT *
FROM tarefas
ORDER BY 
    CASE prioridade
        WHEN 'Alta' THEN 1
        WHEN 'Media' THEN 2
        WHEN 'Baixa' THEN 3
        ELSE 4
    END;

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: CASE com agregacao
-- ----------------------------------------------------------------------------
-- Contagem condicional (pivot simples)

SELECT 
    YEAR(data_venda) AS ano,
    SUM(CASE WHEN MONTH(data_venda) = 1 THEN valor ELSE 0 END) AS janeiro,
    SUM(CASE WHEN MONTH(data_venda) = 2 THEN valor ELSE 0 END) AS fevereiro,
    SUM(CASE WHEN MONTH(data_venda) = 3 THEN valor ELSE 0 END) AS marco
FROM vendas
GROUP BY YEAR(data_venda);

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: CASE em UPDATE
-- ----------------------------------------------------------------------------
-- Atualizacao condicional

UPDATE produtos
SET desconto = 
    CASE
        WHEN estoque > 100 THEN 0.20
        WHEN estoque > 50 THEN 0.10
        WHEN estoque > 20 THEN 0.05
        ELSE 0
    END;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: CASE aninhado
-- ----------------------------------------------------------------------------
-- Multiplos niveis de condicao

SELECT 
    nome,
    tipo,
    valor,
    CASE tipo
        WHEN 'produto' THEN 
            CASE
                WHEN valor > 1000 THEN 'Produto Premium'
                ELSE 'Produto Padrao'
            END
        WHEN 'servico' THEN 'Servico'
        ELSE 'Outro'
    END AS categoria
FROM itens;

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: CASE com NULL
-- ----------------------------------------------------------------------------
-- Tratando valores nulos

SELECT 
    nome,
    telefone,
    CASE 
        WHEN telefone IS NULL THEN 'Nao informado'
        ELSE telefone
    END AS telefone_display
FROM clientes;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: CASE para calculos condicionais
-- ----------------------------------------------------------------------------
-- Aplicando regras de negocio

SELECT 
    id_pedido,
    valor_bruto,
    CASE
        WHEN tipo_cliente = 'VIP' THEN valor_bruto * 0.9      -- 10% desconto
        WHEN tipo_cliente = 'Premium' THEN valor_bruto * 0.95 -- 5% desconto
        ELSE valor_bruto
    END AS valor_final
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: CASE com funcoes
-- ----------------------------------------------------------------------------
-- Combinando com outras funcoes

SELECT 
    nome,
    data_nascimento,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 18 THEN 'Menor de idade'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 60 THEN 'Adulto'
        ELSE 'Idoso'
    END AS faixa_etaria
FROM clientes;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. Sempre inclua ELSE para tratar casos nao previstos
-- 2. A ordem dos WHEN importa - primeiro match e retornado
-- 3. Use CASE simples para igualdade, pesquisado para ranges
-- 4. CASE pode ser usado em SELECT, WHERE, ORDER BY, UPDATE
-- 5. Evite CASE muito complexos - considere criar funcoes ou views
--
-- ============================================================================
