# Metabase
Projeto responsável pela infraestrutura e documentação do Metabase.

## Arquitetura
A solução é composta por:
- Metabase para criação e visualização dos dashboards;
- PostreSQL dedicado ao armazenamento dos dados internos do Metabase;
- SQL Server externo utilizado como fonte de dados dos dashboards;
- Docker para execução dos serviços;
- Portainer para gerenciamento e implantação da stack;
- GitHub para versionamento da infraestrutura, documentação e consultas SQL.

## Estrutura

```text
metabase/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
├── backups/
│   └── README.md
└── sql/
    ├── projetos/
    ├── indicadores/
    └── dashboards/
```