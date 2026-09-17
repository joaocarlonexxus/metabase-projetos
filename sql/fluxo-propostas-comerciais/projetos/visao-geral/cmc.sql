WITH Projetos AS
(
	SELECT
		proj.task_gid,
		MAX(proj.cmc) AS cmc
	FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_porte_projeto AS porte
		ON proj.porte_projeto = porte.porte_projeto
	WHERE proj.status_projeto = 'Finalizado'
		AND proj.cmc > 0
		[[AND proj.data_termino >= {{data_inicial}}]]
		[[AND proj.data_termino <= {{data_final}}]]
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
		proj.task_gid
)
SELECT
	COALESCE(
		SUM(cmc) / NULLIF(COUNT(cmc), 0),
		0
	) AS [CMC]
FROM Projetos;