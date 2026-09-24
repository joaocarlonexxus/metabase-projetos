USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_clientes]    Data do Script: 24/09/2026 14:26:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_clientes](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [nvarchar](255) NOT NULL,
	[ativo] [bit] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
	[data_atualizacao] [datetime2](3) NOT NULL,
	[cnpj] [varchar](20) NULL,
	[cliente_simples] [nvarchar](5) NULL,
 CONSTRAINT [PK_d_clientes] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_clientes_cliente] UNIQUE NONCLUSTERED 
(
	[cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_clientes] ADD  CONSTRAINT [DF_d_clientes_ativo]  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [dbo].[d_clientes] ADD  CONSTRAINT [DF_d_clientes_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO

ALTER TABLE [dbo].[d_clientes] ADD  CONSTRAINT [DF_d_clientes_data_atualizacao]  DEFAULT (sysutcdatetime()) FOR [data_atualizacao]
GO


