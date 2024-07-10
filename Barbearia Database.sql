CREATE DATABASE Barbearia;
USE Barbearia;

CREATE TABLE Cliente(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(45) NOT NULL UNIQUE,
    cpf VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE Barbeiro(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE
);


CREATE TABLE Cabelo(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco FLOAT NOT NULL
);

CREATE TABLE Barba(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco FLOAT NOT NULL
);

CREATE TABLE Outros(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco FLOAT NOT NULL
);

CREATE TABLE Agendamento(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    barbeiro_id INT NOT NULL,
    cabelo_id INT NOT NULL,
    barba_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (barbeiro_id) REFERENCES Barbeiro(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (cabelo_id) REFERENCES Cabelo(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (barba_id) REFERENCES Barba(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Agendamento_Outros(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    agendamento_id INT NOT NULL,
    outros_id INT NOT NULL,
    FOREIGN KEY (agendamento_id) REFERENCES Agendamento(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (outros_id) REFERENCES Outros(id)
		ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Cliente(nome, telefone, cpf)
VALUES
	("Jozezinho", "+55 48 51457846", "14578465982"),
    ("Fulaninho", "+55 48 84751325", "54876215324"),
    ("Ciclanihno", "+55 48 74812456", "23456784215");
    
INSERT INTO Barbeiro(nome, cpf)
VALUES
	("Qualquer um", ""),
	("Roberto", "53468754218"),
    ("Gleyson", "42157846235"),
    ("Neymar", "53157846821");
    
INSERT INTO Cabelo(nome, preco)
VALUES
	("Nenhum", 0),
	("Americano", 30),
    ("Mid Fade", 30),
    ("Low Fade", 30);
    
INSERT INTO Barba(nome, preco)
VALUES
	("Nenhum", 0),
	("Lenhador", 40),
    ("Cavanhaque", 25),
    ("Alinhamento", 20);
    
INSERT INTO Outros(nome, preco)
VALUES
	("Nenhum", 0),
	("Sobrancelha", 10),
    ("Corte Navalhado", 10),
    ("Tirar pelos do nariz e orelhas", 5);

INSERT INTO Agendamento(data_hora, cliente_id, barbeiro_id, cabelo_id, barba_id)
VALUES
	(NOW(), 1, 3, 3, 1),
    ("2024-07-31 13:00:00", 2, 1, 1, 2),
    ("2024-07-28 14:30:00", 3, 2, 4, 4);
    
    
INSERT INTO Agendamento_Outros(agendamento_id, outros_id)
VALUES
	(1, 2),
    (2, 1),
    (3, 3),
    (3, 2),
    (3, 4);
    
SELECT Cliente.nome Nome, Cliente.telefone Telefone, Barbeiro.nome Barbeiro, Cabelo.nome Cabelo, Cabelo.preco Preço, Barba.nome Barba, Barba.preco Preço, GROUP_CONCAT(Outros.nome) Outros, SUM(Outros.preco) Preço, (Cabelo.preco + Barba.preco + SUM(Outros.preco)) Total, Agendamento.data_hora "Data/Hora" FROM Cliente
INNER JOIN Agendamento
ON Cliente.id = Agendamento.cliente_id
INNER JOIN Barbeiro
ON Barbeiro.id = Agendamento.barbeiro_id
INNER JOIN Cabelo
ON Agendamento.cabelo_id = Cabelo.id
INNER JOIN Barba
ON Agendamento.barba_id = Barba.id
INNER JOIN Agendamento_Outros
ON Agendamento.id = Agendamento_Outros.agendamento_id
INNER JOIN Outros
ON Agendamento_Outros.outros_id = Outros.id
GROUP BY Agendamento.id;





    

    

    






