-- 01 - Buscar Última Sincronização

SELECT
    processo,
    ultima_execucao,
    CASE
        WHEN ultima_execucao IS NULL
            THEN '1970-01-01T00:00:00.000Z'
        ELSE CONVERT(VARCHAR(23), ultima_execucao, 126) + 'Z'
    END AS modified_since
FROM dbo.n8n_controle_sincronizacao
WHERE processo = N'f_projetos_raw';