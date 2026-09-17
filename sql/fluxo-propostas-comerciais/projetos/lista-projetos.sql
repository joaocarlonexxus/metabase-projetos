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
	proj.origem_impacto AS [Origem Impacto],
	proj.data_abertura_proposta AS [Data Abertura],
	proj.data_inicio AS [Data Início - Desenv],
	proj.data_termino AS [Data Término],
	proj.data_estimada_finalizacao AS [Data Estimada Finalização],
	proj.data_reuniao_abertura AS [Data Reunião Abertura],
	proj.data_reuniao_kickoff AS [Data Reunião Kickoff],
	proj.tempo_estimado_desenv_automacao AS [Tempo Estimado Desenv Automação],
	proj.tempo_estimado_desenv_eletrica AS [Tempo Estimado Desenv Elétrica],
	proj.tempo_estimado_desenv_sistemas AS [Tempo Estimado Desenv Sistemas],
	proj.tempo_estimado_desenv_geral AS [Tempo Estimado Desenv Geral],
	proj.tempo_real_desenv_automacao AS [Tempo Real Desenv Automação],
	proj.tempo_real_desenv_eletrica AS [Tempo Real Desenv Elétrica],
	proj.tempo_real_desenv_sistemas AS [Tempo Real Desenv Sistemas],
	proj.tempo_real_desenv_geral AS [Tempo Real Desenv Geral],
	proj.tempo_levantado_desenv_automacao AS [Tempo Levantado Desenv Automação],
	proj.horas_retrabalho AS [Horas Retrabalho],
	proj.horas_itens_fora_escopo AS [Horas Itens Fora Escopo],
	proj.tempo_estimado_deslocamento AS [Tempo Estimado Desloc],
	proj.tempo_real_deslocamento AS [Tempo Real Desloc],
	proj.tempo_estimado_implant_automacao AS [Tempo Estimado Implant Automação],
	proj.tempo_estimado_implant_eletrica AS [Tempo Estimado Implant Elétrica],
	proj.tempo_estimado_implant_sistemas AS [Tempo Estimado Implant Sistemas],
	proj.tempo_estimado_implant_geral AS [Tempo Estimado Implant Geral],
	proj.tempo_real_implant_automacao AS [Tempo Real Implant Automação],
	proj.tempo_real_implant_eletrica AS [Tempo Real Implant Elétrica],
	proj.tempo_real_implant_sistemas AS [Tempo Real Implant Sistemas],
	proj.tempo_real_implant_geral AS [Tempo Real Implant Geral],
	proj.desvio_horas_desenv AS [Desvio Horas Desenv],
	proj.desvio_horas_implant AS [Desvio Horas Implant],
	proj.cmc AS [CMC]
FROM dbo.f_projetos_tratada AS proj
LEFT JOIN dbo.d_porte_projeto AS porte
	ON proj.porte_projeto = porte.porte_projeto
LEFT JOIN dbo.d_prioridades AS priori
	ON proj.prioridade = priori.prioridade
LEFT JOIN dbo.d_clientes AS cli
	ON proj.cliente = cli.cliente
WHERE 1 = 1
	[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
	[[AND proj.data_abertura_proposta <= {{data_final}}]]
	[[
	AND EXISTS
	(
		SELECT 1
		FROM dbo.b_projetos_setores AS bp_setor
		INNER JOIN dbo.d_setores AS st
			ON bp_setor.setor_id = st.setor_id
		WHERE bp_setor.task_gid = proj.task_gid
			AND {{setor}}
	)
	]]
	[[AND {{porte_projeto}}]]
	[[
	AND EXISTS
	(
		SELECT 1
		FROM dbo.b_projetos_colaboradores AS bp_colab
		INNER JOIN dbo.d_colaboradores AS colab
			ON bp_colab.colaborador_id = colab.colaborador_id
		WHERE bp_colab.task_gid = proj.task_gid
			AND {{colaborador}}
	)
	]]
	[[AND {{prioridade}}]]
ORDER BY
	[Cliente];