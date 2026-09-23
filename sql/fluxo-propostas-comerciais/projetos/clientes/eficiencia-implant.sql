WITH Projetos AS
(
	SELECT
		proj.task_gid,
		MAX(proj.tempo_estimado_implant_geral) AS tempo_estimado,
		MAX(proj.tempo_real_implant_geral) AS tempo_real
	FROM dbo.vw_projetos_tratada AS proj
		LEFT JOIN dbo.d_clientes AS cli
			ON proj.cliente = cli.cliente
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
		[[AND {{cliente}}]]
	GROUP BY
		proj.task_gid
)
SELECT
	COALESCE(
		SUM(tempo_estimado) / NULLIF(SUM(tempo_real), 0),
		0
	) AS [Estimado x Real - Implant.]
FROM Projetos;