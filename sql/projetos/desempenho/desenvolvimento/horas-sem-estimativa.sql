WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(
            CASE
                WHEN proj.setor IN ('Automação', 'Automação Ágil')
                    THEN COALESCE(proj.tempo_estimado_desenv_automacao, 0)
                WHEN proj.setor = 'Elétrica'
                    THEN COALESCE(proj.tempo_estimado_desenv_eletrica, 0)
                WHEN proj.setor = 'Sistemas'
                    THEN COALESCE(proj.tempo_estimado_desenv_sistemas, 0)
                ELSE COALESCE(proj.tempo_estimado_desenv_geral, 0)
            END
        ) AS tempo_estimado,
        MAX(
            CASE
                WHEN proj.setor IN ('Automação', 'Automação Ágil')
                    THEN COALESCE(proj.tempo_real_desenv_automacao, 0)
                WHEN proj.setor = 'Elétrica'
                    THEN COALESCE(proj.tempo_real_desenv_eletrica, 0)
                WHEN proj.setor = 'Sistemas'
                    THEN COALESCE(proj.tempo_real_desenv_sistemas, 0)
                ELSE COALESCE(proj.tempo_real_desenv_geral, 0)
            END
        ) AS tempo_real
    FROM dbo.vw_projetos_tratada AS proj
        LEFT JOIN dbo.d_colaboradores AS colab
            ON proj.colaborador = colab.colaborador
        LEFT JOIN dbo.d_porte_projeto AS porte
        ON proj.porte_projeto = porte.porte_projeto
    WHERE
        proj.status_projeto IN (
            'Não Iniciado',
            'Em Desenvolvimento',
            'Desenvolvimento Pausado'
        )
        [[AND proj.data_abertura_proposta >= {{data_inicial}}]]
        [[AND proj.data_abertura_proposta <= {{data_final}}]]
        [[AND {{setor}}]]
        [[AND {{porte_projeto}}]]
        [[AND {{colaborador}}]]
    GROUP BY
        proj.task_gid
)
SELECT
    CASE
        WHEN SUM(tempo_estimado) - SUM(tempo_real) < 0 THEN 0
        ELSE SUM(tempo_estimado) - SUM(tempo_real)
    END AS [Horas Estimadas]
FROM Projetos;