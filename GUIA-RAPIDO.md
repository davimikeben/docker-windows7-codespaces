# ⚡ Guia rápido — Windows 7 em Docker + Codespaces

## Parte A — GitHub Codespaces (recomendado para começar)

### 1. Publique o repositório

```bash
cd windows-7-codespaces
git init -b main
git add .
git commit -m "feat: Windows 7 em Docker + Codespaces 🇧🇷"
gh repo create windows-7-codespaces --public --source=. --push
```

Os links do `README.md` (botão do Codespaces e comandos `git clone`) já estão configurados para `davimikeben` ✅ — só publique e use.

### 2. Crie o Codespace

- Clique no botão **Open in GitHub Codespaces** do README, **ou**
- Na página do repo: botão verde **`< > Code`** → aba **Codespaces** → **Create codespace on main**.
- Se puder escolher a máquina, prefira **4 núcleos / 8 GB RAM / 32 GB**.

O devcontainer sobe o container `windows` automaticamente (isso baixa a imagem `ghcr.io/dockur/windows`, ~1 GB — aguarde).

### 3. Abra o Windows no navegador

1. No VS Code do Codespace, abra a aba **PORTAS** (menu `...` → Terminal → Portas, ou `Ctrl+Shift+P` → *Ports: Focus on Ports View*).
2. Localize a porta **`8006`** e clique no ícone 🌐 (abrir no navegador).
3. Você verá o visualizador: primeiro o download da ISO (~3,1 GB), depois a instalação automática.

> ⏳ Tempo típico: **15–60 min** na primeira vez. Deixe a aba aberta; se fechar, reabra pela aba PORTAS.

### 4. Conectar via RDP (opcional, mais rápido que o navegador)

1. Na aba **PORTAS**, clique com o botão direito na porta **`3389`** → **Visibilidade da porta** → **Pública**.
2. Copie o endereço encaminhado (algo como `https://laughing-xyz-3389.app.github.dev` → host `laughing-xyz-3389.app.github.dev`, porta `443` — o GitHub encaminha 3389 via HTTPS; alternativamente use o IP/host direto mostrado na coluna *Endereço local encaminhado*).
3. No seu app de RDP, conecte nesse host, usuário **`Docker`**, senha **`admin`**.
   - Windows: `mstsc` · Linux: FreeRDP (`xfreerdp /u:Docker /p:admin /v:HOST:PORTA`) · Celular: app *Remote Desktop* da Microsoft.

> 🔒 Atenção: porta pública significa que qualquer um com o link pode tentar conectar — **troque a senha** dentro do Windows (Painel de Controle → Contas de Usuário) e volte a porta para **Privada** quando terminar.

### 5. Economizar cota

- O Codespace **cobra por tempo ligado** (conta gratuita tem cota mensal — confira em *Settings → Billing → Codespaces*).
- Quando pausar: `Ctrl+Shift+P` → **Codespaces: Stop Current Codespace** (o disco da VM é preservado).
- Para desligar o Windows com segurança antes: dentro do Win7, *Iniciar → Desligar*; depois `docker stop windows` no terminal.

---

## Parte B — Docker local (Linux)

```bash
git clone https://github.com/davimikeben/windows-7-codespaces.git
cd windows-7-codespaces
cp .env.example .env        # ajuste RAM/CPU/disco/senha se quiser
./scripts/check-kvm.sh      # confere Docker + KVM
docker compose up -d        # sobe
docker compose logs -f windows   # acompanha a instalação
```

- 🌐 Navegador: **http://localhost:8006**
- 🔌 RDP: **localhost:3389** (`Docker` / `admin`)

Sem KVM (ex.: VM sem virtualização aninhada), comente as linhas `devices:` no `compose.yml` — funciona, mas **muito mais lento**.

---

## Parte C — Primeiros passos dentro do Windows 7

1. **Ativação/licença**: a instalação usa chave genérica de avaliação. Para uso contínuo, insira **sua licença válida** (*Computador → Propriedades → Ativação*).
2. **Idioma/teclado**: já vêm PT-BR/ABNT2 por padrão deste repo.
3. **Pasta compartilhada**: use o drive **`Z:`** para pegar arquivos da pasta `shared/` do host.
4. **Instalar programas automaticamente**: coloque instaladores em `oem/` e chame-os no `oem/install.bat` **antes** da primeira instalação.
5. **Áudio no navegador**: já vem `AUDIO=Y`; ative também *Settings → Advanced → Audio* no visualizador web.
6. **Backup**: com o container parado, copie a pasta `windows/` (disco virtual) para um local seguro.

---

## Parte D — Comandos do dia a dia

| Quero... | Comando |
|---|---|
| Ver se está rodando | `docker ps` / `docker compose ps` |
| Ver logs da instalação | `docker compose logs -f windows` (local) ou `docker logs -f windows` (Codespaces) |
| Parar o container | `docker compose stop` |
| Remover container (mantém disco) | `docker compose down` |
| Reinstalar do zero | `./scripts/reset.sh` (pede confirmação `RESET`) |
| Trocar recursos (RAM/CPU/disco) | Edite `.env`, depois `docker compose up -d` (vale após reiniciar) |
| Usar Win10/11 em vez do 7 | `VERSION=11` no `.env` + `./scripts/reset.sh` (**apaga o Win7!**) |
