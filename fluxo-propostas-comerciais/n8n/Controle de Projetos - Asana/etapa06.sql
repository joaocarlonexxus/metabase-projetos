-- 06 - Consolidar / Executar uma vez

EXEC dbo.sp_atualizar_modelo_projetos
    @execucao_n8n_id = '{{ $execution.id }}';


/*
Execute Once: true
*/