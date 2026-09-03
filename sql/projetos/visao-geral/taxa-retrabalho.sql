WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(proj.tempo_real_desenv_geral) AS tempo_real_desenv_geral,
        MAX(proj.horas_retrabalho) AS horas_retrabalho
    FROM dbo.vw_projetos_tratada AS proj
        LEFT JOIN dbo.d_colaboradores AS colab
            ON proj.colaborador = colab.colaborador
        LEFT JOIN dbo.d_porte_projeto AS porte
            ON proj.porte_projeto = porte.porte_projeto
    WHERE
        proj.status_projeto = 'Finalizado'
        [[AND proj.data_abertura_proposta >= {{data_inicial}}]]
        [[AND proj.data_abertura_proposta <= {{data_final}}]]
        [[AND {{setor}}]]
        [[AND {{porte_projeto}}]]
        [[AND {{colaborador}}]]
    GROUP BY
        proj.task_gid
)
SELECT
    COALESCE(
        SUM(horas_retrabalho) / NULLIF(SUM(tempo_real_desenv_geral) + SUM(horas_retrabalho), 0),
        0
    ) AS [Taxa de Retrabalho]
FROM Projetos;