SELECT
	COUNT(DISTINCT proj.task_gid) AS [Total de Projetos],
	CASE
		WHEN proj.status_projeto = 'Não Iniciado' THEN 'Não Iniciado'
		WHEN proj.status_projeto = 'Em Desenvolvimento' THEN 'Em Desenv.'
		WHEN proj.status_projeto = 'Desenvolvimento Pausado' THEN 'Desenv. Pausado'
		WHEN proj.status_projeto = 'Aguardando Implantação' THEN 'Ag. Implant'
		WHEN proj.status_projeto = 'Em Implantação' THEN 'Em Implant.'
		WHEN proj.status_projeto = 'Fornecimento Materiais' THEN 'Fornec. Materiais'
		WHEN proj.status_projeto = 'Em Fechamento' THEN 'Em Fechamento'
	END AS [Status do Projeto]
FROM dbo.vw_projetos_tratada AS proj
LEFT JOIN dbo.d_porte_projeto AS porte
	ON proj.porte_projeto = porte.porte_projeto
WHERE proj.status_projeto IN (
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
GROUP BY
	proj.status_projeto
ORDER BY
	CASE
		WHEN proj.status_projeto = 'Não Iniciado' THEN 1
		WHEN proj.status_projeto = 'Em Desenvolvimento' THEN 2
		WHEN proj.status_projeto = 'Desenvolvimento Pausado' THEN 3
		WHEN proj.status_projeto = 'Aguardando Implantação' THEN 4
		WHEN proj.status_projeto = 'Em Implantação' THEN 5
		WHEN proj.status_projeto = 'Fornecimento Materiais' THEN 6
		WHEN proj.status_projeto = 'Em Fechamento' THEN 7
	END;