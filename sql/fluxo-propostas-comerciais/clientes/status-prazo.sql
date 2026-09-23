SELECT
	COUNT(DISTINCT proj.task_gid) AS [Total de Projetos],
	CASE
		WHEN proj.status_prazo = 'Em dia' THEN 'Em Dia'
		WHEN proj.status_prazo = 'Atrasado' THEN 'Atrasado'
		WHEN proj.status_prazo IS NULL THEN 'Em Branco'
	END AS [Status do Prazo]
FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_clientes AS cli
		ON proj.cliente = cli.cliente
WHERE
	proj.status_projeto IN (
		'Não Iniciado',
		'Em Desenvolvimento',
		'Desenvolvimento Pausado',
		'Aguardando Implantação',
		'Em Implantação',
		'Fornecimento Materiais',
		'Em Fechamento'
	)
	AND proj.task_section_name NOT IN (
		'11. Controle Suporte',
		'12. Controle de Suporte - Vencidos',
		'13. Reunião de Fechamento',
		'14. Finalizado',
		'15. Excedente de Horas de Suporte'
	)
	[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
	[[AND proj.data_abertura_proposta <= {{data_final}}]]
	[[AND {{cliente}}]]
GROUP BY
	proj.status_prazo;