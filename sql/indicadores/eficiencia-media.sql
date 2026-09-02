SELECT 
    indic.dt_referencia AS [Data],
    indic.eficiencia_media_desenv AS [Desenvolvimento],
    indic.eficiencia_media_implant AS [Implantação]
FROM dbo.indicadores AS indic
WHERE 1 = 1
    [[AND indic.dt_referencia >= {{data_inicial}}]]
    [[AND indic.dt_referencia <= {{data_final}}]]
    [[AND {{setor}}]]
ORDER BY [Data];