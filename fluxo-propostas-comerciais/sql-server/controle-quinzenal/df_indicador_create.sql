USE [controle_projetos_new]
GO

ALTER TABLE [dbo].[indicadores] ADD  CONSTRAINT [DF__indicador__creat__619B8048]  DEFAULT (getdate()) FOR [created_at]
GO


