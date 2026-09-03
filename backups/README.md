# Backups do Metabase

Este diretório contém a documentação relacionada aos backups do Metabase.

Os arquivos de backup não devem ser armazenados neste repositório Git.

## O que deve ser protegido

O banco de dados interno do Metabase contém informações como:
- Dashboards;
- Perguntas;
- Consultas SQL salvas;
- Coleções;
- Usuários;
- Configurações do Metabase;
- Conexões cadastradas.

## Banco de aplicação

O Metabase utiliza um banco de dados dedicado para armazenar suas informações internas.

Banco:

`metabase_app`

O banco utilizado como fonte dos dashboards, como o SQL Server, não faz parte deste backup.

## Backups

Os backups do banco `metabase_app` devem ser realizados periodicamente e armazenados fora do repositório Git.

Exemplo de estrutura local:
```
backups/
├── README.md
├── metabase_2026-09-01.sql.gz
├── metabase_2026-09-02.sql.gz
└── metabase_2026-09-03.sql.gz
```

## Segurança

Arquivos `.sql`, `.gz` e outros arquivos contendo dados do banco não devem ser enviados ao GitHub.

O `.gitignore` do projeto deve conter:
```
backups/*.sql
backups/*.sql.gz
backups/*.gz
```

## Restauração

Em caso de perda ou recriação do container do Metabase:
1. Criar ou iniciar o banco de aplicação do Metabase;
2. Restaurar o backup do banco `metabase_app`;
3. Configurar o Metabase para utilizar esse banco;
4. Iniciar o Metabase;
5. Validar dashboards, perguntas, consultas e configurações.