-- Procedimento para atualizar proprietários

-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria um procedimento que atualiza o telefone de um proprietário.
DELIMITER $$
CREATE PROCEDURE atualizar_proprietario (
IN p_id INT,
IN p_telefone VARCHAR(20)
)
BEGIN
UPDATE proprietarios
SET telefone = p_telefone
WHERE id = p_id;
END $$
DELIMITER ;
-- Atualiza o telefone da proprietária de ID 2.
CALL atualizar_proprietario(2, '(14) 99100-5566');
-- Confere a atualização.
SELECT * FROM proprietarios;

-- Desafio 2

-- Procedimento para atualizar veículos
-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria um procedimento que atualiza a placa de um veículo.
DELIMITER $$
CREATE PROCEDURE atualizar_veiculos (
IN p_id INT,
IN p_placa VARCHAR(10)
)
BEGIN
UPDATE veiculos
SET placa = p_placa
WHERE id = p_id;
END $$
DELIMITER ;
-- Atualiza a placa do veículo de ID 3.
CALL atualizar_veiculos(3, 'IJK7L98');
-- Confere a atualização.
SELECT * FROM veiculos;