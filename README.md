# Hannes' Powertools

## Beschreibung
Hannes' Powertools ist ein leistungsstarkes Batch-Skript für Windows, das eine Vielzahl von Systemverwaltungstools und -funktionen in einer benutzerfreundlichen Kommandozeilen-Oberfläche bietet. Mit diesem Tool können Benutzer Aufgaben wie das Starten in den abgesicherten Modus, das Erstellen von Backups, das Umbenennen von Bildern, das Aktualisieren von Programmen mit Winget und vieles mehr ausführen. Es ist ideal für Fortgeschrittene und Profis, die ihr Windows-System effizient verwalten möchten.

## Funktionen
- **Ins BIOS starten**
- **Von USB starten**
- **Abgesicherter Modus**
- **Reparaturmodus**
- **System-Backup erstellen**
- **TEMP-Dateien löschen**
- **Bilder umbenennen**
- **Datenträgerbereinigung für Profis**
- **Systemdateien reparieren**
- **Windows Update und Upgrade**
- **Winget: Programme aktualisieren (automatische Installation, falls nötig)**
- **TPM 2.0 prüfen**
- **Energie sparen (Sleep-Modus)**
- **Verstecktes Administrator-Konto aktivieren**
- **Dateien verschlüsseln**
- **Unlöschbare Dateien entfernen**
- **Sicheres Löschen**
- **IP-Adresse herausfinden**
- **chkdsk auf Fehler prüfen**
- **robocopy für robustes Kopieren**
- **diskpart für Partitionenverwaltung**

## Voraussetzungen
- **Betriebssystem**: Windows 11 (andere Versionen können eingeschränkt funktionieren)
- **Rechte**: Administratorrechte werden für viele Funktionen empfohlen
- **PowerShell**: Erforderlich für das Umbenennen von Bildern
- **Internetverbindung**: Für Winget-Installation und -Updates

## Installation
1. **Repository klonen oder Datei herunterladen**:
   ```bash
   git clone https://github.com/yottapixel-de/Hannes-Powertools.git

   





Haftungsausschluss:

Hannes Powertools ist ein von Johannes Heide entwickeltes Skript, das unter der Creative Commons Attribution 4.0 International (CC BY 4.0) Lizenz veröffentlicht wird. Nutzer dürfen das Skript kopieren, verbreiten, anpassen und verwenden, sofern die Urheberschaft korrekt angegeben wird, wie in der Lizenz beschrieben.

Dieses Skript wird "WIE ES IST" ohne jegliche Garantien, ausdrücklich oder stillschweigend, bereitgestellt. Der Autor, Johannes Heide, übernimmt keine Haftung für Schäden, Datenverlust oder andere negative Folgen, die aus der Nutzung dieses Skripts resultieren könnten. Es liegt in der Verantwortung des Nutzers, sicherzustellen, dass:

Das Skript in einer sicheren und geeigneten Umgebung ausgeführt wird.
Alle Eingaben (z. B. Dateipfade, Basisnamen, Bildformate) korrekt und sicher sind.
Der Nutzer über die erforderlichen Berechtigungen verfügt, um auf die angegebenen Dateien und Verzeichnisse zuzugreifen.
Vor der Ausführung des Skripts eine Datensicherung erstellt wird, insbesondere bei Operationen, die Dateien löschen oder ändern (z. B. Umbenennen und Konvertieren von Bildern).

Wichtige Hinweise:

Datenverlust: Das Skript Rename-Images.ps1 kann Originaldateien löschen, nachdem sie umbenannt oder konvertiert wurden. Es liegt in der Verantwortung des Nutzers, vor der Ausführung eine Sicherungskopie der Dateien zu erstellen.
Systemkompatibilität: Das Skript wurde für Windows-Systeme entwickelt und verwendet PowerShell sowie CMD-Befehle. Es wird keine Kompatibilität mit anderen Betriebssystemen garantiert.
Bildformate: Die Unterstützung ist auf die Formate .jpg, .jpeg, .png, .gif, .bmp und .tiff beschränkt. Andere Formate wie .webp erfordern zusätzliche Software (z. B. ImageMagick).
Berechtigungen: Das Skript erfordert ausreichende Lese- und Schreibrechte für die angegebenen Verzeichnisse. Fehler aufgrund fehlender Berechtigungen liegen in der Verantwortung des Nutzers.

Nutzung auf eigene Gefahr:

Durch die Verwendung dieses Skripts erklären Sie sich damit einverstanden, dass Sie es auf eigene Gefahr verwenden. Der Autor haftet nicht für direkte, indirekte, zufällige oder Folgeschäden, die aus der Nutzung des Skripts entstehen, einschließlich, aber nicht beschränkt auf, Datenverlust, Systemausfälle oder andere technische Probleme.

Support:

Für Fragen oder Unterstützung wenden Sie sich bitte an: johannes_heide@yahoo.de. Es wird kein fortlaufender Support garantiert, und Antworten erfolgen nach Ermessen des Autors.

Lizenz:

Dieses Skript unterliegt der Creative Commons Attribution 4.0 International (CC BY 4.0). Bitte beachten Sie die Lizenzbedingungen für die Nutzung, Weitergabe und Anpassung des Skripts.
Letzte Aktualisierung: 29. Juni 2025
