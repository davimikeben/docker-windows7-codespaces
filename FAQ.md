# ❓ Perguntas frequentes (FAQ)

## É legal rodar Windows 7 assim?

O código deste repositório é aberto (MIT) e **não distribui o Windows** — a ISO é baixada na hora da instalação pela base [dockur/windows](https://github.com/dockur/windows). Porém **você precisa de uma licença válida do Windows** para uso além do período de avaliação, conforme os [termos da Microsoft](https://www.microsoft.com/pt-br/licensing/). As chaves genéricas embutidas na instalação automática são só para trial.

## O Windows 7 ainda é seguro?

**Não para uso geral.** O suporte terminou em **14/01/2020**: sem correções de segurança. Use isolado, para **testes, estudos e software legado**. Evite banco, e-mail principal e dados sensíveis.

## Quanto custa rodar no Codespaces?

Contas pessoais têm uma **cota gratuita mensal** de Codespaces (verifique em *Settings → Billing*). A VM do Win7 consome disco (~25 GB) e horas de máquina — **pare o Codespace quando não estiver usando** (*Codespaces: Stop Current Codespace*). Localmente com Docker, é grátis.

## Quanto tempo leva a instalação?

Primeira vez: **download da ISO (~3,1 GB) + instalação automática**, tipicamente **15–60 min** (Codespaces gratuito tende ao limite alto). As próximas inicializações levam **1–3 min**.

## Por que está tão lento?

Causas comuns, em ordem: (1) **sem KVM** (emulação por software é ~10x mais lenta) — confira `./scripts/check-kvm.sh`; (2) máquina fraca (use 4 núcleos/8 GB se possível); (3) primeira instalação (sempre pesada); (4) visualizador web é menos fluido que **RDP** — prefira RDP para uso contínuo.

## Qual usuário/senha?

Padrão: usuário **`Docker`**, senha **`admin`** (definidos por `USERNAME`/`PASSWORD`). Troque dentro do Windows após instalar, principalmente se expor a porta RDP.

## Posso instalar Windows 10/11 em vez do 7?

Sim! Troque `VERSION` no `.env` (`10`, `11`, `tiny10`, `tiny11`...) e rode `./scripts/reset.sh` (**apaga o disco atual**). Veja a tabela completa na [base dockur/windows](https://github.com/dockur/windows).

## Onde ficam os arquivos da VM? Como faço backup?

Tudo fica em `./windows/` (disco virtual + NVRAM). Com o container **parado**, copie essa pasta para backup. Para migrar de máquina, leve a pasta junto.

## Como uso uma ISO própria (ex.: Win7 PT-BR da minha empresa)?

Coloque o arquivo como `custom.iso` na raiz e descomente a linha `- ./custom.iso:/custom.iso` no compose. Nesse modo, `VERSION` é ignorado e a instalação pode pedir interação manual no viewer.

## O áudio funciona?

Sim: este repo já define `AUDIO=Y`. No visualizador web, abra *Settings → Advanced* e ative **Audio**. Via RDP o áudio funciona nativamente.

## Funciona no Mac (ARM/M1/M2/M3) ou Raspberry Pi?

Esta configuração é **x86_64**. Para ARM, use a variante [dockur/windows-arm](https://github.com/dockur/windows-arm) (com limitações e ISOs ARM).

## Dá pra rodar jogos?

Não é o foco: sem GPU dedicada (QEMU usa vídeo virtualizado), jogos 3D ficam inviáveis. Para apps legados de escritório, testes e estudos, atende bem.

## Como atualizo a imagem base?

```bash
docker compose pull
docker compose up -d
```

## Onde pedir ajuda?

1. Leia os logs: `docker compose logs -f windows`
2. Confira a [documentação da base](https://github.com/dockur/windows)
3. Abra uma [issue](../../issues) neste repositório usando o template de bug 🐞
