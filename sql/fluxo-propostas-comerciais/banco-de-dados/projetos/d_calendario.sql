USE [controle_projetos_new]
GO

/****** Objeto:  Table [dbo].[d_calendario]    Data do Script: 24/09/2026 14:25:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[d_calendario](
	[data_id] [int] NOT NULL,
	[data] [date] NOT NULL,
	[ano] [smallint] NOT NULL,
	[semestre] [tinyint] NOT NULL,
	[trimestre] [tinyint] NOT NULL,
	[bimestre] [tinyint] NOT NULL,
	[mes] [tinyint] NOT NULL,
	[nome_mes] [nvarchar](20) NOT NULL,
	[mes_abreviado] [nvarchar](3) NOT NULL,
	[ano_mes] [char](7) NOT NULL,
	[ano_mes_numero] [int] NOT NULL,
	[dia] [tinyint] NOT NULL,
	[dia_ano] [smallint] NOT NULL,
	[dia_semana] [tinyint] NOT NULL,
	[nome_dia_semana] [nvarchar](20) NOT NULL,
	[dia_semana_abreviado] [nvarchar](3) NOT NULL,
	[semana_ano] [tinyint] NOT NULL,
	[semana_mes] [tinyint] NOT NULL,
	[dia_util] [bit] NOT NULL,
	[fim_de_semana] [bit] NOT NULL,
	[inicio_mes] [date] NOT NULL,
	[fim_mes] [date] NOT NULL,
	[data_criacao] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_d_calendario] PRIMARY KEY CLUSTERED 
(
	[data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_d_calendario_data] UNIQUE NONCLUSTERED 
(
	[data] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[d_calendario] ADD  CONSTRAINT [DF_d_calendario_data_criacao]  DEFAULT (sysutcdatetime()) FOR [data_criacao]
GO


