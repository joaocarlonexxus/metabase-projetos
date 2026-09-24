USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[b_projetos_tipos_proposta]    Data do Script: 24/09/2026 14:25:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[b_projetos_tipos_proposta](
	[task_gid] [varchar](32) NOT NULL,
	[tipo_proposta_id] [int] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_b_projetos_tipos_proposta] PRIMARY KEY CLUSTERED 
(
	[task_gid] ASC,
	[tipo_proposta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[b_projetos_tipos_proposta] ADD  CONSTRAINT [DF_b_projetos_tipos_proposta_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[b_projetos_tipos_proposta]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_tipos_proposta_projeto] FOREIGN KEY([task_gid])
REFERENCES [dbo].[f_projetos_tratada] ([task_gid])
GO

ALTER TABLE [dbo].[b_projetos_tipos_proposta] CHECK CONSTRAINT [FK_b_projetos_tipos_proposta_projeto]
GO

ALTER TABLE [dbo].[b_projetos_tipos_proposta]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_tipos_proposta_tipo_proposta] FOREIGN KEY([tipo_proposta_id])
REFERENCES [dbo].[d_tipos_proposta] ([tipo_proposta_id])
GO

ALTER TABLE [dbo].[b_projetos_tipos_proposta] CHECK CONSTRAINT [FK_b_projetos_tipos_proposta_tipo_proposta]
GO


