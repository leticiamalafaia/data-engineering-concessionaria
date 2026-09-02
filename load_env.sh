#!/bin/bash

if [ ! -f ".env" ]; then
    echo "Erro: Arquivo .env nao encontrado. Copie .env.example para .env e preencha as credenciais primeiro." >&2
    exit 1
fi

set -a
source .env
set +a

echo "OK: variaveis do .env carregadas nesta sessao do terminal."