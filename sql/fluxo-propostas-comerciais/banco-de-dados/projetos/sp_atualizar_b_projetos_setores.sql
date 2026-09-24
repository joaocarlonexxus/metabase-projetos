USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_b_projetos_setores]    Data do Script: 24/09/2026 14:38:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_atualizar_b_projetos_setores]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @QuantidadeInserida INT = 0;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Limpa a tabela de relacionamento
        TRUNCATE TABLE dbo.b_projetos_setores;

        -------------------------------------------------------------------
        -- Insere os setores reais dos projetos
        -------------------------------------------------------------------
        INSERT INTO dbo.b_projetos_setores
        (
            task_gid,
            setor_id
        )
        SELECT DISTINCT
            p.task_gid,
            d.setor_id
        FROM dbo.f_projetos_tratada AS p
        CROSS APPLY STRING_SPLIT(p.setor, ',') AS s
        INNER JOIN dbo.d_setores AS d
            ON d.setor = LTRIM(RTRIM(s.value))
        WHERE p.setor IS NOT NULL
          AND LTRIM(RTRIM(p.setor)) <> ''
          AND LTRIM(RTRIM(s.value)) <> '';

        SET @QuantidadeInserida += @@ROWCOUNT;

        COMMIT TRANSACTION;

        PRINT CONCAT(
            @QuantidadeInserida,
            ' vínculos inseridos na dbo.b_projetos_setores.'
        );

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO


