-- Criação de BD para o cenário de Oficina Mecânica

CREATE DATABASE oficina;
USE oficina;

-- Criando tabelas sem foreign keys
CREATE TABLE if not exists clientes (
id_clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
sobrenome VARCHAR(30) NOT NULL,
CPF CHAR(11) NOT NULL UNIQUE,
endereco VARCHAR(45) NOT NULL,
complemento VARCHAR(12),
cidade VARCHAR(15) NOT NULL,
estado CHAR(2) DEFAULT('SP'),
telefone VARCHAR(11) NOT NULL,
email VARCHAR(45)
);
ALTER TABLE clientes AUTO_INCREMENT=1;

CREATE TABLE if not exists mao_obra (
id_mao_obra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
tipo_servico VARCHAR(45) NOT NULL,
valor DECIMAL(9,2) NOT NULL
);

CREATE TABLE if not exists pecas (
id_pecas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
descricao VARCHAR(45) NOT NULL,
categoria VARCHAR(45),
marca ENUM('VW', 'FIAT', 'FORD'),
valor DECIMAL(9,2) NOT NULL
);

CREATE TABLE if not exists mecanicos (
id_mecanicos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
sobrenome VARCHAR(20) NOT NULL,
especialidade ENUM('Geral','Preventiva','Corretiva') NOT NULL,
celular CHAR(11)
);


-- Criando tabelas com foreign keys
CREATE TABLE if not exists veiculos (
id_veiculos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modelo VARCHAR(20) NOT NULL,
marca VARCHAR(20) NOT NULL,
placa VARCHAR(10) NOT NULL,
cor VARCHAR(12),
observacoes VARCHAR(60),
fk_clientes INT,
CONSTRAINT fk_clientes FOREIGN KEY (fk_clientes) REFERENCES clientes (id_clientes)
);
ALTER TABLE veiculos AUTO_INCREMENT=1;


CREATE TABLE if not exists ordem_servico (
id_ordem_servico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_emissao DATE NOT NULL,
valor DECIMAL(9,2) NOT NULL,
status_servico ENUM('Em andamento', 'Finalizado', 'Aguardando peça') NOT NULL DEFAULT('Em andamento'),
data_conclusao DATE,
motivo_servico ENUM('Preventiva','Conserto'),
tipo_servico VARCHAR(45) NOT NULL,
autorizacao_cliente CHAR NOT NULL DEFAULT('S'),
fk_mecanicos INT,
fk_clientes_os INT,
CONSTRAINT fk_mecanicos_OS FOREIGN KEY (fk_mecanicos) REFERENCES mecanicos (id_mecanicos),
CONSTRAINT fk_clientes_OS FOREIGN KEY (fk_clientes_os) REFERENCES clientes (id_clientes)
);
ALTER TABLE ordem_servico AUTO_INCREMENT=1;


CREATE TABLE if not exists avaliacao (
id_av_veiculos INT,
id_av_mecanicos INT,
observacao VARCHAR(45),
PRIMARY KEY (id_av_veiculos, id_av_mecanicos),
CONSTRAINT fk_mecanicos_aval FOREIGN KEY (id_av_mecanicos) REFERENCES mecanicos (id_mecanicos),
CONSTRAINT fk_veiculos_aval FOREIGN KEY (id_av_veiculos) REFERENCES veiculos (id_veiculos)
);


CREATE TABLE if not exists os_pecas (
id_os INT,
id_pecas_os INT,
PRIMARY KEY (id_os, id_pecas_os),
CONSTRAINT fk_OS_pecas FOREIGN KEY (id_pecas_os) REFERENCES pecas (id_pecas),
CONSTRAINT fk_pecas_OS FOREIGN KEY (id_os) REFERENCES ordem_servico (id_ordem_servico)
);

CREATE TABLE if not exists os_mao_obra (
fk_mao_obra INT,
fk_ordem_servico INT,
PRIMARY KEY (fk_mao_obra, fk_ordem_servico),
CONSTRAINT fk_mao_obra FOREIGN KEY (fk_mao_obra) REFERENCES mao_obra (id_mao_obra),
CONSTRAINT fk_mao_obra_OS FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_servico (id_ordem_servico)
);