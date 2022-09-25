USE oficina;

-- Queries de consulta SQL em BD cenário Oficina.

-- Mecânicos com especialidade Corretiva
SELECT nome, sobrenome FROM mecanicos WHERE especialidade = 'Corretiva';

-- Mecânicos onde a especialidade termine com 'iva'
SELECT concat(nome, ' ',sobrenome) AS Mecanico, especialidade FROM mecanicos WHERE especialidade LIKE '%iva';

-- Informações de clientes cadastrados e seu carros
SELECT concat(c.nome, ' ', c.sobrenome) AS Cliente, c.telefone, v.modelo, v.placa
FROM clientes c, veiculos v
WHERE c.id_clientes = v.fk_clientes;


-- Informações de clientes cadastrados com carro da marca VW
SELECT concat(c.nome, ' ', c.sobrenome) AS Cliente, c.telefone, v.modelo, v.placa
FROM clientes c, veiculos v
WHERE c.id_clientes = v.fk_clientes AND marca = 'VW'
ORDER BY Cliente;


-- Quais mecânicos avaliaram os veículos?
SELECT m.nome AS Mecanico, v.modelo as Carro, observacao
FROM mecanicos m
JOIN avaliacao a ON m.id_mecanicos = a.id_av_mecanicos
JOIN veiculos v ON a.id_av_veiculos = v.id_veiculos;

-- Quais mecânicos avaliaram os veículos e escreveram alguma observação da avaliação
SELECT m.nome AS Mecanico, v.modelo as Carro, v.cor, observacao
FROM mecanicos m
JOIN avaliacao a ON m.id_mecanicos = a.id_av_mecanicos
JOIN veiculos v ON a.id_av_veiculos = v.id_veiculos
WHERE observacao IS NOT NULL;


-- Data, motivo e valor da mão de obra de cada OS
SELECT os.data_emissao, os.motivo_servico, mo.valor AS Valor_Mao_Obra
FROM ordem_servico os
JOIN os_mao_obra m ON os.id_ordem_servico = m.fk_ordem_servico
JOIN mao_obra mo ON m.fk_mao_obra = mo.id_mao_obra
ORDER BY os.data_emissao;


-- Relatório com informações de todas as OS cadastradas e o valor total de cada uma
SELECT concat(c.nome, ' ', c.sobrenome) AS Cliente, os.id_ordem_servico AS Num_OS, os.motivo_servico, p.descricao AS Peça, SUM(mo.valor) AS Valor_Mao_Obra, SUM(p.valor) AS Valor_Peca, SUM((p.valor + mo.valor)) AS Valor_Total
FROM ordem_servico os
JOIN os_mao_obra m ON os.id_ordem_servico = m.fk_ordem_servico
JOIN mao_obra mo ON m.fk_mao_obra = mo.id_mao_obra
JOIN clientes c ON os.fk_clientes_os = c.id_clientes
JOIN os_pecas op ON os.id_ordem_servico = op.id_os
JOIN pecas p ON op.id_pecas_os = p.id_pecas
GROUP BY c.nome, id_ordem_servico, os.motivo_servico
ORDER BY c.nome;


-- Relatório de OS com filtrada por motivo = 'Conserto'
SELECT concat(c.nome, ' ', c.sobrenome) AS Cliente, os.id_ordem_servico AS Num_OS, os.motivo_servico, p.descricao AS Peça, SUM(mo.valor) AS Valor_Mao_Obra, SUM(p.valor) AS Valor_Peca, SUM((p.valor + mo.valor)) AS Valor_Total
FROM ordem_servico os
JOIN os_mao_obra m ON os.id_ordem_servico = m.fk_ordem_servico
JOIN mao_obra mo ON m.fk_mao_obra = mo.id_mao_obra
JOIN clientes c ON os.fk_clientes_os = c.id_clientes
JOIN os_pecas op ON os.id_ordem_servico = op.id_os
JOIN pecas p ON op.id_pecas_os = p.id_pecas
GROUP BY c.nome, id_ordem_servico, os.motivo_servico
HAVING os.motivo_servico = 'Conserto'
ORDER BY Cliente;