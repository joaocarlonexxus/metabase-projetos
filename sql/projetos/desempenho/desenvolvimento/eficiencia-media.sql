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
        LEFT JOIN dbo.d_colaboradores AS colab
            ON proj.colaborador = colab.colaborador
        LEFT JOIN dbo.d_porte_projeto AS porte
            ON proj.porte_projeto = porte.porte_projeto
    WHERE
        proj.status_projeto = 'Finalizado'
        AND
        (
            CASE
                WHEN 1 = 0 THEN 0
                [[WHEN {{setor}} AND proj.setor IN ('Automação', 'Automação Ágil')
                    THEN
                        CASE
                            WHEN proj.tempo_real_desenv_automacao > 0 AND proj.tempo_estimado_desenv_automacao > 0
                            THEN 1 ELSE 0
                        END]]
                [[WHEN {{setor}} AND proj.setor = 'Elétrica'
                    THEN
                        CASE
                            WHEN proj.tempo_real_desenv_eletrica > 0 AND proj.tempo_estimado_desenv_eletrica > 0
                            THEN 1 ELSE 0
                        END]]
                [[WHEN {{setor}} AND proj.setor = 'Sistemas'
                    THEN
                        CASE
                            WHEN proj.tempo_real_desenv_sistemas > 0 AND proj.tempo_estimado_desenv_sistemas > 0
                            THEN 1 ELSE 0
                        END]]
                ELSE
                    CASE
                        WHEN proj.tempo_real_desenv_geral > 0
                         AND proj.tempo_estimado_desenv_geral > 0
                        THEN 1 ELSE 0
                    END
            END = 1
        )
        [[AND proj.data_termino >= {{data_inicial}}]]
        [[AND proj.data_termino <= {{data_final}}]]
        [[AND {{setor}}]]
        [[AND {{porte_projeto}}]]
        [[AND {{colaborador}}]]
    GROUP BY
        proj.task_gid
)
SELECT
    COALESCE(
        SUM(tempo_real) / NULLIF(SUM(tempo_estimado), 0),
        0
    ) AS [Eficiência Média - Desenv.]
FROM Projetos;