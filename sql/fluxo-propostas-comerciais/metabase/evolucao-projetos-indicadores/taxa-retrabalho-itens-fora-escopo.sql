SELECT 
    indic.dt_referencia AS [Data],
    indic.tx_retrabalho AS [Taxa de Retrabalho],
    indic.tx_itens_fora_escopo AS [Taxa de Itens Fora de Escopo]
FROM dbo.indicadores AS indic
WHERE 1 = 1
    [[AND indic.dt_referencia >= {{data_inicial}}]]
    [[AND indic.dt_referencia <= {{data_final}}]]
    [[AND {{setor}}]]
ORDER BY [Data];