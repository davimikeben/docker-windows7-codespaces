# syntax=docker/dockerfile:1
# 🪟 Windows 7 em Docker — imagem customizada (opcional)
# Base: dockurr/windows (QEMU + KVM + instalação automática).
# O entrypoint/cmd são herdados da base: ao subir, ela baixa a ISO (se preciso),
# instala o Windows 7 sozinho e expõe o visualizador web na porta 8006 + RDP 3389.

FROM dockurr/windows:latest

LABEL org.opencontainers.image.title="Windows 7 em Docker (Codespaces-ready, PT-BR)" \
      org.opencontainers.image.description="Windows 7 Ultimate SP1 x64 automatizado em Docker, pronto para GitHub Codespaces. Base dockur/windows." \
      org.opencontainers.image.source="https://github.com/davimikeben/windows-7-codespaces" \
      org.opencontainers.image.licenses="MIT"

# Padrões PT-BR (podem ser sobrescritos via environment no compose ou -e no docker run)
ENV VERSION="7u" \
    LANGUAGE="Portuguese" \
    REGION="pt-BR" \
    KEYBOARD="pt-BR" \
    RAM_SIZE="4G" \
    CPU_CORES="2" \
    DISK_SIZE="30G" \
    USERNAME="Docker" \
    PASSWORD="admin" \
    AUDIO="Y" \
    TZ="America/Sao_Paulo"

EXPOSE 8006 3389/tcp 3389/udp

# Exemplo de healthcheck (descomente se a sua base tiver curl/wget):
# HEALTHCHECK --interval=30s --timeout=10s --start-period=10m --retries=3 \
#   CMD curl -fs http://localhost:8006/ || exit 1

VOLUME ["/storage" "/shared" "/oem"]
