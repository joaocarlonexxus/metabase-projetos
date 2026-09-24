USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_b_projetos_tipos_proposta]    Data do Script: 24/09/2026 14:39:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_atualizar_b_projetos_tipos_proposta]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @QuantidadeInserida INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM dbo.b_projetos_tipos_proposta;

        INSERT INTO dbo.b_projetos_tipos_proposta
        (
            task_gid,
            tipo_proposta_id
        )
        SELECT DISTINCT
            p.task_gid,
            d.tipo_proposta_id
        FROM dbo.f_projetos_tratada AS p
        CROSS APPLY STRING_SPLIT(p.tipo_proposta, ',') AS s
        INNER JOIN dbo.d_tipos_proposta AS d
            ON d.tipo_proposta = LTRIM(RTRIM(s.value))
        WHERE p.tipo_proposta IS NOT NULL
          AND LTRIM(RTRIM(p.tipo_proposta)) <> ''
          AND LTRIM(RTRIM(s.value)) <> '';

        SET @QuantidadeInserida = @@ROWCOUNT;

        COMMIT TRANSACTION;

        SELECT
            @QuantidadeInserida AS quantidade_inserida,
            N'Bridge de tipos de proposta atualizada com sucesso.'
                AS mensagem;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO


