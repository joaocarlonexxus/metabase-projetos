USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[n8n_controle_sincronizacao]    Data do Script: 24/09/2026 14:27:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[n8n_controle_sincronizacao](
	[processo] [varchar](100) NOT NULL,
	[ultima_execucao] [datetime2](7) NULL,
	[data_atualizacao] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[processo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[n8n_controle_sincronizacao] ADD  DEFAULT (sysdatetime()) FOR [data_atualizacao]
GO


