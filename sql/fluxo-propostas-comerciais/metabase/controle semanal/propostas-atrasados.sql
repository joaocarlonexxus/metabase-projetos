SELECT 
    indic.dt_referencia AS [Data],
    indic.propostas_atraso AS [Propostas em Atraso]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];