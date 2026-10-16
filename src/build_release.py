#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Baut ADMBw_QEA_Analyzer_Edit.html und .aspx (v5.0, Edit-Edition).

Aufbau der Einzeldatei:
  part1_head_body.html
  + v2-Skriptblock (qeaOpen + ADMBW_DATA aus backups/ADMBw_Viewpoint_Dashboard.html)
  + <script>sql.js-Glue (vendor/sql-wasm.js)</script>
  + <script>var SQLJS_WASM_B64="..."</script>   (eingebettetes SQLite-WASM, MIT-Lizenz)
  + <script>part2_app_core.js + part3_app_graph.js + part4_path.js + part5_edit.js</script>

ASPY-Regeln (Vorgabe Mitch, 10/2026):
  * Die ASPX-Datei beginnt DIREKT mit '<!DOCTYPE html>' — KEINE <%@ … %>-Direktive!
  * UTF-8 MIT BOM; Inhalt enthält keine '<%'-Sequenz.
Outputs: Arbeitsverzeichnis + dist/ + Auslieferungsordner.
"""
import base64
import os
import re
import shutil
import subprocess

DIR = "/root/hermes-workspace/admbw_viewpoint_dashboard"
VEND = "/root/hermes-workspace/admbw-qea-analyzer/vendor"
BAK_HTML = os.path.join(DIR, "backups/ADMBw_Viewpoint_Dashboard.html")
DIST = "/root/hermes-workspace/admbw-qea-analyzer/dist"
OUT_DIR = "/root/outputs/Mitch_6882251060"
NAME = "ADMBw_QEA_Analyzer_Edit"

with open(BAK_HTML, "r", encoding="utf-8") as f:
    orig_lines = f.readlines()

# Zeilen 211 bis 693 (1-basiert): <script>qeaOpen...</script> und <script>var ADMBW_DATA = ...</script>
script_qea_and_data = "".join(orig_lines[210:693])
assert "function qeaOpen(" in script_qea_and_data, "qeaOpen fehlt!"
assert "var ADMBW_DATA =" in script_qea_and_data, "ADMBW_DATA fehlt!"


def rd(p):
    with open(p, "r", encoding="utf-8") as f:
        return f.read()


part1 = rd(os.path.join(DIR, "part1_head_body.html"))
part2 = rd(os.path.join(DIR, "part2_app_core.js"))
part3 = rd(os.path.join(DIR, "part3_app_graph.js"))
part4 = rd(os.path.join(DIR, "part4_path.js"))
part5 = rd(os.path.join(DIR, "part5_edit.js"))
sqlglue = rd(os.path.join(VEND, "sql-wasm.js"))
with open(os.path.join(VEND, "sql-wasm.wasm"), "rb") as f:
    wasm_b64 = base64.b64encode(f.read()).decode("ascii")

assert "</script" not in sqlglue, "sql.js-Glue enthält '</script'!"

full_html = (
    part1.rstrip() + "\n" +
    script_qea_and_data.rstrip() + "\n" +
    "<script>\n" + sqlglue.strip() + "\n</script>\n" +
    "<script>var SQLJS_WASM_B64=\"" + wasm_b64 + "\";</script>\n" +
    "<script>\n" +
    part2.rstrip() + "\n\n" +
    part3.rstrip() + "\n\n" +
    part4.rstrip() + "\n\n" +
    part5.rstrip() + "\n" +
    "</script>\n</body>\n</html>\n"
)

# ASPX-Sicherheit: keine Server-Direktiven im Inhalt
assert "<%" not in full_html, "Fehler: '<%' im HTML-Inhalt gefunden!"

# Alle <script>-Blöcke extrahieren und mit node --check prüfen
scripts = re.findall(r"<script[^>]*>(.*?)</script>", full_html, flags=re.S)
print(f"Gefundene <script>-Blöcke: {len(scripts)}")
assert len(scripts) == 5, f"Erwartet: 5 <script>-Blöcke, gefunden: {len(scripts)}"

for idx, sc in enumerate(scripts, 1):
    tmp_js = os.path.join(DIR, f"_check_block_{idx}.js")
    with open(tmp_js, "w", encoding="utf-8") as f:
        f.write(sc)
    subprocess.check_call(["node", "--check", tmp_js])
    os.remove(tmp_js)
    print(f"  Block {idx}: node --check OK ({len(sc)} chars)")

# 1. HTML schreiben (Arbeitsverzeichnis + dist + Auslieferungsordner)
targets_html = [
    os.path.join(DIR, NAME + ".html"),
    os.path.join(DIST, NAME + ".html"),
    os.path.join(OUT_DIR, NAME + ".html"),
]
for p in targets_html:
    os.makedirs(os.path.dirname(p) or ".", exist_ok=True)
    with open(p, "w", encoding="utf-8") as f:
        f.write(full_html)

# 2. ASPX bauen: Inhalt identisch, beginnt DIREKT mit <!DOCTYPE html>, UTF-8 mit BOM
assert full_html.startswith('<!DOCTYPE html>')
assert "<%" not in full_html, "ASPY enthält Server-Direktiven!"
assert full_html.lstrip('\ufeff').startswith('<!DOCTYPE html>'), "ASPY muss mit <!DOCTYPE html> beginnen!"

targets_aspx = [
    os.path.join(DIR, NAME + ".aspx"),
    os.path.join(DIST, NAME + ".aspx"),
    os.path.join(OUT_DIR, NAME + ".aspx"),
]
for p in targets_aspx:
    os.makedirs(os.path.dirname(p) or ".", exist_ok=True)
    with open(p, "wb") as f:
        f.write(b"\xef\xbb\xbf" + full_html.encode("utf-8"))

# 3. Quellbausteine + Vendor in die Projektstruktur kopieren (für GitHub)
SRC = "/root/hermes-workspace/admbw-qea-analyzer/src"
VEND_REPO = "/root/hermes-workspace/admbw-qea-analyzer/vendor"
os.makedirs(SRC, exist_ok=True)
for fn in ["part1_head_body.html", "part2_app_core.js", "part3_app_graph.js", "part4_path.js", "part5_edit.js"]:
    shutil.copy2(os.path.join(DIR, fn), os.path.join(SRC, fn))
shutil.copy2(__file__, os.path.join(SRC, "build_release.py"))
os.makedirs(VEND_REPO, exist_ok=True)
for fn in ["sql-wasm.js", "sql-wasm.wasm", "LICENSE-sql.js"]:
    src = os.path.join(VEND, fn)
    dst = os.path.join(VEND_REPO, fn)
    if os.path.exists(src) and os.path.abspath(src) != os.path.abspath(dst):
        shutil.copy2(src, dst)

print("Build erfolgreich!")
print("  HTML:", targets_html[2], os.path.getsize(targets_html[2]), "bytes")
print("  ASPX:", targets_aspx[2], os.path.getsize(targets_aspx[2]), "bytes")
