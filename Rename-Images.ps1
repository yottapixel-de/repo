# PowerShell-Skript zum Umbenennen von Bildern
# Speichern als: Rename-Images.ps1

param (
    [string]$FolderPath,
    [string]$NewBaseName
)

# Debugging-Informationen
Write-Host "Debugging: Erhaltener Pfad: '$FolderPath'" -ForegroundColor Magenta
Write-Host "Debugging: Erhaltener Basisname: '$NewBaseName'" -ForegroundColor Magenta

# Prüfen, ob der Ordner existiert
if (-not (Test-Path $FolderPath)) {
    Write-Host "Fehler: Der angegebene Ordner '$FolderPath' wurde nicht gefunden." -ForegroundColor Red
    Write-Host "Bitte überprüfen Sie den Pfad und versuchen Sie es erneut." -ForegroundColor Red
    pause
    exit 1
}

# Prüfen, ob der Basisname leer ist
if ([string]::IsNullOrWhiteSpace($NewBaseName)) {
    Write-Host "Fehler: Der neue Basisname darf nicht leer sein." -ForegroundColor Red
    pause
    exit 1
}

# Unterstützte Bildformate
$SupportedExtensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.bmp", "*.tiff", "*.webp", "*.ico")

# Bilder im Ordner suchen
Write-Host "Debugging: Suche nach Dateien im Pfad: $FolderPath mit Erweiterungen: $SupportedExtensions" -ForegroundColor Magenta
$ImageFiles = Get-ChildItem -Path $FolderPath -Include $SupportedExtensions -File -ErrorAction SilentlyContinue -Recurse

Write-Host "Debugging: Anzahl der gefundenen Dateien: $($ImageFiles.Count)" -ForegroundColor Magenta

if ($ImageFiles.Count -eq 0) {
    Write-Host "Keine unterstützten Bilddateien im Ordner '$FolderPath' gefunden." -ForegroundColor Yellow
    Write-Host "Unterstützte Formate: jpg, jpeg, png, gif, bmp, tiff, webp, ico" -ForegroundColor Yellow
    Write-Host "Bitte überprüfen Sie, ob der Ordner Dateien mit diesen Erweiterungen enthält." -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "Gefundene Bilder zum Umbenennen:" -ForegroundColor Cyan
$ImageFiles | ForEach-Object {
    Write-Host "  - $($_.Name)"
}
Write-Host ""

# Bestätigung vom Benutzer einholen
$Confirm = Read-Host "Möchten Sie diese Bilder umbenennen? (J/N)"
if ($Confirm -ne "J" -and $Confirm -ne "j") {
    Write-Host "Umbenennung abgebrochen." -ForegroundColor Yellow
    pause
    exit 0
}

# Bilder umbenennen
$Counter = 1
foreach ($File in $ImageFiles) {
    $NewName = "$NewBaseName`_$(($Counter).ToString('000'))$($File.Extension)"
    $NewFullPath = Join-Path -Path $FolderPath -ChildPath $NewName
    try {
        Rename-Item -Path $File.FullName -NewName $NewName -Force -ErrorAction Stop
        Write-Host "Umbenannt: $($File.Name) -> $NewName" -ForegroundColor Green
    }
    catch {
        Write-Host "Fehler beim Umbenennen von $($File.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
    $Counter++
}

Write-Host "`nUmbenennung abgeschlossen! Alle unterstützten Bilder im Ordner '$FolderPath' wurden verarbeitet." -ForegroundColor Green
pause
exit 0