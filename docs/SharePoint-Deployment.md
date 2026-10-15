# Deployment des ADMBw QEA Analyzers auf Bw-SharePoint

Zwei Dateien stehen zur Verfügung (identischer Inhalt, bis auf den Kopf):

* `ADMBw_QEA_Analyzer.html` — reine HTML-Variante
* `ADMBw_QEA_Analyzer.aspx` — SharePoint-/IIS-Variante

## 1. Lokale Nutzung (empfohlen für Einzelplatz)

1. Datei `ADMBw_QEA_Analyzer.html` speichern.
2. Per **Doppelklick** öffnen (Edge/Chrome/Firefox aktuell halten).
3. QEA-Datei auf die Seite ziehen — Auswertung startet automatisch.
   *Hinweis: Es werden keinerlei Daten übertragen; alles rechnet im Browser.*

## 2. SharePoint-Dokumentbibliothek

1. Zielbibliothek öffnen (z. B. „Dokumente" der Projekt- oder Referatsseite).
2. **`ADMBw_QEA_Analyzer.aspx`** hochladen (für die Bibliotheksansicht; die ASPX rendert ohne Server-Code).
3. Datei anklicken → sie wird direkt im Browser ausgeführt bzw. kann in einem neuen Tab geöffnet werden.
4. Für die **HTML-Variante**: `ADMBw_QEA_Analyzer.html` ebenfalls hochladen; je nach Farm-Konfiguration wird sie zum Download angeboten oder direkt angezeigt.

### Technische Vorgaben (bereits eingehalten)

* Die ASPX-Datei beginnt **direkt mit `<!DOCTYPE html>`**.
  **Es wird keine `<%@ Page Language=… %>`-Direktive vorangestellt** (Vorgabe 10/2026; die Farm-Parser lehnen die Direktive ab).
* Datei ist **UTF-8 mit BOM** gespeichert + `<meta charset>` und `<meta http-equiv="Content-Type">` als Absicherungen (verhindert Mojibake bei Umlauten).
* Die Datei enthält **keine `<%`-Sequenzen** (kein Server-Code).
* Keine externen Abhängigkeiten (kein CDN, keine Webfonts, keine Bibliotheken) — funktioniert daher auch in gesperrten Netzen vollständig offline.

### Prüfliste nach dem Upload

1. Seite öffnen → Header „ADMBw QEA Analyzer" mit Versions-Badge sichtbar?
2. Umlaute korrekt (z. B. „Sichten", „Prüfung")? Falls nicht → BOM/Zeichendekodierung prüfen.
3. QEA-Datei laden → Kennzahlenzeile („x Pakete · y Sichten …") erscheint?
4. Test-Export: eine Sicht öffnen → „📊 Sicht als Excel (.xlsx)" → Datei öffnet in Excel.

## 3. Fehlersuche

| Symptom | Ursache / Abhilfe |
|---|---|
| Mojibake („Ã¤", „Ã¶") | BOM verloren (Datei wurde z. B. über einen Editor ohne BOM neu gespeichert) → Original aus diesem Repo verwenden |
| „Seite kann nicht angezeigt werden" beim ASPX-Aufruf | Bibliothek erlaubt kein Ausführen von ASPX → HTML-Variante nutzen oder Datei in einen Ordner mit Ausführungsrechten legen (Admin) |
| Leere Seite im IE-Altbestand | Tool setzt ES5 voraus, benötigt aber aktuellen Browser (Chromium/Firefox); IE11 wird nicht unterstützt |
| Download der Exporte blockiert | Pop-up-/Download-Blocker für die SharePoint-Seite erlauben |

---

*Stand: 15.10.2026 · ADMBw QEA Analyzer v4.0*
