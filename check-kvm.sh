#!/usr/bin/env bash
# Verifica se o host está pronto: Docker, KVM, CPU, RAM e disco.
set -euo pipefail

ok()   { echo "✅ $1"; }
warn() { echo "⚠️  $1"; }
fail() { echo "❌ $1"; }

echo "🪟 Verificando pré-requisitos do Windows 7 em Docker..."
echo

# --- Docker ---
if command -v docker >/dev/null 2>&1; then
  ok "Docker encontrado: $(docker --version)"
  if docker info >/dev/null 2>&1; then
    ok "Daemon Docker acessível"
  else
    fail "Daemon Docker inacessível (tente: sudo systemctl start docker ou adicione seu usuário ao grupo docker)"
  fi
else
  fail "Docker não encontrado — instale https://docs.docker.com/engine/install/"
fi

# --- /dev/kvm ---
if [ -e /dev/kvm ]; then
  ok "/dev/kvm existe ($(ls -l /dev/kvm | awk '{print $1, $3, $4}'))"
  if [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
    ok "Permissão de leitura/escrita em /dev/kvm"
  else
    warn "Sem acesso a /dev/kvm — rode: sudo usermod -aG kvm \"$USER\" (depois faça logout/login)"
  fi
else
  warn "/dev/kvm NÃO encontrado — o container vai cair em emulação lenta (sem KVM)."
  echo "   → Habilite VT-x (Intel) / AMD-V na BIOS/UEFI e a virtualização aninhada se for VM."
fi

# --- kvm-ok / flags de CPU ---
if command -v kvm-ok >/dev/null 2>&1; then
  sudo -n true 2>/dev/null && kvm-ok || echo "   (pulei o kvm-ok: precisa de sudo)"
elif grep -Eq 'vmx|svm' /proc/cpuinfo 2>/dev/null; then
  ok "CPU com suporte a virtualização (flag vmx/svm detectada)"
else
  warn "Não detectei flag vmx/svm na CPU (pode ser VM sem virtualização aninhada)"
fi

# --- RAM e disco ---
if command -v free >/dev/null 2>&1; then
  echo "💾 RAM disponível: $(free -h | awk '/Mem:/ {print $7}')"
fi
echo "💽 Disco livre em $(pwd): $(df -h . | awk 'NR==2 {print $4}')"
echo
echo "Pronto! Se está tudo ✅, suba com:  docker compose up -d"
echo "Dica: acompanhe a instalação com:  docker compose logs -f windows"
