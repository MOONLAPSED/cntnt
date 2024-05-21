@echo off

:: Add Scoop to PATH for this session
set "SCOOP_BIN=C:\Users\WDAGUtilityAccount\AppData\Local\Programs\Scoop\bin"
set "PATH=%PATH%;%SCOOP_BIN%"

:: Introduce a delay of 3 seconds
ping 127.0.0.1 -n 4 > nul

:: Check if Scoop is in the PATH
echo %PATH% | findstr /i /c:"%SCOOP_BIN%" > nul

IF %ERRORLEVEL% EQU 0 (
    :: Scoop is in the PATH, proceed with the installation
    echo Scoop is in the PATH.
) ELSE (
    :: Scoop is not in the PATH, handle the error or take appropriate action
    echo Scoop is not in the PATH. Please check the installation.
    goto :retry
)

:: Install Git
echo Installing Git...
scoop install git
IF %ERRORLEVEL% NEQ 0 (
    echo Error installing Git. Please check the installation and try again.
    goto :retry
)

:: Install 7zip (if not already installed)
echo Installing 7zip...
scoop install 7zip
IF %ERRORLEVEL% NEQ 0 (
    echo Error installing 7zip. Please check the installation and try again.
    goto :retry
)

:: Update Scoop buckets
echo Adding Scoop buckets...
scoop bucket add versions
scoop bucket add extras

:: Install additional packages
echo Installing additional packages...
scoop install main/gh
scoop install versions/vscode-insiders
scoop install versions/windows-terminal-preview
scoop install main/lsd
scoop install extras/mambaforge

:: Ask for user confirmation to install additional packages
set /p yesToAll="Do you want to install additional packages? (y/n): "

if /i "%yesToAll%"=="y" (
    echo Installing extra packages...
    scoop bucket add nerd-fonts
    scoop install extras/x64dbg
    scoop install main/curl
    scoop install versions/openssl-light
    scoop install extras/okular
    scoop install extras/irfanview-lean
    scoop install extras/mpc-hc-fork
    scoop install extras/carapace-bin
    scoop install main/zoxide
    scoop install nerd-fonts/FiraMono-NF-Mono
    scoop install nerd-fonts/FiraCode-NF
)

:: Launch common applications
echo Launching common applications...
start microsoft-edge:
start notepad
start explorer

:: Update Scoop and install additional packages if desired
set /p updateScoop="Do you want to update Scoop and install additional packages? (y/n): "

if /i "%updateScoop%"=="y" (
    echo Updating Scoop and installing additional packages...
    scoop update
    scoop install your-additional-packages
)

:retry
:: Retry logic
echo Retrying...
ping 127.0.0.1 -n 4 > nul
goto :EOF

pause
