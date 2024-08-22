SELECT
	d.F14474 AS dossie,
	MAX(a.F01544) AS criado_em,
	MAX(m.F00689) AS criado_por,
	MAX(f.F35249) AS data_atualizacao_benner,
	MAX(a.F04461) AS pasta,
	MAX(n.F00091) AS adverso,
	MAX(n.F27086) AS cpf_cnpj,
	MAX(i.F00091) AS adverso_nome,
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
	MAX(j.F01132) AS ultimo_evento,
	MAX (i.F00091) AS advogado_interno,
	MAX(l.F02571) AS juiza,
	MAX(k.F02568) AS comarca,
    MAX(SUBSTRING(l.F02571, CHARINDEX('/', l.F02571 + '/') + 1, LEN(l.F02571)) + '-' + k.F02568) AS cartorio_comarca,
    MAX(p.F00075) AS estado,
	MAX(p.F00074) UF,
	MAX(k.F02568) + '-' + MAX(p.F00074) AS comarca_UF,
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 0.7',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 1.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 2.8',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 3.2 - Decurso do Prazo para Purgação da Mora' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 3.2',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 4.1 - Pagamento de Débitos Imóvel' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 4.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 5.1 - Consolidação da Propriedade' OR c.F01132 = 'DP 1.3.1 - Averbação da dação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 5.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita' OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 6.2',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 6.1 - Envio do Imóvel ao Real Estate' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 6.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.3 - Leilão Negativo' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 9.3',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 12.1 - Pagamento' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 12.1',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_distribuicao',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_intimacao',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 5.1 - Consolidação da Propriedade' OR c.F01132 = 'DP 1.3.1 - Averbação da dação' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_consolidacao',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 5.1 - Consolidação da Propriedade' OR c.F01132 = 'DP 1.3.1 - Averbação da dação' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita'  OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_contabilizacao',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 5.1 - Consolidação da Propriedade' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 9.3 - Leilão Negativo' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_leilao',
    DATEDIFF(DAY,
        MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' THEN a.F00385 ELSE NULL END),
        MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita' OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END)
    ) AS 'tm_retomada',
    MAX (
    	CASE 	
    		WHEN c.F01132 LIKE 'DP%'  THEN 'Dação em Pagamento'
    		ELSE 'Consolidação'
    	END ) AS tipo_retomadas,
    MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita'  OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN b.F00689 ELSE NULL END) AS advogado_consolidacao,
    MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN b.F00689 ELSE NULL END) AS advogado_distribuicao,
    MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN b.F00689 ELSE NULL END) AS advogado_intimacao,
    MAX(
     	CASE 
    		WHEN c.F01132 = 'AF 2.1 - Intimação Positiva - Alienação' THEN 1
    		WHEN c.F01132 = 'AF 2.5 - Intimação por Hora Certa' THEN 2
    		WHEN c.F01132 = 'AF 2.6 - Intimação Positiva - Edital Alienação' THEN 3
    		WHEN c.F01132 = 'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)' THEN 4
    	END) AS tipo_intimacao 
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
LEFT JOIN [ramaprod].[dbo].T00003 AS m ON d.F01061 = m.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS n ON f.F05220 = n.ID
LEFT JOIN [ramaprod].[dbo].T00049 AS o ON k.F02568 = o.F00230
LEFT JOIN [ramaprod].[dbo].T00023 AS p ON o.F00232 = p.ID
GROUP BY a.F04461, d.F14474
HAVING
	MAX (e.F01187) IN (32,34,14,36,35) AND
	MAX (h.F00162) LIKE '%AF%' OR MAX (h.F00162) LIKE '%DP%' OR MAX (h.F00162) LIKE '%Alienação%'
ORDER BY (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' THEN a.F00385 ELSE NULL END)) DESC;