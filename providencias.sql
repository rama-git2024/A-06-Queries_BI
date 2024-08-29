-- Tabela fato de providências jurídico imob
-- Agrupando por dossie, resp, resp2, providencia, data, cumprido_em

SELECT
	c.F14474 AS dossie,
	a.F05633 AS resp,
	f.F00091 AS resp2,
	b.F00446 AS providencia,
	CASE
		WHEN MAX(a.F00445) = 1 THEN 'Inserido'
		WHEN MAX(a.F00445) = 2 THEN 'Sugestão'
		WHEN MAX(a.F00445) = 3 THEN 'A cumprir'
		WHEN MAX(a.F00445) = 4 THEN 'Cumprido'
		WHEN MAX(a.F00445) = 5 THEN 'Cancelado'
	END AS situacao,
	a.F05342 AS data,
	MAX(d.F00689) AS criado_por,
	CAST(MAX(a.F00453) AS DATE) AS data_inicio,
	CAST(MAX(a.F17598) AS DATE) AS data_inicio_contagem,
	MAX(a.F00454) AS prazo,
	CAST(MAX(a.F00455) AS DATE) AS data_final,
	a.F06337 AS cumprido_em,
	LAG(a.F06337) OVER (PARTITION BY f.F00091 ORDER BY a.F06337) AS providencia_futura,
	DATEDIFF(
		SECOND,
		LAG(a.F06337) OVER (PARTITION BY f.F00091 ORDER BY a.F06337),
		a.F06337
		) AS tempo_entre_prov,
	CAST(MAX(a.F06337) AS TIME) AS cumprido_em_hora,
	CASE
		WHEN MAX(a.F00445) = 4 THEN DATEDIFF(DAY,MAX(a.F00455),MAX(a.F00451))
		WHEN MAX(a.F00445) = 3 THEN DATEDIFF(DAY,MAX(a.F00455),GETDATE())
	END AS dias_mesclado,
	DATEDIFF(DAY,MAX(a.F17598),MAX(a.F00451)) AS dias_efetivos,
	CASE
		WHEN DATEDIFF(DAY, MAX(a.F00455), MAX(a.F00451)) < 0 THEN 0
		ELSE DATEDIFF(DAY, MAX(a.F00455), MAX(a.F00451))
	END	AS dias_atrasados
FROM [ramaprod].[dbo].T00076 AS a
LEFT JOIN [ramaprod].[dbo].T00077 AS b ON a.F00447 = b.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS c ON a.F06982 = c.ID
LEFT JOIN [ramaprod].[dbo].T00003 AS d ON a.F05341 = d.ID
LEFT JOIN [ramaprod].[dbo].T00557 AS e ON a.F05633 = e.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS f ON e.F05200 = f.ID
GROUP BY c.F14474, a.F05633,f.F00091, b.F00446, a.F05342, a.F06337
HAVING 
	YEAR(CAST(MAX(a.F00453) AS DATE)) >= 2022 AND 
	MAX(c.F01187) IN (32,34,14,36,35)
ORDER BY cumprido_em DESC;