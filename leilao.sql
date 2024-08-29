SELECT
	d.F14474 AS dossie,
	MAX(f.F35249) AS data_atualizacao_benner,
	MAX(a.F04461) AS pasta,
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
	CAST (MAX(CASE WHEN c.F01132 = 'AF 7.1 - Operação Liquidada' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_71',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 8.1 - Notificação Devedor Positiva' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_81',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 8.2 - Notificação Coobrigado Positiva' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_82',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 8.3 - Notificação Negativa' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_83',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 8.4 - Notificação por Edital' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_84',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 8.5 - Todas as Notificações Enviadas' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_85',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.1 - Arrematação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_91',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_92',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.3 - Leilão Negativo' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_93',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.4 - Exercício do Direito de Preferência' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_94',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 10.1 - Arrematação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_101',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 10.2 - Sobejo de Valores' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_102',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 10.3 - Leilão Negativo' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_103',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 10.4 - Averbação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_104',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 11.1 - Contabilização da Purga de Mora' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_111',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 11.2 - Prestação de Contas Arrematação/Real Estate' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_112',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 11.3 - Restituição do Sobejo' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_113',
	CASE
		WHEN MAX (h.F00162) = 'AF 8. NOTIFICAÇÕES PRÉ-LEILÃO' THEN 'Pré-Leilão'
		ELSE 'Leilão'
	END AS status_leilao
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
GROUP BY a.F04461, d.F14474
HAVING
	MAX (e.F01187) IN (32,34,14,36,35) AND
	MAX (h.F00162)  IN ('AF 8. NOTIFICAÇÕES PRÉ-LEILÃO', 'AF 9. 1º LEILÃO', 'AF 10. 2º LEILÃO', 'AF 11. REPASSE DE VALORES')
