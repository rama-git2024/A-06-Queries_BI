SELECT DISTINCT
	b.F00091 AS advogado,
	b.F00091 AS advogado_ref,
	LEFT(b.F00091, CHARINDEX(' ', b.F00091 + ' ') - 1) AS primeiro_nome_adv,
	SUBSTRING(b.F00091, LEN(b.F00091) - CHARINDEX(' ', REVERSE(b.F00091)) + 2, LEN(b.F00091)) AS ultimo_nome,
	LEFT(b.F00091, CHARINDEX(' ', b.F00091 + ' ') - 1)+' '+SUBSTRING(b.F00091, LEN(b.F00091) - CHARINDEX(' ', REVERSE(b.F00091)) + 2, LEN(b.F00091)) AS nome_sobrenome,
		CASE
		WHEN b.F00091 IN ('Gustavo Araujo Tavares', 'Darlei Jacoby Kayser', 'Thierri Rech', 'Bruno Gonçalves Barrios', 'João Lucas Martins Falcão', 
			'Thiago Haggstrom dos Santos','Thiago dos Santos','Augusto Almeida Gerhardt', 'Sarah Raquel Lopes Gonçalves') THEN 'Intimação'
		WHEN b.F00091 = 'Rafael Rama e Silva' THEN 'Gestor'
		WHEN b.F00091  IN ('Ana Carolina Bressan da Silva', 'Erick Damin Bitencourt') THEN 'Backoffice'
		WHEN b.F00091  IN ('Sabrina de Jesus Pereira', 'Felipe Machado da Luz', 'Luciana Caroline Moraes Panatieri', 'Rafaella Rodrigues dos Santos Marques',
			'Danielle Lais da Silva Lutkemeyer', 'Jenifer da Silva Lopes', 'Matheus Cezar Dias') THEN 'Consolidação'
		ELSE 'Outro'
	END AS nucleo
FROM [ramaprod].[dbo].T00041 AS a
LEFT JOIN [ramaprod].[dbo].T00030 AS b ON a.F11578 = b.ID
WHERE b.F00091 IN ('Ana Carolina Bressan da Silva', 'Gustavo Araujo Tavares', 'Erick Damin Bitencourt', 'Darlei Jacoby Kayser', 'Thierri Rech', 
	'Bruno Gonçalves Barrios', 'João Lucas Martins Falcão', 'Sabrina de Jesus Pereira', 'Felipe Machado da Luz', 'Rafaella Rodrigues dos Santos Marques', 
	'Rafael Rama e Silva', 'Thiago Haggstrom dos Santos', 'Thiago dos Santos', 'Danielle Lais da Silva Lutkemeyer','Augusto Almeida Gerhardt','Jenifer da Silva Lopes', 'Matheus Cezar Dias',
	'Sarah Raquel Lopes Gonçalves');