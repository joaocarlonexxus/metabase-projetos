USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_documentos]    Data do Script: 24/09/2026 14:17:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_documentos](
	[documento_id] [int] NOT NULL,
	[documento] [nvarchar](50) NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_documentos] PRIMARY KEY CLUSTERED 
(
	[documento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_documentos_documento] UNIQUE NONCLUSTERED 
(
	[documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_documentos] ADD  CONSTRAINT [DF_d_documentos_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_documentos] ADD  CONSTRAINT [DF_d_documentos_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_documentos] ADD  CONSTRAINT [DF_d_documentos_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


