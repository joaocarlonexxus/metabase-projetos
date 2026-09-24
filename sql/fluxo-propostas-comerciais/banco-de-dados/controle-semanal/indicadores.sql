USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[indicadores]    Data do Script: 24/09/2026 14:13:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[indicadores](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[setor] [varchar](50) NOT NULL,
	[dt_referencia] [date] NOT NULL,
	[proj_nao_iniciados] [int] NOT NULL,
	[proj_nao_iniciados_pct]  AS (CONVERT([float],[proj_nao_iniciados])/nullif([total_proj],(0))),
	[proj_em_desenv] [int] NOT NULL,
	[proj_em_desenv_pct]  AS (CONVERT([float],[proj_em_desenv])/nullif([total_proj],(0))),
	[proj_desenv_pausado] [int] NOT NULL,
	[proj_desenv_pausado_pct]  AS (CONVERT([float],[proj_desenv_pausado])/nullif([total_proj],(0))),
	[proj_ag_implant] [int] NOT NULL,
	[proj_ag_implant_pct]  AS (CONVERT([float],[proj_ag_implant])/nullif([total_proj],(0))),
	[proj_em_implant] [int] NOT NULL,
	[proj_em_implant_pct]  AS (CONVERT([float],[proj_em_implant])/nullif([total_proj],(0))),
	[proj_ag_aceite] [int] NOT NULL,
	[proj_ag_aceite_pct]  AS (CONVERT([float],[proj_ag_aceite])/nullif([total_proj],(0))),
	[proj_em_fechamento] [int] NOT NULL,
	[proj_em_fechamento_pct]  AS (CONVERT([float],[proj_em_fechamento])/nullif([total_proj],(0))),
	[fornecim_materiais] [int] NULL,
	[fornecim_materiais_pct]  AS (CONVERT([float],[fornecim_materiais])/nullif([total_proj],(0))),
	[excedente_hs_suporte] [int] NULL,
	[excedente_hs_suporte_pct]  AS (CONVERT([float],[excedente_hs_suporte])/nullif([total_proj],(0))),
	[proj_finalizados] [int] NOT NULL,
	[proj_finalizados_pct]  AS (CONVERT([float],[proj_finalizados])/nullif([total_proj],(0))),
	[proj_cancelados] [int] NOT NULL,
	[proj_cancelados_pct]  AS (CONVERT([float],[proj_cancelados])/nullif([total_proj],(0))),
	[total_proj] [float] NOT NULL,
	[tx_conclusao] [float] NOT NULL,
	[tx_retrabalho] [float] NULL,
	[tx_itens_fora_escopo] [float] NULL,
	[eficiencia_media_desenv] [float] NULL,
	[eficiencia_media_implant] [float] NULL,
	[desvio_medio_horas_desenv] [float] NULL,
	[desvio_medio_horas_implant] [float] NULL,
	[horas_estimadas_desenv] [float] NULL,
	[horas_estimadas_implant] [float] NULL,
	[custo_manut_cliente] [float] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[desvio_total_horas] [float] NULL,
	[propostas_novas] [int] NULL,
	[contrato_sup_vigente] [int] NULL,
	[contrato_sup_vencido] [int] NULL,
	[contrato_sup_vigente_pct]  AS (CONVERT([float],[contrato_sup_vigente])/nullif([total_proj],(0))),
	[contrato_sup_vencido_pct]  AS (CONVERT([float],[contrato_sup_vencido])/nullif([total_proj],(0))),
	[propostas_criticas] [int] NULL,
	[propostas_atraso] [int] NULL,
	[propostas_ativas] [int] NULL,
	[horas_retrabalho] [float] NULL,
	[horas_itens_fora_escopo] [float] NULL,
	[desvio_total_horas_desenv] [float] NULL,
	[desvio_total_horas_implant] [float] NULL,
	[proj_sem_estimativa_desenv] [int] NULL,
	[proj_sem_estimativa_implant] [int] NULL,
	[horas_sem_estimativa_desenv] [float] NULL,
	[horas_sem_estimativa_implant] [float] NULL,
	[tx_proj_sem_estimativa_desenv] [float] NULL,
	[tx_proj_sem_estimativa_implant] [float] NULL,
	[tx_horas_sem_estimativa_desenv] [float] NULL,
	[tx_horas_sem_estimativa_implant] [float] NULL,
	[desvio_esforco_desenv] [float] NULL,
	[desvio_esforco_implant] [float] NULL,
 CONSTRAINT [PK__indicador__3213E83F208F9FA3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[indicadores] ADD  CONSTRAINT [DF__indicador__creat__619B8048]  DEFAULT (getdate()) FOR [created_at]
GO

ALTER TABLE [dbo].[indicadores] ADD  CONSTRAINT [DF__indicador__updat__628FA481]  DEFAULT (getdate()) FOR [updated_at]
GO