WITH Projetos AS
(
	SELECT
		proj.task_gid,
		MAX(proj.tempo_estimado_implant_geral) AS tempo_estimado,
		MAX(proj.tempo_real_implant_geral) AS tempo_real
	FROM dbo.vw_projetos_tratada AS proj
		LEFT JOIN dbo.d_clientes AS cli
			ON proj.cliente = cli.cliente
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
		[[AND {{cliente}}]]
	GROUP BY
		proj.task_gid
)
SELECT
	COALESCE(
		SUM(tempo_real) / NULLIF(SUM(tempo_estimado), 0),
		0
	) AS [Desvio Esforço - Implant.]
FROM Projetos;