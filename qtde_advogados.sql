-- Tabela fato de providências jurídico imob
-- Agrupando por dossie, resp, resp2, providencia, data, cumprido_em

SELECT 
	MIN(a.F06337) AS cumpri_em,
	YEAR(a.F06337) AS cumprido_em_ano,
	MONTH(a.F06337) AS cumprido_em_mes,
	COUNT(DISTINCT f.F00091) AS qtde_advogados
FROM [ramaprod].[dbo].T00076 AS a
LEFT JOIN [ramaprod].[dbo].T00077 AS b ON a.F00447 = b.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS c ON a.F06982 = c.ID
LEFT JOIN [ramaprod].[dbo].T00003 AS d ON a.F05341 = d.ID
LEFT JOIN [ramaprod].[dbo].T00557 AS e ON a.F05633 = e.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS f ON e.F05200 = f.ID
WHERE
	YEAR(a.F06337) IS NOT NULL AND
	YEAR(a.F00453) >= 2022 AND 
	c.F01187 IN (32, 34, 14, 36, 35) AND
	f.F00091 IN ('Ana Carolina Bressan da Silva', 'Gustavo Araujo Tavares', 'Erick Damin Bitencourt', 'Darlei Jacoby Kayser', 'Thierri Rech', 
	'Bruno Gonçalves Barrios', 'João Lucas Martins Falcão', 'Sabrina de Jesus Pereira', 'Felipe Machado da Luz', 'Rafaella Rodrigues dos Santos Marques', 
	'Rafael Rama e Silva', 'Thiago Haggstrom dos Santos', 'Thiago dos Santos', 'Danielle Lais da Silva Lutkemeyer','Augusto Almeida Gerhardt','Jenifer da Silva Lopes', 'Matheus Cezar Dias',
	'Sarah Raquel Lopes Gonçalves')
GROUP BY YEAR(a.F06337), MONTH(a.F06337)
ORDER BY cumprido_em_ano, cumprido_em_mes;
