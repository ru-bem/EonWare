@echo off
chcp 65001 >nul
set bel=echo 
mode con:cols=60 lines=20

:: Cores
set ccca=[90m
set ccve=[92m
set feve=[42m[97m
set cevo=[31m
set fevo=[41m[97m
set fcbo=[107m[30m
set ccbo=[97m
set crst=[0m[97m

:: StartAllBack info
set sab=3.7.3
set "sab_exe=%localappdata%\StartAllBack\StartAllBackCfg.exe"

:: Admin
if not "%1"=="am_admin" (powershell -command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'" & exit /b)

:netchk
set ison=0 & cls & title Verificando conexão com a internet
echo: & echo    Verificando conexão com a internet...
ping www.google.com -n 1 -w 1000 >nul 2>&1 && (set "ison=1") || (set "ison=0")
if %ison%==0 (echo [1A%cevo%   Sem conexão... Tentando novamente.          %crst% & timeout /t 2 >nul & goto netchk) else (goto sab_down)

:sab_down
cls
echo:
md %temp%\startallback >nul 2>&1
echo    Fazendo download dos arquivos necessários, aguarde...
if not exist "%temp%\startallback\StartAllBack_%sab%.exe" (curl -o %temp%\startallback\StartAllBack_%sab%.exe https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_%sab%_setup.exe >nul 2>&1)
if not exist "%temp%\startallback\StartAllBackX64.dll" (curl -o %temp%\startallback\StartAllBackX64.dll https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/StartAllBack/StartAllBackX64.dll >nul 2>&1)
goto sab_menu

:sab_menu
cls
title EonWare - StartAllBack
echo %fcbo%▓▒░                                                      ░▒▓
echo ▓▒░            █▀▀ █▀█ █▄ █ █ █ █ ▄▀█ █▀█ █▀▀            ░▒▓
echo ▓▒░            ██▄ █▄█ █ ▀█ ▀▄▀▄▀ █▀█ █▀▄ ██▄            ░▒▓
echo ▓▒░                                                      ░▒▓
echo ▓▒░            %feve% EonWare - StartAllBack %sab% %fcbo%            ░▒▓
echo ▓▒░             github.com/rubem-psd/EonWare             ░▒▓
echo ▓▒░                                                      ░▒▓%crst%
echo:
if exist "%sab_exe%" (echo %ccve%            O StartAllBack já está instalado%crst%) else (echo %cevo%           O StartAllBack não está instalado%crst%)
echo:
echo    [ 1] - Instalar/Ativar StartAllBack %sab%
echo    [ 2] - Ativar o StartAllBack %sab%
echo    [ 3] - Desinstalar o programa
echo    [ 4] - Iniciar o programa
echo:
echo    [ X] - Sair
echo:
set /p "sab_menu_choice=⠀⠀⠀["
if /i %sab_menu_choice%==X rd /s /q %temp%\startallback >nul 2>&1 & exit

if %sab_menu_choice%==4 if not exist "%sab_exe%" (msg * O StartAllBack não está instalado. & goto sab_menu) else (start %sab_exe% >nul 2>&1 & goto sab_menu)

if %sab_menu_choice%==3 if not exist "%sab_exe%" (msg * O StartAllBack não está instalado. & goto sab_menu) else (goto sab_del)

if %sab_menu_choice%==2 if not exist "%sab_exe%" (msg * O StartAllBack não está instalado. & goto sab_menu) else (goto sab_act)

if %sab_menu_choice%==1 if exist "%sab_exe%" (msg * O StartAllBack já está instalado. Para tentar novamente desinstale-o antes. & goto sab_menu) else (goto sab_add)

msg * Esta não é uma opção válida.

:sab_add
cls
echo %fcbo%▓▒░                                                      ░▒▓
echo ▓▒░              Instalando o StartAllBack.              ░▒▓
echo ▓▒░                                                      ░▒▓%crst%
echo:
echo    Instalando o StartAllBack & start /min /wait %temp%\startallback\StartAllBack_%sab%.exe /silent
echo    Encerrando o explorer.exe para evitar problemas
taskkill /f /im explorer.exe >nul 2>&1
echo    Configurando o programa
set regstart=Reg add "HKCU\Software\StartIsBack" /v 
%regstart%"ModernIconsColorized" /t REG_DWORD /d "0" /f >nul 2>&1
%regstart%"SettingsVersion" /t REG_DWORD /d "5" /f >nul 2>&1
%regstart%"FrameStyle" /t REG_DWORD /d "0" /f >nul 2>&1
%regstart%"WelcomeShown" /t REG_DWORD /d "3" /f >nul 2>&1
%regstart%"UpdateCheck" /t REG_BINARY /d "3dd1002e7f39da01" /f >nul 2>&1
%regstart%"WinkeyFunction" /t REG_DWORD /d "1" /f >nul 2>&1
%regstart%"LegacyTaskbar" /t REG_DWORD /d "0" /f >nul 2>&1
%regstart%"AlterStyle" /t REG_SZ /d "" /f >nul 2>&1
%regstart%"TaskbarStyle" /t REG_SZ /d "" /f >nul 2>&1
%regstart%"SysTrayStyle" /t REG_DWORD /d "0" /f >nul 2>&1
%regstart%"BottomDetails" /t REG_DWORD /d "0" /f >nul 2>&1
echo    Abrindo e fechando o programa para gravar informações
start /min %sab_exe% >nul 2>&1
timeout /t 2 >nul
taskkill /f /im StartAllBackCfg.exe >nul 2>&1
goto sab_act

:sab_act
cls
echo %fcbo%▓▒░                                                      ░▒▓
echo ▓▒░               Ativando o StartAllBack.               ░▒▓
echo ▓▒░                                                      ░▒▓%crst%
echo:
echo    Verificando ativação...
fc /b %temp%\startallback\StartAllBackX64.dll %localappdata%\StartAllBack\StartAllBackX64.dll >nul 2>&1 && (echo [1A%ccve%   O programa já está ativado! %crst% & echo: & echo    Pressione qualquer tecla para voltar ao menu. & pause >nul & goto sab_menu) || (echo [90m   Ativando o programa... & xcopy /y "%temp%\startallback\StartAllBackX64.dll" "%localappdata%\StartAllBack\StartAllBackX64.dll" >nul 2>&1 & start explorer.exe & echo [1A%ccve%   O StartAllBack foi ativado! %crst% & echo    Pressione qualquer tecla para voltar ao menu & pause >nul & goto sab_menu)

:sab_del
cls
echo %fcbo%▓▒░                                                      ░▒▓
echo ▓▒░             Desinstalando o StartAllBack             ░▒▓
echo ▓▒░                                                      ░▒▓%crst%
echo:
echo    Desinstalando o StartAllBack...
start /min /wait %sab_exe% /uninstall /silent >nul 2>&1
reg delete HKCU\Software\StartIsBack /f >nul 2>&1
rd /s /q %localappdata%\StartAllBack >nul 2>&1
echo: & echo %ccve%   Programa desinstalado com sucesso! %crst%
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul & rd /s /q %localappdata%\StartAllBack >nul 2>&1 &
goto sab_menu
