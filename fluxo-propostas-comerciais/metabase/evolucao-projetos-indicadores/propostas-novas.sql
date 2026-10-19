SELECT 
    indic.dt_referencia AS [Data],
    indic.propostas_novas AS [Propostas Novas]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];