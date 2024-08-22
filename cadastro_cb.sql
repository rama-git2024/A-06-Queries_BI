SELECT
	a.F13576 AS criado_por,
	b.F00689 AS nome
FROM ramaprod.dbo.T01166 AS a
LEFT JOIN ramaprod.dbo.T00003 AS b ON a.F13576 = b.ID;