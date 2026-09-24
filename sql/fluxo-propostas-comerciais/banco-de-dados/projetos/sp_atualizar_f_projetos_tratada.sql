USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_f_projetos_tratada]    Data do Script: 24/09/2026 14:30:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_atualizar_f_projetos_tratada]
    @execucao_n8n_id NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE b
        FROM dbo.b_projetos_documentos AS b
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dbo.f_projetos_raw AS r
            WHERE r.task_gid = b.task_gid
        );

        DELETE b
        FROM dbo.b_projetos_colaboradores AS b
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dbo.f_projetos_raw AS r
            WHERE r.task_gid = b.task_gid
        );

        DELETE b
        FROM dbo.b_projetos_tipos_proposta AS b
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dbo.f_projetos_raw AS r
            WHERE r.task_gid = b.task_gid
        );

        ;WITH dados_tratados AS
        (
            SELECT
                r.task_gid,
                r.project_gid,
                r.section_gid,
                r.task_name,
                r.task_section_name,

                r.completed,
                r.completed_at,
                r.created_at,
                r.modified_at,
                r.start_on,
                r.due_on,
                r.assignee_gid,
                r.assignee_name,

                r.atualizacao_semanal,
                r.cliente,
                r.proposta,
                r.tipo_contrato,
                r.setor,
                r.prioridade,
                r.porte_projeto,
                r.tipo_proposta,
                r.etapa_proposta,
                r.status_projeto,
                r.responsavel_comercial,
                r.cnpj,
                r.email_nfs,
                r.atualizacoes,
                r.processo,
                r.colaborador,
                r.documentos,
                r.tipo_item,
                r.status_prazo,
                r.origem_impacto,
                r.tipo_startup,
                r.ticket,

                r.data_termino,
                r.data_estimada_finalizacao,
                r.data_abertura_proposta,
                r.data_inicio,
                r.data_reuniao_abertura,
                r.data_reuniao_kickoff,
                r.data_reuniao_encerramento,

                r.tempo_estimado_desenv,
                r.tempo_estimado_desenv_automacao,
                r.tempo_estimado_desenv_eletrica,
                r.tempo_estimado_desenv_sistemas,

                CASE
                    WHEN COALESCE(r.tempo_estimado_desenv, 0) > 0
                        THEN r.tempo_estimado_desenv
                    ELSE
                        COALESCE(r.tempo_estimado_desenv_automacao, 0)
                        + COALESCE(r.tempo_estimado_desenv_eletrica, 0)
                        + COALESCE(r.tempo_estimado_desenv_sistemas, 0)
                END AS tempo_estimado_desenv_geral,

                r.tempo_real_desenv,
                r.tempo_real_desenv_automacao,
                r.tempo_real_desenv_eletrica,
                r.tempo_real_desenv_sistemas,

                CASE
                    WHEN COALESCE(r.tempo_real_desenv, 0) > 0
                        THEN r.tempo_real_desenv
                    ELSE
                        COALESCE(r.tempo_real_desenv_automacao, 0)
                        + COALESCE(r.tempo_real_desenv_eletrica, 0)
                        + COALESCE(r.tempo_real_desenv_sistemas, 0)
                END AS tempo_real_desenv_geral,

                r.tempo_estimado_implant,
                r.tempo_estimado_implant_automacao,
                r.tempo_estimado_implant_eletrica,
                r.tempo_estimado_implant_sistemas,

                CASE
                    WHEN COALESCE(r.tempo_estimado_implant, 0) > 0
                        THEN r.tempo_estimado_implant
                    ELSE
                        COALESCE(r.tempo_estimado_implant_automacao, 0)
                        + COALESCE(r.tempo_estimado_implant_eletrica, 0)
                        + COALESCE(r.tempo_estimado_implant_sistemas, 0)
                END AS tempo_estimado_implant_geral,

                r.tempo_real_implant,
                r.tempo_real_implant_automacao,
                r.tempo_real_implant_eletrica,
                r.tempo_real_implant_sistemas,

                CASE
                    WHEN COALESCE(r.tempo_real_implant, 0) > 0
                        THEN r.tempo_real_implant
                    ELSE
                        COALESCE(r.tempo_real_implant_automacao, 0)
                        + COALESCE(r.tempo_real_implant_eletrica, 0)
                        + COALESCE(r.tempo_real_implant_sistemas, 0)
                END AS tempo_real_implant_geral,

                r.tempo_estimado_deslocamento,
                r.tempo_real_deslocamento,
                r.tempo_levantado_desenv_automacao,
                r.horas_retrabalho,
                r.horas_itens_fora_escopo,

                r.execucao_n8n_id AS execucao_raw_id
            FROM dbo.f_projetos_raw AS r
        ),
        dados_com_cmc AS
        (
            SELECT
                d.*,

                CASE
                    WHEN
                        d.tempo_real_desenv_geral
                        - d.tempo_estimado_desenv_geral > 0
                    THEN
                        d.tempo_real_desenv_geral
                        - d.tempo_estimado_desenv_geral
                    ELSE 0
                END AS cmc_desenv,

                CASE
                    WHEN
                        d.tempo_real_implant_geral
                        - d.tempo_estimado_implant_geral > 0
                    THEN
                        d.tempo_real_implant_geral
                        - d.tempo_estimado_implant_geral
                    ELSE 0
                END AS cmc_implant,

                CASE
                    WHEN d.tempo_real_desenv_geral IS NOT NULL
                        AND d.tempo_estimado_desenv_geral IS NOT NULL
                    THEN d.tempo_real_desenv_geral - d.tempo_estimado_desenv_geral
                END AS desvio_horas_desenv,

                CASE
                    WHEN d.tempo_real_implant_geral IS NOT NULL
                        AND d.tempo_estimado_implant_geral IS NOT NULL
                    THEN d.tempo_real_implant_geral - d.tempo_estimado_implant_geral
                END AS desvio_horas_implant

            FROM dados_tratados AS d
        ),
        origem AS
        (
            SELECT
                d.*,
                d.cmc_desenv + d.cmc_implant AS cmc
            FROM dados_com_cmc AS d
        )

        MERGE dbo.f_projetos_tratada AS destino
        USING origem AS fonte
            ON destino.task_gid = fonte.task_gid

        WHEN MATCHED THEN
            UPDATE SET
                destino.project_gid = fonte.project_gid,
                destino.section_gid = fonte.section_gid,
                destino.task_name = fonte.task_name,
                destino.task_section_name = fonte.task_section_name,

                destino.completed = fonte.completed,
                destino.completed_at = fonte.completed_at,
                destino.created_at = fonte.created_at,
                destino.modified_at = fonte.modified_at,
                destino.start_on = fonte.start_on,
                destino.due_on = fonte.due_on,
                destino.assignee_gid = fonte.assignee_gid,
                destino.assignee_name = fonte.assignee_name,

                destino.atualizacao_semanal = fonte.atualizacao_semanal,
                destino.cliente = fonte.cliente,
                destino.proposta = fonte.proposta,
                destino.tipo_contrato = fonte.tipo_contrato,
                destino.setor = fonte.setor,
                destino.prioridade = fonte.prioridade,
                destino.porte_projeto = fonte.porte_projeto,
                destino.tipo_proposta = fonte.tipo_proposta,
                destino.etapa_proposta = fonte.etapa_proposta,
                destino.status_projeto = fonte.status_projeto,
                destino.responsavel_comercial = fonte.responsavel_comercial,
                destino.cnpj = fonte.cnpj,
                destino.email_nfs = fonte.email_nfs,
                destino.atualizacoes = fonte.atualizacoes,
                destino.processo = fonte.processo,
                destino.colaborador = fonte.colaborador,
                destino.documentos = fonte.documentos,
                destino.tipo_item = fonte.tipo_item,
                destino.status_prazo = fonte.status_prazo,
                destino.origem_impacto = fonte.origem_impacto,
                destino.tipo_startup = fonte.tipo_startup,
                destino.ticket = fonte.ticket,

                destino.data_termino = fonte.data_termino,
                destino.data_estimada_finalizacao = fonte.data_estimada_finalizacao,
                destino.data_abertura_proposta = fonte.data_abertura_proposta,
                destino.data_inicio = fonte.data_inicio,
                destino.data_reuniao_abertura = fonte.data_reuniao_abertura,
                destino.data_reuniao_kickoff = fonte.data_reuniao_kickoff,
                destino.data_reuniao_encerramento = fonte.data_reuniao_encerramento,

                destino.tempo_estimado_desenv = fonte.tempo_estimado_desenv,
                destino.tempo_estimado_desenv_automacao = fonte.tempo_estimado_desenv_automacao,
                destino.tempo_estimado_desenv_eletrica = fonte.tempo_estimado_desenv_eletrica,
                destino.tempo_estimado_desenv_sistemas = fonte.tempo_estimado_desenv_sistemas,
                destino.tempo_estimado_desenv_geral = fonte.tempo_estimado_desenv_geral,

                destino.tempo_real_desenv = fonte.tempo_real_desenv,
                destino.tempo_real_desenv_automacao = fonte.tempo_real_desenv_automacao,
                destino.tempo_real_desenv_eletrica = fonte.tempo_real_desenv_eletrica,
                destino.tempo_real_desenv_sistemas = fonte.tempo_real_desenv_sistemas,
                destino.tempo_real_desenv_geral = fonte.tempo_real_desenv_geral,

                destino.tempo_estimado_implant = fonte.tempo_estimado_implant,
                destino.tempo_estimado_implant_automacao = fonte.tempo_estimado_implant_automacao,
                destino.tempo_estimado_implant_eletrica = fonte.tempo_estimado_implant_eletrica,
                destino.tempo_estimado_implant_sistemas = fonte.tempo_estimado_implant_sistemas,
                destino.tempo_estimado_implant_geral = fonte.tempo_estimado_implant_geral,

                destino.tempo_real_implant = fonte.tempo_real_implant,
                destino.tempo_real_implant_automacao = fonte.tempo_real_implant_automacao,
                destino.tempo_real_implant_eletrica = fonte.tempo_real_implant_eletrica,
                destino.tempo_real_implant_sistemas = fonte.tempo_real_implant_sistemas,
                destino.tempo_real_implant_geral = fonte.tempo_real_implant_geral,

                destino.desvio_horas_desenv = fonte.desvio_horas_desenv,
                destino.desvio_horas_implant = fonte.desvio_horas_implant,

                destino.tempo_estimado_deslocamento = fonte.tempo_estimado_deslocamento,
                destino.tempo_real_deslocamento = fonte.tempo_real_deslocamento,
                destino.tempo_levantado_desenv_automacao = fonte.tempo_levantado_desenv_automacao,
                destino.horas_retrabalho = fonte.horas_retrabalho,
                destino.horas_itens_fora_escopo = fonte.horas_itens_fora_escopo,

                destino.cmc_desenv = fonte.cmc_desenv,
                destino.cmc_implant = fonte.cmc_implant,
                destino.cmc = fonte.cmc,

                destino.data_ultimo_tratamento = SYSUTCDATETIME(),

                destino.execucao_n8n_id =
                    COALESCE(@execucao_n8n_id, fonte.execucao_raw_id)

        WHEN NOT MATCHED BY TARGET THEN
            INSERT
            (
                task_gid,
                project_gid,
                section_gid,
                task_name,
                task_section_name,

                completed,
                completed_at,
                created_at,
                modified_at,
                start_on,
                due_on,
                assignee_gid,
                assignee_name,

                atualizacao_semanal,
                cliente,
                proposta,
                tipo_contrato,
                setor,
                prioridade,
                porte_projeto,
                tipo_proposta,
                etapa_proposta,
                status_projeto,
                responsavel_comercial,
                cnpj,
                email_nfs,
                atualizacoes,
                processo,
                colaborador,
                documentos,
                tipo_item,
                status_prazo,
                origem_impacto,
                tipo_startup,
                ticket,

                data_termino,
                data_estimada_finalizacao,
                data_abertura_proposta,
                data_inicio,
                data_reuniao_abertura,
                data_reuniao_kickoff,
                data_reuniao_encerramento,

                tempo_estimado_desenv,
                tempo_estimado_desenv_automacao,
                tempo_estimado_desenv_eletrica,
                tempo_estimado_desenv_sistemas,
                tempo_estimado_desenv_geral,

                tempo_real_desenv,
                tempo_real_desenv_automacao,
                tempo_real_desenv_eletrica,
                tempo_real_desenv_sistemas,
                tempo_real_desenv_geral,

                tempo_estimado_implant,
                tempo_estimado_implant_automacao,
                tempo_estimado_implant_eletrica,
                tempo_estimado_implant_sistemas,
                tempo_estimado_implant_geral,

                tempo_real_implant,
                tempo_real_implant_automacao,
                tempo_real_implant_eletrica,
                tempo_real_implant_sistemas,
                tempo_real_implant_geral,

                desvio_horas_desenv,
                desvio_horas_implant,

                tempo_estimado_deslocamento,
                tempo_real_deslocamento,
                tempo_levantado_desenv_automacao,
                horas_retrabalho,
                horas_itens_fora_escopo,

                cmc_desenv,
                cmc_implant,
                cmc,

                data_primeiro_tratamento,
                data_ultimo_tratamento,
                execucao_n8n_id
            )
            VALUES
            (
                fonte.task_gid,
                fonte.project_gid,
                fonte.section_gid,
                fonte.task_name,
                fonte.task_section_name,

                fonte.completed,
                fonte.completed_at,
                fonte.created_at,
                fonte.modified_at,
                fonte.start_on,
                fonte.due_on,
                fonte.assignee_gid,
                fonte.assignee_name,

                fonte.atualizacao_semanal,
                fonte.cliente,
                fonte.proposta,
                fonte.tipo_contrato,
                fonte.setor,
                fonte.prioridade,
                fonte.porte_projeto,
                fonte.tipo_proposta,
                fonte.etapa_proposta,
                fonte.status_projeto,
                fonte.responsavel_comercial,
                fonte.cnpj,
                fonte.email_nfs,
                fonte.atualizacoes,
                fonte.processo,
                fonte.colaborador,
                fonte.documentos,
                fonte.tipo_item,
                fonte.status_prazo,
                fonte.origem_impacto,
                fonte.tipo_startup,
                fonte.ticket,

                fonte.data_termino,
                fonte.data_estimada_finalizacao,
                fonte.data_abertura_proposta,
                fonte.data_inicio,
                fonte.data_reuniao_abertura,
                fonte.data_reuniao_kickoff,
                fonte.data_reuniao_encerramento,

                fonte.tempo_estimado_desenv,
                fonte.tempo_estimado_desenv_automacao,
                fonte.tempo_estimado_desenv_eletrica,
                fonte.tempo_estimado_desenv_sistemas,
                fonte.tempo_estimado_desenv_geral,

                fonte.tempo_real_desenv,
                fonte.tempo_real_desenv_automacao,
                fonte.tempo_real_desenv_eletrica,
                fonte.tempo_real_desenv_sistemas,
                fonte.tempo_real_desenv_geral,

                fonte.tempo_estimado_implant,
                fonte.tempo_estimado_implant_automacao,
                fonte.tempo_estimado_implant_eletrica,
                fonte.tempo_estimado_implant_sistemas,
                fonte.tempo_estimado_implant_geral,

                fonte.tempo_real_implant,
                fonte.tempo_real_implant_automacao,
                fonte.tempo_real_implant_eletrica,
                fonte.tempo_real_implant_sistemas,
                fonte.tempo_real_implant_geral,

                fonte.desvio_horas_desenv,
                fonte.desvio_horas_implant,

                fonte.tempo_estimado_deslocamento,
                fonte.tempo_real_deslocamento,
                fonte.tempo_levantado_desenv_automacao,
                fonte.horas_retrabalho,
                fonte.horas_itens_fora_escopo,

                fonte.cmc_desenv,
                fonte.cmc_implant,
                fonte.cmc,

                SYSUTCDATETIME(),
                SYSUTCDATETIME(),
                COALESCE(@execucao_n8n_id, fonte.execucao_raw_id)
            )

        WHEN NOT MATCHED BY SOURCE THEN
            DELETE;

        DECLARE @registros_afetados INT = @@ROWCOUNT;

        COMMIT TRANSACTION;

        SELECT
            CAST(1 AS BIT) AS sucesso,
            @registros_afetados AS registros_afetados,
            SYSUTCDATETIME() AS data_execucao;

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH;
END;
GO


