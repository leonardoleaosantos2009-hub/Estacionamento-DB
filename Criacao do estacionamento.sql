-- Cria a base de dados.
DROP DATABASE IF EXISTS estacionamento_db;
CREATE DATABASE estacionamento_db;
-- Define o uso da base de dados.
USE estacionamento_db;
-- Cria a tabela de proprietários.
CREATE TABLE proprietarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(15) NOT NULL UNIQUE,
telefone VARCHAR(20) NOT NULL
);
-- Cria a tabela de veículos.
CREATE TABLE veiculos (
id INT AUTO_INCREMENT PRIMARY KEY,
id_proprietario INT NOT NULL,
placa VARCHAR(10) NOT NULL UNIQUE,
modelo VARCHAR(50) NOT NULL,
cor VARCHAR(25) NOT NULL,
data_entrada DATETIME NOT NULL,
data_saida DATETIME NULL,
valor_pago DECIMAL(10,2) NULL,
-- Chave estrangeira que conecta os veículos aos proprietários.
FOREIGN KEY (id_proprietario) REFERENCES proprietarios(id)
);