CREATE TABLE Funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR(50) NOT null,
cpf CHAR(11) NOT NULL unique,
celular CHAR(11) NOT null
)

CREATE TABLE Equipamento(
idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
nomeEquipamento VARCHAR(50) NOT null,
qtd INT NOT NULL,
valorHora DECIMAL(5,2) NOT null
)

CREATE TABLE Cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
NomeCliente VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL unique
)

CREATE TABLE Aluguel(
idAluguel INT PRIMARY KEY AUTO_INCREMENT,
idCliente INT NOT NULL,
idFuncionario INT NOT NULL,
dataHoraRetirada DATETIME NOT null,
dataHoraDevolucao DATETIME,
valorAPagar DECIMAL(10,2),
valorPago DECIMAL(10,2),
pago BIT,
formaPagamento VARCHAR(50),
qtVezes INT,
CONSTRAINT fk_Aluguel_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
CONSTRAINT fk_Aluguel_Funcionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario),
CONSTRAINT ck_formaPagamento CHECK (formaPagamento IN ('DINHEIRO','PIX','DÉBITO','CRÉDITO','OUTROS'))
)

CREATE TABLE AluguelEquipamento(
idAluguelEquipamento INT PRIMARY KEY AUTO_INCREMENT,
idEquipamento INT NOT NULL,
idAluguel INT NOT NULL,
valorItem DECIMAL(10,2) NOT NULL,
valorUnitario DECIMAL(10,2) NOT NULL,
qtd INT,
CONSTRAINT fk_AluguelEquipamento_Equipamento FOREIGN KEY (idEquipamento) REFERENCES equipamento (idEquipamento),
CONSTRAINT fk_AluguelEquipamento_Aluguel FOREIGN KEY (idAluguel) REFERENCES Aluguel (idAluguel)
)

ALTER TABLE cliente 
ADD email VARCHAR(100), 
ADD cidade CHAR(50) NOT NULL, 
ADD estado CHAR(2) NOT null, 
ADD tipoLogradouro VARCHAR(30) NOT NULL, 
ADD nomeLogradouro VARCHAR(50) NOT NULL, 
ADD numero VARCHAR(6) NOT NULL, 
ADD complemento VARCHAR(30);





INSERT INTO cliente 
(nomeCliente, cpf, email, cidade, estado, tipoLogradouro, nomeLogradouro, numero, complemento)
VALUES
('Donald', '1111111111155', 'donald@uol.com', 'Santos', 'SP', 'Rua', 'Joaquim Tavora', '100', NULL),

('Margarida', '2222222222277', 'margarina@uol.com', 'São Vicente', 'SP', 'Avenida', 'Presidente Wilson', '101', 'apto 11'),

('Patinhas', '3333333333388', 'patinhas@uol.com', 'Florianópolis', 'SC', 'Rua', 'das praias', '102', NULL),

('Huguinho', '4444444444499', 'huguinho@gmail.com', 'Santos', 'SP', 'Rua', 'Frei Vital', '12', 'apto 11'),

('Luizinho', '5555555555500', 'luizinho@gmail.com', 'Praia Grande', 'SP', 'Rua', 'Londrina', '104', 'apto 05'),

('Zezinho', '6666666666604', 'zezinho@gmail.com', 'São Vicente', 'SP', 'Avenida', 'Manoel da Nóbrega', '105', NULL),

('Pardal', '7777777777705', 'pardal@uol.com', 'Santos', 'SP', 'Avenida', 'Pedro Lessa', '1006', NULL),

('Zé Carioca', '8888888888807', null, 'Rio de Janeiro', 'RJ', 'Rua', 'Peteco Peteco', '107', NULL),

('Mickey', '9999999999908', 'michey@hotmail.com', 'Recife', 'PE', 'Rua', 'das ostras', '108', 'apto 03');


ALTER TABLE cliente
ALTER COLUMN email VARCHAR(100) NULL;

ALTER TABLE cliente
MODIFY cidade CHAR(50) NULL,
MODIFY estado CHAR(2) NULL,
MODIFY tipoLogradouro VARCHAR(30) NULL,
MODIFY nomeLogradouro VARCHAR(50) NULL,
MODIFY numero VARCHAR(6) NULL,
MODIFY complemento VARCHAR(30) NULL;

INSERT INTO cliente 
(nomeCliente, cpf, email, cidade, estado, tipoLogradouro, nomeLogradouro, numero, complemento)
VALUES

('Minie', '10101010101', 'minie@gmail.com', 'Recife', 'PE', NULL, NULL, NULL, NULL),

('Pateta', '20202020202', 'pateta@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL),

('Branca de Neve', '30303030303', 'brancadeneve@hotmail.com', 'São Joaquim', 'SC', NULL, NULL, NULL, NULL),

('Aladin', '40404040404', 'aladin@gmail.com', 'Belém', 'PA', NULL, NULL, NULL, NULL),

('Cinderela', '50505050505', 'cinderela@hotmail.com', 'Goiania', 'GO', NULL, NULL, NULL, 'Mora em casa'),

('Mulan', '60606060606', 'mulan@gmail.com', 'Rio das Ostras', 'RJ', NULL, NULL, NULL, NULL),

('Moana', '70707070707', 'moana@gmail.com', 'Parati', 'RJ', NULL, NULL, NULL, NULL),

('Asnésio', '80808080808', 'asnesio@uol.com', 'Belo Horizonte', 'MG', NULL, NULL, NULL, NULL),

('Maga Patalógica', '90909090909', 'magapatalogica@gmail.com', 'Cubatão', 'SP', NULL, NULL, NULL, NULL),

('Capitão Boeing', '11122233344', 'capitaoboeing@uol.com', 'Manaus', 'AM', NULL, NULL, NULL, 'Mora em casa'),

('Pão Duro Mac Money', '12121212121', 'paoduromacmoney@ig.com', 'Osasco', 'SP', NULL, NULL, NULL, NULL);



INSERT INTO Funcionario
(nomeFuncionario, cpf, celular)
VALUES
('Cebolinha', '12345678901', '13987654321'),

('Cascão', '23456789012', '13976543210'),

('Chico Bento', '34567890123', '13965432109');


INSERT INTO Equipamento (nomeEquipamento, qtd, valorHora)
VALUES
('Cadeira 02 posições', 50, 2.00),
('Cadeira 04 posições', 100, 3.50),
('Guarda Sol P', 40, 2.00),
('Guarda Sol G', 60, 3.00),
('Mesinha', 30, 1.50)

INSERT INTO aluguel 
(idCliente, idFuncionario, dataHoraRetirada, valorAPagar, valorPago, pago)
VALUES
(20, 1, '2024-12-08 08:00:00', 2.00, 0, 0)

UPDATE Equipamento
SET qtd = qtd - 1
WHERE nomeEquipamento='Cadeira 02 posições';

INSERT INTO aluguel 
(idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(18, 3, '2024-12-10 00:00:00', 0)


INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 2, 3.00, 3.50, 1)

UPDATE Equipamento
SET qtd = qtd - 1
WHERE idEquipamento=4;

UPDATE Equipamento
SET qtd = qtd - 2
WHERE idEquipamento=2;

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(1, 1, 2.00, 2.00, 1)


INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 2, 7.00, 3.50, 2)

INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(10, 1, '2024-12-24 00:00:00', 0)
/*Cebolinha alugou pro Donald*/

INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(11, 1, '2024-12-24 00:00:00', 0)
/*Cebolinha alugou pra Margarida*/

INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(13, 1, '2024-12-24 00:00:00', 0)
/*Cebolinha alugou pro Huguinho*/

UPDATE Equipamento
SET qtd = qtd - 3
WHERE idEquipamento=3;

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(3, 3, 2.00, 2.00, 1)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(3, 4, 2.00, 2.00, 1)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(3, 5, 2.00, 2.00, 1)

UPDATE aluguelequipamento 
SET idAluguel =5
WHERE idAluguelEquipamento=6

/* parte 9 */

/*Chico aluga para o aladin gera o idAluguel 6)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(22, 3, '2024-12-28 15:00:00',0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 6, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 6, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4


/*Chico aluga para a Cinderela gera o idAluguel 7)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(23, 3, '2024-12-28 16:00:00', 0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 7, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 7, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4

/*Chico aluga para a Mulan gera o idAluguel 8)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(24, 3, '2024-12-28 17:00:00', 0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 8, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 8, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4

/*Chico aluga para a Zezinho gera o idAluguel 9)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(15, 3, '2024-12-28 13:00:00', 0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 9, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 9, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4

/*Chico aluga para o Asnésio gera o idAluguel 10)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(26, 3, '2024-12-28 13:35:00', 0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 10, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 10, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4

/*Chico aluga para a Moana gera o idAluguel 11)*/
INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(25, 3, '2024-12-28 13:35:00', 0)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(2, 11, 7.00, 3.50, 2)

INSERT INTO AluguelEquipamento
(idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(4, 11, 3.00, 3.00, 1)

UPDATE equipamento 
SET qtd = qtd -2
WHERE idEquipamento = 2

UPDATE equipamento 
SET qtd = qtd -1
WHERE idEquipamento = 4


SELECT * FROM equipamento

SELECT * FROM aluguel

SELECT * FROM aluguelequipamento

SELECT * FROM funcionario

SELECT * FROM cliente

/* Parte 10*/

SELECT nomeCliente, email FROM cliente

/*Parte 11*/

SELECT nomeFuncionario, celular FROM funcionario

/*Parte 12*/

SELECT * FROM aluguel ORDER BY  dataHoraRetirada

/*Parte 13*/

SELECT nomeCliente, cidade, estado 
FROM cliente 
WHERE cidade IN ('Santos', 'São Vicente', 'Praia Grande', 'Cubatão') 
ORDER BY nomeCliente

/*Parte 14*/

SELECT nomeEquipamento, qtd FROM equipamento

/*Parte 15*/

SELECT nomeCliente, cidade, estado 
FROM cliente 
WHERE complemento is NULL 
ORDER BY NomeCliente

/*Parte 16*/

SELECT nomeCliente, estado 
FROM cliente 
WHERE estado <> 'SP'

/*Parte 17*/

SELECT nomeCliente 
FROM cliente
WHERE nomeCliente LIKE 'A%'

/*Parte 18*/

SELECT nomeCliente
FROM cliente
WHERE nomeCliente LIKE 'M%' AND estado = 'PE'

/*Parte 19 */

SELECT nomeEquipamento, qtd
FROM equipamento
WHERE nomeEquipamento LIKE 'CADEIRA%'
ORDER BY qtd DESC

/*Parte 20*/

SELECT * 
FROM aluguel
WHERE dataHoraRetirada BETWEEN '2024-12-25 00:00:00' AND '2024-12-31 23:59:59'
ORDER BY dataHoraRetirada ASC

