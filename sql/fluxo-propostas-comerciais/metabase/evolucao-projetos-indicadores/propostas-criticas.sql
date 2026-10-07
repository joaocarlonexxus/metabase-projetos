SELECT 
    indic.dt_referencia AS [Data],
    indic.propostas_criticas AS [Propostas Críticas]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];