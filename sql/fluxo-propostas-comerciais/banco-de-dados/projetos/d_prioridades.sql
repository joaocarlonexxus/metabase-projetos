USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_prioridades]    Data do Script: 24/09/2026 14:21:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_prioridades](
	[prioridade_id] [int] NOT NULL,
	[prioridade] [nvarchar](100) NOT NULL,
	[prioridade_simples] [nvarchar](50) NOT NULL,
	[ordem] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_prioridades] PRIMARY KEY CLUSTERED 
(
	[prioridade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_prioridades_ordem] UNIQUE NONCLUSTERED 
(
	[ordem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_prioridades_prioridade] UNIQUE NONCLUSTERED 
(
	[prioridade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_prioridades_prioridade_simples] UNIQUE NONCLUSTERED 
(
	[prioridade_simples] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_prioridades] ADD  CONSTRAINT [DF_d_prioridades_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_prioridades] ADD  CONSTRAINT [DF_d_prioridades_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_prioridades] ADD  CONSTRAINT [DF_d_prioridades_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


