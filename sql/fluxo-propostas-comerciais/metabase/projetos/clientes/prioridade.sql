SELECT
	COUNT(DISTINCT proj.task_gid) AS [Total de Projetos],
	priori.prioridade_simples AS [Prioridade]
FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_prioridades AS priori
		ON proj.prioridade = priori.prioridade
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
	priori.prioridade_simples
ORDER BY
	CASE
		WHEN priori.prioridade_simples = 'Crítica' THEN 1
		WHEN priori.prioridade_simples = 'Alta' THEN 2
		WHEN priori.prioridade_simples = 'Média' THEN 3
		WHEN priori.prioridade_simples = 'Baixa' THEN 4
	END;