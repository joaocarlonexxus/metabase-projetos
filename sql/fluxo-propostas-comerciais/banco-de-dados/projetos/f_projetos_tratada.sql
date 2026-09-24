USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[f_projetos_tratada]    Data do Script: 24/09/2026 14:18:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[f_projetos_tratada](
	[task_gid] [varchar](32) NOT NULL,
	[project_gid] [varchar](32) NULL,
	[section_gid] [varchar](32) NULL,
	[task_name] [nvarchar](500) NULL,
	[task_section_name] [nvarchar](255) NULL,
	[completed] [bit] NULL,
	[completed_at] [datetime2](3) NULL,
	[created_at] [datetime2](3) NULL,
	[modified_at] [datetime2](3) NULL,
	[start_on] [date] NULL,
	[due_on] [date] NULL,
	[assignee_gid] [varchar](32) NULL,
	[assignee_name] [nvarchar](255) NULL,
	[atualizacao_semanal] [nvarchar](max) NULL,
	[cliente] [nvarchar](500) NULL,
	[proposta] [nvarchar](500) NULL,
	[tipo_contrato] [nvarchar](255) NULL,
	[setor] [nvarchar](max) NULL,
	[prioridade] [nvarchar](255) NULL,
	[porte_projeto] [nvarchar](255) NULL,
	[tipo_proposta] [nvarchar](max) NULL,
	[etapa_proposta] [nvarchar](255) NULL,
	[status_projeto] [nvarchar](255) NULL,
	[responsavel_comercial] [nvarchar](255) NULL,
	[cnpj] [nvarchar](50) NULL,
	[email_nfs] [nvarchar](500) NULL,
	[atualizacoes] [nvarchar](max) NULL,
	[processo] [nvarchar](500) NULL,
	[colaborador] [nvarchar](max) NULL,
	[documentos] [nvarchar](max) NULL,
	[tipo_item] [nvarchar](255) NULL,
	[status_prazo] [nvarchar](255) NULL,
	[origem_impacto] [nvarchar](255) NULL,
	[tipo_startup] [nvarchar](255) NULL,
	[ticket] [nvarchar](255) NULL,
	[data_termino] [date] NULL,
	[data_estimada_finalizacao] [date] NULL,
	[data_abertura_proposta] [date] NULL,
	[data_inicio] [date] NULL,
	[tempo_estimado_desenv] [decimal](18, 2) NULL,
	[tempo_estimado_desenv_automacao] [decimal](18, 2) NULL,
	[tempo_estimado_desenv_eletrica] [decimal](18, 2) NULL,
	[tempo_estimado_desenv_sistemas] [decimal](18, 2) NULL,
	[tempo_estimado_desenv_geral] [decimal](18, 2) NULL,
	[tempo_real_desenv] [decimal](18, 2) NULL,
	[tempo_real_desenv_automacao] [decimal](18, 2) NULL,
	[tempo_real_desenv_eletrica] [decimal](18, 2) NULL,
	[tempo_real_desenv_sistemas] [decimal](18, 2) NULL,
	[tempo_real_desenv_geral] [decimal](18, 2) NULL,
	[tempo_estimado_implant] [decimal](18, 2) NULL,
	[tempo_estimado_implant_automacao] [decimal](18, 2) NULL,
	[tempo_estimado_implant_eletrica] [decimal](18, 2) NULL,
	[tempo_estimado_implant_sistemas] [decimal](18, 2) NULL,
	[tempo_estimado_implant_geral] [decimal](18, 2) NULL,
	[tempo_real_implant] [decimal](18, 2) NULL,
	[tempo_real_implant_automacao] [decimal](18, 2) NULL,
	[tempo_real_implant_eletrica] [decimal](18, 2) NULL,
	[tempo_real_implant_sistemas] [decimal](18, 2) NULL,
	[tempo_real_implant_geral] [decimal](18, 2) NULL,
	[tempo_estimado_deslocamento] [decimal](18, 2) NULL,
	[tempo_real_deslocamento] [decimal](18, 2) NULL,
	[tempo_levantado_desenv_automacao] [decimal](18, 2) NULL,
	[horas_retrabalho] [decimal](18, 2) NULL,
	[horas_itens_fora_escopo] [decimal](18, 2) NULL,
	[cmc_desenv] [decimal](18, 2) NULL,
	[cmc_implant] [decimal](18, 2) NULL,
	[cmc] [decimal](18, 2) NULL,
	[data_primeiro_tratamento] [datetime2](3) NOT NULL,
	[data_ultimo_tratamento] [datetime2](3) NOT NULL,
	[execucao_n8n_id] [nvarchar](100) NULL,
	[desvio_horas_desenv] [decimal](18, 2) NULL,
	[desvio_horas_implant] [decimal](18, 2) NULL,
	[data_reuniao_abertura] [date] NULL,
	[data_reuniao_kickoff] [date] NULL,
	[data_reuniao_encerramento] [date] NULL,
 CONSTRAINT [PK_f_projetos_tratada] PRIMARY KEY CLUSTERED 
(
	[task_gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[f_projetos_tratada] ADD  CONSTRAINT [DF_f_projetos_tratada_primeiro_tratamento]  DEFAULT (sysutcdatetime()) FOR [data_primeiro_tratamento]
GO

ALTER TABLE [dbo].[f_projetos_tratada] ADD  CONSTRAINT [DF_f_projetos_tratada_ultimo_tratamento]  DEFAULT (sysutcdatetime()) FOR [data_ultimo_tratamento]
GO


