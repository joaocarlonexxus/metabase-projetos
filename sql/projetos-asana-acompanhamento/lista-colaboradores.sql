SELECT DISTINCT
	colab.colaborador AS [Colaborador]
FROM dbo.b_projetos_colaboradores AS bp_colab
	LEFT JOIN dbo.d_colaboradores AS colab
		ON bp_colab.colaborador_id = colab.colaborador_id
	LEFT JOIN dbo.f_projetos_tratada AS proj
		ON bp_colab.task_gid = proj.task_gid
WHERE colab.ativo = 1
	AND proj.status_projeto IN (
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
	);

/*
* Observações:
    * Script criado para ser utilizado no filtro de colaboradores ativos do relatório de acompanhamento de projetos no Asana.
    * O filtro de colaboradores deve trazer apenas os colaboradores que possuem projetos ativos no Asana.
*/