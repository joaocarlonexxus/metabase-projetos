SELECT
	proj.task_gid,
	cli.cliente_simples AS [Cliente],
	proj.task_name AS [Proposta],
	proj.colaborador AS [Colaborador],
	proj.status_projeto AS [Status Projeto]
FROM dbo.f_projetos_tratada AS proj
	LEFT JOIN dbo.d_porte_projeto AS porte
		ON proj.porte_projeto = porte.porte_projeto
	LEFT JOIN dbo.d_prioridades AS priori
		ON proj.prioridade = priori.prioridade
	LEFT JOIN dbo.d_clientes AS cli
		ON proj.cliente = cli.cliente
WHERE 
	proj.status_projeto IN (
		'Em Desenvolvimento',
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
		FROM dbo.b_projetos_colaboradores AS bp_colab
		INNER JOIN dbo.d_colaboradores AS colab
			ON bp_colab.colaborador_id = colab.colaborador_id
		WHERE bp_colab.task_gid = proj.task_gid
			AND {{colaborador}}
	)
	]]
	[[AND {{cliente}}]]
ORDER BY
	[Cliente], [Colaborador] ASC;

/*
* Observações:
    * Script criado para ser utilizado no relatório de acompanhamento de projetos ativos no Asana.
    * A listagem de projetos ativos deve trazer apenas os projetos com seguintes status:
        * Em Desenvolvimento;
        * Aguardando Implantação;
        * Em Implantação;
        * Fornecimento de Materiais;
        * Em Fechamento.
    * A listagem deverá desconsiderar os projetos que estão nas seguintes seções do Asana:
        * 11. Controle Suporte;
        * 12. Controle de Suporte - Vencidos;
        * 13. Reunião de Fechamento;
        * 14. Finalizado;
        * 15. Excedente de Horas de Suporte.
*/