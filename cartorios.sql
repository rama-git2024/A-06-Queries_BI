SELECT
    (SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568) AS cartorio_comarca,
    (SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568) AS cartorio_comarca_ref,
    MAX(SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571))) AS cartorio,
    MAX(k.F02568) AS comarca,
	MAX(c.F00075) AS estado,
	MAX(c.F00074) AS UF,
	MAX(l.F02571) AS juizo
FROM [ramaprod].[dbo].T00069 AS a
LEFT JOIN [ramaprod].[dbo].T00041 AS k ON a.F02003 = k.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS l ON a.F02003 = l.ID
LEFT JOIN [ramaprod].[dbo].T00049 AS b ON b.F00230 = k.F02568
LEFT JOIN [ramaprod].[dbo].T00023 AS c ON b.F00232 = c.ID
GROUP BY (SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568);



















































SELECT
	(a.F00235 +'-'+ b.F00230) cartorio_comarca,
	MAX(a.F00235 +'-'+ b.F00230) cartorio_comarca_ref,
	a.F00235 cartorio,
	MAX(b.F00230) comarca,
	MAX(c.F00075) AS estado,
	MAX(c.F00074) AS UF,
	MAX(d.F33110) AS juizo
FROM [ramaprod].[dbo].T00051 AS a
LEFT JOIN [ramaprod].[dbo].T00049 AS b ON a.F00236 = b.ID
LEFT JOIN [ramaprod].[dbo].T00023 AS c ON a.F05186 = c.ID
LEFT JOIN [ramaprod].[dbo].T02227 AS d ON a.F33233 = d.ID
GROUP BY (a.F00235 +'-'+ b.F00230) ,a.F00235
