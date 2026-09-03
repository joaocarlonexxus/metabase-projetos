SELECT
    COUNT(DISTINCT proj.task_gid) AS [Total de Projetos],
    CASE
        WHEN proj.processo = 'Defensivos Agrícolas' THEN 'Def. Agrícolas'
        WHEN proj.processo = 'Fertilizantes' THEN 'Fertilizantes'
        WHEN proj.processo = 'Indústria Química' THEN 'Ind. Química'
        WHEN proj.processo = 'Nutrição Animal' THEN 'Nutr. Animal'
        WHEN proj.processo = 'Outros' THEN 'Outros'
        WHEN proj.processo = 'Terminal Portuário / Recebimento' THEN 'Term. Port. / Rec.'
        ELSE proj.processo
    END AS [Processo]
FROM dbo.vw_projetos_tratada AS proj
    LEFT JOIN dbo.d_colaboradores AS colab
        ON proj.colaborador = colab.colaborador
    LEFT JOIN dbo.d_porte_projeto AS porte
        ON proj.porte_projeto = porte.porte_projeto
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
    AND NULLIF(LTRIM(RTRIM(proj.processo)), '') IS NOT NULL
    [[AND proj.data_abertura_proposta >= {{data_inicial}}]]
    [[AND proj.data_abertura_proposta <= {{data_final}}]]
    [[AND {{setor}}]]
    [[AND {{porte_projeto}}]]
    [[AND {{colaborador}}]]
GROUP BY
    proj.processo;