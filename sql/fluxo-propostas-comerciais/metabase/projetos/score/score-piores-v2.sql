SELECT 
	TOP 10
    proj.task_gid,
    MAX(cli.cliente_simples) AS [Cliente],
    MAX(proj.task_name) AS [Proposta],
    MAX(proj.tempo_estimado_desenv_geral) AS [Desenv. - Planejado],
    MAX(proj.tempo_real_desenv_geral) AS [Desenv. - Executado],
    MAX(proj.tempo_estimado_implant_geral) AS [Implant. - Planejado],
    MAX(proj.tempo_real_implant_geral) AS [Implant. - Executado],
    MAX(proj.horas_retrabalho) AS [Horas de Retrabalho],
    MAX(proj.horas_itens_fora_escopo) AS [Horas de Itens Fora do Escopo],
	MAX(
	    CASE
	        WHEN
	            COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.tempo_real_implant_geral, 0) + COALESCE(proj.horas_retrabalho, 0) + COALESCE(proj.horas_itens_fora_escopo, 0)
	            <=
	            COALESCE(proj.tempo_estimado_desenv_geral, 0) + COALESCE(proj.tempo_estimado_implant_geral, 0)
	        THEN 1
	        ELSE
	            (
	                COALESCE(proj.tempo_estimado_desenv_geral, 0) + COALESCE(proj.tempo_estimado_implant_geral, 0)
	            )
	            /
	            NULLIF(
	                COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.tempo_real_implant_geral, 0) + COALESCE(proj.horas_retrabalho, 0) + COALESCE(proj.horas_itens_fora_escopo, 0),
	                0
	            )
	    END
	) AS [Eficiência]
FROM dbo.vw_projetos_tratada AS proj
    LEFT JOIN dbo.d_colaboradores AS colab
        ON proj.colaborador = colab.colaborador
    LEFT JOIN dbo.d_porte_projeto AS porte
        ON proj.porte_projeto = porte.porte_projeto
    LEFT JOIN dbo.d_clientes AS cli
        ON proj.cliente = cli.cliente
WHERE proj.status_projeto = 'Finalizado'
    [[AND proj.data_termino >= {{data_inicio}}]]
    [[AND proj.data_termino <= {{data_final}}]]
    [[AND {{setor}}]]
    [[AND {{porte_projeto}}]]
    [[AND {{colaborador}}]]
GROUP BY proj.task_gid
ORDER BY
    [Eficiência] ASC,
    [Cliente] ASC,
    [Proposta] ASC;