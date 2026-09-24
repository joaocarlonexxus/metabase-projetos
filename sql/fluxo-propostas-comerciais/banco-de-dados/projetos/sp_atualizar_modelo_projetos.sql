USE [controle_projetos_new]
GO

/****** Objeto:  StoredProcedure [dbo].[sp_atualizar_modelo_projetos]    Data do Script: 24/09/2026 14:29:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_atualizar_modelo_projetos]
    @execucao_n8n_id NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NULLIF(LTRIM(RTRIM(@execucao_n8n_id)), '') IS NULL
        BEGIN
            THROW 50001, 'O ID da execução do n8n não foi informado.', 1;
        END;

        DELETE FROM dbo.f_projetos_raw
        WHERE execucao_n8n_id <> @execucao_n8n_id
           OR execucao_n8n_id IS NULL;

        EXEC dbo.sp_atualizar_f_projetos_tratada
            @execucao_n8n_id = @execucao_n8n_id;

        UPDATE d
        SET
            d.cnpj = t.cnpj,
            d.data_atualizacao = SYSUTCDATETIME()
        FROM dbo.d_clientes AS d
        INNER JOIN dbo.f_projetos_tratada AS t
            ON d.cliente = LTRIM(RTRIM(t.cliente))
        WHERE t.cnpj IS NOT NULL
          AND LTRIM(RTRIM(t.cnpj)) <> '';

        INSERT INTO dbo.d_clientes
        (
            cliente,
            cliente_simples,
            cnpj
        )
        SELECT DISTINCT
            LTRIM(RTRIM(t.cliente)),
            LEFT(LTRIM(RTRIM(t.cliente)), 5),
            NULLIF(LTRIM(RTRIM(t.cnpj)), '')
        FROM dbo.f_projetos_tratada AS t
        WHERE t.cliente IS NOT NULL
          AND LTRIM(RTRIM(t.cliente)) <> ''
          AND NOT EXISTS
          (
              SELECT 1
              FROM dbo.d_clientes AS d
              WHERE d.cliente = LTRIM(RTRIM(t.cliente))
          );

        EXEC dbo.sp_atualizar_b_projetos_documentos;
        EXEC dbo.sp_atualizar_b_projetos_tipos_proposta;
        EXEC dbo.sp_atualizar_b_projetos_setores;
        EXEC dbo.sp_atualizar_b_projetos_colaboradores;

        SELECT
            CAST(1 AS BIT) AS sucesso,
            N'Modelo atualizado com sucesso.' AS mensagem;

    END TRY
    BEGIN CATCH

        SELECT
            CAST(0 AS BIT) AS sucesso,
            ERROR_NUMBER() AS erro_numero,
            ERROR_PROCEDURE() AS erro_procedure,
            ERROR_LINE() AS erro_linha,
            ERROR_MESSAGE() AS mensagem;

        THROW;

    END CATCH;
END;
GO


