-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria um procedimento que cadastra um proprietário.
DELIMITER $$
CREATE PROCEDURE cadastrar_proprietario (
IN p_nome VARCHAR(100),
IN p_cpf VARCHAR(15),
IN p_telefone VARCHAR(20)
)
BEGIN
INSERT INTO proprietarios (nome, cpf, telefone)
VALUES (p_nome, p_cpf, p_telefone);
END $$
DELIMITER ;
-- Cadastra 3 proprietários.
CALL cadastrar_proprietario('Roberto Almeida', '123.456.789-01', '(14) 99811-2233');
CALL cadastrar_proprietario('Patrícia Gomes', '234.567.890-12', '(14) 99722-3344');
CALL cadastrar_proprietario('Sérgio Moraes', '345.678.901-23', '(14) 99633-4455');
-- Confere os proprietários cadastrados.
SELECT * FROM proprietarios;

-- Desafio 1 

DELIMITER $$
CREATE PROCEDURE cadastrar_veiculos (
IN p_id_proprietario INT,
IN p_placa VARCHAR(10),
IN p_modelo VARCHAR(50),
IN p_cor VARCHAR(25),
IN p_data_entrada DATETIME
)
BEGIN
INSERT INTO veiculos (id_proprietario, placa, modelo, cor, data_entrada)
VALUES (p_id_proprietario, p_placa, p_modelo, p_cor, p_data_entrada);
END $$
DELIMITER ;
-- Cadastra 3 proprietários.
CALL cadastrar_veiculos(1, 'ABC1D23', 'Fiat Argo', 'Prata', '2026-10-29 07:45:00');
CALL cadastrar_veiculos(2, 'EFG4H56', 'Honda Civic', 'Preto', '2026-10-29 08:10:00');
CALL cadastrar_veiculos(3, 'IJK7L89', 'Volkswagen Gol', 'Branco', '2026-10-29 08:30:00');
CALL cadastrar_veiculos(1, 'MNO2P34', 'Jeep Renegade', 'Vermelho', '2026-10-29 09:05:00');
-- Confere os proprietários cadastrados.
SELECT * FROM veiculos;
