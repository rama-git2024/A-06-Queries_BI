SELECT DISTINCT
		CASE
			WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
			WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
			WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
			WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
			ELSE 'Crédito Imobiliário'
		END AS produto,
				CASE
			WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
			WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
			WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
			WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
			ELSE 'Crédito Imobiliário'
		END AS produto_ref
FROM [ramaprod].[dbo].T00069 AS a
LEFT JOIN [ramaprod].[dbo].T00003 AS b ON a.F08501 = b.ID
LEFT JOIN [ramaprod].[dbo].T00064 AS c ON a.F01133 = c.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS d ON a.F02003 = d.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS e ON a.F02003 = e.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS f ON a.F02003 = f.ID
LEFT JOIN [ramaprod].[dbo].T02682 AS g ON f.F43687 = g.ID
LEFT JOIN [ramaprod].[dbo].T00037 AS h ON f.F00177 = h.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS i ON f.F11578 = i.ID
LEFT JOIN [ramaprod].[dbo].T00064 AS j ON a.F01133 = j.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS k ON a.F02003 = k.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS l ON a.F02003 = l.ID;
