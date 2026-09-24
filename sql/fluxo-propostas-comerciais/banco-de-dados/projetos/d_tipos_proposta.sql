USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_tipos_proposta]    Data do Script: 24/09/2026 14:18:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_tipos_proposta](
	[tipo_proposta_id] [int] NOT NULL,
	[tipo_proposta] [nvarchar](150) NOT NULL,
	[ordem] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_tipos_proposta] PRIMARY KEY CLUSTERED 
(
	[tipo_proposta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_tipos_proposta_ordem] UNIQUE NONCLUSTERED 
(
	[ordem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_tipos_proposta_tipo_proposta] UNIQUE NONCLUSTERED 
(
	[tipo_proposta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_tipos_proposta] ADD  CONSTRAINT [DF_d_tipos_proposta_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_tipos_proposta] ADD  CONSTRAINT [DF_d_tipos_proposta_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_tipos_proposta] ADD  CONSTRAINT [DF_d_tipos_proposta_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


