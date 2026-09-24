SELECT 
    indic.dt_referencia AS [Data],
    indic.proj_finalizados AS [Finalizados],
    indic.total_proj AS [Total de Projetos]
FROM dbo.indicadores AS indic
WHERE 1 = 1
    [[AND indic.dt_referencia >= {{data_inicial}}]]
    [[AND indic.dt_referencia <= {{data_final}}]]
    [[AND {{setor}}]]
ORDER BY [Data];