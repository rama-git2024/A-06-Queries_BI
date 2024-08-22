-- processos que entraram na esteira do núcleo de consolidação e ainda não foram internalizados
-- inserir evento af 3.2.2 
-- processos que não tenham o 12.9 e que tenham o 12.9

WITH subquery AS ( 
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
	MAX (h.F00162) AS fase,
	MAX (g.F43686) AS subfase,
	MAX (i.F00091) AS advogado_interno,
	CAST (MAX(CASE WHEN c.F01132 = 'AF 0.7 - Pendência regularizada: Prosseguir Distribuição CRI' OR c.F01132 = 'Na esteira de ajuizamento com kit OK' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_07',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 1.1 - Distribuição via CRI' OR c.F01132 = 'Protocolo do Requerimento de Intimação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_11',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.8 - Todas as Intimações Positivas' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_28',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 5.1 - Consolidação da Propriedade' OR c.F01132 = 'DP 1.3.1 - Averbação da dação' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 5.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 6.2 - Documentação aceita' OR c.F01132 = 'DP 1.5.2 - Documentação aceita' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 6.2',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 6.1 - Envio do Imóvel ao Real Estate' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 6.1',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 9.3 - Leilão Negativo' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF 9.3',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 12.1 - Pagamento' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_121',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.7 - Intimação via Notificação Judicial' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_27',
	CAST (MAX(CASE WHEN c.F01132 = 'Acordo Quitado/Atualizado' THEN a.F00385 ELSE NULL END) AS DATE) AS 'acordo_quitado',
	CAST (MAX(CASE WHEN c.F01132 = 'Intimação Positiva' THEN a.F00385 ELSE NULL END) AS DATE) AS 'positiva',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 2.3 - Intimação Negativa - 01ª Tentativa' THEN a.F00385 ELSE NULL END) AS DATE) AS 'negativa',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 4.1 - Pagamento de Débitos Imóvel' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_41',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 7.1 - Operação Liquidada' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_71',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 12.9 - Ônus na matrícula' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_129',
	CAST (MAX(CASE WHEN c.F01132 = 'AF 3.2.2. - Calculadora de consolidação aprovada' THEN a.F00385 ELSE NULL END) AS DATE) AS 'AF_322'
FROM [ramaprod].[dbo].T00069 AS a
LEFT JOIN [ramaprod].[dbo].T00003 AS b ON a.F08501 = b.ID
LEFT JOIN [ramaprod].[dbo].T00064 AS c ON a.F01133 = c.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS d ON a.F02003 = d.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS e ON a.F02003 = e.ID
LEFT JOIN [ramaprod].[dbo].T00041 AS f ON a.F02003 = f.ID
LEFT JOIN [ramaprod].[dbo].T02682 AS g ON f.F43687 = g.ID
LEFT JOIN [ramaprod].[dbo].T00037 AS h ON f.F00177 = h.ID
LEFT JOIN [ramaprod].[dbo].T00030 AS i ON f.F11578 = i.ID
GROUP BY d.F14474
HAVING
	MAX (e.F01187) IN (32,34,14,36,35)
)
SELECT
	situacao,
	dossie,
	AF_322,
	AF_41, 
	AF_71,
	AF_129
FROM subquery
WHERE 
	situacao = 'Ativo' AND
	dossie IS NOT NULL AND
	AF_322 IS NOT NULL AND
	AF_71 IS NULL
ORDER BY AF_11 DESC;




