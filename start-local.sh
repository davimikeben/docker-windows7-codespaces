#!/usr/bin/env bash
# Sobe o Windows 7 localmente (usa compose.yml da raiz).
set -euo pipefail
cd "$(dirname "$0")/.."

command -v docker >/dev/null 2>&1 || { echo "❌ Docker não encontrado."; exit 1; }

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "📝 .env criado a partir do .env.example (ajuste e rode de novo se quiser)."
fi

echo "🚀 Subindo o Windows 7 (primeira vez pode levar 15–60 min)..."
docker compose up -d

echo
echo "✅ Container iniciado! Próximos passos:"
echo "   1. Abra http://localhost:8006 no navegador"
echo "   2. Aguarde o download (~3 GB) e a instalação automática até ver o desktop"
echo "   3. RDP: localhost:3389 — usuário Docker / senha admin"
echo "   Logs: docker compose logs -f windows"
