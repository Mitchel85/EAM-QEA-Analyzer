# Deployment des ADMBw QEA Analyzers auf Bw-SharePoint

Zur Verfügung stehen vier Dateien (Analyse- und Edit-Edition, jeweils HTML + ASPX):

* `ADMBw_QEA_Analyzer.html` — reine HTML-Variante (Analyse, v4.0)
* `ADMBw_QEA_Analyzer.aspx` — SharePoint-/IIS-Variante (Analyse, v4.0)
* `ADMBw_QEA_Analyzer_Edit.html` — **Edit-Edition (v5.0)**: analysieren **und bearbeiten**
* `ADMBw_QEA_Analyzer_Edit.aspx` — Edit-Edition als SharePoint-/IIS-Variante

## 1. Lokale Nutzung (empfohlen für Einzelplatz)

1. Datei `ADMBw_QEA_Analyzer.html` (Analyse) bzw. `ADMBw_QEA_Analyzer_Edit.html` (Bearbeiten) speichern.
2. Per **Doppelklick** öffnen (Edge/Chrome/Firefox aktuell halten).
3. QEA-Datei auf die Seite ziehen — Auswertung startet automatisch.
   *Hinweis: Es werden keinerlei Daten übertragen; alles rechnet im Browser.*

## 2. SharePoint-Dokumentbibliothek

1. Zielbibliothek öffnen (z. B. „Dokumente" der Projekt- oder Referatsseite).
2. **`ADMBw_QEA_Analyzer.aspx`** (bzw. `ADMBw_QEA_Analyzer_Edit.aspx`) hochladen (für die Bibliotheksansicht; die ASPX rendert ohne Server-Code).
3. Datei anklicken → sie wird direkt im Browser ausgeführt bzw. kann in einem neuen Tab geöffnet werden.
4. Für die **HTML-Varianten**: die jeweilige `.html`-Datei ebenfalls hochladen; je nach Farm-Konfiguration wird sie zum Download angeboten oder direkt angezeigt.

### Technische Vorgaben (bereits eingehalten)

* Die ASPX-Dateien beginnen **direkt mit `<!DOCTYPE html>`**.
  **Es wird keine `<%@ Page Language=… %>`-Direktive vorangestellt** (Vorgabe 10/2026; die Farm-Parser lehnen die Direktive ab).
* Dateien sind **UTF-8 mit BOM** gespeichert + `<meta charset>` und `<meta http-equiv="Content-Type">` als Absicherungen (verhindert Mojibake bei Umlauten).
* Die Dateien enthalten **keine `<%`-Sequenzen** (kein Server-Code).
* Keine externen Abhängigkeiten zur Laufzeit (kein CDN, keine Webfonts, keine externen Bibliotheken) — funktioniert daher auch in gesperrten Netzen vollständig offline.

### Besonderheiten der Edit-Edition (v5.0)

* Die Edit-Dateien sind **~1,3 MB** groß: Sie enthalten eine eingebettete SQLite-Engine (sql.js, WASM, MIT-Lizenz) für den lokalen Schreibpfad.
* Anforderung: aktueller Edge/Chrome/Firefox — **WebAssembly** ist dort standardmäßig aktiv. Die reine Analyse funktioniert auch darüber hinaus.
* **Arbeitsweise:** Änderungen werden erst **vorgemerkt** und über „💾 Als neue .qea speichern" als **neue Datei** (Download) geschrieben. Die geöffnete Originaldatei wird **nie** verändert.
* **Empfehlung:** Mit einer **Kopie** des Modells arbeiten; die erzeugte Datei zuerst in Sparx EA öffnen und prüfen, bevor sie weiterverwendet wird.

### Prüfliste nach dem Upload

1. Seite öffnen → Header „ADMBw QEA Analyzer" mit Versions-Badge sichtbar?
2. Umlaute korrekt (z. B. „Sichten", „Prüfung")? Falls nicht → BOM/Zeichendekodierung prüfen.
3. QEA-Datei laden → Kennzahlenzeile („x Pakete · y Sichten …") erscheint?
4. Test-Export: eine Sicht öffnen → „📊 Sicht als Excel (.xlsx)" → Datei öffnet in Excel.
5. (Edit-Edition) Kleine Änderung vormerken → „💾 Als neue .qea speichern" → neue Datei landet im Download-Ordner; Ansicht aktualisiert sich; in Sparx EA öffnen und prüfen.

## 3. Fehlersuche

| Symptom | Ursache / Abhilfe |
|---|---|
| Mojibake („Ã¤", „Ã¶") | BOM verloren (Datei wurde z. B. über einen Editor ohne BOM neu gespeichert) → Original aus diesem Repo verwenden |
| „Seite kann nicht angezeigt werden" beim ASPX-Aufruf | Bibliothek erlaubt kein Ausführen von ASPX → HTML-Variante nutzen oder Datei in einen Ordner mit Ausführungsrechten legen (Admin) |
| Leere Seite im IE-Altbestand | Tool setzt ES5 voraus, benötigt aber aktuellen Browser (Chromium/Firefox); IE11 wird nicht unterstützt |
| Download der Exporte blockiert | Pop-up-/Download-Blocker für die SharePoint-Seite erlauben |
| Edit-Edition: „SQLite-Engine konnte nicht geladen werden" | Browser blockiert WebAssembly (selten, z. B. per Richtlinie) → Analyse-Variante nutzen bzw. Richtlinie prüfen |

---

*Stand: 16.10.2026 · ADMBw QEA Analyzer v5.0 (Edit-Edition) & v4.0 (Analyse)*
