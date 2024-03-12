@echo off
chcp 65001 >nul
set bel=echo 
mode con:cols=60 lines=20

set "idm_exe=%programfiles(x86)%\Internet Download Manager\IDMan.exe"

:: Cores
set ccca=[90m
set ccve=[92m
set feve=[42m[97m
set cevo=[31m
set fevo=[41m[97m
set fcbo=[107m[30m
set ccbo=[97m
set crst=[0m[97m

:: Admin
if not "%1"=="am_admin" (powershell -command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'" & exit /b)

:netchk
set /a netretry=0 & cls & title Verificando conexão com a internet
echo: & echo    Verificando conexão com a internet...
echo    %netretry%ª tentativa...
ping www.google.com -n 1 -w 1000 >nul 2>&1 && goto idm_down || set /a netretry+=1 & cls & echo: & echo %cevo%   Sem conexão... Tentando novamente. %crst% & timeout /t 2 >nul & goto netchk

:::::::::::::::::::::::::::::::::::::::::::::::::::::

:idm_down
cls & echo:
md %temp%\idm >nul 2>&1
echo    Baixando arquivos necessários, aguarde...
if not exist "%temp%\idm\idman.exe" curl -o %temp%\idm\idman.exe https://mirror2.internetdownloadmanager.com/idman642build3.exe >nul 2>&1
if not exist "%temp%\idm\IDMact.cmd" curl -o %temp%\idm\IDMact.cmd https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/IDM/IDMact.cmd >nul 2>&1

:idm_menu
cls
title EonWare - Internet Download Manager
echo %fcbo%▓▒░                                                      ░▒▓
echo %fcbo%▓▒░            █▀▀ █▀█ █▄ █ █ █ █ ▄▀█ █▀█ █▀▀            ░▒▓
echo %fcbo%▓▒░            ██▄ █▄█ █ ▀█ ▀▄▀▄▀ █▀█ █▀▄ ██▄            ░▒▓
echo %fcbo%▓▒░                                                      ░▒▓
echo %fcbo%▓▒░                Internet Dwnld Manager                ░▒▓
echo %fcbo%▓▒░             github.com/rubem-psd/EonWare             ░▒▓
echo %fcbo%▓▒░                                                      ░▒▓%crst%
echo:
if exist "%idm_exe%" (echo %ccve%                  O IDM já está instalado.%crst%) else (echo %cevo%                  O IDM não está instalado%crst%)
if exist "%idm_exe%" (tasklist | find /i "IDMan.exe" >nul && echo %ccve%         O IDM está sendo executado no seu sistema.%crst%)
echo:
echo    [ 1] - Instalar e Ativar IDM
echo    [ 2] - Ativar o IDM
echo    [ 3] - Desinstalar o IDM
echo    [ 4] - Iniciar o IDM
echo:
echo    [ X] - Sair
echo:
set /p "idm_menu_choice=⠀⠀⠀[⠀"

if /i %idm_menu_choice%==X rd /s /q %temp%\idm >nul 2>&1 & exit

if %idm_menu_choice%==4 if exist "%idm_exe%" (tasklist | find /i "IDMan.exe" >nul && (msg * IDM já está sendo executado. & goto idm_menu) || (cls & echo: & echo    IDM foi executado & echo    Feche-o para continuar usando o EonWare. & "%idm_exe%" & echo ... & goto idm_menu)) else (msg * O Internet Download Manager não está instalado. & goto idm_menu)

if %idm_menu_choice%==3 if exist "%idm_exe%" (goto idm_del) else (msg * O Internet Download Manager não está instalado. & goto idm_menu)

if %idm_menu_choice%==2 if exist "%idm_exe%" (goto idm_act) else (msg * O IDM não está instalado. & goto idm_menu)

if %idm_menu_choice%==1 if not exist "%idm_exe%" (goto idm_add) else (goto idm_ask_act)

:idm_add
cls
echo %fcbo%▓▒░                                                      ░▒▓
echo %fcbo%▓▒░        Instalando o Internet Download Manager        ░▒▓
echo %fcbo%▓▒░                                                      ░▒▓%crst%
echo:
echo    Iniciando instalação... & start /min /wait %temp%\idm\idman.exe /skipdlgs & goto idmstpchk

:idm_ask_act
cls
echo:
echo    O programa já está instalado!
echo: & echo   Deseja ativar o IDM?
echo    [S] SIM
echo    [N] NÃO
echo:
set /p "goto_act=⠀⠀⠀["
if /i %goto_act%==S goto idm_act
if /i %goto_act%==N goto idm_menu

:idmstpchk
tasklist | find /i "IDM1.tmp" >nul && (timeout /t 2 >nul & goto idmstpchk) || goto idmconfig

:idmconfig
echo    Configurando o IDM...
taskkill /f /im IDMan.exe >nul 2>&1
set idmreg=reg add "HKCU\Software\DownloadManager
%idmreg%" /v "LIDwa" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "LanguageID" /t REG_DWORD /d "1046" /f >nul 2>&1
%idmreg%" /v "bRmGUCfEx" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "ExceptionServers" /t REG_SZ /d "*.update.microsoft.com download.windowsupdate.com *.download.windowsupdate.com siteseal.thawte.com ecom.cimetz.com *.voice2page.com" /f >nul 2>&1
%idmreg%" /v "EnableDriver" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "FSPSSettingsChecked" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "FSSettingsChecked" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "mzcc_ext_vers" /t REG_DWORD /d "73120" /f >nul 2>&1
%idmreg%" /v "intAOFRWE" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "lastintres" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "Extensions" /t REG_SZ /d "3GP 7Z AAC ACE AIF APK ARJ ASF AVI BIN BZ2 EXE GZ GZIP IMG ISO LZH M4A M4V MKV MOV MP3 MP4 MPA MPE MPEG MPG MSI MSU OGG OGV PDF PLJ PPS PPT QT R0* R1* RA RAR RM RMVB SEA SIT SITX TAR TIF TIFF WAV WMA WMV Z ZIP" /f >nul 2>&1
%idmreg%" /v "LocalPathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%" /v "FindApps" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "LaunchOnStart" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "RememberLastSave" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "MonitorUrlClipboard" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "UseHttpProxy" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "UseFtpProxy" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "FtpPasive" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "nDESC7" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "nDESC8" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "isSSW_OK" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "windowPlacementV6" /t REG_NONE /d "," /f >nul 2>&1
%idmreg%" /v "sortOrder" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "LargeButtons" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "ToolbarStyle" /t REG_SZ /d "Neon" /f >nul 2>&1
%idmreg%" /v "rshext" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "TrayIcon" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "RunIEMonitor2" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "TipStartUp" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "TipFilePos" /t REG_DWORD /d "2613" /f >nul 2>&1
%idmreg%" /v "MaxConnectionsNumber" /t REG_DWORD /d "4" /f >nul 2>&1
%idmreg%" /v "ComplDlgShowing" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "bQueueSelPnlOnDlLt" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "bQueueSelPnlOnGAL" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "bIgnMTCh" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "StartDlgShowing" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "RememberDuplLinksA" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "ToolbarState_v5.11" /t REG_BINARY /d "15800000168000001780000018800000198000001a8000001b800000" /f >nul 2>&1
%idmreg%" /v "bShTipDD" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "ShowTipOnFirstCatch" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%" /v "CheckUpdtVM" /t REG_SZ /d "10" /f >nul 2>&1
%idmreg%" /v "bNShConfDelUncDlg" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "bShLc2" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%" /v "DuplLinksA" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%" /v "bVP9Ch" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "FLV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MP3" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MP4" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "M4V" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "F4V" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "M4A" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MPG" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MPEG" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "AVI" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "WMV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "WMA" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "WAV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "ASF" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "RM" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "OGG" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "OGV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MOV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "3GP" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "QT" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "WEBM" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "TS" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "MKV" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "AAC" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "VTT" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "TTML" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "TTML2" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "DFXP" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "SRT" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "PanelView" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\DwnlPanel" /v "DonlCaptWP" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\DwnlPanel\defminsizeset" /v "OGG" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\DwnlPanel\minsize" /v "MP3" /t REG_DWORD /d "51200" /f >nul 2>&1
%idmreg%\DwnlPanel\minsize" /v "OGG" /t REG_DWORD /d "102400" /f >nul 2>&1
%idmreg%\FoldersTree" /v "Visiblity" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "ID" /t REG_DWORD /d "7" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "mask" /t REG_SZ /d "zip rar r0* r1* arj gz sit sitx sea ace bz2 7z" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "pathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "rememberLastPath" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "forSiteOnly" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Compressed" /v "sites" /t REG_SZ /d "" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "ID" /t REG_DWORD /d "5" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "mask" /t REG_SZ /d "doc pdf ppt pps docx pptx" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "pathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "rememberLastPath" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "forSiteOnly" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Documents" /v "sites" /t REG_SZ /d "" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "ID" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "mask" /t REG_SZ /d "mp3 wav wma mpa ram ra aac aif m4a tsa" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "pathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "rememberLastPath" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "forSiteOnly" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Music" /v "sites" /t REG_SZ /d "" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "ID" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "mask" /t REG_SZ /d "exe msi" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "pathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "rememberLastPath" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "forSiteOnly" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Programs" /v "sites" /t REG_SZ /d "" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "ID" /t REG_DWORD /d "3" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "mask" /t REG_SZ /d "avi mpg mpe mpeg asf wmv mov qt rm mp4 flv m4v webm ogv ogg mkv ts tsv" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "pathW" /t REG_NONE /d "%homepath%\Downloads" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "rememberLastPath" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "forSiteOnly" /t REG_DWORD /d "0" /f >nul 2>&1
%idmreg%\FoldersTree\Video" /v "sites" /t REG_SZ /d "" /f >nul 2>&1
%idmreg%\ListSettings" /v "FileName" /t REG_NONE /d "" /f >nul 2>&1
%idmreg%\ListSettings" /v "DateAdded" /t REG_NONE /d "A" /f >nul 2>&1
%idmreg%\ListSettings" /v "Queue" /t REG_NONE /d "" /f >nul 2>&1
%idmreg%\ListSettings" /v "Size" /t REG_NONE /d "K" /f >nul 2>&1
%idmreg%\ListSettings" /v "Status" /t REG_NONE /d "A" /f >nul 2>&1
%idmreg%\ListSettings" /v "Timeleft" /t REG_NONE /d "K" /f >nul 2>&1
%idmreg%\ListSettings" /v "TransferRate" /t REG_NONE /d "_" /f >nul 2>&1
%idmreg%\ListSettings" /v "LastTry" /t REG_NONE /d "A" /f >nul 2>&1
%idmreg%\ListSettings" /v "Description" /t REG_NONE /d "È" /f >nul 2>&1
%idmreg%\ListSettings" /v "SaveTo" /t REG_NONE /d "È" /f >nul 2>&1
%idmreg%\ListSettings" /v "Referer" /t REG_NONE /d "È" /f >nul 2>&1
%idmreg%\ListSettings" /v "Parent_wp" /t REG_NONE /d "È" /f >nul 2>&1
%idmreg%\ListSettings" /v "Order639" /t REG_NONE /d "" /f >nul 2>&1
%idmreg%\menuExt" /v "ffdownlFLV_v" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\menuExt" /v "ffdownl10FLV_v" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\menuExt" /v "ffdownlAll_v" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\menuExt" /v "ffdownl1_v" /t REG_DWORD /d "1" /f >nul 2>&1
%idmreg%\menuExt" /v "iedownlAll_v" /t REG_DWORD /d "2" /f >nul 2>&1
%idmreg%\menuExt" /v "iedownl1_v" /t REG_DWORD /d "1" /f >nul 2>&1

:idm_act
echo    Ativando o IDM...
start /min /wait %temp%\idm\IDMact.cmd >nul 2>&1
%idmreg%" /v "StartDlgShowing" /t REG_DWORD /d "1" /f >nul 2>&1
goto idm_end

:idm_end
echo:
echo %ccve%   O IDM está instalado e ativado!
echo    Pressione qualquer tecla para voltar ao menu
pause >nul
goto idm_menu

:idm_del
cls
echo %fcbo%▓▒░                                                      ░▒▓
echo %fcbo%▓▒░                 Desinstalando o IDM.                 ░▒▓
echo %fcbo%▓▒░                                                      ░▒▓%crst%
echo:
echo    Desinstalando o IDM...
taskkill /f /im IDM* >nul 2>&1
taskkill /f /im IEMon* >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
regsvr32 /s /u idmfsa.dll downlWithIDM.dll >nul 2>&1
regsvr32 /s /u IDMIECC.dll IDMGetAll.dll IDMShellExt.dll >nul 2>&1
If Exist "%WinDir%\SysWOW64" regsvr32 /s /u IDMIECC64.dll >nul 2>&1
If Exist "%WinDir%\SysWOW64" regsvr32 /s /u downlWithIDM64.dll >nul 2>&1
If Exist "%WinDir%\SysWOW64" regsvr32 /s /u IDMGetAll64.dll >nul 2>&1
If Exist "%WinDir%\SysWOW64" regsvr32 /s /u IDMShellExt64.dll >nul 2>&1
If Exist "%Public%" idmBroker.exe -unRegServer >nul 2>&1
If Exist "%Public%" Uninstall.exe -uninstdriv >nul 2>&1
If Exist "%Public%" Net Stop IDMWFP >nul 2>&1
If Not Exist "%Public%" Net Stop IDMTDI >nul 2>&1
If Not Exist "%Public%" Rundll32 setupapi.dll,InstallHinfSection DefaultUninstall 128 .\idmtdi.inf >nul 2>&1
rd/s/q "%AppData%\IDM" >nul 2>&1
rd/s/q "%ProgramData%\IDM" >nul 2>&1
rd/s/q "%AllUsersProfile%\Application Data\IDM" >nul 2>&1
reg delete "HKLM\SOFTWARE\Internet Download Manager" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Internet Download Manager" /f >nul 2>&1
reg delete HKCU\Software\DownloadManager /f >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Internet Download Manager" >nul 2>&1
del /f /s /q "%homepath%\desktop\Internet Download Manager.lnk" >nul 2>&1
start explorer.exe >nul 2>&1

echo %ccve%   IDM Desinstalado com sucesso!
echo    Pressione qualquer tecla para voltar ao menu
pause >nul
goto idm_menu
