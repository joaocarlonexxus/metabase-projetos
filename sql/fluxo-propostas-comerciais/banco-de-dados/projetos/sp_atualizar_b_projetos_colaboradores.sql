USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_b_projetos_colaboradores]    Data do Script: 24/09/2026 14:36:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_atualizar_b_projetos_colaboradores]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @QuantidadeInserida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM dbo.b_projetos_colaboradores;

        INSERT INTO dbo.b_projetos_colaboradores
        (
            task_gid,
            colaborador_id
        )
        SELECT DISTINCT
            p.task_gid,
            d.colaborador_id
        FROM dbo.f_projetos_tratada AS p
        CROSS APPLY STRING_SPLIT(p.colaborador, ',') AS s
        INNER JOIN dbo.d_colaboradores AS d
            ON d.colaborador = LTRIM(RTRIM(s.value))
        WHERE p.colaborador IS NOT NULL
          AND LTRIM(RTRIM(p.colaborador)) <> ''
          AND LTRIM(RTRIM(s.value)) <> '';

        SET @QuantidadeInserida = @@ROWCOUNT;

        COMMIT TRANSACTION;

        PRINT CONCAT(
            @QuantidadeInserida,
            ' vínculos inseridos na dbo.b_projetos_colaboradores.'
        );
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO


