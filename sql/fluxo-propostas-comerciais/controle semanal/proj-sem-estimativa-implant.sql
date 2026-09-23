SELECT 
    indic.dt_referencia AS [Data],
    indic.proj_sem_estimativa_implant AS [Implantação]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];