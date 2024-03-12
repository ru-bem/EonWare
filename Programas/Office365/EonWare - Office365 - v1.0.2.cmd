@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
mode con:cols=60 lines=30
set bel=echo 

:: Cores
set cinza=[90m
set verde=[92m
set bverd=[42m[97m
set vrmlh=[31m
set bvmlh=[41m[97m
set branc=[107m[30m
set fbrnc=[97m
set reset=[0m[97m
set "underline=echo %cinza%____________________________________________________________%reset%"

:: Requisitar permissões de administrador
if not "%1"=="am_admin" (
powershell -command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
exit /b )

:::::::::::::::::::::::::::::::::::::::::::::::::::::
set "o365dir=%ProgramFiles%\Microsoft Office\root\Office16"
md %temp%\o365
md %temp%\o365\bin
:::::::::::::::::::::::::::::::::::::::::::::::::::::

:o365netchk
cls
title Verificando conexão com a internet
echo:
echo    Verificando sua conexão com a internet...
set "ison=0" & ping www.google.com -n 1 -w 1000 >nul 2>&1 && (set "ison=1") || (set "ison=0")
if %ison%==0 (echo [1A%vrmlh%   Sem conexão... Tentando novamente.          %reset% & timeout /t 2 >nul & goto o365netchk) else (
echo [1A[92m   Conexão OK!                               %reset% & echo    Fazendo download dos arquivos necessários, aguarde. & echo    ...
if not exist %temp%\o365\Setup.exe (curl -o %temp%\o365\Setup.exe https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/Office365/setup.exe >nul 2>&1)
if not exist %temp%\o365\MAS_AIO.cmd (curl -o %temp%\o365\MAS_AIO.cmd https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/W11/MAS_AIO.cmd >nul 2>&1)
if not exist %temp%\o365\Desinstalador.cmd (https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/Office365/Desinstalador.cmd >nul 2>&1)
for %%G in (CleanOffice.txt,OffScrub03.vbs,OffScrub07.vbs,OffScrub10.vbs,OffScrubC2R.vbs,OffScrub_O15msi.vbs,OffScrub_O16msi.vbs) do (if not exist "%temp%\o365\bin\%%G" (curl -o %temp%\o365\bin\%%G https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/Office365/bin/%%G >nul 2>&1)))

:o365
set "WINWORD=Word" & set "POWERPNT=Power Point" & set "EXCEL=Excel" & set "OUTLOOK=Outlook" & set "MSACCESS=Access" & set "MSPUB=Publisher"
cls
title Office 365
echo %branc%▓▒░                                                      ░▒▓
echo ▓▒░            █▀▀ █▀█ █▄ █ █ █ █ ▄▀█ █▀█ █▀▀            ░▒▓
echo ▓▒░            ██▄ █▄█ █ ▀█ ▀▄▀▄▀ █▀█ █▀▄ ██▄            ░▒▓
echo ▓▒░                                                      ░▒▓
echo ▓▒░            %bverd% EonWare - OFFICE365 - v1.0.2 %branc%            ░▒▓
echo ▓▒░                                                      ░▒▓
echo ▓▒░          Digite um número e pressione ENTER          ░▒▓
echo ▓▒░                                                      ░▒▓%reset%
echo:
echo    [ 1] - Instalar o Office365
if not exist "%o365dir%" (echo [90m   [  ] - Desinstalar o Office365) else (echo    [ 2] - Desinstalar o Office365)
if exist "%o365dir%" (echo    [ 3] - Ativar o Office 365) else (echo [90m   [  ] - Ativar o Office365    ^| Office não instalado)
%underline%
echo:
if exist "%o365dir%\WINWORD.EXE"  (echo    [ 4] - Iniciar o Word)        else (echo [90m   [  ] - Iniciar o Word        ^| Não instalado%reset%)
if exist "%o365dir%\EXCEL.EXE"    (echo    [ 5] - Iniciar o Excel)       else (echo [90m   [  ] - Iniciar o Excel       ^| Não instalado%reset%)
if exist "%o365dir%\POWERPNT.EXE" (echo    [ 6] - Iniciar o Power Point) else (echo [90m   [  ] - Iniciar o Power Point ^| Não instalado%reset%)
if exist "%o365dir%\OUTLOOK.EXE"  (echo    [ 7] - Iniciar o Outlook)     else (echo [90m   [  ] - Iniciar o Outlook     ^| Não instalado%reset%)
if exist "%o365dir%\MSACCESS.EXE" (echo    [ 8] - Iniciar o Access)      else (echo [90m   [  ] - Iniciar o Access      ^| Não instalado%reset%)
if exist "%o365dir%\MSPUB.EXE"    (echo    [ 9] - Iniciar o Publisher)   else (echo [90m   [  ] - Iniciar o Publisher   ^| Não instalado%reset%)
%underline%
echo:
echo [97m   [ X] - Sair
echo:
echo    %branc% OBS: %reset% Algumas opções ficarão disponíveis após
echo    a instalação dos programas.
echo:
set /p "num=⠀⠀⠀[⠀"
echo:

if /i %num%==X (
	cls & echo:
	echo    Limpando arquivos temporários...
	del /f /s /q %temp%\o365\*.* & rd /s /q %temp%\o365 >nul 2>&1 & Exit)
	
if %num%==9 if exist "%o365dir%\MSPUB.EXE"    (cls & echo: & echo   Publisher está rodando, para usar o EonWare feche-o.  & cd "%o365dir%" & mspub    & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==8 if exist "%o365dir%\MSACCESS.EXE" (cls & echo: & echo   Access está rodando, para usar o EonWare feche-o.     & cd "%o365dir%" & msaccess & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==7 if exist "%o365dir%\OUTLOOK.EXE"  (cls & echo: & echo   Outlook está rodando, para usar o EonWare feche-o.    & cd "%o365dir%" & outlook  & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==6 if exist "%o365dir%\POWERPNT.EXE" (cls & echo: & echo   PowerPoint está rodando, para usar o EonWare feche-o. & cd "%o365dir%" & powerpnt & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==5 if exist "%o365dir%\EXCEL.EXE"    (cls & echo: & echo   Excel está rodando, para usar o EonWare feche-o.      & cd "%o365dir%" & excel    & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==4 if exist "%o365dir%\WINWORD.EXE"  (cls & echo: & echo   Word está rodando, para usar o EonWare feche-o.       & cd "%o365dir%" & winword  & goto o365) else (%bel% & msg * Este programa não está instalado. & goto o365)
if %num%==3 if not exist "%o365dir%" (msg * Não é possível ativar um programa que ainda não está instalado. & goto o365) else (goto o365_act)
if %num%==2 if not exist "%o365dir%" (%bel% & msg * Não é possível desinstalar um programa que ainda não está instalado. & goto o365) else (goto o365_del)
if %num%==1 if exist "%o365dir%" (goto o365_exist) else (goto o365_xml_del)
msg * Esta não é uma opção válida! & goto o365

:: Deleta o arquivo XML de configuração caso tenha sido criado anteriormente pelo programa
:o365_xml_del
del /f /s /q %temp%\o365\o365list.xml >nul 2>&1
goto o365i_esc

:: Office 365 Idioma : Escolha
:o365i_esc
cls
echo:
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░ Qual o idioma desejado para instalação do Office365? ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    [1] Português_BR
echo    [2] Inglês
echo    [3] Espanhol
echo    [4] Francês
echo    [5] Italiano
echo:
echo    [0] Voltar ao menu principal
echo:
set /p "idioma=⠀⠀⠀["
if %idioma%==5 set "idioma=it-it" & set idiomanome=Italiano& goto o365i_con
if %idioma%==4 set "idioma=fr-fr" & set idiomanome=Francês& goto o365i_con
if %idioma%==3 set "idioma=es-es" & set idiomanome=Espanhol& goto o365i_con
if %idioma%==2 set "idioma=en-us" & set idiomanome=Inglês& goto o365i_con
if %idioma%==1 set "idioma=pt-br" & set idiomanome=Português_BR& goto o365i_con
if %idioma%==0 goto o365
msg * Esta não é uma opção válida! & goto o365i_esc

:: Office 365 Idioma : Confirmação
:o365i_con
cls
echo:
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░          Por favor, confirme a sua escolha.          ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    Você escolheu o idioma %bverd% %idiomanome% %reset%
echo    Deseja confirmar a sua escolha?
echo:
echo    [1] Sim, desejo confirmar.
echo    [2] Não, desejo alterar o idioma.
echo:
set /p "o365i_con=⠀⠀⠀["
if %o365i_con%==2 goto o365i_esc
if %o365i_con%==1 goto o365p_esc_set
msg * Esta não é uma opção válida! & goto o365i_con

:o365p_esc_set
set o365c_10=1
set o365c_20=1
set o365c_30=1
set o365c_40=0
set o365c_50=0
set o365c_60=0

:o365p_esc
cls
echo    Idioma: %idiomanome%
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░      Personalize a instalação do office usando       ░▒▓
echo %branc%▓▒░                os números no teclado.                ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:

set o365s_10=[0m[97m   [1][31m ██[0m[90m
set o365s_20=[0m[97m   [2][31m ██[0m[90m
set o365s_30=[0m[97m   [3][31m ██[0m[90m
set o365s_40=[0m[97m   [4][31m ██[0m[90m
set o365s_50=[0m[97m   [5][31m ██[0m[90m
set o365s_60=[0m[97m   [6][31m ██[0m[90m

set "o365s_11=Word"
set "o365s_21=Excel"
set "o365s_31=Power Point"
set "o365s_41=Outlook"
set "o365s_51=Access"
set "o365s_61=Publisher"

if %o365c_10%==1 set o365s_10=[0m[97m   [1][92m ██[0m[97m
if %o365c_20%==1 set o365s_20=[0m[97m   [2][92m ██[0m[97m
if %o365c_30%==1 set o365s_30=[0m[97m   [3][92m ██[0m[97m
if %o365c_40%==1 set o365s_40=[0m[97m   [4][92m ██[0m[97m
if %o365c_50%==1 set o365s_50=[0m[97m   [5][92m ██[0m[97m
if %o365c_60%==1 set o365s_60=[0m[97m   [6][92m ██[0m[97m

set %errorlevel%=

echo %o365s_10% %o365s_11%
echo %o365s_20% %o365s_21%
echo %o365s_30% %o365s_31%
echo %o365s_40% %o365s_41%
echo %o365s_50% %o365s_51%
echo %o365s_60% %o365s_61%
%underline%
echo:
echo    [0m[97m[7] Continuar
echo    [0m[97m[8] Voltar
%underline%
choice /c 12345678 /n >nul
if %errorlevel%==8 (goto :o365i_con)
if %errorlevel%==7 (goto :o365p_res)
if %errorlevel%==6 (if %o365c_60%==1 (set o365c_60=0) else (set o365c_60=1) & goto :o365p_esc)
if %errorlevel%==5 (if %o365c_50%==1 (set o365c_50=0) else (set o365c_50=1) & goto :o365p_esc)
if %errorlevel%==4 (if %o365c_40%==1 (set o365c_40=0) else (set o365c_40=1) & goto :o365p_esc)
if %errorlevel%==3 (if %o365c_30%==1 (set o365c_30=0) else (set o365c_30=1) & goto :o365p_esc)
if %errorlevel%==2 (if %o365c_20%==1 (set o365c_20=0) else (set o365c_20=1) & goto :o365p_esc)
if %errorlevel%==1 (if %o365c_10%==1 (set o365c_10=0) else (set o365c_10=1) & goto :o365p_esc)
cls & goto o365p_esc

:o365p_res
cls
echo    Idioma: %idiomanome%
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░    Você escolheu instalar os seguintes programas:    ░▒▓
echo %branc%▓▒░                     [42m[97m (em verde) %branc%                     ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
if %o365c_10%==1 (<nul set /p="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[42m[97m %o365s_11%    [0m[97m") else (<nul set /p="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[100m[37m %o365s_11%     [0m[97m")
if %o365c_20%==1 (<nul set /p="⠀⠀[42m[97m %o365s_21%  [0m[97m") else (<nul set /p="⠀⠀[100m[37m %o365s_21%  [0m[97m")
if %o365c_30%==1 (<nul set /p="⠀⠀[42m[97m %o365s_31% [0m[97m") else (<nul set /p="⠀⠀[100m[37m %o365s_31% [0m[97m")
echo:
echo:
if %o365c_40%==1 (<nul set /p="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[42m[97m %o365s_41% [0m[97m") else (<nul set /p="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[100m[37m %o365s_41% [0m[97m")
if %o365c_50%==1 (<nul set /p="⠀⠀[42m[97m %o365s_51% [0m[97m") else (<nul set /p="⠀⠀[100m[37m %o365s_51% [0m[97m")
if %o365c_60%==1 (<nul set /p="⠀⠀[42m[97m %o365s_61%   [0m[97m") else (<nul set /p="⠀⠀[100m[37m %o365s_61%   [0m[97m")
echo [0m[97m
%underline%
echo:
echo    Deseja iniciar a instalação desses programas?
if %o365c_10%==0 if %o365c_20%==0 if %o365c_30%==0 if %o365c_40%==0 if %o365c_50%==0 if %o365c_60%==0 (echo [4A[41m[97m  Nenhum programa foi escolhido. Volte e faça sua escolha.  [0m[97m & echo:)
echo:
echo    [1] Sim, vamos continuar.
echo    [2] Não, quero alterar as opções.
echo:
set /p "o365p_res=⠀⠀⠀["
if %o365p_res%==2 goto o365p_esc
if %o365p_res%==1 goto o365_xml
msg * Esta não é uma opção válida! & goto o365p_res

:o365_xml
cls
echo:
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░%bverd%                Instalando o Office365                %branc%░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░         Você será avisado ao fim do processo         ░▒▓
echo %branc%▓▒░      É permitido usar o computador normalmente.      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    Criando o arquivo de configurações
:: Cria o arquivo vazio na pasta temp
type > %temp%\o365\o365list.xml >nul 2>&1

echo    ╠═ Escrevendo o conteúdo do arquivo
:: Escreve o início do arquivo
for %%G in ("<Configuration ID="e080f356-4291-4788-a421-330bd43b9e1b">","  <Add OfficeClientEdition="64" Channel="Current">","    <Product ID="O365ProPlusRetail">")  do echo %%~G >> %temp%\o365\o365list.xml

echo    ╠═ Definindo o Idioma da instalação
:: Define o idioma
for %%G in ("      <Language ID="!idioma!" />") do echo %%~G >> %temp%\o365\o365list.xml

echo    ╠═ Removendo bloatware da instalação
:: Remove bloatware
for %%G in ("      <ExcludeApp ID="Groove" />","      <ExcludeApp ID="Lync" />","      <ExcludeApp ID="OneDrive" />","      <ExcludeApp ID="OneNote" />","      <ExcludeApp ID="Teams" />","      <ExcludeApp ID="Bing" />") do echo %%~G >> %temp%\o365\o365list.xml

echo    ╠═ Definindo programas escolhidos no arquivo
:: Exclui os programas que não serão instalados

if %o365c_10%==0 (for %%G in ("      <ExcludeApp ID="Word" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365c_20%==0 (for %%G in ("      <ExcludeApp ID="Excel" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365c_30%==0 (for %%G in ("      <ExcludeApp ID="PowerPoint" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365c_40%==0 (for %%G in ("      <ExcludeApp ID="Outlook" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365c_50%==0 (for %%G in ("      <ExcludeApp ID="Access" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365c_60%==0 (for %%G in ("      <ExcludeApp ID="Publisher" />") do echo %%~G >> %temp%\o365\o365list.xml)

echo    ╠═ Finalizando o arquivo
:: Fecha o arquivo
for %%G in ("    </Product>","  </Add>","  <Updates Enabled="TRUE" />","  <RemoveMSI />","  <Display Level="None" AcceptEULA="TRUE" />","</Configuration>") do echo %%~G >> %temp%\o365\o365list.xml
echo    ╚═%verde% Tudo pronto para iniciar %reset%
%underline%
echo:
echo    Iniciando instalação em 5 segundos...
timeout /t 5 /nobreak >nul

:o365_add
cls
echo:
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░%bverd%                Instalando o Office365                %branc%░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░         Você será avisado ao fim do processo         ░▒▓
echo %branc%▓▒░      É permitido usar o computador normalmente.      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    Executando a instalação.
echo    Pode levar algum tempo dependendo do seu computador.
%underline%
echo:
%temp%\o365\setup.exe /configure %temp%\o365\o365list.xml
echo %verde%   Office instalado com sucesso!
echo    Iniciando a ativação em 10 segundos...
%bel% & msg * /time:10 O Office foi instalado com sucesso!
timeout /t 10 /nobreak >nul
goto o365_act

:o365_act
cls
echo:
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░%bverd%                Ativação do Office365.                %branc%░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    Ativando o Office 365, aguarde
echo    ...
start /min /wait %temp%\o365\MAS_AIO.cmd /Ohook >nul 2>&1
%underline%
echo:
echo %verde%   O Office365 está ativado!
echo    Pressione qualquer tecla para voltar ao menu principal.
pause >nul
goto o365

:o365_exist
cls
title Office detectado
echo:
echo %bvmlh%█▓▒░                                                    ░▒▓█
echo %bvmlh%█▓▒░            O OFFICE AINDA ESTÁ INSTALADO.          ░▒▓█
echo %bvmlh%█▓▒░                                                    ░▒▓█
echo %bvmlh%█▓▒░                    LEIA, SÉRIO.                    ░▒▓█
echo %bvmlh%█▓▒░                                                    ░▒▓█%reset%
echo:
<nul set /p ="⠀⠀⠀⠀⠀⠀⠀⠀⠀Os programas na cor [92mverde[0m foram detectados:"
echo:
echo:
<nul set /p ="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀" & for %%G in (WINWORD POWERPNT EXCEL) do (if exist "%O365dir%\%%G.exe" (<nul set /p ="[92m  !%%G!  [0m") else (<nul set /p ="[90m  !%%G!  [0m"))
echo:
<nul set /p ="⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀" & for %%G in (OUTLOOK MSACCESS MSPUB) do (if exist "%O365dir%\%%G.exe" (<nul set /p ="[92m  !%%G!  [0m") else (<nul set /p ="[90m  !%%G!  [0m"))
echo:
%underline%
echo:
echo    Se algum conjunto do Office já estiver instalado,
echo    instalá-lo novamente 'por cima' provavelmente
echo    causará erros.
echo:
echo    %branc% DESINSTALE o Office %reset% e retorne para reinstalá-lo.
%underline%
echo:
echo    Pressine qualquer tecla para voltar ao menu principal
echo:
timeout /t 1 /nobreak >nul 2>&1
pause >nul 2>&1
goto o365

:o365_del
cls
title Desinstalação do Office
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░             Desinstalação do Office 365.             ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    Deseja remover completamente o Office e todos
echo    os arquivos relacionados a instalações antigas?
echo    (Pode levar algum tempo dependendo do seu PC)
echo:
echo    [ 1] Confirmar Desinstalação
echo    [ 2] Voltar ao menu principal
set /p "o365_del_con=⠀⠀⠀["
if %o365_del_con%==2 goto o365
if %o365_del_con%==1 goto o365_del1

:o365_del1
cd %localappdata%\o365 >nul 2>&1
cls
title Desinstalando o Office
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░              Desinstalando o Office 365              ░▒▓
echo %branc%▓▒░                                                      ░▒▓
echo %branc%▓▒░         Você será avisado ao fim do processo         ░▒▓
echo %branc%▓▒░      É permitido usar o computador normalmente.      ░▒▓
echo %branc%▓▒░                                                      ░▒▓%reset%
echo:
echo    O Office e todos os arquivos relacionados estão
echo    sendo encontrados e deletados...
%underline%
echo:
start /min /wait %temp%\o365\Desinstalador.cmd >nul 2>&1
echo %verde%   Office desinstalado com sucesso!
echo    Pressione qualquer tecla para voltar ao menu principal.
%bel% & msg * /time:10 O Office foi desinstalado com sucesso!
pause >nul
goto o365

:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
