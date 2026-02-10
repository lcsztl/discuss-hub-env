# discuss-hub-env

Este repositorio e um **facilitador** para rodar o Discuss Hub em ambiente local usando Docker Compose.

Ele existe para manter o repositorio de addons `discuss_hub` no padrao OCA (somente addons), enquanto este repo concentra:

- `docker/` (build do Odoo com dependencias)
- `compose-dev.yaml` (ambiente local)
- `addons/mail_discuss_hub_full` (meta-addon que instala tudo)

## Repositorio de addons (upstream)

- https://github.com/lcsztl/discuss_hub

## Como funciona

1. O container do Odoo e buildado com:
   - addons do `discuss_hub` (clonado durante o build)
   - dependencias OCA (`OCA/social` e `OCA/helpdesk`)
   - este meta-addon `mail_discuss_hub_full`
2. Voce sobe o Compose e instala o addon `Mail Discuss Hub - Full Installation` no Odoo.

## Requisitos

- Docker + Docker Compose plugin (comando `docker compose`)

## Quick start (dev)

1. Crie o `.env`:

```bash
cp .env.example .env
```

2. Suba os servicos:

```bash
docker compose -f compose-dev.yaml up -d --build
```

Se houver conflito de portas, ajuste no `.env` (ex.: `ODOO_HTTP_PORT`, `POSTGRES_PORT`, `REDIS_PORT`).

Opcional: atalhos via `Makefile`:

```bash
make up
make logs
```

3. Abra o Odoo:

- `http://localhost:8069`

4. Crie um banco (Database Manager) e instale o meta-addon:

- Apps
- (se necessario) Atualize a lista de Apps
- Procure por **Mail Discuss Hub - Full Installation**
- Install

## Profiles (opcionais)

- Evolution API (WhatsApp via Evolution): `--profile evolution`
- WAHA: `--profile waha`

Exemplo:

```bash
docker compose -f compose-dev.yaml --profile evolution up -d
```

## Trocar o repo/branch do discuss_hub

No `.env`:

- `DISCUSS_HUB_GIT_URL`
- `DISCUSS_HUB_REF`

Depois rode:

```bash
docker compose -f compose-dev.yaml build --no-cache odoo
docker compose -f compose-dev.yaml up -d
```

## Publicar (git)

Comandos tipicos para publicar este repo em um remoto:

```bash
git init -b main
git add .
git commit -m "Initial commit"
git remote add origin <URL_DO_REPO>
git push -u origin main
```
