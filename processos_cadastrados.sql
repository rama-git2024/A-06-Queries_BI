SELECT
	a.F14474 AS dossie,
	a.F01062 AS criado_em,
	b.F00689 AS criado_por
FROM [ramaprod].[dbo].T00041 AS a
LEFT JOIN [ramaprod].[dbo].T00003 AS b ON a.F01061 = b.ID
WHERE a.F01187 IN (32,34,14,36,35)


