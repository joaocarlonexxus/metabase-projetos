// 04 - Transformar Dados

// * Mode: Run Once for All Items
// * Language: JavaScript

/**
 * NÓ 04 — Mapear dados do Asana para dbo.f_projetos_raw
 *
 * Nó Code do n8n:
 * Run Once for All Items
 */

function normalizarTexto(valor) {
  return String(valor ?? '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .trim()
    .toLowerCase();
}

function obterTarefa(item) {
  const json = item?.json ?? item ?? {};

  if (
    json.data &&
    typeof json.data === 'object' &&
    !Array.isArray(json.data)
  ) {
    return json.data;
  }

  return json;
}

function buscarCampo(campos, ...identificadores) {
  if (!Array.isArray(campos)) {
    return null;
  }

  const procurados = identificadores
    .filter((valor) => valor !== null && valor !== undefined)
    .map(normalizarTexto);

  return (
    campos.find((campo) => {
      const gid = normalizarTexto(campo?.gid);
      const nome = normalizarTexto(campo?.name);

      return procurados.includes(gid) || procurados.includes(nome);
    }) ?? null
  );
}

function converterTexto(campo) {
  if (campo === null || campo === undefined) {
    return null;
  }

  if (typeof campo !== 'object') {
    const texto = String(campo).trim();
    return texto || null;
  }

  if (
    Array.isArray(campo.multi_enum_values) &&
    campo.multi_enum_values.length > 0
  ) {
    const valores = campo.multi_enum_values
      .map((opcao) => opcao?.name)
      .filter(Boolean);

    return valores.length ? valores.join(', ') : null;
  }

  const valor =
    campo.text_value ??
    campo.enum_value?.name ??
    campo.display_value ??
    null;

  if (valor === null || valor === undefined) {
    return null;
  }

  const texto = String(valor).trim();

  return texto || null;
}

function converterNumero(campo) {
  if (campo === null || campo === undefined) {
    return null;
  }

  let valor = campo;

  if (typeof campo === 'object') {
    valor =
      campo.number_value ??
      campo.display_value ??
      campo.text_value ??
      null;
  }

  if (
    valor === null ||
    valor === undefined ||
    String(valor).trim() === ''
  ) {
    return null;
  }

  if (typeof valor === 'number') {
    return Number.isFinite(valor) ? valor : null;
  }

  let texto = String(valor)
    .trim()
    .replace(/\s/g, '');

  if (texto.includes(',') && texto.includes('.')) {
    texto = texto
      .replace(/\./g, '')
      .replace(',', '.');
  } else {
    texto = texto.replace(',', '.');
  }

  const numero = Number(texto);

  return Number.isFinite(numero) ? numero : null;
}

function converterData(campo) {
  if (campo === null || campo === undefined) {
    return null;
  }

  let valor = campo;

  if (typeof campo === 'object') {
    valor =
      campo.date_value?.date ??
      campo.date_value?.date_time ??
      campo.display_value ??
      campo.text_value ??
      null;
  }

  if (valor === null || valor === undefined) {
    return null;
  }

  const texto = String(valor).trim();

  return texto || null;
}

function obterMembership(tarefa) {
  if (
    !Array.isArray(tarefa?.memberships) ||
    tarefa.memberships.length === 0
  ) {
    return null;
  }

  return tarefa.memberships[0];
}

function mapearTarefa(tarefa) {
  const campos = Array.isArray(tarefa?.custom_fields)
    ? tarefa.custom_fields
    : [];

  const membership = obterMembership(tarefa);

  return {
    task_gid:
      tarefa?.task_gid ??
      tarefa?.gid ??
      tarefa?.id ??
      null,

    project_gid:
      tarefa?.project_gid ??
      membership?.project?.gid ??
      tarefa?.projects?.[0]?.gid ??
      null,

    section_gid:
      tarefa?.section_gid ??
      membership?.section?.gid ??
      null,

    task_name:
      tarefa?.task_name ??
      tarefa?.name ??
      null,

    task_section_name:
      tarefa?.task_section_name ??
      membership?.section?.name ??
      null,

    completed:
      tarefa?.completed === true ||
      tarefa?.completed === 1 ||
      tarefa?.completed === '1'
        ? 1
        : 0,

    completed_at:
      tarefa?.completed_at ?? null,

    created_at:
      tarefa?.created_at ?? null,

    modified_at:
      tarefa?.modified_at ?? null,

    start_on:
      tarefa?.start_on ?? null,

    due_on:
      tarefa?.due_on ?? null,

    assignee_gid:
      tarefa?.assignee_gid ??
      tarefa?.assignee?.gid ??
      null,

    assignee_name:
      tarefa?.assignee_name ??
      tarefa?.assignee?.name ??
      null,

    atualizacao_semanal: converterTexto(
      buscarCampo(
        campos,
        '1210831222714357',
        'Atualização Semanal',
        'Atualizacao Semanal'
      )
    ),

    cliente: converterTexto(
      buscarCampo(
        campos,
        '1209042063369497',
        'Cliente'
      )
    ),

    proposta: converterTexto(
      buscarCampo(
        campos,
        '1209042063369510',
        'Proposta'
      )
    ),

    tipo_contrato: converterTexto(
      buscarCampo(
        campos,
        '1209432717951922',
        'Tipo Contrato'
      )
    ),

    setor: converterTexto(
      buscarCampo(
        campos,
        '1210159981293422',
        'Setor'
      )
    ),

    urgencia_entrega: converterTexto(
      buscarCampo(
        campos,
        '1210926833975472',
        'Urgência de Entrega',
        'Urgência de entrega',
        'Urgência Entrega',
      )
    ),

    porte_projeto: converterTexto(
      buscarCampo(
        campos,
        '1212490391471556',
        'Porte do Projeto'
      )
    ),

    tipo_proposta: converterTexto(
      buscarCampo(
        campos,
        '1210968464830368',
        'Tipo Proposta'
      )
    ),

    etapa_proposta: converterTexto(
      buscarCampo(
        campos,
        '1209042063369428',
        'Etapa Proposta'
      )
    ),

    status_projeto: converterTexto(
      buscarCampo(
        campos,
        '1209047494656052',
        'Status Projeto'
      )
    ),

    responsavel_comercial: converterTexto(
      buscarCampo(
        campos,
        '1210547436365808',
        'Responsável Comercial',
        'Responsavel Comercial'
      )
    ),

    cnpj: converterTexto(
      buscarCampo(
        campos,
        '1210547436365813',
        'CNPJ'
      )
    ),

    email_nfs: converterTexto(
      buscarCampo(
        campos,
        '1210547436365815',
        "E-mail NF's",
        'E-mail NFs',
        'Email NFs'
      )
    ),

    atualizacoes: converterTexto(
      buscarCampo(
        campos,
        '1212716950190534',
        'Atualizações',
        'Atualizacoes'
      )
    ),

    processo: converterTexto(
      buscarCampo(
        campos,
        '1215214854376123',
        'Processo'
      )
    ),

    colaborador: converterTexto(
      buscarCampo(
        campos,
        '1212887834066239',
        'Colaborador'
      )
    ),

    documentos: converterTexto(
      buscarCampo(
        campos,
        '1209042063369513',
        'Documentos'
      )
    ),

    tipo_item: converterTexto(
      buscarCampo(
        campos,
        '1215239523786309',
        'Tipo de Item',
        'Tipo Item'
      )
    ),

    status_prazo: converterTexto(
      buscarCampo(
        campos,
        '1213012835147373',
        'Status de Prazo',
        'Status Prazo'
      )
    ),

    origem_impacto: converterTexto(
      buscarCampo(
        campos,
        '1213012835147378',
        'Origem do Impacto',
        'Origem Impacto'
      )
    ),

    data_termino: converterData(
      buscarCampo(
        campos,
        '1212923894182193',
        'Data de Término',
        'Data de Termino'
      )
    ),

    data_estimada_finalizacao: converterData(
      buscarCampo(
        campos,
        '1210652353265511',
        'Data estimada finalização',
        'Data estimada finalizacao'
      )
    ),

    data_abertura_proposta: converterData(
      buscarCampo(
        campos,
        '1212923894182195',
        'Data de abertura Proposta',
        'Data de Abertura Proposta'
      )
    ),

    data_inicio: converterData(
      buscarCampo(
        campos,
        '1212923894182191',
        'Data de Início Desenvolvimento',
        'Data de Inicio Desenvolvimento'
      )
    ),

    data_reuniao_abertura: converterData(
      buscarCampo(
        campos,
        '1218065366211582',
        'Data reunião de abertura',
        'Data reunião de Abertura',
        'Data Reunião de Abertura'
      )
    ),

    data_reuniao_kickoff: converterData(
      buscarCampo(
        campos,
        '1218065326023163',
        'Data reunião de kickoff',
        'Data reunião de Kickoff',
        'Data Reunião de Kickoff'
      )
    ),

    data_reuniao_encerramento: converterData(
      buscarCampo(
        campos,
        //'1218065326023163',
        'Data de Reunião de Encerramento',
        'Data de reunião de encerramento',
        'Data Reunião Encerramento',
        'Data reunião de encerramento'
      )
    ),
    
    tempo_estimado_desenv: converterNumero(
      buscarCampo(
        campos,
        '1209042063369531',
        'Tempo estimado de desenvolvimento'
      )
    ),

    tempo_estimado_desenv_automacao: converterNumero(
      buscarCampo(
        campos,
        '1211587084283420',
        'Tempo estimado de desenvolvimento Automação',
        'Tempo estimado de desenvolvimento Automacao'
      )
    ),

    tempo_estimado_desenv_eletrica: converterNumero(
      buscarCampo(
        campos,
        '1212457049878819',
        'Tempo estimado de desenvolvimento Elétrica',
        'Tempo estimado de desenvolvimento Eletrica'
      )
    ),

    tempo_estimado_desenv_sistemas: converterNumero(
      buscarCampo(
        campos,
        '1211587084283422',
        'Tempo estimado de desenvolvimento Sistemas'
      )
    ),

    tempo_real_desenv: converterNumero(
      buscarCampo(
        campos,
        '1210856591788842',
        'Tempo real de desenvolvimento'
      )
    ),

    tempo_real_desenv_automacao: converterNumero(
      buscarCampo(
        campos,
        '1212457049878821',
        'Tempo real de desenvolvimento Automação',
        'Tempo real de desenvolvimento Automacao'
      )
    ),

    tempo_real_desenv_eletrica: converterNumero(
      buscarCampo(
        campos,
        '1212457049878823',
        'Tempo real de desenvolvimento Elétrica',
        'Tempo real de desenvolvimento Eletrica'
      )
    ),

    tempo_real_desenv_sistemas: converterNumero(
      buscarCampo(
        campos,
        '1212457049878825',
        'Tempo real de desenvolvimento Sistemas'
      )
    ),

    tempo_estimado_implant: converterNumero(
      buscarCampo(
        campos,
        '1209042063369533',
        'Tempo estimado de implantação',
        'Tempo estimado de implantacao'
      )
    ),

    tempo_estimado_implant_automacao: converterNumero(
      buscarCampo(
        campos,
        '1212531085569739',
        'Tempo estimado de implantação Automação',
        'Tempo estimado de implantacao Automacao'
      )
    ),

    tempo_estimado_implant_eletrica: converterNumero(
      buscarCampo(
        campos,
        '1212531085569741',
        'Tempo estimado de implantação Elétrica',
        'Tempo estimado de implantacao Eletrica'
      )
    ),

    tempo_estimado_implant_sistemas: converterNumero(
      buscarCampo(
        campos,
        '1212531085569743',
        'Tempo estimado de implantação Sistemas',
        'Tempo estimado de implantacao Sistemas'
      )
    ),

    tempo_real_implant: converterNumero(
      buscarCampo(
        campos,
        '1210856591788846',
        'Tempo real implantação',
        'Tempo real de implantação',
        'Tempo real implantacao',
        'Tempo real de implantacao'
      )
    ),

    tempo_real_implant_automacao: converterNumero(
      buscarCampo(
        campos,
        '1211587084283424',
        'Tempo real implantação Automação',
        'Tempo real de implantação Automação',
        'Tempo real implantacao Automacao',
        'Tempo real de implantacao Automacao'
      )
    ),

    tempo_real_implant_eletrica: converterNumero(
      buscarCampo(
        campos,
        '1212457049878827',
        'Tempo real implantação Elétrica',
        'Tempo real de implantação Elétrica',
        'Tempo real implantacao Eletrica',
        'Tempo real de implantacao Eletrica'
      )
    ),

    tempo_real_implant_sistemas: converterNumero(
      buscarCampo(
        campos,
        '1211587084283426',
        'Tempo real implantação Sistemas',
        'Tempo real de implantação Sistemas',
        'Tempo real implantacao Sistemas',
        'Tempo real de implantacao Sistemas'
      )
    ),

    tempo_estimado_deslocamento: converterNumero(
      buscarCampo(
        campos,
        '1209042063369543',
        'Tempo estimado de deslocamento'
      )
    ),

    tempo_real_deslocamento: converterNumero(
      buscarCampo(
        campos,
        '1210856591788844',
        'Tempo real deslocamento',
        'Tempo real de deslocamento'
      )
    ),

    tempo_levantado_desenv_automacao: converterNumero(
      buscarCampo(
        campos,
        '1213509117769742',
        'Tempo levantado de desenvolvimento automação',
        'Tempo levantado de desenvolvimento Automação',
        'Tempo levantado de desenvolvimento automacao'
      )
    ),

    horas_retrabalho: converterNumero(
      buscarCampo(
        campos,
        '1210856591788838',
        'Horas de retrabalho'
      )
    ),

    horas_itens_fora_escopo: converterNumero(
      buscarCampo(
        campos,
        '1210856591788840',
        'Horas de itens fora do escopo'
      )
    ),

    execucao_n8n_id:
      typeof $execution !== 'undefined'
        ? $execution.id
        : null,

    payload_asana_json: JSON.stringify(tarefa)
  };
}

const entradas = $input.all();
const tarefas = [];

for (const item of entradas) {
  const json = item?.json ?? {};

  if (Array.isArray(json)) {
    for (const tarefa of json) {
      tarefas.push(tarefa);
    }

    continue;
  }

  if (Array.isArray(json.data)) {
    for (const tarefa of json.data) {
      tarefas.push(tarefa);
    }

    continue;
  }

  tarefas.push(obterTarefa(item));
}

return tarefas
  .filter((tarefa) => {
    if (!tarefa || typeof tarefa !== 'object') {
      return false;
    }

    const taskGid =
      tarefa?.task_gid ??
      tarefa?.gid ??
      tarefa?.id ??
      null;

    return (
      taskGid !== null &&
      taskGid !== undefined &&
      String(taskGid).trim() !== ''
    );
  })
  .map((tarefa) => ({
    json: mapearTarefa(tarefa)
  }));