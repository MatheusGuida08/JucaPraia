/*1.Criar um aluguel de equipamento para o mês de novembro 
(qualquer data e hora), qualquer equipamento, qualquer 
funcionário e qualquer cliente, mas cujo pagamento não tenha 
sido feito (ficou em aberto).*/

INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, pago)
VALUES
(14, 1, '2026-11-11 12:00', 0);

INSERT INTO aluguelequipamento (idEquipamento, idAluguel, valorItem, valorUnitario, qtd)
VALUES
(5, LAST_INSERT_ID(), 1.50, 1, 1);

UPDATE equipamento
SET qtd = qtd - 1
WHERE idEquipamento = 5

/*Listar nome de todos os funcionários, cpf e os aluguéis 
feitos por ele (apenas a data e que equipamento alugou)*/

SELECT f.nomeFuncionario, 
f.cpf, 
a.dataHoraRetirada, 
e.nomeEquipamento 

FROM funcionario f

INNER JOIN aluguel a
ON f.idFuncionario = a.idFuncionario

INNER JOIN aluguelequipamento ae
ON a.idAluguel = ae.idAluguel

INNER JOIN equipamento e
ON ae.idEquipamento = e.idEquipamento

ORDER BY f.nomeFuncionario

/*Listar nome do cliente, cpf, datas 
que ele esteve na praia, quem atendeu este
cliente, tudo isto, ordenado por data, da mais 
nova para a mais antiga, apenas no mês de DEZ24.*/

SELECT c.nomeCliente,
		 c.cpf, 
		 a.dataHoraRetirada,
		 f.nomeFuncionario
		 
		 FROM cliente c
		 
		 INNER JOIN aluguel a
		 ON c.idCliente = a.idCliente
		 
		 INNER JOIN funcionario f
		 ON f.idFuncionario = a.idFuncionario
		 
		 WHERE a.dataHoraRetirada BETWEEN '2024-12-01' AND '2024-12-31' 
		 ORDER BY a.dataHoraRetirada DESC

/*Lista do nome dos equipamentos que foram mais alugados 
em ordem decrescente, do equipamento mais alugado 
para o menos alugado. Equipamentos não alugados 
devem sair no relatório. */

SELECT e.nomeEquipamento,
		 COALESCE(SUM(ae.qtd)) AS 'Quantidade alugadas'
		 
		 FROM equipamento e
		 
		 LEFT JOIN aluguelequipamento ae
		 ON e.idEquipamento = ae.idEquipamento
		 
		 GROUP BY e.nomeEquipamento
		 ORDER BY count(ae.qtd) DESC 

/*Listar a arrecadação bruta da barraca de praia entre Natal e Ano Novo.*/

SELECT SUM(valorPago) AS 'Arrecadação Bruta' 
FROM aluguel
WHERE dataHoraRetirada BETWEEN '2024-12-24 00:00' AND '2024-12-31 23:59'

/*Reajustar preço por hora de todos os equipamentos em 10%.*/

UPDATE equipamento
SET valorHora = valorHora * 1.1

/*Listar a quantidade de clientes que pagaram utilizando determinada 
forma de pagamento, em ordem crescente, do método mais usado para 
o menos usado. Também é necessário que pagamentos não realizados 
sejam apontados.*/

SELECT 
    IFNULL(formaPagamento, 'Não Realizado') AS formaPagamento,
    COUNT(idCliente) AS qtdClientes
FROM aluguel
GROUP BY formaPagamento
ORDER BY qtdClientes DESC;


/*Listar quanto a barraca faturou por dia, em cada um dos 
dias do mês de dezembro apenas. */

SELECT 
    DATE(dataHoraRetirada) AS dia,
    SUM(valorPago) AS faturamento
FROM aluguel
WHERE MONTH(dataHoraRetirada) = 12
GROUP BY DATE(dataHoraRetirada)
ORDER BY dia;



/*Excluir o aluguel e todas as referências a ele 
criadas no item 1. Se tentar excluir direto 
da tabela aluguel teremos um problema? Por que isto ocorre? 
Como resolver (escrever o código usado)?*/

DELETE FROM aluguelequipamento
WHERE idAluguelEquipamento = 19

DELETE FROM aluguel
WHERE idAluguel = 12


/*Listar todos os equipamentos que tiveram a quantidade de aluguéis 
inferiores a 5 unidades, durante o mês de DEZ24. */

SELECT 
e.idEquipamento,
e.nomeEquipamento,
COUNT(ae.idAluguel) AS qtdAlugueis
FROM equipamento e 
LEFT JOIN aluguelequipamento ae
ON ae.idEquipamento = e.idEquipamento
LEFT JOIN aluguel a
ON a.idAluguel = ae.idAluguel
AND MONTH(a.dataHoraRetirada) = 12 
AND YEAR(a.dataHoraRetirada) = 2024
GROUP BY e.idEquipamento, e.nomeEquipamento
HAVING COUNT(ae.idAluguel) < 5
ORDER BY qtdAlugueis DESC;
