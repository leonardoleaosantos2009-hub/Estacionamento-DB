-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria uma função que calcula o valor a pagar.
DELIMITER $$
CREATE FUNCTION calcular_valor (
p_data_entrada DATETIME,
p_data_saida DATETIME
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL
BEGIN
RETURN CEIL(TIMESTAMPDIFF(MINUTE, p_data_entrada, p_data_saida) / 60) * 8.00;
END $$
DELIMITER ;
-- Testa a função com 1 hora exata (resultado esperado: 8.00).
SELECT calcular_valor('2026-10-29 08:00:00', '2026-10-29 09:00:00');
-- Testa a função com 1 hora e 10 minutos (resultado esperado: 16.00).
SELECT calcular_valor('2026-10-29 08:00:00', '2026-10-29 09:10:00');
-- Calcula quanto cada veículo pagaria se saísse às 12:00.
SELECT
placa,
data_entrada,
calcular_valor(data_entrada, '2026-10-29 12:00:00') AS valor_previsto
FROM veiculos;
