SELECT 
	indic.dt_referencia AS [Data],
	indic.media_dias_reuniao_abertura AS [Média dias de Reunião de Abertura]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];