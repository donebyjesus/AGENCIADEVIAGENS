CREATE DATABASE agencia_viagens;
USE agencia_viagens;

-- Tabela CATEGORIA
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Tabela DESTINO
CREATE TABLE destino (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_base DECIMAL(10,2) NOT NULL
);

-- Tabela PACOTE
CREATE TABLE pacote (
    id_pacote INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    preco_inicio DECIMAL(10,2),
    preco_fim DECIMAL(10,2),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Tabela de relacionamento PACOTE_DESTINO
CREATE TABLE pacote_destino (
    id_pacote INT,
    id_destino INT,
    PRIMARY KEY (id_pacote, id_destino),
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote) ON DELETE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino) ON DELETE CASCADE
);

-- Tabela CLIENTE
CREATE TABLE cliente (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco TEXT
);

-- Tabela RESERVA
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status ENUM('Pendente', 'Confirmada', 'Cancelada') NOT NULL DEFAULT 'Pendente',
    id_cliente VARCHAR(14) NOT NULL,
    id_pacote INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(cpf),
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote)
);

-- Tabela PAGAMENTO
CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('Pendente', 'Aprovado', 'Recusado') NOT NULL DEFAULT 'Pendente',
    metodo_pagamento ENUM('PIX', 'Cartão de Crédito', 'Cartão de Débito', 'Boleto') NOT NULL,
    data_pagamento DATETIME NOT NULL,
    id_reserva INT NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);
-- Inserção de dados de exemplo
INSERT INTO categoria (nome, descricao) VALUES
('Praia', 'Pacotes para destinos com praias paradisíacas'),
('Montanha', 'Pacotes para destinos montanhosos e clima frio'),
('Cidade', 'Pacotes para destinos urbanos e culturais'),
('Aventura', 'Pacotes para destinos com esportes radicais');

INSERT INTO destino (nome, descricao, preco_base) VALUES
('Rio de Janeiro', 'Cidade Maravilhosa com praias deslumbrantes', 1999.99),
('Fernando de Noronha', 'Paraíso ecológico com águas cristalinas', 3499.99),
('Foz do Iguaçu', 'Maravilha natural das Cataratas', 1599.99),
('Salvador', 'Rica história e cultura afro-brasileira', 1799.99);

INSERT INTO pacote (nome, descricao, preco, preco_inicio, preco_fim, id_categoria) VALUES
('Rio Completo', 'Pacote completo Rio de Janeiro', 2499.99, 2499.99, 3499.99, 1),
('Noronha Paradisíaco', 'Pacote Fernando de Noronha', 4999.99, 4999.99, 6999.99, 1),
('Foz Aventura', 'Pacote Foz do Iguaçu', 1999.99, 1999.99, 2999.99, 4),
('Salvador Cultural', 'Pacote Salvador', 2299.99, 2299.99, 3299.99, 3);


