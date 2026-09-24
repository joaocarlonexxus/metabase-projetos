USE [controle_projetos_new]
GO

/****** Objeto:  Trigger [dbo].[trg_indicadores_updated_at]    Data do Script: 24/09/2026 14:43:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_indicadores_updated_at]
ON [dbo].[indicadores]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i
    SET updated_at = GETDATE()
    FROM dbo.indicadores i
    INNER JOIN inserted ins
        ON i.id = ins.id;
END
GO

ALTER TABLE [dbo].[indicadores] ENABLE TRIGGER [trg_indicadores_updated_at]
GO


