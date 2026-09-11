@echo off
REM ============================================================
REM  🧩 Script pós-instalação do Windows 7 em Docker
REM  Esta pasta (oem/) é copiada para C:\OEM e este install.bat
REM  é executado automaticamente ao final do setup.
REM  Coloque instaladores .exe/.msi aqui ao lado e chame-os abaixo.
REM ============================================================

echo Instalacao customizada concluida em %DATE% %TIME% > C:\OEM\ok.txt

REM --- Exemplos (descomente e adapte) ---
REM Desabilitar UAC (cuidado: menos segurança):
REM reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

REM Instalar um programa que você colocou nesta pasta:
REM start /wait C:\OEM\meu-programa-setup.exe /S

REM Instalar Chocolatey + pacotes (verifique compatibilidade com Win7):
REM powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
REM choco install -y firefox-esr 7zip

echo Concluido!
