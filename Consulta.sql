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
