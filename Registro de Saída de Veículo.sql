
-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria um procedimento que atualiza a data de saida e valor
DELIMITER $$
CREATE PROCEDURE atualizar_veiculo_saida (
IN p_id_veiculo INT,
IN p_data_saida DATETIME,
IN p_valor_pago DECIMAL(10,2)
)
BEGIN
UPDATE veiculos
SET data_saida = p_data_saida , valor_pago = calcular_valor(data_entrada, p_data_saida)
WHERE id = p_id_veiculo;
END $$
DELIMITER ;
-- Atualiza 
CALL atualizar_veiculo_saida(1, '2026-10-29 09:00:00', '16.00');
CALL atualizar_veiculo_saida(2, '2026-10-29 12:10:00', '32.00');
CALL atualizar_veiculo_saida(3, '2026-10-29 08:55:00', '8.00');

-- Confere a atualização.
SELECT * FROM veiculos;