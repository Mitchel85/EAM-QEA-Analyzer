# ADMBw QEA Analyzer

**▶️ Online ausprobieren:** [mitchel85.github.io/EAM-QEA-Analyzer](https://mitchel85.github.io/EAM-QEA-Analyzer/) — Analyse direkt im Browser, 100 % lokal.

**QEA-Architekturen niederschwellig analysieren — und auf Wunsch bearbeiten. 100 % lokal im Browser, ohne KI, ohne Installation.**

Einzeldatei-Tool (HTML & ASPX) für Sparx-EA-Architekturmodelle (`.qea` / `.qeax`):
Pakete & Sichten erkunden · Gesamtzusammenhang im Graphen analysieren · **Verbindungen zweier Elemente nachweisen** (ArAMIS-inspiriert) · jede Sicht als **PNG oder Excel (.xlsx)** exportieren. Knoten-Farben gemäß **ADMBw/NAFv4**.

**NEU in v5.0 — Edit-Edition:** Architekturdaten auch **bearbeiten** (Elemente, Pakete, Sichten, Beziehungen, Tags; anlegen & entfernen) — geschrieben wird in eine **neue `.qea`-Datei**, das Original bleibt unangetastet. → [Edit-Edition](#edit-edition-v50--architektur-bearbeiten)

![Ansicht „Erkunden“](docs/img/vorschau_erkunden.png)

---

## Funktionen

* **🧭 Erkunden** — realer Paketbaum (t_package) mit allen tatsächlich vorhandenen Sichten (t_diagram), Elementen und Beziehungen. Auch Modelle **ohne** ADMBw-Namenskonvention werden vollständig angezeigt.
* **🔍 Sofort-Suche** — globale Live-Suche über Sichten, Pakete und Elemente (Name, Alias, Stereotyp, Beschreibung) mit Ergebnis-Vollansicht.
* **🕸️ Graph** — interaktive Netzwerk-/Schichten-/Radial-Darstellung; Knotenzahl stufenlos per **Schieberegler oder manueller Zahleneingabe**; Farb-Legende nach ADMBw/NAFv4.
* **🔗 Verbindungen (Pfadanalyse, experimentell)** — Start- und Ziel-Element wählen: Der Analyzer findet die Verbindungskette (kürzester Pfad oder bis zu 5 Alternativen, gerichtet/ungerichtet, max. 1–10 Hops), zeigt sie als **Schritt-Kette, Tabelle und Graph-Ausschnitt** — und liefert bei fehlender Verbindung eine **Architektur-Diagnose** (getrennte Teilarchitekturen, Erreichbarkeit, gemeinsame Nachbarn). Inspiriert von ArAMIS Web (/ AAroN-Neo4j).
* **📸 / 📊 1-Klick-Export** — jede einzelne Sicht, jedes Paket, jeder Graph und jede Pfadanalyse als hochauflösendes **PNG** (mit Bw-Kopfzeile) oder als echte, mehrblättrige **Excel-Arbeitsmappe (.xlsx)** — komplett offline erzeugt.
* **🎨 ADMBw/NAFv4-Farben** — Elemente in den offiziellen Schichtfarben (Konzepte, Services, Logik, Ressourcen, Anforderungen) → Details: [docs/ADMBw-Farben.md](docs/ADMBw-Farben.md)
* **✏️ Bearbeiten (v5.0, Edit-Edition)** — siehe eigener Abschnitt unten.
* **🔒 Zero-Data-Leakage** — die QEA-Datei wird ausschließlich im Browser verarbeitet; es findet **keinerlei** Datenübertragung statt. Kein CDN, kein Build-Schritt. *(Die Edit-Edition enthält zusätzlich eine eingebettete SQLite-Engine ausschließlich für den lokalen Schreibpfad.)*

![Verbindungsanalyse](docs/img/vorschau_verbindungen.png)
![Architektur-Graph in ADMBw/NAFv4-Farben](docs/img/vorschau_graph_admbw.png)

---

## Edit-Edition (v5.0) — Architektur bearbeiten

`dist/ADMBw_QEA_Analyzer_Edit.html` (bzw. `.aspx`) ist die Vollversion inkl. **Bearbeiten-Modus**:

* **Ändern:** Elemente (Name, Stereotype, Alias, Status, Beschreibung), Pakete (Name, Beschreibung), Sichten/Diagramme (Name, Beschreibung), Beziehungen (Name, Stereotype, Richtung, Beschreibung) und **Tagged Values** (ändern, ergänzen, entfernen).
* **Anlegen:** neue Elemente in einem Paket; neue Beziehungen zwischen zwei Elementen (mit Zielsuche über Name/Alias/Stereotype).
* **Entfernen:** einzelne Elemente (mit vollständiger Kaskade: Beziehungen, Sicht-Platzierungen, Tags, Diagramm-Links, Eigenschafts-/xref-Einträge) und einzelne Beziehungen.
* **Prinzip „Vormerken statt Sofort-Schreiben":** Alle Änderungen landen in einer sichtbaren **Änderungsliste** (mit Alt→Neu-Diff, einzeln entfernbar) und werden erst über **„💾 Als neue .qea speichern"** geschrieben — als **neue Datei**. Die geöffnete Originaldatei wird **nie** verändert. Änderungsprotokoll als CSV exportierbar.
* **Technik:** Geschrieben wird mit einer eingebetteten, echten **SQLite-Engine** (sql.js 1.13, MIT-Lizenz, als WASM eingebettet — läuft vollständig offline). Vor dem Export: `PRAGMA integrity_check` + Selbsttest mit dem eingebauten QEA-Reader; danach aktualisiert sich die Ansicht automatisch auf den gespeicherten Stand.
* **EA-Konventionen berücksichtigt:** getrennte AUTOINCREMENT-Sequenzen je Tabelle (neue IDs vergibt SQLite selbst), Paket-Spiegelung (`t_package` + `t_object` über `ea_guid`), Entity-kodierte Notizen (`&#252;`, CRLF), `t_xref`-Stereotype-Einträge (inkl. `FQName`), «…»-Labels auf Diagrammen, `ModifiedDate` nur dort, wo EA die Spalte führt.

![Bearbeiten-Buttons im Steckbrief](docs/img/vorschau_edit_steckbrief.png)
![Element-Editor](docs/img/vorschau_edit_editor.png)
![Änderungsliste mit „Als neue .qea speichern“](docs/img/vorschau_edit_aenderungen.png)

> ⚠️ **Erste Schritte mit der Edit-Edition:** mit einer **Kopie** des Modells arbeiten und die erzeugte Datei zunächst in Sparx EA öffnen und prüfen, bevor sie weiterverwendet wird. Die reine Analyse-Version (v4.0, ~300 KB ohne WASM) bleibt unverändert verfügbar.

---

## Schnellstart

1. `dist/ADMBw_QEA_Analyzer.html` herunterladen (oder direkt vom GitHub-Repo: *Raw → Datei speichern*).
2. Per Doppelklick im Browser öffnen (Edge/Chrome/Firefox aktuell).
3. QEA-/EAPX-Datei per Drag & Drop auf die Startseite ziehen — fertig.

Für Pfadanalyse und Graph gibt es keinen Server, keine Installation und keine Netzabhängigkeit.
Für das **Bearbeiten** zusätzlich `dist/ADMBw_QEA_Analyzer_Edit.html` verwenden.

## Deployment bei der Bundeswehr (SharePoint)

Es liegen **vier Varianten** bei (Analyse- und Edit-Edition, jeweils HTML + ASPX):

| Datei | Verwendung |
|---|---|
| `dist/ADMBw_QEA_Analyzer.html` | Analyse-Version v4.0 (~300 KB) — lokale Nutzung oder SharePoint-Dokumentbibliothek |
| `dist/ADMBw_QEA_Analyzer.aspx` | Analyse-Version als SharePoint-/IIS-Variante (beginnt direkt mit `<!DOCTYPE html>`) |
| `dist/ADMBw_QEA_Analyzer_Edit.html` | **Edit-Edition v5.0** — analysieren **und bearbeiten** (~1,3 MB inkl. eingebetteter SQLite-Engine) |
| `dist/ADMBw_QEA_Analyzer_Edit.aspx` | Edit-Edition als SharePoint-/IIS-Variante |

> **Wichtig (Vorgabe 10/2026):** Die ASPX-Dateien beginnen **direkt mit `<!DOCTYPE html>`** — es wird **keine** `<%@ Page … %>`-Direktive vorangestellt. Alle Dateien sind **UTF-8 mit BOM** (sonst Mojibake „Ã¤/Ã¶/Ã¼") und enthalten keine `<%`-Sequenzen.

Schritt-für-Schritt-Anleitung: [docs/SharePoint-Deployment.md](docs/SharePoint-Deployment.md)

---

## Testmodell

Zum Ausprobieren eignet sich die öffentliche Musterarchitektur **MASC** aus dem Begleit-Repo:
`https://github.com/Mitchel85/EAM-AI-QEA-Analyzer` → `Demo-Output/Musterarchitektur_MASC.qea` (225 Pakete, 265 Sichten, 1.652 Elemente, 1.746 Beziehungen).

## Build aus Quellen

Die Anwendung ist eine einzige HTML-Datei; die Quellen liegen modular in `src/`:

```
src/part1_head_body.html   Struktur & Design (CSS, Reiter, Ansichten, Edit-UI)
src/part2_app_core.js      Kern: Modell-Parser-Aufsatz, Suche, Exporte (PNG/XLSX/CSV)
src/part3_app_graph.js     Diagramme, Steckbriefe, interaktiver Graph
src/part4_path.js          Verbindungs-/Pfadanalyse (BFS, Alternativpfade, Diagnose)
src/part5_edit.js          Edit-Modus: Änderungsliste, Editoren, SQLite-Schreibpfad
vendor/sql-wasm.js/.wasm   sql.js 1.13 (MIT) — eingebettete SQLite-Engine (Schreibpfad)
src/build_release.py       Assembler: baut HTML + ASPX + bettet WASM ein (+ node --check)
```

```bash
python3 src/build_release.py   # Pfade im Skript ggf. anpassen
```

Das Skript prüft alle Script-Blöcke mit `node --check`, stellt sicher, dass keine `<%`-Sequenz enthalten ist, und schreibt die ASPX mit BOM.

## Technische Eckdaten

* **Analyse-Version (v4.0):** Vanilla-JS (ES5), keine externen Bibliotheken, ~293 KB Einzeldatei, komplett offline; Graph- und Pfadberechnung auf ~2.000 Knoten in **< 15 ms**.
* **Edit-Edition (v5.0):** zusätzlich eingebettetes SQLite (sql.js 1.13, WASM, MIT) — ~1,29 MB Einzeldatei. Speichern eines 12,4-MB-Modells inkl. Integritätsprüfung in **~3 s** (getestet); WASM läuft in aktuellen Edge/Chrome/Firefox.
* Getestet mit `Musterarchitektur_MASC.qea`: 225 Pakete · 265 Sichten · 1.652 Elemente · 1.746 Beziehungen · Exporte in Excel (openpyxl-validiert) und PNG. Edit-Testsatz: 10 Änderungsarten (Umbenennen, Stereotype, Notizen, Tags, Anlegen, Löschen inkl. Kaskaden) — 33 DB-Checks grün, `integrity_check` ok.

## Changelog

### v5.0 — 16.10.2026 · Edit-Edition
* **NEU: Bearbeiten statt nur Lesen** — Elemente, Pakete, Sichten, Beziehungen und Tags ändern; Elemente & Beziehungen anlegen und entfernen (mit Kaskade).
* **Vormerk-Prinzip:** Änderungsliste mit Diff, Speichern als **neue Datei** (Original bleibt unverändert), CSV-Änderungsprotokoll, Integritäts-Selbsttest vor dem Export.
* **Schreibpfad EA-konform:** eingebettete SQLite-Engine (sql.js/WASM), AUTOINCREMENT-IDs, Paket-Spiegelung über `ea_guid`, Entity-kodierte Notizen, `t_xref`-Stereotype-Einträge, «…»-Labels, Diagramm-/Link-Kaskaden.
* Die reine Analyse-Version (v4.0) bleibt unverändert verfügbar.

### v4.0 — 15.10.2026
* **Umbenennung:** „ADMBw Architektur- & Viewpoint-Explorer" → **ADMBw QEA Analyzer** (Fokus: QEA-Dateien niederschwellig analysieren, ohne KI).
* **Oberfläche aufgeräumt:** 5 klar benannte Reiter (Erkunden · Sichten · Graph · Verbindungen · Referenz-Grid), kontextnahe Exporte statt globaler Buttonleiste, eingeklappte Hilfen.
* **NEU: Verbindungs-/Pfadanalyse** (ArAMIS-inspiriert) inkl. Architektur-Diagnose bei fehlender Verbindung.
* **Neu: Knoten-Farben gemäß ADMBw/NAFv4** (offizielle Farblegende; auch in Diagrammen und Exporten).
* ASPX ohne `<%@ Page %>`-Direktive (startet direkt mit `<!DOCTYPE html>`).

### v3.0 — 14.10.2026
* Search-First-Oberfläche, Paket- & Sichten-Explorer, natives `.xlsx`/PNG-Export je Sicht, Graph mit manueller Knotenzahl + Slider, 3 Layouts.

## Rechtliches

Der ADMBw QEA Analyzer ist ein unabhängiges Drittanbieter-Produkt. Es ist nicht mit der Sparx Systems Pty Ltd verbunden, wird von dieser nicht unterstützt und nicht gesponsert. „Sparx Systems“ und „Enterprise Architect“ sind Marken oder eingetragene Marken der Sparx Systems Pty Ltd.

*(Autor: Michael Estel)*

## Rechtliches

ADMBw QEA Analyzer ist ein unabhängiges Drittanbieter-Werkzeug. Es ist nicht mit der Sparx Systems Pty Ltd
verbunden, wird von dieser nicht unterstützt und nicht gesponsert. „Sparx Systems" und
„Enterprise Architect" sind Marken oder eingetragene Marken der Sparx Systems Pty Ltd.
Alle weiteren Marken sind Eigentum ihrer jeweiligen Inhaber.
