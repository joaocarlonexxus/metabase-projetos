SELECT 
    indic.dt_referencia AS [Data],
    indic.propostas_ativas AS [Propostas Ativas]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];