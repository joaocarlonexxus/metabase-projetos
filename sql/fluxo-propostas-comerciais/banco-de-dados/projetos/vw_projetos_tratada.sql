USE [controle_projetos_new]
GO

/****** Objeto:  View [dbo].[vw_projetos_tratada]    Data do Script: 24/09/2026 14:28:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_projetos_tratada]
AS
SELECT
    p.task_gid,
    p.project_gid,
    p.section_gid,
    p.task_name,
    p.task_section_name,
    p.completed,
    p.completed_at,
    p.created_at,
    p.modified_at,
    p.start_on,
    p.due_on,
    p.assignee_gid,
    p.assignee_name,
    p.atualizacao_semanal,
    p.cliente,
    p.proposta,
    p.tipo_contrato,
    s.setor AS setor,
    p.prioridade,
    p.porte_projeto,
    p.tipo_proposta,
    p.etapa_proposta,
    p.status_projeto,
    p.responsavel_comercial,
    p.cnpj,
    p.email_nfs,
    p.atualizacoes,
    p.processo,
    p.colaborador,
    p.documentos,
    p.tipo_item,
    p.status_prazo,
    p.origem_impacto,
    p.tipo_startup,
    p.ticket,
    p.data_termino,
    p.data_estimada_finalizacao,
    p.data_abertura_proposta,
    p.data_inicio,
    p.data_reuniao_abertura,
    p.data_reuniao_kickoff,
    p.data_reuniao_encerramento,
    p.tempo_estimado_desenv,
    p.tempo_estimado_desenv_automacao,
    p.tempo_estimado_desenv_eletrica,
    p.tempo_estimado_desenv_sistemas,
    p.tempo_estimado_desenv_geral,
    p.tempo_real_desenv,
    p.tempo_real_desenv_automacao,
    p.tempo_real_desenv_eletrica,
    p.tempo_real_desenv_sistemas,
    p.tempo_real_desenv_geral,
    p.tempo_estimado_implant,
    p.tempo_estimado_implant_automacao,
    p.tempo_estimado_implant_eletrica,
    p.tempo_estimado_implant_sistemas,
    p.tempo_estimado_implant_geral,
    p.tempo_real_implant,
    p.tempo_real_implant_automacao,
    p.tempo_real_implant_eletrica,
    p.tempo_real_implant_sistemas,
    p.tempo_real_implant_geral,
    p.desvio_horas_desenv,
    p.desvio_horas_implant,
    p.tempo_estimado_deslocamento,
    p.tempo_real_deslocamento,
    p.tempo_levantado_desenv_automacao,
    p.horas_retrabalho,
    p.horas_itens_fora_escopo,
    p.cmc_desenv,
    p.cmc_implant,
    p.cmc,
    p.data_primeiro_tratamento,
    p.data_ultimo_tratamento,
    p.execucao_n8n_id
FROM dbo.f_projetos_tratada AS p
LEFT JOIN dbo.b_projetos_setores AS b
    ON p.task_gid = b.task_gid
LEFT JOIN dbo.d_setores AS s
    ON b.setor_id = s.setor_id;
GO


