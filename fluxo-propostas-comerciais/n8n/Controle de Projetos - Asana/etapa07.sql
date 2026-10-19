-- 07 - Atualizar Modelo de Projetos

EXEC dbo.sp_atualizar_modelo_projetos
    @execucao_n8n_id = '{{ $execution.id }}';