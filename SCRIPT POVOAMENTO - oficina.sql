-- Persistindo os dados nas tabelas do BD oficina

-- Inserção na tabela clientes (estado default 'SP', email pode ser nulo) - 6 clientes
INSERT INTO clientes (nome, sobrenome, CPF, endereco, complemento, cidade, telefone, email)
VALUES ('Rosana', 'Costa', '66955847722', 'Rua das Flores, 45', 'casa 2', 'Louveira', '11965478932', 'rosecostamake@gmail.com'),
		('Carlos Roberto', 'Batista', '32145620078', 'Av Giustiniano Borim, 1800', 'bl 3 apto 11', 'Jundiaí', '11985471236', null),
        ('João Paulo', 'Braga', '23066954788', 'Rua Guatemala, 87', 'apto 66', 'Praia Grande', '1345879632', 'jpbraga@hotmail.com'),
        ('Manoel', 'Silva Santos', '44521306977', 'Av Antenor Gandra, 1230', 'casa 1', 'Jundiaí', '11985223641', 'manoelsantos2@gmail.com'),
        ('Silvia Maria', 'Ranali', '05098744412', 'Rua João Augusto, 20', 'ultima casa', 'Varzea Paulista', '1733452169', null),
        ('Jorge Jair', 'Prates', '05377895511', 'Rua XV de Novembro, 798', 'apto 22', 'Jundiaí', '1145221796', 'jorgeprates@v8moveis.com.br');
        
SELECT * FROM clientes;

-- Inserção tabela mão de obra (id, tipo servico, valor) - 8 itens
INSERT INTO mao_obra (tipo_servico, valor)
VALUES ('Troca de óleo', 120),
		('Freios', 240),
        ('Manutenção embreagem', 300),
        ('Injeção eletrônica', 600),
        ('Limpeza de bicos', 90),
        ('Manutenção motor', 450),
        ('Troca de filtros', 115),
        ('Troca de velas', 85);
        
SELECT * FROM mao_obra;
    
-- Inserção tabela peças (id, descricao, categoria, valor) - 13 itens
INSERT INTO pecas (descricao, categoria, marca, valor)
VALUES ('Radiador do Motor', 'Motor', 'VW', 300),
		('Velas de ignição', 'Ignição', 'FIAT', 18.3),
        ('Velas de ignição', 'Ignição', 'FORD', 16.9),
        ('Filtro de óleo', 'Motor', 'VW', 98),
        ('Filtro de óleo', 'Motor', 'FIAT', 85),
        ('Pistão', 'Motor', 'VW', 215.9),
        ('Caixa de câmbio', 'Marchas', 'FORD', 954),
        ('Caixa de câmbio', 'Marchas', 'VW', 1100),
        ('Suspensão', 'Suspensão', 'VW', 550),
        ('Suspensão', 'Suspensão', 'FIAT', 512.30),
        ('Pastilha Freio', 'Freios', 'VW', 78.9),
        ('Pastilha Freio', 'Freios', 'FORD', 95.9),
        ('Pastilha Freio', 'Freios', 'FIAT', 122.2);

SELECT * FROM pecas;

-- Inserção na tabela mecanicos (id, nome, sobrenome, especialidade, celular) - 6 cadastros
INSERT INTO mecanicos (nome, sobrenome, especialidade, celular)
VALUES ('Marcos', 'Furlan', 'Geral', null),
		('José Carlos', 'Souza', 'Preventiva', '11985223147'),
        ('Thiago', 'Moraes', 'Geral', '11984756233'),
        ('David Augusto', 'Costa', 'Corretiva', null),
        ('Clovis', 'Valverde', 'Corretiva', '21996113232'),
        ('Felisberto', 'Silva', 'Geral', null);
        
SELECT * FROM mecanicos;

-- Inserção na tabela veiculos (id, modelo, marca, placa, cor, observacoes, fk) - 6 inserções
INSERT INTO veiculos (modelo, marca, placa, cor, observacoes, fk_clientes)
VALUES ('Polo', 'VW', 'ETR8996', 'vermelho', 'Tem alarme e risco porta passageiro', 5),
		('Mobi', 'FIAT', 'FUU2135', 'Branco', null, 3),
        ('Strada', 'FIAT', 'GRE8547', 'Preto', 'Urgente', 6),
        ('Gol', 'VW', 'BRU2333', 'Prata', 'Amassado capô', 1),
        ('Fiesta', 'FORD', 'MIN6512', 'Branco', 'Acionou seguro', 4),
        ('Gol', 'VW', 'TTO8879', 'Cinza', null , 2);
        
SELECT * FROM veiculos;


/* Inserção na tabela ordem-servico (id_ordem_servico, data_emissao, valor, status_servico ENUM('Em andamento', 'Finalizado', 'Aguardando peça') NOT NULL DEFAULT('Em andamento'), data_conclusao, motivo ENUM('Preventiva','Conserto'), tipo_servico, autorizacao DEFAULT('S'), fk_mecanicos INT, fk_clientes_os */
INSERT INTO ordem_servico (data_emissao, valor, data_conclusao, motivo_servico, tipo_servico, fk_mecanicos, fk_clientes_os)
VALUES ('2022-08-24', 130, '2022-08-26', 'Preventiva', 'Troca de óleo, velas e revisão', 2, 3),
		('2022-09-02', 154, '2022-09-06', 'Preventiva', 'Pastilhas de freio', 6, 1),
        ('2022-08-22', 310, '2022-08-29', 'Conserto', 'Troca de parachoques e testes (batido)', 4, 4),
        ('2022-09-12', 140, '2022-09-13', 'Preventiva', 'Revisão básica', 1, 5),
        ('2022-07-10', 420, '2022-07-14', 'Conserto', 'Barulho motor e falhas', 4, 2),
        ('2022-07-10', 420, '2022-07-14', 'Conserto', 'Barulho motor e falhas', 5, 2);
        
SELECT * FROM ordem_servico;


-- Inserção de dados nas tabelas geradas pelos relacionamentos N:M - avaliacao, os_pecas e os_mao_obra
INSERT INTO avaliacao (id_av_veiculos, id_av_mecanicos, observacao)
VALUES (1, 2, 'Primeira vez'),
		(2, 5, null),
        (3, 4, 'Atenção aos barulhos'),
        (4, 2, null),
        (5, 5, null),
        (5, 1, 'Precisa trocar peça'),
        (6, 2, 'Segunda vez');
        
SELECT * FROM avaliacao;


INSERT INTO os_pecas (id_os, id_pecas_os)
VALUES (1, 13), (1, 5), (2, 4), (3, 7), (3, 12), (4, 4), (5, 1), (5, 6), (6, 8);

SELECT * FROM os_pecas;


INSERT INTO os_mao_obra (fk_mao_obra, fk_ordem_servico)
VALUES (1 ,1), (2, 1), (2 ,2), (2 ,3), (4, 3), (7 ,4), (6 ,5), (3 ,6);

SELECT * FROM os_mao_obra;