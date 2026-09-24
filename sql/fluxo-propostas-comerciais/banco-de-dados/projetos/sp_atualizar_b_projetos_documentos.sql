USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_b_projetos_documentos]    Data do Script: 24/09/2026 14:37:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_atualizar_b_projetos_documentos]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @QuantidadeInserida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM dbo.b_projetos_documentos;

        INSERT INTO dbo.b_projetos_documentos
        (
            task_gid,
            documento_id
        )
        SELECT DISTINCT
            p.task_gid,
            d.documento_id
        FROM dbo.f_projetos_tratada AS p
        CROSS APPLY STRING_SPLIT(p.documentos, ',') AS s
        INNER JOIN dbo.d_documentos AS d
            ON d.documento = LTRIM(RTRIM(s.value))
        WHERE p.documentos IS NOT NULL
          AND LTRIM(RTRIM(p.documentos)) <> ''
          AND LTRIM(RTRIM(s.value)) <> '';

        SET @QuantidadeInserida = @@ROWCOUNT;

        COMMIT TRANSACTION;

        PRINT CONCAT(
            @QuantidadeInserida,
            ' vínculos inseridos na dbo.b_projetos_documentos.'
        );
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO


