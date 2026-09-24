USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[b_projetos_setores]    Data do Script: 24/09/2026 14:24:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[b_projetos_setores](
	[task_gid] [varchar](32) NOT NULL,
	[setor_id] [int] NOT NULL,
	[data_criacao] [datetime] NOT NULL,
 CONSTRAINT [PK_b_projetos_setores_v2] PRIMARY KEY CLUSTERED 
(
	[task_gid] ASC,
	[setor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[b_projetos_setores] ADD  DEFAULT (getdate()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[b_projetos_setores]  WITH CHECK ADD  CONSTRAINT [FK_b_projetos_setores_v2_d_setores_v2] FOREIGN KEY([setor_id])
REFERENCES [dbo].[d_setores] ([setor_id])
GO

ALTER TABLE [dbo].[b_projetos_setores] CHECK CONSTRAINT [FK_b_projetos_setores_v2_d_setores_v2]
GO


