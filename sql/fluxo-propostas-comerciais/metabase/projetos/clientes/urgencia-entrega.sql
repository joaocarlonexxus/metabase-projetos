SELECT
	COUNT(DISTINCT proj.task_gid) AS [Total de Projetos],
	ue.urgencia_entrega AS [Urgência de Entrega]
FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_urgencias_entrega AS ue
		ON proj.urgencia_entrega = ue.urgencia_entrega
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
	ue.urgencia_entrega
ORDER BY
	CASE
		WHEN ue.urgencia_entrega = 'Crítica' THEN 1
		WHEN ue.urgencia_entrega = 'Alta' THEN 2
		WHEN ue.urgencia_entrega = 'Média' THEN 3
		WHEN ue.urgencia_entrega = 'Baixa' THEN 4
	END;