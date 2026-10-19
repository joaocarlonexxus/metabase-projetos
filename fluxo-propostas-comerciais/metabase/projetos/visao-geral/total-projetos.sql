SELECT
    COUNT(DISTINCT proj.task_gid) AS [Total de Projetos]
FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_colaboradores AS colab
    	ON proj.colaborador = colab.colaborador
	LEFT JOIN dbo.d_porte_projeto AS porte
    	ON proj.porte_projeto = porte.porte_projeto
	LEFT JOIN dbo.d_tipos_proposta AS tp
		ON proj.tipo_proposta = tp.tipo_proposta
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
	[[
	AND EXISTS
	(
		SELECT 1
		FROM dbo.b_projetos_tipos_proposta AS bp_tp
		INNER JOIN dbo.d_tipos_proposta AS tp
			ON bp_tp.tipo_proposta_id = tp.tipo_proposta_id
		WHERE bp_tp.task_gid = proj.task_gid
			AND {{tipo_proposta}}
	)
	]];

/*
O filtro de tipo de proposta foi adicionado neste indicador para que o Eduard extraía o valor para inserir na Reunião de acompanhamento Lista de Prioridades.
*/
