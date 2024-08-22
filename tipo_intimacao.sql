SELECT DISTINCT
    CASE 
        WHEN c.F01132 = 'AF 2.1 - Intimação Positiva - Alienação' THEN 1
        WHEN c.F01132 = 'AF 2.5 - Intimação por Hora Certa' THEN 2
        WHEN c.F01132 = 'AF 2.6 - Intimação Positiva - Edital Alienação' THEN 3
        WHEN c.F01132 = 'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)' THEN 4
    END AS id_tipo_intimacao,
    CASE 
    	WHEN c.F01132 = 'AF 2.1 - Intimação Positiva - Alienação' THEN 'Pessoal, postal, cláusula de outorga e judicial'
    	WHEN c.F01132 = 'AF 2.5 - Intimação por Hora Certa' THEN 'Hora Certa'
    	WHEN c.F01132 = 'AF 2.6 - Intimação Positiva - Edital Alienação' THEN 'Edital'
    	WHEN c.F01132 = 'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)' THEN 'Meio Digital'
    END AS tipo_intimacao,
    CASE 
        WHEN c.F01132 = 'AF 2.1 - Intimação Positiva - Alienação' THEN 'Pessoal, postal, cláusula de outorga e judicial'
        WHEN c.F01132 = 'AF 2.5 - Intimação por Hora Certa' THEN 'Hora Certa'
        WHEN c.F01132 = 'AF 2.6 - Intimação Positiva - Edital Alienação' THEN 'Edital'
        WHEN c.F01132 = 'AF 2.9 - Intimação Eletrônica (What’s App ou e-mail)' THEN 'Meio Digital'
    END AS tipo_intimacao_ref     
FROM [ramaprod].[dbo].T00069 AS a
LEFT JOIN [ramaprod].[dbo].T00064 AS c ON a.F01133 = c.ID
ORDER BY id_tipo_intimacao;