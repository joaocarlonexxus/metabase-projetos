/*
## Horas Estimadas
* Métrica criada para calcular as horas estimadas restantes de desenvolvimento dos projetos.
* Para cada projeto, os tempos de desenvolvimento são definidos de acordo com o setor, conforme apresentado na introdução.
* A métrica considera os seguintes **status do projeto**:
    * Não Iniciado;
    * Em Desenvolvimento;
    * Desenvolvimento Pausado.
* O resultado é calculado pela diferença entre a **soma do tempo estimado de desenvolvimento** e a **soma do tempo real de desenvolvimento** dos projetos considerados.
* Quando o resultado da diferença é negativo, a métrica retorna zero.
* **Tooltip**: Total de horas estimadas restantes de desenvolvimento.
*/

WITH Projetos AS
(
    SELECT
        *
    FROM dbo.vw_projetos_tratada AS proj
    LEFT JOIN dbo.d_colaboradores AS colab
        ON proj.colaborador = colab.colaborador
    LEFT JOIN dbo.d_porte_projeto AS porte
        ON proj.porte_projeto = porte.porte_projeto
    WHERE
        proj.status_projeto IN (
            'Não Iniciado',
            'Em Desenvolvimento',
            'Desenvolvimento Pausado'
        )
    --[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
    --[[AND proj.data_abertura_proposta <= {{data_final}}]]
    --[[AND {{setor}}]]
    --[[AND {{porte_projeto}}]]
    --[[AND {{colaborador}}]];
)
    
