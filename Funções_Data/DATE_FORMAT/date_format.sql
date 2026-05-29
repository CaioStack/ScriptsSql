-- ============================================================================
-- DATE_FORMAT - Formatacao de Datas
-- ============================================================================
-- 
-- DESCRICAO:
-- A funcao DATE_FORMAT() formata uma data de acordo com um padrao especificado.
-- Permite exibir datas em diferentes formatos para relatorios e interfaces.
--
-- SINTAXE BASICA:
-- MySQL: DATE_FORMAT(data, formato)
--
-- PRINCIPAIS CODIGOS DE FORMATO (MySQL):
-- %Y - Ano com 4 digitos (2024)
-- %y - Ano com 2 digitos (24)
-- %m - Mes com 2 digitos (01-12)
-- %c - Mes sem zero (1-12)
-- %M - Nome do mes (January)
-- %b - Nome abreviado do mes (Jan)
-- %d - Dia com 2 digitos (01-31)
-- %e - Dia sem zero (1-31)
-- %D - Dia com sufixo (1st, 2nd, 3rd)
-- %H - Hora 24h (00-23)
-- %h - Hora 12h (01-12)
-- %i - Minutos (00-59)
-- %s - Segundos (00-59)
-- %p - AM ou PM
-- %W - Nome do dia da semana (Sunday)
-- %a - Nome abreviado do dia (Sun)
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- EXEMPLO 1: Formato brasileiro (DD/MM/YYYY)
-- ----------------------------------------------------------------------------
-- Exibindo data no formato brasileiro

SELECT 
    data_pedido,
    DATE_FORMAT(data_pedido, '%d/%m/%Y') AS data_brasileira
FROM pedidos;

-- Resultado esperado:
-- | data_pedido | data_brasileira |
-- |-------------|-----------------|
-- | 2024-03-15  | 15/03/2024      |

-- ----------------------------------------------------------------------------
-- EXEMPLO 2: Formato americano (MM/DD/YYYY)
-- ----------------------------------------------------------------------------
-- Exibindo data no formato americano

SELECT 
    DATE_FORMAT(data_pedido, '%m/%d/%Y') AS data_americana
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 3: Data por extenso
-- ----------------------------------------------------------------------------
-- Exibindo data completa por extenso

SELECT 
    DATE_FORMAT(data_evento, '%W, %d de %M de %Y') AS data_extenso
FROM eventos;

-- Resultado: 'Friday, 15 de March de 2024'

-- ----------------------------------------------------------------------------
-- EXEMPLO 4: Data e hora formatadas
-- ----------------------------------------------------------------------------
-- Combinando data e hora

SELECT 
    DATE_FORMAT(data_hora, '%d/%m/%Y %H:%i:%s') AS data_hora_br,
    DATE_FORMAT(data_hora, '%d/%m/%Y as %H:%i') AS data_hora_texto
FROM logs;

-- Resultado: '15/03/2024 14:30:45', '15/03/2024 as 14:30'

-- ----------------------------------------------------------------------------
-- EXEMPLO 5: Hora em formato 12h
-- ----------------------------------------------------------------------------
-- Exibindo hora com AM/PM

SELECT 
    DATE_FORMAT(data_hora, '%h:%i %p') AS hora_12h
FROM reunioes;

-- Resultado: '02:30 PM'

-- ----------------------------------------------------------------------------
-- EXEMPLO 6: Apenas mes e ano
-- ----------------------------------------------------------------------------
-- Para agrupamentos mensais

SELECT 
    DATE_FORMAT(data_venda, '%Y-%m') AS mes_ano,
    DATE_FORMAT(data_venda, '%M/%Y') AS mes_nome_ano,
    SUM(valor) AS total
FROM vendas
GROUP BY DATE_FORMAT(data_venda, '%Y-%m'), DATE_FORMAT(data_venda, '%M/%Y');

-- ----------------------------------------------------------------------------
-- EXEMPLO 7: SQL Server - FORMAT
-- ----------------------------------------------------------------------------
-- Equivalente no SQL Server

-- SQL Server:
SELECT 
    FORMAT(data_pedido, 'dd/MM/yyyy') AS data_br,
    FORMAT(data_pedido, 'MMMM dd, yyyy') AS data_extenso,
    FORMAT(data_hora, 'dd/MM/yyyy HH:mm') AS data_hora
FROM pedidos;

-- CONVERT com estilos:
SELECT 
    CONVERT(VARCHAR, data_pedido, 103) AS data_br,  -- dd/mm/yyyy
    CONVERT(VARCHAR, data_pedido, 101) AS data_us   -- mm/dd/yyyy
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 8: PostgreSQL - TO_CHAR
-- ----------------------------------------------------------------------------
-- Equivalente no PostgreSQL

-- PostgreSQL:
SELECT 
    TO_CHAR(data_pedido, 'DD/MM/YYYY') AS data_br,
    TO_CHAR(data_pedido, 'Day, DD "de" Month "de" YYYY') AS data_extenso,
    TO_CHAR(data_hora, 'DD/MM/YYYY HH24:MI:SS') AS data_hora
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 9: Oracle - TO_CHAR
-- ----------------------------------------------------------------------------
-- Equivalente no Oracle

-- Oracle:
SELECT 
    TO_CHAR(data_pedido, 'DD/MM/YYYY') AS data_br,
    TO_CHAR(data_pedido, 'Day, DD "de" Month "de" YYYY') AS data_extenso
FROM pedidos;

-- ----------------------------------------------------------------------------
-- EXEMPLO 10: Formato ISO
-- ----------------------------------------------------------------------------
-- Padrao ISO 8601

SELECT 
    DATE_FORMAT(data_hora, '%Y-%m-%dT%H:%i:%s') AS iso_8601
FROM logs;

-- Resultado: '2024-03-15T14:30:45'

-- ============================================================================
-- DICAS E BOAS PRATICAS
-- ============================================================================
--
-- 1. DATE_FORMAT e especifica do MySQL - use equivalentes em outros SGBDs
-- 2. Nomes de mes/dia dependem da configuracao de locale do servidor
-- 3. Use formato ISO para APIs e integracao entre sistemas
-- 4. Formate na aplicacao quando possivel (melhor performance)
-- 5. Mantenha consistencia de formato em toda a aplicacao
--
-- ============================================================================
