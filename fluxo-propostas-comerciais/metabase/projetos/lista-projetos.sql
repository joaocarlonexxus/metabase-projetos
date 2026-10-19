SELECT
	proj.task_gid,
	cli.cliente_simples AS [Cliente],
	proj.task_name AS [Proposta],
	proj.setor AS [Setor],
	proj.colaborador AS [Colaborador],
	porte.porte_projeto AS [Porte Projeto],
	ue.urgencia_entrega AS [Urgência de Entrega],
	proj.tipo_proposta AS [Tipo Proposta],
	proj.status_projeto AS [Status Projeto],
	proj.status_prazo AS [Status Prazo],
	proj.data_abertura_proposta AS [Data Abertura],
	proj.data_inicio AS [Data Início - Desenv],
	proj.data_termino AS [Data Término],
	proj.tempo_estimado_desenv_geral AS [Desenv. Estimado - Geral],
	proj.tempo_real_desenv_geral AS [Desenv. Real - Geral],
	proj.horas_retrabalho AS [Horas Retrabalho],
	proj.horas_itens_fora_escopo AS [Horas Itens Fora Escopo],
	proj.tempo_estimado_deslocamento AS [Deslocamento - Estimado],
	proj.tempo_real_deslocamento AS [Deslocamento - Real],
	proj.tempo_estimado_implant_geral AS [Implant. Estimado - Geral],
	proj.tempo_real_implant_geral AS [Implant. Real - Geral]
FROM dbo.f_projetos_tratada AS proj
	LEFT JOIN dbo.d_porte_projeto AS porte
		ON proj.porte_projeto = porte.porte_projeto
	LEFT JOIN dbo.d_urgencias_entrega AS ue
		ON proj.urgencia_entrega = ue.urgencia_entrega
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
	[[AND {{urgencia_entrega}}]]
ORDER BY
	[Cliente] ASC, [Proposta] ASC;