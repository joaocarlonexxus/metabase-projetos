SELECT 
	indic.dt_referencia AS [Data],
	indic.media_dias_reuniao_kickoff AS [Média dias de Reunião de Kickoff]
FROM dbo.indicadores AS indic
WHERE indic.setor = 'Gerais'
ORDER BY [Data];