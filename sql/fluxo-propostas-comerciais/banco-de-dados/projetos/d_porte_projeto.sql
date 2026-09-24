USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_porte_projeto]    Data do Script: 24/09/2026 14:26:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_porte_projeto](
	[porte_id] [int] NOT NULL,
	[porte_projeto] [nvarchar](150) NOT NULL,
	[porte_projeto_simples] [nvarchar](50) NOT NULL,
	[ordem] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_porte_projeto] PRIMARY KEY CLUSTERED 
(
	[porte_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_porte_projeto_ordem] UNIQUE NONCLUSTERED 
(
	[ordem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_porte_projeto_porte_projeto] UNIQUE NONCLUSTERED 
(
	[porte_projeto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_porte_projeto_porte_simples] UNIQUE NONCLUSTERED 
(
	[porte_projeto_simples] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_porte_projeto] ADD  CONSTRAINT [DF_d_porte_projeto_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_porte_projeto] ADD  CONSTRAINT [DF_d_porte_projeto_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_porte_projeto] ADD  CONSTRAINT [DF_d_porte_projeto_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


