# PowerShell-Skript zum Umbenennen und Konvertieren von Bildern

# Parameter für Ordnerpfad, Basisname und neues Bildformat
param (
    [string]$FolderPath,
    [string]$NewBaseName,
    [string]$NewFormat
)

# --- Interaktive Eingabe, falls Parameter nicht gesetzt ---
# Diese Eingaben werden nur benötigt, wenn das Skript direkt (ohne Batch-Datei) ausgeführt wird
if ([string]::IsNullOrWhiteSpace($FolderPath)) {
    $FolderPath = Read-Host "Bitte geben Sie den vollständigen Pfad des Ordners ein (z.B. C:\Users\IhrName\Bilder)"
}
if ([string]::IsNullOrWhiteSpace($NewBaseName)) {
    $NewBaseName = Read-Host "Bitte geben Sie den neuen Basisnamen für die Bilder ein (z.B. MeinUrlaubsbild)"
}
if ([string]::IsNullOrWhiteSpace($NewFormat)) {
    $NewFormat = Read-Host "Bitte geben Sie das neue Bildformat ein (z.B. PNG, JPG, TIFF, GIF)"
}

# --- Debugging-Start ---
Write-Host "Debugging: Erhaltener Pfad: '$FolderPath'" -ForegroundColor Magenta
Write-Host "Debugging: Erhaltener Basisname: '$NewBaseName'" -ForegroundColor Magenta
Write-Host "Debugging: Erhaltenes Format: '$NewFormat'" -ForegroundColor Magenta
# --- Debugging-Ende ---

# Prüfen, ob der Ordner existiert
if (-not (Test-Path $FolderPath)) {
    Write-Host "Fehler: Der angegebene Ordner wurde nicht gefunden. Bitte überprüfen Sie den Pfad." -ForegroundColor Red
    Exit 1
}

# Prüfen, ob der Basisname leer ist
if ([string]::IsNullOrWhiteSpace($NewBaseName)) {
    Write-Host "Fehler: Der neue Basisname darf nicht leer sein. Abbruch." -ForegroundColor Red
    Exit 1
}

# Prüfen, ob das Format gültig ist
$SupportedFormats = @("jpg", "jpeg", "png", "gif", "bmp", "tiff")
if ([string]::IsNullOrWhiteSpace($NewFormat) -or $SupportedFormats -notcontains $NewFormat.ToLower()) {
    Write-Host "Fehler: Ungültiges oder kein Format angegeben. Unterstützte Formate: $($SupportedFormats -join ', ')" -ForegroundColor Red
    Exit 1
}

# Unterstützte Eingabeformate für die Bildsuche
$SupportedExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff")

# --- Debugging-Start ---
# Prüfe alle Dateien im Ordner (für Debugging)
$AllFiles = Get-ChildItem -Path $FolderPath -File -ErrorAction SilentlyContinue
Write-Host "Debugging: Alle Dateien im Ordner ($($AllFiles.Count)):" -ForegroundColor Magenta
$AllFiles | ForEach-Object { Write-Host "  - $($_.Name) (Erweiterung: $($_.Extension))" -ForegroundColor Magenta }
# --- Debugging-Ende ---

# Bilder suchen (Groß-/Kleinschreibung ignorieren)
$ImageFiles = Get-ChildItem -Path $FolderPath -File -ErrorAction SilentlyContinue | Where-Object { $SupportedExtensions -contains $_.Extension.ToLower() }

# --- Debugging-Start ---
Write-Host "Debugging: Anzahl der gefundenen Bilddateien: $($ImageFiles.Count)" -ForegroundColor Magenta
if ($ImageFiles.Count -gt 0) {
    Write-Host "Debugging: Gefundene Bilddateien:" -ForegroundColor Magenta
    $ImageFiles | ForEach-Object { Write-Host "  - $($_.FullName)" -ForegroundColor Magenta }
}
# --- Debugging-Ende ---

# Prüfen, ob Bilddateien gefunden wurden
if ($ImageFiles.Count -eq 0) {
    Write-Host "Keine unterstützten Bilddateien im angegebenen Ordner gefunden." -ForegroundColor Yellow
    Write-Host "Hinweis: Unterstützte Erweiterungen sind: $($SupportedExtensions -join ', ')" -ForegroundColor Yellow
    Write-Host "Bitte überprüfen Sie, ob der Ordner Bilddateien enthält und ob Sie Zugriffsrechte haben." -ForegroundColor Yellow
    Exit 1
}

# Liste der gefundenen Bilder anzeigen
Write-Host "Gefundene Bilder zum Umbenennen/Konvertieren:" -ForegroundColor Cyan
$ImageFiles | ForEach-Object {
    Write-Host "  - $($_.Name)"
}
Write-Host ""

# Bestätigung vom Benutzer einholen
$Confirm = Read-Host "Möchten Sie diese Bilder umbenennen und konvertieren? (J/N)"
if ($Confirm -ne "J" -and $Confirm -ne "j") {
    Write-Host "Vorgang abgebrochen." -ForegroundColor Yellow
    Exit 0
}

# Lade System.Drawing für die Bildkonvertierung
Add-Type -AssemblyName System.Drawing

$Counter = 1
foreach ($File in $ImageFiles) {
    # Dreistellige Nummerierung (z.B. 001)
    $Number = $Counter.ToString("D3")
    $NewName = "$($NewBaseName)_$($Number).$($NewFormat.ToLower())"
    $NewFilePath = Join-Path -Path $FolderPath -ChildPath $NewName

    # Prüfen, ob die neue Datei bereits existiert
    if (Test-Path $NewFilePath) {
        Write-Host "Warnung: Datei '$NewName' existiert bereits. Überspringe oder wähle neuen Namen." -ForegroundColor Yellow
        $Counter++
        continue
    }

    try {
        # Prüfen, ob die Datei lesbar ist
        $null = [System.IO.File]::OpenRead($File.FullName).Close()
        
        # Bild laden
        $Image = [System.Drawing.Image]::FromFile($File.FullName)
        
        # Neues Format bestimmen
        $ImageFormat = switch ($NewFormat.ToLower()) {
            "jpg"  { [System.Drawing.Imaging.ImageFormat]::Jpeg }
            "jpeg" { [System.Drawing.Imaging.ImageFormat]::Jpeg }
            "png"  { [System.Drawing.Imaging.ImageFormat]::Png }
            "gif"  { [System.Drawing.Imaging.ImageFormat]::Gif }
            "bmp"  { [System.Drawing.Imaging.ImageFormat]::Bmp }
            "tiff" { [System.Drawing.Imaging.ImageFormat]::Tiff }
            default { [System.Drawing.Imaging.ImageFormat]::Png }
        }

        # Bild im neuen Format speichern
        $Image.Save($NewFilePath, $ImageFormat)
        $Image.Dispose()

        # Originaldatei löschen
        Remove-Item -Path $File.FullName -Force -ErrorAction Stop
        Write-Host "Konvertiert und umbenannt: $($File.Name) -> $NewName" -ForegroundColor Green
    }
    catch {
        Write-Host "Fehler beim Verarbeiten von $($File.Name): $($_.Exception.Message)" -ForegroundColor Red
        continue
    }
    $Counter++
}

Write-Host "`nAlle unterstützten Bilder im Ordner '$FolderPath' wurden erfolgreich verarbeitet!" -ForegroundColor Green

# Pause für Benutzer (verhindert Schließen des Fensters)
Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
