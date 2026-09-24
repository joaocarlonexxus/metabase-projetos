USE [controle_projetos_new]
GO

ALTER TABLE [dbo].[indicadores] ADD  CONSTRAINT [DF__indicador__updat__628FA481]  DEFAULT (getdate()) FOR [updated_at]
GO


