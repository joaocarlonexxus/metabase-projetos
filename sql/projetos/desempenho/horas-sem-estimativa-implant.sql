WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(proj.tempo_real_implant_geral) AS tempo_real_implant_geral
    FROM dbo.vw_projetos_tratada AS proj
    LEFT JOIN dbo.d_colaboradores AS colab
        ON proj.colaborador = colab.colaborador
    LEFT JOIN dbo.d_porte_projeto AS porte
        ON proj.porte_projeto = porte.porte_projeto
    WHERE
        (
            proj.tempo_estimado_implant_geral IS NULL
            OR proj.tempo_estimado_implant_geral = 0
        )
        AND proj.tempo_real_implant_geral > 0
        --[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
        --[[AND proj.data_abertura_proposta <= {{data_final}}]]
        --[[AND {{setor}}]]
        --[[AND {{porte_projeto}}]]
        --[[AND {{colaborador}}]]
    GROUP BY
        proj.task_gid
)
SELECT
    COALESCE(SUM(tempo_real_implant_geral), 0) AS [Horas sem Estimativa - Implant.]
FROM Projetos;