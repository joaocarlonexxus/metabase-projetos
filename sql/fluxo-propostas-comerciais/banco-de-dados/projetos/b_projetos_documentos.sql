USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[b_projetos_documentos]    Data do Script: 24/09/2026 14:16:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[b_projetos_documentos](
	[task_gid] [varchar](32) NOT NULL,
	[documento_id] [int] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_b_projetos_documentos] PRIMARY KEY CLUSTERED 
(
	[task_gid] ASC,
	[documento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[b_projetos_documentos] ADD  CONSTRAINT [DF_b_projetos_documentos_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[b_projetos_documentos]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_documentos_documento] FOREIGN KEY([documento_id])
REFERENCES [dbo].[d_documentos] ([documento_id])
GO

ALTER TABLE [dbo].[b_projetos_documentos] CHECK CONSTRAINT [FK_b_projetos_documentos_documento]
GO

ALTER TABLE [dbo].[b_projetos_documentos]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_documentos_projeto] FOREIGN KEY([task_gid])
REFERENCES [dbo].[f_projetos_tratada] ([task_gid])
GO

ALTER TABLE [dbo].[b_projetos_documentos] CHECK CONSTRAINT [FK_b_projetos_documentos_projeto]
GO


