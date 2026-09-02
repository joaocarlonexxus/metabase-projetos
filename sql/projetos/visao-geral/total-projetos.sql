SELECT
    COUNT(DISTINCT proj.task_gid) AS [Total de Projetos]
FROM dbo.vw_projetos_tratada AS proj
	LEFT JOIN dbo.d_colaboradores AS colab
    	ON proj.colaborador = colab.colaborador
	LEFT JOIN dbo.d_porte_projeto AS porte
    	ON proj.porte_projeto = porte.porte_projeto
WHERE 1 = 1
    [[AND proj.data_abertura_proposta >= {{data_inicial}}]]
    [[AND proj.data_abertura_proposta <= {{data_final}}]]
    [[AND {{setor}}]]
    [[AND {{porte_projeto}}]]
    [[AND {{colaborador}}]];