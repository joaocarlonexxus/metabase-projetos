-- 08 - Atualizar Última Sincronização

UPDATE dbo.n8n_controle_sincronizacao
SET
    ultima_execucao = SYSUTCDATETIME(),
    data_atualizacao = SYSUTCDATETIME()
WHERE processo = 'f_projetos_raw';

SELECT
    processo,
    ultima_execucao,
    data_atualizacao
FROM dbo.n8n_controle_sincronizacao
WHERE processo = 'f_projetos_raw';


/*
Execute Once: true
*/