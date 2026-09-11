#!/usr/bin/env bash
# Sobe o Windows 7 manualmente DENTRO de um Codespace (usa .devcontainer/codespaces.yml).
# Normalmente você não precisa disso: o devcontainer já sobe sozinho ao criar o Codespace.
set -euo pipefail
cd "$(dirname "$0")/.."

command -v docker >/dev/null 2>&1 || { echo "❌ Docker não encontrado neste ambiente."; exit 1; }

echo "🚀 Subindo o Windows 7 no Codespace..."
docker compose -f .devcontainer/codespaces.yml up -d

echo
echo "✅ Container iniciado! Próximos passos:"
echo "   1. Abra a aba PORTAS no VS Code e clique no 🌐 da porta 8006"
echo "   2. Aguarde a instalação automática até ver o desktop do Windows 7"
echo "   3. RDP: deixe a porta 3389 como PÚBLICA e conecte no host:porta encaminhados"
echo "   Logs: docker logs -f windows"
