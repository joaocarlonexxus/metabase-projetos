WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(proj.tempo_real_desenv_geral) AS tempo_real_desenv_geral,
        MAX(proj.horas_itens_fora_escopo) AS horas_itens_fora_escopo
	FROM dbo.vw_projetos_tratada AS proj
	    LEFT JOIN dbo.d_colaboradores AS colab
	        ON proj.colaborador = colab.colaborador
	    LEFT JOIN dbo.d_porte_projeto AS porte
	        ON proj.porte_projeto = porte.porte_projeto
    WHERE
        proj.status_projeto = 'Finalizado'
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
        SUM(horas_itens_fora_escopo) / NULLIF(SUM(tempo_real_desenv_geral) + SUM(horas_itens_fora_escopo), 0),
        0
    ) AS [Taxa de Itens Fora do Escopo]
FROM Projetos;