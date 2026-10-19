SELECT DISTINCT
	cli.cliente_simples AS [Cliente]
FROM dbo.f_projetos_tratada AS proj
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
	);