USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_colaboradores]    Data do Script: 24/09/2026 14:15:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_colaboradores](
	[colaborador_id] [int] NOT NULL,
	[colaborador] [nvarchar](255) NOT NULL,
	[colaborador_sigla] [nvarchar](10) NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_colaboradores] PRIMARY KEY CLUSTERED 
(
	[colaborador_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_colaboradores_colaborador] UNIQUE NONCLUSTERED 
(
	[colaborador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_colaboradores_sigla] UNIQUE NONCLUSTERED 
(
	[colaborador_sigla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_colaboradores] ADD  CONSTRAINT [DF_d_colaboradores_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_colaboradores] ADD  CONSTRAINT [DF_d_colaboradores_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_colaboradores] ADD  CONSTRAINT [DF_d_colaboradores_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


