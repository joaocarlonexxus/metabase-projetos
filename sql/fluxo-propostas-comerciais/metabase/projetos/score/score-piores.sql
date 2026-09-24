WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(proj.task_name) AS [Proposta],

        -- desvio
        MAX(
            CASE
                WHEN
                    (
                        (proj.tempo_real_implant_geral - proj.tempo_estimado_implant_geral) + (proj.tempo_real_desenv_geral - proj.tempo_estimado_desenv_geral)
                    ) IS NULL
                THEN 'Sem Estimativa'
                WHEN
                    ABS(
                        (proj.tempo_real_implant_geral - proj.tempo_estimado_implant_geral) + (proj.tempo_real_desenv_geral - proj.tempo_estimado_desenv_geral)
                    ) <= 16
                THEN 'Dentro do esperado'
                WHEN
                    ABS(
                        (proj.tempo_real_implant_geral - proj.tempo_estimado_implant_geral) + (proj.tempo_real_desenv_geral - proj.tempo_estimado_desenv_geral)
                    ) <= 80
                THEN 'Atenção'
                ELSE 'Crítico'
            END
        ) AS desvio,

        -- eficiencia
        MAX(
            CASE
                WHEN
                    COALESCE(proj.tempo_estimado_desenv_geral, 0) + COALESCE(proj.tempo_estimado_implant_geral, 0) = 0
                THEN 0
                ELSE
                    (COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.tempo_real_implant_geral, 0)) /
                    (COALESCE(proj.tempo_estimado_desenv_geral, 0) + COALESCE(proj.tempo_estimado_implant_geral, 0))
            END
        ) AS eficiencia,

        -- retrabalho
        MAX(
            CASE
                WHEN
                    COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.horas_retrabalho, 0) = 0
                THEN 0
                ELSE
                    COALESCE(proj.horas_retrabalho, 0) / (COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.horas_retrabalho, 0))
            END
        ) AS retrabalho,

        -- itens fora de escopo
        MAX(
            CASE
                WHEN
                    COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.horas_itens_fora_escopo, 0) = 0
                THEN 0
                ELSE
                    COALESCE(proj.horas_itens_fora_escopo, 0) / (COALESCE(proj.tempo_real_desenv_geral, 0) + COALESCE(proj.horas_itens_fora_escopo, 0))
            END
        ) AS fora_escopo
    FROM dbo.vw_projetos_tratada AS proj
        LEFT JOIN dbo.d_colaboradores AS colab
            ON proj.colaborador = colab.colaborador
        LEFT JOIN dbo.d_porte_projeto AS porte
            ON proj.porte_projeto = porte.porte_projeto
    WHERE 1 = 1
        [[AND proj.data_abertura_proposta >= {{data_inicio}}]]
        [[AND proj.data_abertura_proposta <= {{data_fim}}]]
        [[AND {{setor}}]]
        [[AND {{porte_projeto}}]]
        [[AND {{colaborador}}]]
    GROUP BY
        proj.task_gid
),
Score AS
(
    SELECT
        task_gid,
        [Proposta],
        -- desvio
        desvio,
        CASE
            WHEN desvio = 'Dentro do esperado' THEN 1
            WHEN desvio = 'Atenção' THEN 0.6667
            WHEN desvio = 'Crítico' THEN 0.3333
            ELSE 0.1667
        END * 23.08 AS desvio_result,

        -- eficiencia
        eficiencia,
        CASE
            WHEN eficiencia >= 0.95 AND eficiencia <= 1.10 THEN 1
            WHEN eficiencia >= 0.70 AND eficiencia < 0.95 THEN 0.6667
            WHEN eficiencia < 0.70 THEN 0.3333
            ELSE 0.1667
        END * 30.78 AS eficiencia_result,

        -- retrabalho
        retrabalho,
        CASE
            WHEN retrabalho <= 0.05 THEN 1
            WHEN retrabalho <= 0.10 THEN 0.6667
            ELSE 0.3333
        END * 30.78 AS retrabalho_result,

        -- itens fora de escopo
        fora_escopo,
        CASE
            WHEN fora_escopo <= 0.05 THEN 1
            WHEN fora_escopo <= 0.10 THEN 0.6667
            ELSE 0.3333
        END * 15.36 AS fora_escopo_result
    FROM Projetos
)
SELECT
	TOP 10
    task_gid,
    [Proposta],
	desvio_result AS [Desvio],
	eficiencia_result AS [Eficiência],
	retrabalho_result AS [Retrabalho],
	fora_escopo_result AS [Fora Escopo],
    (desvio_result + eficiencia_result + retrabalho_result + fora_escopo_result) AS [Score Total]
FROM Score
ORDER BY
    [Score Total], [Proposta] ASC;