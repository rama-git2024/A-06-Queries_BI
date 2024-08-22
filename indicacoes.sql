SELECT
	F01062 AS data_contecioso,

FROM [ramaprod].[dbo].T00041 
WHERE F01187 IN (32,34,14,36,35)

SELECT
	F13577 AS data_criacao,
	F13661 AS processo_interno,
	ID
FROM [ramaprod].[dbo].T01166
WHERE F13577 IS NOT NULL



SELECT
	d.F14474 AS dossie,
	MAX(d.F01062) AS criado_em,
	MAX(d.F01061) AS criado_por,
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
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.1 - Tratamento Benner - Fora de Parametrização'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_01',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.2 - Pend. Doc: Contrato sem Registro ou Matrícula AF'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_02',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.3 - Pend. Doc: Sem Imagem do Contrato ou Matrícula'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_03',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.4 - Pend. Doc: Outros Documentos'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_04',
	CAST (MAX(CASE WHEN c.F01132 = 'AAF 0.5 - Impedimento Cobrança / Jurídico'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_05',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.6 - Inviabilidade de Consolidação (Calculadora Negativa ou Perda de Garantia)'  THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_06',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_07'
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
GROUP BY d.F14474
HAVING
	MAX (e.F01187) IN (32,34,14,36,35) AND
	MAX (h.F00162) LIKE '%AF%' OR MAX (h.F00162) LIKE '%DP%' OR MAX (h.F00162) LIKE '%Alienação%' AND
	MAX(d.F01062) IS NOT NULL
ORDER BY MAX(d.F01062) DESC;