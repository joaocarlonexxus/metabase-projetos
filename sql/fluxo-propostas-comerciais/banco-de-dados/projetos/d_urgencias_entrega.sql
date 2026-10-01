USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_urgencias_entrega]    Data do Script: 01/10/2026 11:05:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_urgencias_entrega](
	[urgencia_id] [int] NOT NULL,
	[urgencia_entrega] [nvarchar](100) NOT NULL,
	[ordem] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_urgencias_entrega] PRIMARY KEY CLUSTERED 
(
	[urgencia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_urgencias_entrega_ordem] UNIQUE NONCLUSTERED 
(
	[ordem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_urgencias_entrega_urgencia_entrega] UNIQUE NONCLUSTERED 
(
	[urgencia_entrega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_urgencias_entrega] ADD  CONSTRAINT [DF_d_urgencias_entrega_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_urgencias_entrega] ADD  CONSTRAINT [DF_d_urgencias_entrega_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_urgencias_entrega] ADD  CONSTRAINT [DF_d_urgencias_entrega_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO