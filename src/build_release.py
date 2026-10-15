#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Baut ADMBw_QEA_Analyzer.html und .aspx (v4.0).

ASPY-Regeln (Vorgabe Mitch, 10/2026):
  * Die ASPX-Datei beginnt DIREKT mit '<!DOCTYPE html>' — KEINE <%@ … %>-Direktive!
  * UTF-8 MIT BOM; Inhalt enthält keine '<%'-Sequenz.
Outputs: Arbeitsverzeichnis + dist/ + Auslieferungsordner.
"""
import os, re, subprocess, shutil

DIR = "/root/hermes-workspace/admbw_viewpoint_dashboard"
BAK_HTML = os.path.join(DIR, "backups/ADMBw_Viewpoint_Dashboard.html")
DIST = "/root/hermes-workspace/admbw-qea-analyzer/dist"
OUT_DIR = "/root/outputs/Mitch_6882251060"

with open(BAK_HTML, "r", encoding="utf-8") as f:
    orig_lines = f.readlines()

# Zeilen 211 bis 693 (1-basiert) sind <script>qeaOpen...</script> und <script>var ADMBW_DATA = ...</script>
script_qea_and_data = "".join(orig_lines[210:693])
assert "function qeaOpen(" in script_qea_and_data, "qeaOpen fehlt!"
assert "var ADMBW_DATA =" in script_qea_and_data, "ADMBW_DATA fehlt!"

with open(os.path.join(DIR, "part1_head_body.html"), "r", encoding="utf-8") as f:
    part1 = f.read()
with open(os.path.join(DIR, "part2_app_core.js"), "r", encoding="utf-8") as f:
    part2 = f.read()
with open(os.path.join(DIR, "part3_app_graph.js"), "r", encoding="utf-8") as f:
    part3 = f.read()
with open(os.path.join(DIR, "part4_path.js"), "r", encoding="utf-8") as f:
    part4 = f.read()

full_html = (
    part1.rstrip() + "\n" +
    script_qea_and_data.rstrip() + "\n" +
    "<script>\n" +
    part2.rstrip() + "\n\n" +
    part3.rstrip() + "\n\n" +
    part4.rstrip() + "\n" +
    "</script>\n</body>\n</html>\n"
)

# ASPX-Sicherheit: keine Server-Direktiven im Inhalt
assert "<%" not in full_html, "Fehler: '<%' im HTML-Inhalt gefunden!"

# Alle <script>-Blöcke extrahieren und mit node --check prüfen
scripts = re.findall(r"<script[^>]*>(.*?)</script>", full_html, flags=re.S)
print(f"Gefundene <script>-Blöcke: {len(scripts)}")
assert len(scripts) == 3, f"Erwartet: 3 <script>-Blöcke, gefunden: {len(scripts)}"

for idx, sc in enumerate(scripts, 1):
    tmp_js = os.path.join(DIR, f"_check_block_{idx}.js")
    with open(tmp_js, "w", encoding="utf-8") as f:
        f.write(sc)
    subprocess.check_call(["node", "--check", tmp_js])
    os.remove(tmp_js)
    print(f"  Block {idx}: node --check OK ({len(sc)} chars)")

# 1. HTML schreiben (Arbeitsverzeichnis + dist + Auslieferungsordner)
targets_html = [
    os.path.join(DIR, "ADMBw_QEA_Analyzer.html"),
    os.path.join(DIST, "ADMBw_QEA_Analyzer.html"),
    os.path.join(OUT_DIR, "ADMBw_QEA_Analyzer.html"),
]
for p in targets_html:
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, "w", encoding="utf-8") as f:
        f.write(full_html)

# 2. ASPX bauen: Inhalt identisch, beginnt DIREKT mit <!DOCTYPE html>, UTF-8 mit BOM
assert full_html.startswith('<!DOCTYPE html>')
aspx_content = full_html
assert "<%" not in aspx_content, "ASPY enthält Server-Direktiven!"
assert aspx_content.lstrip('\ufeff').startswith('<!DOCTYPE html>'), "ASPY muss mit <!DOCTYPE html> beginnen!"

targets_aspx = [
    os.path.join(DIR, "ADMBw_QEA_Analyzer.aspx"),
    os.path.join(DIST, "ADMBw_QEA_Analyzer.aspx"),
    os.path.join(OUT_DIR, "ADMBw_QEA_Analyzer.aspx"),
]
for p in targets_aspx:
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, "wb") as f:
        f.write(b"\xef\xbb\xbf" + aspx_content.encode("utf-8"))

# 3. Quellbausteine in die Projektstruktur kopieren (für GitHub)
SRC = "/root/hermes-workspace/admbw-qea-analyzer/src"
os.makedirs(SRC, exist_ok=True)
for fn in ["part1_head_body.html", "part2_app_core.js", "part3_app_graph.js", "part4_path.js", "build_v3.py"]:
    src = os.path.join(DIR, fn)
    if os.path.exists(src):
        shutil.copy2(src, os.path.join(SRC, fn))
shutil.copy2(__file__, os.path.join(SRC, "build_release.py"))

print("Build erfolgreich!")
print("  HTML:", targets_html[2], os.path.getsize(targets_html[2]), "bytes")
print("  ASPX:", targets_aspx[2], os.path.getsize(targets_aspx[2]), "bytes")
