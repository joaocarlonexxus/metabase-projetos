USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_setores]    Data do Script: 24/09/2026 14:16:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_setores](
	[setor_id] [int] IDENTITY(1,1) NOT NULL,
	[setor] [nvarchar](50) NOT NULL,
	[ordem] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime] NOT NULL,
	[data_atualizacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[setor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_setores] ADD  DEFAULT (getdate()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_setores] ADD  DEFAULT (getdate()) FOR [data_atualizacao]
GO


