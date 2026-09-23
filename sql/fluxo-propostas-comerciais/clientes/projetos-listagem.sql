SELECT
	proj.task_gid,
	cli.cliente_simples AS [Cliente],
	proj.task_name AS [Proposta],
	proj.setor AS [Setor],
	proj.colaborador AS [Colaborador],
	porte.porte_projeto_simples AS [Porte Projeto],
	priori.prioridade_simples AS [Prioridade],
	proj.tipo_proposta AS [Tipo Proposta],
	proj.status_projeto AS [Status Projeto],
	proj.status_prazo AS [Status Prazo],
	proj.data_abertura_proposta AS [Data Abertura],
	proj.data_estimada_finalizacao AS [Data Est. Finalização],
	proj.data_reuniao_abertura AS [Data Reunião Abertura],
	proj.data_reuniao_kickoff AS [Data Reunião Kickoff],
	proj.data_inicio AS [Data Início - Desenv],
	proj.tempo_estimado_desenv_geral AS [Desenv. - Planejado],
	proj.tempo_real_desenv_geral AS [Desenv. - Executado],
	(
    	proj.tempo_real_desenv_geral - proj.tempo_estimado_desenv_geral
	) AS [Desvio - Desenv.],
	(
    	COALESCE(proj.tempo_estimado_desenv_geral / NULLIF(proj.tempo_real_desenv_geral, 0), 0)
	) AS [Eficiência - Desenv.],
	proj.tempo_estimado_implant_geral AS [Implant. - Planejado],
	proj.tempo_real_implant_geral AS [Implant. - Executado],
	(
    	proj.tempo_real_implant_geral - proj.tempo_estimado_implant_geral
	) AS [Desvio - Implant.],
	(
    	COALESCE(proj.tempo_estimado_implant_geral / NULLIF(proj.tempo_real_implant_geral, 0), 0)
	) AS [Eficiência - Implant.],
	proj.horas_retrabalho AS [Retrabalho],
	proj.horas_itens_fora_escopo AS [Itens Fora do Escopo]
FROM dbo.f_projetos_tratada AS proj
	LEFT JOIN dbo.d_porte_projeto AS porte
		ON proj.porte_projeto = porte.porte_projeto
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
ORDER BY
	[Cliente];