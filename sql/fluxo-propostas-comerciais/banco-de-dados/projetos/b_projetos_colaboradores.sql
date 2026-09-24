USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[b_projetos_colaboradores]    Data do Script: 24/09/2026 14:19:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[b_projetos_colaboradores](
	[task_gid] [varchar](32) NOT NULL,
	[colaborador_id] [int] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_b_projetos_colaboradores] PRIMARY KEY CLUSTERED 
(
	[task_gid] ASC,
	[colaborador_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[b_projetos_colaboradores] ADD  CONSTRAINT [DF_b_projetos_colaboradores_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[b_projetos_colaboradores]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_colaboradores_colaborador] FOREIGN KEY([colaborador_id])
REFERENCES [dbo].[d_colaboradores] ([colaborador_id])
GO

ALTER TABLE [dbo].[b_projetos_colaboradores] CHECK CONSTRAINT [FK_b_projetos_colaboradores_colaborador]
GO

ALTER TABLE [dbo].[b_projetos_colaboradores]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_colaboradores_projeto] FOREIGN KEY([task_gid])
REFERENCES [dbo].[f_projetos_tratada] ([task_gid])
GO

ALTER TABLE [dbo].[b_projetos_colaboradores] CHECK CONSTRAINT [FK_b_projetos_colaboradores_projeto]
GO


