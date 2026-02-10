.PHONY: up down ps logs build up-evolution up-waha

up:
\tdocker compose -f compose-dev.yaml up -d --build

down:
\tdocker compose -f compose-dev.yaml down

ps:
\tdocker compose -f compose-dev.yaml ps

logs:
\tdocker compose -f compose-dev.yaml logs -f --tail=200

build:
\tdocker compose -f compose-dev.yaml build

up-evolution:
\tdocker compose -f compose-dev.yaml --profile evolution up -d

up-waha:
\tdocker compose -f compose-dev.yaml --profile waha up -d

