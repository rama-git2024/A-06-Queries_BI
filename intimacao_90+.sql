SELECT
	d.F14474 AS dossie,
	MAX(f.F35249) AS data_atualizacao_benner,
	MAX(a.F04461) AS pasta,
	MAX(n.F00091) AS adverso,
	MAX (
		CASE
			WHEN f.F25017 = 1 THEN 'Ativo'
			WHEN f.F25017 = 2 THEN 'Encerrado'
			WHEN f.F25017 = 3 THEN 'Acordo'
			WHEN f.F25017 = 4 THEN 'Em encerramento'
			ELSE 'Em precatório (Ativo)'
		END ) AS situacao,
	MAX (
		CASE
			WHEN e.F01187 = 32 THEN 'IMOB - Home Equity PF'
			WHEN e.F01187 = 35 THEN 'IMOB - Home Equity PJ'
			WHEN e.F01187 = 34 THEN 'IMOB - Financiamento'
			WHEN e.F01187 = 36 THEN 'IMOB - Hipoteca'
			ELSE 'Crédito Imobiliário'
		END ) AS produto,
	MAX (h.F00162) AS fase,
	MAX (g.F43686) AS subfase,
	MAX (i.F00091) AS advogado_interno,
	MAX(k.F02568) AS comarca,
    MAX(SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568) AS cartorio_comarca,
	CASE
		WHEN MAX(l.F02571) LIKE '%Grande do sul%' THEN 'Rio Grande do Sul'
		WHEN MAX(l.F02571) LIKE '%Paraná%' THEN 'Paraná'
		ELSE 'Santa Catarina'
	END AS estado,
	CASE
		WHEN MAX(l.F02571) LIKE '%Grande do sul%' THEN 'RS'
		WHEN MAX(l.F02571) LIKE '%Paraná%' THEN 'PR'
		WHEN MAX(l.F02571) LIKE '%Catarina%' THEN 'SC'
		ELSE 'Outro'
	END AS UF,
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 0.7',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 1.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.7 - Intimação via Notificação Judicial' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 2.7',	
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 2.8',
	DATEDIFF_BIG (
		DAY,
		CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE),
		CAST (GETDATE() AS DATE)
		) AS SLA_distrib,
	CAST (GETDATE() AS DATE) AS data_hoje
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
LEFT JOIN [ramaprod].[dbo].T00041 AS l ON a.F02003 = l.ID
LEFT JOIN [ramaprod].[dbo].T00035 AS m ON f.F01187 = m.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS n ON f.F05220 = n.ID
GROUP BY a.F04461, d.F14474
HAVING
	MAX (e.F01187) IN (32,34,14,36,35) AND
	MAX (h.F00162) IN ('AF 1. DISTRIBUIÇÃO', 'AF 2. NOTIFICAÇÃO VIA CRI') AND
	MIN (
		CASE
			WHEN f.F25017 = 1 THEN 'Ativo'
			WHEN f.F25017 = 2 THEN 'Encerrado'
			WHEN f.F25017 = 3 THEN 'Acordo'
			WHEN f.F25017 = 4 THEN 'Em encerramento'
			ELSE 'Em precatório (Ativo)'
		END ) IN ('Ativo','Em precatório (Ativo)') AND

	DATEDIFF_BIG (
		DAY,
		CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE),
		CAST (GETDATE() AS DATE)
		) >= 90 AND
	MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END) IS NULL
ORDER BY (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' THEN a.F00385 ELSE NULL END)) DESC;

