#!/usr/bin/env bash
# ⚠️ APAGA o disco virtual e força uma reinstalação limpa do Windows 7.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "⚠️  Isso vai APAGAR tudo dentro de ./windows (disco virtual) e reinstalar do zero."
read -r -p "Tem certeza? Digite RESET para confirmar: " confirm
if [ "$confirm" != "RESET" ]; then
  echo "Cancelado."
  exit 0
fi

echo "🛑 Parando containers..."
docker compose down 2>/dev/null || true
docker compose -f .devcontainer/codespaces.yml down 2>/dev/null || true

echo "🧹 Limpando ./windows ..."
rm -rf windows
mkdir -p windows shared oem
touch windows/.gitkeep

echo "✅ Pronto! Suba novamente com:"
echo "   local:      docker compose up -d"
echo "   codespaces: ./scripts/start-codespaces.sh"
