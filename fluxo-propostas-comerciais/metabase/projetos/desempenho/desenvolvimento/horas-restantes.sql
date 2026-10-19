WITH Projetos AS
(
	SELECT
		proj.task_gid,
		MAX(
			CASE
				WHEN 1 = 0 THEN NULL
				[[WHEN {{setor}} AND proj.setor IN ('Automação', 'Automação Ágil')
					THEN proj.tempo_real_desenv_automacao]]
				[[WHEN {{setor}} AND proj.setor = 'Elétrica'
					THEN proj.tempo_real_desenv_eletrica]]
				[[WHEN {{setor}} AND proj.setor = 'Sistemas'
					THEN proj.tempo_real_desenv_sistemas]]
				ELSE proj.tempo_real_desenv_geral
			END
		) AS tempo_real,
		MAX(
			CASE
				WHEN 1 = 0 THEN NULL
				[[WHEN {{setor}} AND proj.setor IN ('Automação', 'Automação Ágil')
					THEN proj.tempo_estimado_desenv_automacao]]
				[[WHEN {{setor}} AND proj.setor = 'Elétrica'
					THEN proj.tempo_estimado_desenv_eletrica]]
				[[WHEN {{setor}} AND proj.setor = 'Sistemas'
					THEN proj.tempo_estimado_desenv_sistemas]]
				ELSE proj.tempo_estimado_desenv_geral
			END
		) AS tempo_estimado
	FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_porte_projeto AS porte
		ON proj.porte_projeto = porte.porte_projeto
	WHERE proj.status_projeto IN (
		'Não Iniciado',
		'Em Desenvolvimento',
		'Desenvolvimento Pausado'
	)
		[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
		[[AND proj.data_abertura_proposta <= {{data_final}}]]
		[[AND {{setor}}]]
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
	CASE
		WHEN COALESCE(SUM(tempo_estimado), 0) - COALESCE(SUM(tempo_real), 0) < 0
			THEN 0
		ELSE COALESCE(SUM(tempo_estimado), 0) - COALESCE(SUM(tempo_real), 0)
	END AS [Horas Estimadas - Desenv.]
FROM Projetos;