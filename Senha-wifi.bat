:: Header:
:: dev Herzz09
:: data 27/05/2026
:: nome Senha-wifi.bat

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
setlocal enabledelayedexpansion
mode con: lines=7 cols=35

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Descobre o nome da rede - SSID
for /f "tokens=2 delims=:" %%a in (
    'netsh wlan show interface ^| findstr /C:" SSID"'
    ) do (
        set "rede=%%a"
        set "rede=!rede:~1!"
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Salva o resultado do netsh em um arquivo temporario (temp_wifi.txt) e oculta a saida
netsh wlan show profile name="%rede%" key=clear > temp_wifi.txt 2>nul

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Busca a senha 
set "senha=Nao encontrada"
for /f "tokens=2 delims=:" %%a in (
    'findstr /C:"da Chave" /C:"Key Content" temp_wifi.txt'
    ) do (
    set "senha=%%a"
    set "senha=!senha:~1!"
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Resultado final
echo.
echo ===================================
echo Internet: %rede%
echo Senha:    !senha!
echo ===================================

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 5. Deleta o arquivo temporario 
del temp_wifi.txt >nul

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. & pause>nul
