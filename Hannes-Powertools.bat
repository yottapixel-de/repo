

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
title Hannes' Powertools
color 0A
set "LOGFILE=%~dp0powertools.log"
set "CONFIGFILE=%~dp0config.ini"
if not exist "%CONFIGFILE%" echo BackupDrive=D: > "%CONFIGFILE%"
for /f "tokens=1,2 delims==" %%a in (%CONFIGFILE%) do set %%a=%%b

:menu
cls
echo.
echo ====================================
echo   Hannes' Powertools - Hauptmenü
echo ====================================
echo.
echo   1. Ins BIOS starten
echo   2. Von USB starten
echo   3. Abgesicherter Modus
echo   4. Reparaturmodus
echo   5. Windows Backup
echo   6. TEMP-Dateien löschen
echo   7. Bilder umbenennen
echo   8. Aufräumen für Profis
echo   9. Systemdateien reparieren
echo  10. Update und Upgrade
echo  11. Winget: Alle Programme updaten
echo  12. TPM 2.0 prüfen
echo  13. Energie sparen (Sleep)
echo  14. Verstecktes Konto aktivieren
echo  15. Dateien verschlüsseln
echo  16. Unlöschbare Dateien entfernen
echo  17. Sicheres Löschen
echo  18. IP-Adresse herausfinden
echo  19. Chkdsk auf Fehler prüfen
echo  20. Robocopy für Kopieren
echo  21. Diskpart für Partitionen
echo  22. Hilfe anzeigen
echo  23. Netzwerk-Tools
echo  24. Defragmentierung
echo  25. Task-Manager/Process-Kill
echo  26. Automatische Wartung
echo  27. Benutzerdefinierte Skripte
echo  28. Skript, auf neueste Version überprüfen
echo.
echo   0. Beenden
echo.
set /p choice="Bitte wählen Sie eine Option (0-28): "

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
if "%choice%"=="22" goto Help
if "%choice%"=="23" goto NetworkTools
if "%choice%"=="24" goto Defrag
if "%choice%"=="25" goto TaskManager
if "%choice%"=="26" goto AutoMaintenance
if "%choice%"=="27" goto CustomScripts
if "%choice%"=="28" goto CheckUpdates
if "%choice%"=="0" goto end
echo Ungültige Auswahl. Bitte versuchen Sie es erneut. & echo %date% %time%: Ungültige Auswahl - %choice% >> "%LOGFILE%"
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
set /p "BackupDrive=Bitte gib den Laufwerksbuchstaben des Ziels ein (z.B. D:) [%BackupDrive%]: "
if "%BackupDrive%"=="" set "BackupDrive=%BackupDrive%"
if "%BackupDrive%"=="" (
    echo Fehler: Kein Laufwerksbuchstabe angegeben. & echo %date% %time%: Backup-Fehler - Kein Laufwerk >> "%LOGFILE%"
    pause
    goto menu
)
echo Starte das Systembackup...
echo Dies kann einige Zeit dauern. Stelle sicher, dass das Ziel-Laufwerk angeschlossen ist.
wbadmin start backup -backupTarget:%BackupDrive% -include:C: -allCritical -quiet
if %ERRORLEVEL% neq 0 (
    echo Fehler: Das Backup konnte nicht erstellt werden. Überprüfe das Ziel-Laufwerk und den Speicherplatz. & echo %date% %time%: Backup-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Systembackup erfolgreich erstellt auf %BackupDrive%. & echo %date% %time%: Backup erfolgreich auf %BackupDrive% >> "%LOGFILE%"
echo.
pause
goto menu

:ClearTemp
cls
echo Lösche temporäre Dateien...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
echo Temporäre Dateien gelöscht. & echo %date% %time%: TEMP-Dateien gelöscht >> "%LOGFILE%"
echo.
pause
goto menu

:RenamePictures
cls
echo Starte das Skript zum Umbenennen von Bildern...
echo.
set /p "ImageFolderPath=Bitte geben Sie den vollständigen Pfad des Ordners ein (z.B. C:\Users\IhrName\Bilder): "
if not exist "%ImageFolderPath%" (
    echo Fehler: Pfad existiert nicht. & echo %date% %time%: RenamePictures-Fehler - Pfad nicht gefunden >> "%LOGFILE%"
    pause
    goto menu
)
set /p "ImageNewBaseName=Bitte geben Sie den neuen Basisnamen für die Bilder ein (z.B. MeinUrlaubsbild): "
echo.
set "PsScriptPath=%~dp0Rename-Images.ps1"
if not exist "%PsScriptPath%" (
    echo Fehler: Das PowerShell-Skript "%PsScriptPath%" wurde nicht gefunden. & echo %date% %time%: RenamePictures-Fehler - Skript nicht gefunden >> "%LOGFILE%"
    pause
    goto menu
)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PsScriptPath%" -FolderPath "%ImageFolderPath%" -NewBaseName "%ImageNewBaseName%"
if %ERRORLEVEL% neq 0 (
    echo Fehler: Das PowerShell-Skript konnte nicht erfolgreich ausgeführt werden. & echo %date% %time%: RenamePictures-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
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
echo Datenträgerbereinigung abgeschlossen. & echo %date% %time%: ProCleanup abgeschlossen >> "%LOGFILE%"
echo.
pause
goto menu

:RepairSystemFiles
cls
echo Repariere Systemdateien (SFC Scan)...
sfc /scannow
echo Bitte warten Sie, bis der Vorgang abgeschlossen ist. & echo %date% %time%: SFC Scan gestartet >> "%LOGFILE%"
echo.
pause
goto menu

:UpdateUpgrade
cls
echo Starte Windows Update und Upgrade...
echo Öffne Windows Update-Einstellungen.
start ms-settings:windowsupdate
echo %date% %time%: Windows Update gestartet >> "%LOGFILE%"
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
        echo Fehler beim Installieren von Winget. & echo %date% %time%: Winget-Installationsfehler - %ERRORLEVEL% >> "%LOGFILE%"
        pause
        goto menu
    )
)
echo Aktualisiere alle installierten Programme mit Winget...
winget upgrade --all
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Ausführen von Winget Upgrade. & echo %date% %time%: Winget-Upgrade-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Programme erfolgreich aktualisiert. & echo %date% %time%: Winget-Update erfolgreich >> "%LOGFILE%"
echo.
pause
goto menu

:CheckTPM
cls
echo Prüfe TPM 2.0 Installation...
start tpm.msc
echo TPM-Konsole geöffnet. Prüfen Sie die TPM-Informationen. & echo %date% %time%: TPM geöffnet >> "%LOGFILE%"
echo.
pause
goto menu

:SleepMode
cls
echo Aktiviere Energiesparmodus (Sleep)...
rundll32.exe powrprof.dll,SetSuspendState Sleep
echo %date% %time%: Sleep aktiviert >> "%LOGFILE%"
echo.
pause
goto menu

:EnableHiddenAccount
cls
echo Aktiviere das versteckte Administrator-Konto...
net user administrator /active:yes
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Aktivieren des Kontos. & echo %date% %time%: HiddenAccount-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Verstecktes Administrator-Konto aktiviert. & echo %date% %time%: HiddenAccount aktiviert >> "%LOGFILE%"
echo.
pause
goto menu

:EncryptFiles
cls
echo Verschlüssle JPG-Dateien im aktuellen Ordner...
cipher /e *.jpg
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Verschlüsseln der Dateien. & echo %date% %time%: EncryptFiles-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo JPG-Dateien erfolgreich verschlüsselt. & echo %date% %time%: EncryptFiles erfolgreich >> "%LOGFILE%"
echo.
pause
goto menu

:RemoveUndeletable
cls
echo Entferne unlöschbare Dateien...
set /p "FilePath=Bitte geben Sie den vollständigen Pfad der Datei ein (z.B. ?D:Test Ordner\lpt1.txt): "
if "%FilePath%"=="" (
    echo Fehler: Kein Pfad angegeben. & echo %date% %time%: RemoveUndeletable-Fehler - Kein Pfad >> "%LOGFILE%"
    pause
    goto menu
)
del "%FilePath%"
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Löschen der Datei. & echo %date% %time%: RemoveUndeletable-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Datei erfolgreich gelöscht. & echo %date% %time%: RemoveUndeletable erfolgreich - %FilePath% >> "%LOGFILE%"
echo.
pause
goto menu

:SecureDelete
cls
echo Starte sicheres Löschen (erfordert Admin-Rechte)...
set /p "Drive=Bitte geben Sie den Laufwerksbuchstaben ein (z.B. C:): "
if "%Drive%"=="" (
    echo Fehler: Kein Laufwerksbuchstabe angegeben. & echo %date% %time%: SecureDelete-Fehler - Kein Laufwerk >> "%LOGFILE%"
    pause
    goto menu
)
cipher /w:%Drive%
if %ERRORLEVEL% neq 0 (
    echo Fehler beim sicheren Löschen. & echo %date% %time%: SecureDelete-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Sicheres Löschen abgeschlossen. & echo %date% %time%: SecureDelete erfolgreich auf %Drive% >> "%LOGFILE%"
echo.
pause
goto menu

:GetIP
cls
echo Hole IP-Adresse...
ipconfig
echo %date% %time%: IP-Adresse abgerufen >> "%LOGFILE%"
echo.
pause
goto menu

:CheckDisk
cls
echo Prüfe Laufwerke auf Fehler mit chkdsk...
chkdsk /f
echo Chkdsk wird ausgeführt. Drücken Sie eine Taste, um fortzufahren. & echo %date% %time%: Chkdsk gestartet >> "%LOGFILE%"
echo.
pause
goto menu

:Robocopy
cls
echo Starte robocopy zum Kopieren von Dateien...
set /p "Source=Bitte geben Sie den Quellpfad ein (z.B. C:\Quelle): "
if not exist "%Source%" (
    echo Fehler: Quellpfad existiert nicht. & echo %date% %time%: Robocopy-Fehler - Quellpfad nicht gefunden >> "%LOGFILE%"
    pause
    goto menu
)
set /p "Destination=Bitte geben Sie den Zielpfad ein (z.B. D:\Ziel): "
if "%Source%"=="" or "%Destination%"=="" (
    echo Fehler: Quell- oder Zielpfad fehlt. & echo %date% %time%: Robocopy-Fehler - Pfad fehlt >> "%LOGFILE%"
    pause
    goto menu
)
robocopy "%Source%" "%Destination%" /E
if %ERRORLEVEL% neq 0 (
    echo Fehler beim Kopieren mit robocopy. & echo %date% %time%: Robocopy-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Kopiervorgang abgeschlossen. & echo %date% %time%: Robocopy erfolgreich - %Source% nach %Destination% >> "%LOGFILE%"
echo.
pause
goto menu

:DiskPart
cls
echo Starte diskpart zur Partitionverwaltung...
diskpart
echo Diskpart-Konsole geöffnet. Folgen Sie den Anweisungen. & echo %date% %time%: Diskpart geöffnet >> "%LOGFILE%"
echo.
pause
goto menu

:Help
cls
color 0E
echo Hilfe: Wählen Sie eine Zahl (0-28) für die gewünschte Funktion...
echo 0: Beenden
echo 1-21: Grundlegende Systemfunktionen (z.B. BIOS, Backup)
echo 22: Diese Hilfe anzeigen
echo 23: Netzwerk-Tools (Ping, Tracert)
echo 24: Defragmentierung
echo 25: Task-Manager oder Prozess beenden
echo 26: Automatische Wartung
echo 27: Benutzerdefinierte Skripte
echo 28: Prüfe Updates
echo Drücken Sie eine Taste, um zurückzukehren.
pause >nul
color 0A
goto menu

:NetworkTools
cls
echo Netzwerk-Tools:
echo 1. Ping
echo 2. Tracert
set /p netchoice="Wähle eine Option (1-2): "
if "%netchoice%"=="1" set /p host="Gib die IP/Domain ein: " & ping %host% & echo %date% %time%: Ping - %host% >> "%LOGFILE%" & pause & goto menu
if "%netchoice%"=="2" set /p host="Gib die IP/Domain ein: " & tracert %host% & echo %date% %time%: Tracert - %host% >> "%LOGFILE%" & pause & goto menu
echo Ungültige Auswahl. & echo %date% %time%: NetworkTools-Fehler - Ungültige Auswahl >> "%LOGFILE%"
pause
goto menu

:Defrag
cls
set /p drive="Gib den Laufwerksbuchstaben ein (z.B. C:): "
if "%drive%"=="" (
    echo Fehler: Kein Laufwerk angegeben. & echo %date% %time%: Defrag-Fehler - Kein Laufwerk >> "%LOGFILE%"
    pause
    goto menu
)
defrag %drive% /O
if %ERRORLEVEL% neq 0 (
    echo Fehler bei der Defragmentierung. & echo %date% %time%: Defrag-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Defragmentierung abgeschlossen. & echo %date% %time%: Defrag erfolgreich auf %drive% >> "%LOGFILE%"
pause
goto menu

:TaskManager
cls
set /p pid="Gib die Prozess-ID (PID) ein, die beendet werden soll (oder leer für Task-Manager): "
if "%pid%"=="" start taskmgr & echo %date% %time%: TaskManager geöffnet >> "%LOGFILE%" & pause & goto menu
taskkill /PID %pid% /F
if %ERRORLEVEL% neq 0 (
    echo Fehler: Prozess konnte nicht beendet werden. & echo %date% %time%: TaskManager-Fehler - %ERRORLEVEL% >> "%LOGFILE%"
    pause
    goto menu
)
echo Prozess beendet. & echo %date% %time%: Prozess %pid% beendet >> "%LOGFILE%"
pause
goto menu

:AutoMaintenance
cls
echo Starte automatische Wartung...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
chkdsk /f
echo Wartung abgeschlossen. & echo %date% %time%: AutoMaintenance abgeschlossen >> "%LOGFILE%"
pause
goto menu

:CustomScripts
cls
if not exist "%~dp0custom" mkdir "%~dp0custom"
echo Verfügbare benutzerdefinierte Skripte im Ordner 'custom':
dir "%~dp0custom\*.bat" /b
set /p script="Gib den Namen des Skripts ein (z.B. myscript.bat): "
if exist "%~dp0custom\%script%" call "%~dp0custom\%script%" & echo %date% %time%: CustomScript - %script% ausgeführt >> "%LOGFILE%" & pause & goto menu
echo Fehler: Skript nicht gefunden. & echo %date% %time%: CustomScript-Fehler - %script% nicht gefunden >> "%LOGFILE%"
pause
goto menu

:CheckUpdates
cls
echo Prüfe auf Updates...
powershell -Command "Invoke-WebRequest -Uri https://github.com/yottapixel-de/Hannes-Powertools/releases/latest -OutFile version.txt"
for /f "tokens=*" %%i in (version.txt) do set "latest=%%i"
del version.txt
echo Aktuelle Version: 1.0
echo Neueste Version: %latest%
if "%latest%"=="1.0" (
    echo Du hast die neueste Version. & echo %date% %time%: Keine Updates verfügbar >> "%LOGFILE%"
) else (
    echo Eine neuere Version (%latest%) ist verfügbar. Lade sie von GitHub herunter. & echo %date% %time%: Update verfügbar - %latest% >> "%LOGFILE%"
)
pause
goto menu

:end
cls
echo Hannes' Powertools wird beendet. Auf Wiedersehen! & echo %date% %time%: Skript beendet >> "%LOGFILE%"
timeout /t 2 >nul
exit