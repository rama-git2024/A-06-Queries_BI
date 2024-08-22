SELECT
	k.F02568 AS comarca,
	k.F02568 AS comarca_ref,
	MAX(l.F02571) AS juizo,
	CASE
		WHEN MAX(l.F02571) LIKE '%Grande do sul%' THEN 'Rio Grande do Sul'
		WHEN MAX(l.F02571) LIKE '%Paraná%' THEN 'Paraná'
		WHEN MAX(l.F02571) LIKE '%Catarina%' THEN 'Santa Catarina'
		ELSE 'Outro'
	END AS estado,
	CASE
		WHEN MAX(l.F02571) LIKE '%Grande do sul%' THEN 'RS'
		WHEN MAX(l.F02571) LIKE '%Paraná%' THEN 'PR'
		WHEN MAX(l.F02571) LIKE '%Catarina%' THEN 'SC'
		ELSE 'Outro'
	END AS UF
FROM [ramaprod].[dbo].T00069 AS a
LEFT JOIN [ramaprod].[dbo].T00041 AS k ON a.F02003 = k.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS l ON a.F02003 = l.ID
GROUP BY k.F02568;