-- ============================================================================
-- NOW - Data e Hora Atual
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao NOW() retorna a data e hora atuais do servidor de banco de dados.
-- E amplamente utilizada para registrar timestamps de criacao, atualizacao,
-- e para calculos envolvendo o momento presente.
--
-- SINTAXE BASICA:
-- NOW()
--
-- RETORNO:
-- - DATETIME ou TIMESTAMP com data e hora atuais
-- - Formato tipico: 'YYYY-MM-DD HH:MM:SS'
--
-- COMPATIBILIDADE:
-- - MySQL: NOW(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP()
-- - PostgreSQL: NOW(), CURRENT_TIMESTAMP
-- - SQL Server: GETDATE(), CURRENT_TIMESTAMP, SYSDATETIME()
-- - Oracle: SYSDATE, SYSTIMESTAMP, CURRENT_TIMESTAMP
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Obtendo data e hora atual
-- ----------------------------------------------------------------------------
-- Retornando o momento atual

SELECT NOW() AS data_hora_atual;

-- Resultado esperado:
-- | data_hora_atual     |
-- |---------------------|
-- | 2024-03-15 14:30:45 |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Registrando data de criacao
-- ----------------------------------------------------------------------------
-- Inserindo registro com timestamp automatico

INSERT INTO pedidos (cliente_id, valor_total, data_criacao)
VALUES (1, 150.00, NOW());

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Definindo valor padrao na tabela
-- ----------------------------------------------------------------------------
-- Criando tabela com timestamp automatico

CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(500),
    data_registro DATETIME DEFAULT NOW()
);

-- Em SQL Server:
CREATE TABLE logs (
    id INT IDENTITY PRIMARY KEY,
    mensagem VARCHAR(500),
    data_registro DATETIME DEFAULT GETDATE()
);

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Calculando idade de registros
-- ----------------------------------------------------------------------------
-- Encontrando registros das ultimas 24 horas

SELECT *
FROM pedidos
WHERE data_criacao >= NOW() - INTERVAL 24 HOUR;

-- Em SQL Server:
SELECT *
FROM pedidos
WHERE data_criacao >= DATEADD(hour, -24, GETDATE());

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Atualizando campo de modificacao
-- ----------------------------------------------------------------------------
-- Registrando quando o registro foi alterado

UPDATE produtos
SET 
    preco = 199.99,
    data_modificacao = NOW()
WHERE id = 1;

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Comparando com datas
-- ----------------------------------------------------------------------------
-- Verificando se promocao esta ativa

SELECT *
FROM promocoes
WHERE data_inicio <= NOW() AND data_fim >= NOW();

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: Variacoes por SGBD
-- ----------------------------------------------------------------------------

-- MySQL / PostgreSQL:
SELECT NOW() AS agora;

-- SQL Server:
SELECT GETDATE() AS agora;
SELECT SYSDATETIME() AS agora_precisao; -- Maior precisao

-- Oracle:
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

-- Padrao ANSI (funciona na maioria):
SELECT CURRENT_TIMESTAMP AS agora;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: NOW() em expressoes
-- ----------------------------------------------------------------------------
-- Calculando prazo de entrega

SELECT 
    id_pedido,
    NOW() AS data_atual,
    NOW() + INTERVAL 5 DAY AS previsao_entrega
FROM pedidos;

-- SQL Server:
SELECT 
    id_pedido,
    GETDATE() AS data_atual,
    DATEADD(day, 5, GETDATE()) AS previsao_entrega
FROM pedidos;

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. NOW() retorna a hora do servidor, considere fusos horarios
-- 2. Use CURRENT_TIMESTAMP para maior portabilidade entre SGBDs
-- 3. Para apenas data, use CURDATE() (MySQL) ou CAST(GETDATE() AS DATE)
-- 4. NOW() e avaliado uma vez por statement em transacoes
-- 5. Considere usar UTC para aplicacoes globais
--
-- ============================================================================
