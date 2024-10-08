@set stalkerPath=.

@echo off
set version=1.1
title Inastalador Tradu��o STALKER SoC v%version%
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\GSC Game World\STALKER-SHOC" /v InstallPath 2^>nul') do (set stalkerPath=%%b)
if not "%stalkerPath%"=="." (goto :checkPath)
goto :errNoStalker

:checkPath
if not exist "%stalkerPath%\bin\XR_3DA.exe" (goto :errStillNoStalker)
echo Inastalador Tradu��o STALKER SoC v%version%
echo.
echo O S.T.A.L.K.E.R. est� instalado em: "%stalkerPath%"
echo Dependendo do local do jogo, vai ser necess�rio executar o script como administrador.
echo.
choice /c sn  /m "Instalar tradu��o"
if %errorLevel%==2 (exit)
echo --------------------------------------------------
if exist "%stalkerPath%\gamedata" (
    echo Fazendo backup...
    tar 
    echo --------------------------------------------------
)
echo Instalando arquivos...
tar -zxvf "traducao-stalker-soc-mods.zip" -C "%stalkerPath%" --strip-components=1 "traducao-stalker-soc-mods/*"
echo --------------------------------------------------
xcopy "Desinstalar.bat" "%stalkerPath%" /y
echo --------------------------------------------------
if not exist "%stalkerPath%\bin\msvcr80.dll" (goto :version10004) else (goto :version10003)

:version10004
ren "%stalkerPath%\gamedata\config\ui\ui_movies10004.xml" "ui_movies.xml"
echo --------------------------------------------------
xcopy "files\gamedata\config\ui\ui_movies10004.xml" "%stalkerPath%\gamedata\config\ui" /y
echo ##################################################
echo Instala��o finalizada.
echo As legendas das cenas n�o aparecer�o nesta vers�o (1.0004 ou posterior) da engine do jogo.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:version10003
ren "%stalkerPath%\gamedata\config\ui\ui_movies10003.xml" "ui_movies.xml"
echo --------------------------------------------------
xcopy "files\gamedata\config\ui\ui_movies10003.xml" "%stalkerPath%\gamedata\config\ui" /y
echo ##################################################
echo Instala��o finalizada.
echo Se voc� atualizar para v1.0004 ou uma vers�o posterior, lembre-se de reinstalar a tradu��o ou executar o "InGameCC_v10004.bat".
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errNoStalker
echo A pasta do S.T.A.L.K.E.R. n�o foi encontrada no registro.
echo Mas voc� pode especificar a pasta do jogo editando a linha "@set stalkerPath=." no instalador.
echo Ex.: @set stalkerPath=C:\Pasta do Jogo
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit

:errStillNoStalker
echo O executavel do S.T.A.L.K.E.R. n�o pode ser encontrado em: "%stalkerPath%\bin\XR_3DA.exe"
echo No entanto, a instala��o pode ser feita extraindo todos os arquivos do arquivo "traducao-stalker-soc-mods.zip" para a pasta do jogo instalado.
echo Se voc� usa a vers�o do jogo 1.0003 ou anterior, deve executar o arquivo em lote chamado "InGameCC_v10003.bat" para permitir que as legendas tamb�m apare�am nas cenas.
echo Infelizmente v1.0004 e vers�es posteriores do jogo n�o tem este recurso.
echo.
echo Precione qualquer tecla para sair...
pause > nul
exit