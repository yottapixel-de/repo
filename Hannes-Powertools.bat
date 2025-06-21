

@REM *****************************************************
@REM * Copyright CC Lizenz (c) [2024] [Johannes Heide]   *
@REM * Alle Rechte vorbehalten.                          *
@REM * Email support: [ johannes_heide@yahoo.de ]        *
@REM *                                                   *
@REM * Version: [001] Programmname [Hannes Powertools]   *
@REM * Letzte Änderung: [21.07.2025]                     *
@REM *****************************************************

@REM ****************************************************************************
@REM Creative Commons (CC) ist eine internationale Non-Profit-Organisation, die
@REM standardisierte Lizenzen bereitstellt, um das Teilen und Weiterverwenden von
@REM Werken zu erleichtern, während die Urheberrechte der Autoren geschützt bleiben.
@REM Unter einer CC BY-Lizenz können Nutzer Werke kopieren, verbreiten, bearbeiten und
@REM weiterverwenden, sofern sie den Lizenzbedingungen (z. B. Namensnennung, keine
@REM kommerzielle Nutzung) entsprechen. 
@REM ****************************************************************************


@echo off
chcp 65001 >nul
title Hannes Powertools
color 0A

:menu
cls
echo.
echo ====================================
echo   Hannes Powertools - Hauptmenü
echo ====================================
echo.
echo   1. Ins BIOS starten
echo   2. Von USB starten
echo   3. Abgesicherter Modus
echo   4. Reparaturmodus
echo   5. Windows-Backup 
echo   6. TEMP-Dateien löschen
echo   7. Bilder umbenennen
echo   8. Aufräumen für Profis
echo   9. Systemdateien reparieren
echo  10. Update und Upgrade
echo  11. Winget: Programme updaten
echo  12. TPM 2.0 prüfen
echo  13. Energie sparen (Sleep)
echo  14. Verstecktes Konto aktivieren
echo  15. Dateien verschlüsseln
echo  16. Unlöschbare Dateien entfernen
echo  17. Sicheres Löschen
echo  18. IP-Adresse herausfinden
echo  19. chkdsk auf Fehler prüfen
echo  20. Robocopy zum Kopieren
echo  21. Diskpart Partitionen erstellen
echo.
echo   0. Beenden
echo.
set /p choice="Bitte wählen Sie eine Option (0-21): "

if "%choice%"=="1" goto BIOS
if "%choice%"=="2" goto USB
if "%choice%"=="3" goto SafeMode
if "%choice%"=="4" goto RepairMode
if "%choice%"=="5" goto BackupPlaceholder
if "%choice%"=="6" goto ClearTemp
if "%choice%"=="7" goto RenamePictures
if "%choice%"=="8" goto ProCleanup
if "%choice%"=="9" goto RepairSystemFiles
if "%choice%"=="10" goto UpdateUpgrade
if "%choice%"=="11" goto WingetUpdate
if "%choice%"=="12" goto CheckTPM
if "%choice%"=="13" goto SleepMode
if "%choice%"=="14" goto EnableHiddenAccount
if "%choice%"=="15" goto EncryptFiles
if "%choice%"=="16" goto RemoveUndeletable
if "%choice%"=="17" goto SecureDelete
if "%choice%"=="18" goto GetIP
if "%choice%"=="19" goto CheckDisk
if "%choice%"=="20" goto Robocopy
if "%choice%"=="21" goto DiskPart
if "%choice%"=="0" goto end
echo Ungültige Auswahl. Bitte versuchen Sie es erneut.
timeout /t 2 >nul
goto menu

:BIOS
cls
echo Starte ins BIOS...
shutdown /r /fw /t 0
goto :eof

:USB
cls
echo Starte von USB...
echo Dies erfordert normalerweise das manuelle Auswählen des Boot-Geräts beim Systemstart.
echo Das System wird neu gestartet. Wählen Sie dann das USB-Gerät im Boot-Menü.
timeout /t 5 >nul
shutdown /r /t 0
goto :eof

:SafeMode
cls
echo Starte in den abgesicherten Modus...
bcdedit /set {current} safeboot minimal
echo System wird neu gestartet.
timeout /t 3 >nul
shutdown /r /t 0
goto :eof

:RepairMode
cls
echo Starte in den Reparaturmodus...
echo Dies erfordert normalerweise das Starten von einem Wiederherstellungsmedium oder die Verwendung der erweiterten Startoptionen.
echo Das System wird neu gestartet und versucht, in die erweiterten Startoptionen zu gelangen.
timeout /t 5 >nul
shutdown /r /o /t 0
goto :eof

:BackupPlaceholder
cls
echo ---
echo Dies ist eine Funktion zum Erstellen eines Systembackups.
echo Für ein Backup musst du ein externes Laufwerk oder eine Netzwerkfreigabe angeben.
echo ---
echo.
set /p "BackupDrive=Bitte gib den Laufwerksbuchstaben des Ziels ein (z.B. D:): "
if "%BackupDrive%"=="" (
    echo Fehler: Kein Laufwerksbuchstabe angegeben.
    pause
    goto menu
)
echo Starte das Systembackup...
echo Dies kann einige Zeit dauern. Stelle sicher, dass das Ziel-Laufwerk angeschlossen ist.
wbadmin start backup -backupTarget:%BackupDrive% -include:C: -allCritical -quiet
if %ERRORLEVEL% neq 0 (
    echo Fehler: Das Backup konnte nicht erstellt werden. Überprüfe das Ziel-Laufwerk und den Speicherplatz.
    echo Details: %ERRORLEVEL%
    pause
    goto menu
)
echo Systembackup erfolgreich erstellt auf %BackupDrive%.
echo.
pause
goto menu

:ClearTemp
cls
echo Lösche temporäre Dateien...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
echo Temporäre Dateien gelöscht.
echo.
pause
goto menu

:RenamePictures
cls
echo Starte das Skript zum Umbenennen von Bildern...
echo.
set /p "ImageFolderPath=Bitte geben Sie den vollständigen Pfad des Ordners ein (z.B. C:\Users\IhrName\Bilder): "
set /p "ImageNewBaseName=Bitte geben Sie den neuen Basisnamen für die Bilder ein (z.B. MeinUrlaubsbild): "
echo.
set "PsScriptPath=%~dp0Rename-Images.ps1"
if not exist "%PsScriptPath%" (
    echo Fehler: Das PowerShell-Skript "%PsScriptPath%" wurde nicht gefunden.
    pause
    goto menu
)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PsScriptPath%" -FolderPath "%ImageFolderPath%" -NewBaseName "%ImageNewBaseName%"
if %ERRORLEVEL% neq 0 (
    echo Fehler: Das PowerShell-Skript konnte nicht erfolgreich ausgeführt werden.
    pause
    goto menu
)
echo.
pause
goto menu

:ProCleanup
cls
echo Starte Datenträgerbereinigung für Profis (mit erweiterten Optionen)...
echo Ein Fenster zur Auswahl der zu löschenden Dateien wird erscheinen.
cleanmgr /sageset:65535
cleanmgr /sagerun:65535
echo Datenträgerbereinigung abgeschlossen.
echo.
pause
goto menu

:RepairSystemFiles
cls
echo Repariere Systemdateien (SFC Scan)...
sfc /scannow
echo Bitte warten Sie, bis der Vorgang abgeschlossen ist.
echo.
pause
goto menu

:UpdateUpgrade
cls
echo Starte Windows Update und Upgrade...
echo Öffne Windows Update-Einstellungen.
start ms-settings:windowsupdate
echo.
pause
goto menu

:WingetUpdate
cls
echo Prüfe und installiere Winget, falls nicht vorhanden...
where winget >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Winget nicht gefunden. Lade und installiere Winget...
    powershell -Command "Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle"
    powershell -Command "Add-AppxPackage -Path winget.msixbundle"
    del winget.msixbundle
    if %ERRORLEVEL% neq 0 (
        echo Fehler beim Installieren von Winget.
        pause
        goto menu
    )
)
echo Aktualisiere alle installierten Programme mit Winget...
winget upgrade --all
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Ausführen von Winget Upgrade.
    pause
    goto menu
)
echo Programme erfolgreich aktualisiert.
echo.
pause
goto menu

:CheckTPM
cls
echo Prüfe TPM 2.0 Installation...
start tpm.msc
echo TPM-Konsole geöffnet. Prüfen Sie die TPM-Informationen.
echo.
pause
goto menu

:SleepMode
cls
echo Aktiviere Energiesparmodus (Sleep)...
rundll32.exe powrprof.dll,SetSuspendState Sleep
echo.
pause
goto menu

:EnableHiddenAccount
cls
echo Aktiviere das versteckte Administrator-Konto...
net user administrator /active:yes
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Aktivieren des Kontos.
    pause
    goto menu
)
echo Verstecktes Administrator-Konto aktiviert.
echo.
pause
goto menu

:EncryptFiles
cls
echo Verschlüssle JPG-Dateien im aktuellen Ordner...
cipher /e *.jpg
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Verschlüsseln der Dateien.
    pause
    goto menu
)
echo JPG-Dateien erfolgreich verschlüsselt.
echo.
pause
goto menu

:RemoveUndeletable
cls
echo Entferne unlöschbare Dateien...
set /p "FilePath=Bitte geben Sie den vollständigen Pfad der Datei ein (z.B. ?D:Test Ordner\lpt1.txt): "
if "%FilePath%"=="" (
    echo Fehler: Kein Pfad angegeben.
    pause
    goto menu
)
del "%FilePath%"
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Löschen der Datei.
    pause
    goto menu
)
echo Datei erfolgreich gelöscht.
echo.
pause
goto menu

:SecureDelete
cls
echo Starte sicheres Löschen (erfordert Admin-Rechte)...
set /p "Drive=Bitte geben Sie den Laufwerksbuchstaben ein (z.B. C:): "
if "%Drive%"=="" (
    echo Fehler: Kein Laufwerksbuchstabe angegeben.
    pause
    goto menu
)
cipher /w:%Drive%
if %ERRORLEVEL% neq 0 (
    echo Fehler beim sicheren Löschen.
    pause
    goto menu
)
echo Sicheres Löschen abgeschlossen.
echo.
pause
goto menu

:GetIP
cls
echo Hole IP-Adresse...
ipconfig
echo.
pause
goto menu

:CheckDisk
cls
echo Prüfe Laufwerke auf Fehler mit chkdsk...
chkdsk /f
echo Chkdsk wird ausgeführt. Drücken Sie eine Taste, um fortzufahren.
echo.
pause
goto menu

:Robocopy
cls
echo Starte robocopy zum Kopieren von Dateien...
set /p "Source=Bitte geben Sie den Quellpfad ein (z.B. C:\Quelle): "
set /p "Destination=Bitte geben Sie den Zielpfad ein (z.B. D:\Ziel): "
if "%Source%"=="" or "%Destination%"=="" (
    echo Fehler: Quell- oder Zielpfad fehlt.
    pause
    goto menu
)
robocopy "%Source%" "%Destination%" /E
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Kopieren mit robocopy.
    pause
    goto menu
)
echo Kopiervorgang abgeschlossen.
echo.
pause
goto menu

:DiskPart
cls
echo Starte diskpart zur Partitionverwaltung...
diskpart
echo Diskpart-Konsole geöffnet. Folgen Sie den Anweisungen.
echo.
pause
goto menu

:end
cls
echo Hannes' Powertools wird beendet. Auf Wiedersehen!
timeout /t 2 >nul
exit