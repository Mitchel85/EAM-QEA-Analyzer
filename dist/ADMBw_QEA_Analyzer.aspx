<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ADMBw QEA Analyzer — QEA-Architekturen niederschwellig analysieren, erkunden &amp; exportieren</title>
<style>
  :root {
    --bw-blue:#004471; --bw-dark:#0A2E4D; --bw-mid:#5A7184; --bw-light:#C6D6DE;
    --amber:#B45309; --amber-bg:#FEF3C7; --green:#1E6F5C; --green-bg:#E6F4F1;
    --ink:#1E293B; --bg:#F1F5F9; --card:#FFFFFF; --border:#CBD5E1;
  }
  * { box-sizing: border-box; }
  [hidden] { display:none !important; }
  body { margin:0; font-family:"Segoe UI", system-ui, -apple-system, Arial, sans-serif; color:var(--ink); background:var(--bg); line-height:1.45; }
  header { background:linear-gradient(135deg, var(--bw-dark) 0%, var(--bw-blue) 100%); color:#fff; padding:14px 24px; border-bottom:3px solid var(--amber); }
  .hdr-inner { max-width:1440px; margin:0 auto; display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:12px; }
  header h1 { margin:0; font-size:20px; letter-spacing:.3px; display:flex; align-items:center; gap:10px; }
  header h1 .badge-v { font-size:11px; background:var(--amber); color:#fff; padding:2px 8px; border-radius:12px; font-weight:600; vertical-align:middle; }
  header p { margin:3px 0 0; font-size:12.5px; color:#D2E3EE; }
  main { max-width:1440px; margin:0 auto; padding:16px 22px 60px; }
  footer { max-width:1440px; margin:0 auto; padding:12px 22px 30px; color:var(--bw-mid); font-size:11.5px; border-top:1px solid var(--border); }

  /* Dropzone */
  .drop { border:2px dashed var(--bw-mid); border-radius:12px; background:#fff; padding:48px 24px; text-align:center; cursor:pointer; transition:.15s; box-shadow:0 2px 8px rgba(0,0,0,.04); }
  .drop:hover, .drop.over { border-color:var(--bw-blue); background:#EAF2F8; transform:translateY(-1px); }
  .drop .big { font-size:18px; font-weight:700; color:var(--bw-blue); }
  .drop .small { font-size:13px; color:var(--bw-mid); margin-top:8px; line-height:1.6; }

  /* Cockpit / Modellbar & Globale Suche (Search-First!) */
  #modellbar { background:#fff; border:1px solid var(--border); border-radius:10px; padding:14px 16px; margin-bottom:12px; box-shadow:0 2px 10px rgba(0,68,113,.06); }
  .mb-top { display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:10px; margin-bottom:10px; }
  .mb-model { font-size:13.5px; }
  .mb-model b { color:var(--bw-blue); font-size:15px; }
  .mb-actions { display:flex; gap:8px; align-items:center; flex-wrap:wrap; }
  .btn-sm { background:#fff; border:1px solid var(--border); color:var(--bw-blue); border-radius:6px; padding:5px 11px; font-size:12px; font-weight:600; cursor:pointer; font-family:inherit; transition:.12s; }
  .btn-sm:hover { background:#EAF2F8; border-color:var(--bw-blue); }
  .btn-sm.pri { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .btn-sm.pri:hover { background:var(--bw-dark); }
  .btn-sm.amber { background:var(--amber-bg); color:var(--amber); border-color:#F59E0B; }
  .btn-sm.amber:hover { background:#FDE68A; }
  .btn-sm.green { background:var(--green-bg); color:var(--green); border-color:#34D399; }
  .btn-sm.green:hover { background:#A7F3D0; }

  /* Search-First Box */
  .mbsearch { position:relative; }
  .search-hero { display:flex; gap:8px; align-items:stretch; flex-wrap:wrap; }
  .search-input-wrap { flex:1; min-width:280px; position:relative; display:flex; align-items:center; }
  .search-input-wrap input { width:100%; padding:11px 36px 11px 14px; border:2px solid var(--bw-blue); border-radius:8px; font-size:14px; font-family:inherit; background:#F8FAFC; transition:.15s; }
  .search-input-wrap input:focus { outline:none; background:#fff; box-shadow:0 0 0 3px rgba(0,68,113,.15); }
  .search-clear { position:absolute; right:10px; background:none; border:none; font-size:16px; color:var(--bw-mid); cursor:pointer; display:none; }
  .search-scopes { display:inline-flex; background:#F1F5F9; border:1px solid var(--border); border-radius:8px; padding:3px; gap:3px; align-items:center; }
  .scope-btn { border:none; background:transparent; color:var(--ink); padding:6px 11px; border-radius:6px; font-size:12px; font-weight:600; cursor:pointer; font-family:inherit; white-space:nowrap; }
  .scope-btn.on { background:var(--bw-blue); color:#fff; }

  #gsres { display:none; position:absolute; left:0; right:0; top:calc(100% + 4px); z-index:90; background:#fff; border:1px solid var(--bw-blue); border-radius:10px; max-height:460px; overflow:auto; box-shadow:0 12px 32px rgba(0,40,80,.22); }
  .gs-hdr { background:#F1F5F9; padding:7px 12px; font-size:11.5px; font-weight:700; color:var(--bw-blue); border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; position:sticky; top:0; z-index:2; }
  .gsrow { padding:8px 12px; border-bottom:1px solid #EEF2F5; font-size:12.5px; display:flex; gap:8px; align-items:center; flex-wrap:wrap; }
  .gsrow:hover { background:#F0F7FF; }
  .gs-kind { font-size:10.5px; font-weight:700; padding:2px 7px; border-radius:6px; white-space:nowrap; }
  .gs-kind.k-diag { background:#FEF3C7; color:#92400E; border:1px solid #FCD34D; }
  .gs-kind.k-pkg { background:#DBEAFE; color:#1E40AF; border:1px solid #93C5FD; }
  .gs-kind.k-el { background:#E2E8F0; color:#1E293B; border:1px solid #CBD5E1; }
  .gs-name { cursor:pointer; flex:1; min-width:180px; }
  .gs-name b { color:var(--bw-blue); }
  .gs-name .gs-meta { color:var(--bw-mid); font-size:11.5px; margin-left:6px; }
  .gs-conn { color:#2D5A27; background:#E4EDE3; border-radius:8px; padding:1px 6px; font-size:10.5px; white-space:nowrap; }
  .gs-btn { white-space:nowrap; background:#fff; border:1px solid #C6D2DA; color:var(--bw-blue); border-radius:6px; padding:3px 8px; font-size:11px; font-weight:600; cursor:pointer; font-family:inherit; }
  .gs-btn:hover { background:#EAF1F6; border-color:var(--bw-blue); }

  /* Schnell-Einstieg / Kompass */
  .quick-bar { margin-top:10px; padding-top:9px; border-top:1px dashed var(--border); font-size:12px; display:flex; flex-direction:column; gap:6px; }
  .qb-row { display:flex; flex-wrap:wrap; align-items:center; gap:5px; }
  .qb-lbl { font-weight:700; color:var(--bw-blue); margin-right:4px; white-space:nowrap; font-size:11.5px; }

  /* Haupt-Navigation (Tabs) */
  .main-tabs { display:flex; flex-wrap:wrap; gap:8px; margin-bottom:14px; border-bottom:2px solid var(--border); padding-bottom:8px; }
  .mtab { background:#fff; border:1px solid var(--border); color:var(--ink); border-radius:8px; padding:9px 15px; font-size:13px; font-weight:700; cursor:pointer; font-family:inherit; display:inline-flex; align-items:center; gap:7px; transition:.12s; }
  .mtab:hover { border-color:var(--bw-blue); color:var(--bw-blue); background:#F8FAFC; }
  .mtab.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); box-shadow:0 2px 8px rgba(0,68,113,.2); }
  .mtab .cnt { background:rgba(0,0,0,.1); padding:1px 7px; border-radius:10px; font-size:11px; }
  .mtab.on .cnt { background:rgba(255,255,255,.22); color:#fff; }

  /* Explorer Layout (Paketbaum links + Paket-/Sicht-Inhalt rechts) */
  .exp-wrap { display:grid; grid-template-columns:340px 1fr; gap:16px; align-items:start; }
  @media (max-width:1024px){ .exp-wrap { grid-template-columns:1fr; } }
  .exp-tree-panel { background:#fff; border:1px solid var(--border); border-radius:10px; padding:12px; position:sticky; top:12px; max-height:calc(100vh - 28px); display:flex; flex-direction:column; min-width:0; }
  @media (max-width:600px){
    /* Mobile: Grid-Spalte darf nicht an nowrap-Badges/Baumzeilen anwachsen —
       der Baum scrollt intern (.tree-scroll); kein horizontaler Seiten-Scroll.
       Breite tabellen (table.data, Referenz-Grid) scrollen intern statt der Seite. */
    .exp-tree-panel { min-width:0; max-width:100%; }
    .exp-main { overflow-x:auto; }
    #gridbox, #overview { overflow-x:auto; }
    table.data td, table.data th { overflow-wrap:anywhere; }
  }
  .tree-hdr { font-weight:700; color:var(--bw-blue); font-size:13.5px; margin-bottom:8px; display:flex; justify-content:space-between; align-items:center; }
  .tree-filter { width:100%; padding:7px 10px; border:1px solid var(--border); border-radius:6px; font-size:12.5px; margin-bottom:8px; font-family:inherit; }
  .tree-scroll { overflow:auto; flex:1; padding-right:4px; }
  .tnode { user-select:none; }
  .trow { display:flex; align-items:center; gap:5px; padding:4px 6px; border-radius:6px; cursor:pointer; font-size:12.5px; color:var(--ink); }
  .trow:hover { background:#F1F5F9; }
  .trow.active { background:var(--bw-blue); color:#fff; font-weight:600; }
  .trow.active .tbadge { background:rgba(255,255,255,.2); color:#fff; }
  .ttog { width:16px; height:16px; display:inline-flex; align-items:center; justify-content:center; font-size:10px; color:var(--bw-mid); border-radius:3px; }
  .trow.active .ttog { color:#fff; }
  .tname { flex:1; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
  .tbadge { font-size:10px; padding:1px 5px; border-radius:8px; background:#E2E8F0; color:#475569; white-space:nowrap; }
  .tbadge.diag { background:#FEF3C7; color:#92400E; }
  .tchildren { margin-left:15px; border-left:1px dashed #CBD5E1; padding-left:4px; }

  .exp-main { min-width:0; background:#fff; border:1px solid var(--border); border-radius:10px; padding:16px; }

  /* Ordner- & Sichten-Karten */
  .subpkg-grid { display:grid; grid-template-columns:repeat(auto-fill, minmax(220px, 1fr)); gap:10px; margin:8px 0 16px; }
  .pkg-card { background:#F8FAFC; border:1px solid var(--border); border-left:4px solid var(--bw-blue); border-radius:8px; padding:9px 12px; cursor:pointer; transition:.12s; }
  .pkg-card:hover { background:#EAF2F8; border-color:var(--bw-blue); transform:translateY(-1px); }
  .pkg-card-title { font-weight:700; color:var(--bw-blue); font-size:13px; margin-bottom:4px; display:flex; align-items:center; gap:6px; }
  .pkg-card-meta { font-size:11.5px; color:var(--bw-mid); }

  .diag-cards { display:grid; grid-template-columns:repeat(auto-fill, minmax(300px, 1fr)); gap:12px; margin:10px 0 18px; }
  .dcard { background:#fff; border:1px solid var(--border); border-top:3px solid var(--amber); border-radius:8px; padding:12px; display:flex; flex-direction:column; justify-content:space-between; gap:8px; box-shadow:0 1px 4px rgba(0,0,0,.04); transition:.12s; }
  .dcard:hover { border-color:var(--bw-blue); box-shadow:0 4px 12px rgba(0,68,113,.12); }
  .dcard-title { font-weight:700; color:var(--bw-blue); font-size:13.5px; cursor:pointer; line-height:1.3; }
  .dcard-title:hover { text-decoration:underline; }
  .dcard-path { font-size:11px; color:var(--bw-mid); margin-top:3px; }
  .dcard-badges { display:flex; flex-wrap:wrap; gap:5px; margin-top:4px; }
  .dcard-acts { display:flex; flex-wrap:wrap; gap:5px; padding-top:8px; border-top:1px solid #F1F5F9; }

  /* Diagramm-Viewer Box */
  .diaglist { display:grid; grid-template-columns:1fr; gap:16px; margin:10px 0 18px; }
  .diagbox { background:#fff; border:1px solid var(--border); border-radius:10px; padding:12px 14px; overflow:hidden; box-shadow:0 1px 6px rgba(0,0,0,.04); }
  .diagbox-hdr { display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:8px; padding-bottom:8px; margin-bottom:10px; border-bottom:1px solid #E2E8F0; }
  .diagtitle { font-size:13.5px; color:var(--bw-blue); font-weight:700; }
  .diagsub { font-size:11.5px; color:var(--bw-mid); font-weight:400; margin-left:6px; }
  .diagtools { display:flex; flex-wrap:wrap; gap:6px; align-items:center; }
  .svgwrap { overflow:auto; text-align:center; background:#FAFCFF; border:1px solid #E2E8F0; border-radius:6px; padding:8px; max-height:680px; }
  .svgwrap svg .diag-node { cursor:pointer; transition:opacity .12s; }
  .svgwrap svg .diag-node:hover rect { stroke:#B45309 !important; stroke-width:2.4px !important; }

  /* Element-Verteilungs-Leiste */
  .dist-bar { background:#F8FAFC; border:1px solid var(--border); border-radius:8px; padding:9px 12px; margin:10px 0; font-size:12px; }
  .dist-title { font-weight:700; color:var(--bw-blue); margin-bottom:6px; font-size:12px; display:flex; justify-content:space-between; }
  .dist-chips { display:flex; flex-wrap:wrap; gap:6px; }
  .dchip { display:inline-flex; align-items:center; gap:6px; background:#fff; border:1px solid var(--border); border-radius:6px; padding:3px 8px; font-size:11.5px; cursor:pointer; }
  .dchip:hover, .dchip.active { border-color:var(--bw-blue); background:#EAF2F8; font-weight:600; }
  .dchip-bar { width:36px; height:6px; background:#E2E8F0; border-radius:3px; overflow:hidden; display:inline-block; }
  .dchip-fill { height:100%; background:var(--bw-blue); display:block; }

  /* Standard-Elemente (Grid, Tabellen, Badges) */
  h2 { color:var(--bw-blue); font-size:19px; margin:10px 0 6px; }
  h3 { color:var(--bw-blue); font-size:15px; margin:20px 0 8px; border-bottom:2px solid var(--bw-light); padding-bottom:4px; }
  #legend { font-size:11.5px; color:var(--bw-mid); margin:6px 0 10px; }
  table.grid { border-collapse:separate; border-spacing:5px; width:100%; table-layout:fixed; }
  table.grid thead th { background:var(--bw-blue); color:#fff; font-size:10.5px; padding:6px 4px; border-radius:6px; font-weight:600; line-height:1.25; }
  table.grid thead th span { display:block; font-weight:400; color:#C6D6DE; font-size:9.5px; }
  table.grid thead th.corner { background:transparent; color:var(--bw-mid); font-size:10px; text-align:left; padding-left:2px; }
  table.grid th.rowhead { background:#EAF1F6; color:var(--bw-blue); font-size:11px; text-align:left; padding:8px 8px; border-radius:6px; vertical-align:top; width:130px; }
  table.grid th.rowhead b { display:block; font-size:12px; }
  table.grid th.rowhead span { display:block; font-weight:400; color:var(--bw-mid); font-size:9.5px; margin-top:3px; line-height:1.3; }
  td.cell { background:#fff; border:1px solid #D7DEE4; border-radius:6px; padding:7px 7px 6px; cursor:pointer; vertical-align:top; min-height:74px; transition:.12s; }
  td.cell:hover { border-color:var(--bw-blue); box-shadow:0 2px 8px rgba(0,68,113,.16); transform:translateY(-1px); }
  td.cell.nodata { background:#F7F8FA; opacity:.65; }
  td.cell.nodata .vpcode { color:var(--bw-mid); }
  td.empty { background:transparent; border:none; }
  tr.bridge th.rowhead { background:#F3E9D7; color:#6b5a2e; }
  .vpcode { font-weight:700; color:var(--bw-blue); font-size:12.5px; }
  .vpname { font-size:10.5px; color:#333; line-height:1.25; margin:2px 0 4px; min-height:26px; }
  .badges { line-height:1.5; }
  .b { display:inline-block; font-size:10px; border-radius:8px; padding:1px 6px; margin:1px 2px 1px 0; white-space:nowrap; font-weight:600; }
  .b-els { background:#DCE9F2; color:#004471; }
  .b-rel { background:#E4EDE3; color:#2D5A27; }
  .b-diag { background:#FEF3C7; color:#92400E; }
  .b-none { background:#EDEFF1; color:#8B979E; }
  .crumb { font-size:12.5px; color:var(--bw-mid); margin-bottom:6px; display:flex; flex-wrap:wrap; gap:4px; align-items:center; }
  .crumb a { color:var(--bw-blue); text-decoration:none; font-weight:600; }
  .crumb a:hover { text-decoration:underline; }
  .kpis { margin:8px 0 12px; display:flex; flex-wrap:wrap; gap:8px; }
  .kpis span { display:inline-block; background:#F8FAFC; border:1px solid var(--border); border-radius:8px; padding:6px 12px; font-size:12.5px; color:var(--bw-mid); }
  .kpis b { color:var(--bw-blue); font-size:15px; margin-right:3px; }
  .purpose { background:#F8FAFC; border-left:4px solid var(--bw-blue); border-radius:4px; padding:9px 13px; font-size:12.5px; line-height:1.5; margin-bottom:8px; }
  .hint { color:var(--bw-mid); font-size:12.5px; padding:8px 0; }
  table.data { width:100%; border-collapse:collapse; background:#fff; font-size:12.5px; }
  table.data th { background:var(--bw-blue); color:#fff; text-align:left; padding:7px 9px; font-size:11.5px; }
  table.data td { border-bottom:1px solid #E6EAEE; padding:6px 9px; vertical-align:top; }
  table.data tr:hover td { background:#F0F7FF; }
  table.data code, code { background:#EAF1F6; color:#004471; border-radius:4px; padding:1px 5px; font-size:11.5px; }
  .dim { color:var(--bw-mid); font-size:11.5px; }
  .rules { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
  @media (max-width:900px){ .rules { grid-template-columns:1fr; } }
  .rulecol { background:#fff; border:1px solid #D7DEE4; border-radius:8px; padding:10px 12px; font-size:12px; }
  .rulelist { margin-top:6px; line-height:1.7; }
  .rule { border-bottom:1px dotted #E6EAEE; padding:2px 0; }
  .footnote { font-size:11.5px; color:var(--bw-mid); margin-top:22px; border-top:1px solid #D7DEE4; padding-top:10px; }

  /* Aktionsleiste & Export-Buttons */
  .vp-actions { display:flex; flex-wrap:wrap; gap:10px; align-items:center; justify-content:space-between; margin:10px 0 12px; background:#F8FAFC; border:1px solid var(--border); border-radius:8px; padding:8px 12px; }
  .vswitch, .vexport { display:inline-flex; flex-wrap:wrap; gap:6px; align-items:center; font-size:12.5px; color:var(--bw-mid); }
  .vp-actions button { background:#fff; border:1px solid #C6D2DA; color:var(--bw-blue); border-radius:6px; padding:6px 11px; font-size:12px; font-weight:600; cursor:pointer; font-family:inherit; white-space:nowrap; transition:.12s; }
  .vp-actions button:hover { border-color:var(--bw-blue); background:#EAF1F6; }
  .vp-actions button.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .vp-actions button.exp-png { background:#FEF3C7; color:#92400E; border-color:#F59E0B; }
  .vp-actions button.exp-png:hover { background:#FDE68A; }
  .vp-actions button.exp-xls { background:#E6F4F1; color:#065F46; border-color:#10B981; }
  .vp-actions button.exp-xls:hover { background:#A7F3D0; }
  #printmeta { display:none; }
  .vpfilterwrap { margin:10px 0 6px; display:flex; flex-wrap:wrap; gap:8px; align-items:center; }
  .vpfilter { flex:1; min-width:240px; max-width:560px; padding:7px 10px; border:1px solid #C6D2DA; border-radius:6px; font-size:12.5px; font-family:inherit; }
  tr.clickable { cursor:pointer; }
  .vpchip { cursor:pointer; }
  #warnbar { background:#FFF6E5; border:1px solid #E8CF9C; color:#7A5B1E; border-radius:8px; padding:9px 12px; font-size:12.5px; margin-bottom:12px; }
  .helpbox { background:#fff; border:1px solid #D7DEE4; border-radius:8px; padding:8px 14px; margin:8px 0 12px; font-size:12.5px; }
  .helpbox summary { cursor:pointer; color:var(--bw-blue); font-weight:700; }
  .helpbox ol { margin:8px 0 6px 18px; padding:0; line-height:1.65; }

  /* --- Prägnanter Architektur-Graph v3 --- */
  .gwrap { display:grid; grid-template-columns:320px 1fr; gap:14px; margin-top:10px; }
  @media (max-width:1024px){ .gwrap { grid-template-columns:1fr; } }
  .gpanel { background:#fff; border:1px solid var(--border); border-radius:10px; padding:12px; font-size:12.5px; align-self:start; box-shadow:0 1px 4px rgba(0,0,0,.04); }
  .ghead { font-weight:700; color:var(--bw-blue); font-size:14px; margin-bottom:8px; border-bottom:2px solid var(--bw-light); padding-bottom:4px; }
  .grow { margin:8px 0; }
  .gq { width:100%; padding:7px 9px; border:1px solid #C6D2DA; border-radius:6px; font-size:12.5px; font-family:inherit; }
  .gcb { color:#33424D; font-size:12px; }
  .g-num-row { display:flex; align-items:center; justify-content:space-between; gap:8px; margin-bottom:4px; }
  .g-num-inp { width:76px; padding:4px 7px; border:1px solid var(--bw-blue); border-radius:6px; font-size:13px; font-weight:700; color:var(--bw-blue); text-align:right; font-family:inherit; }
  .g-quick-pills { display:flex; flex-wrap:wrap; gap:4px; margin-top:5px; }
  .gpill { background:#F1F5F9; border:1px solid var(--border); color:var(--ink); border-radius:5px; padding:2px 7px; font-size:11px; font-weight:600; cursor:pointer; }
  .gpill:hover, .gpill.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .gsect { margin:11px 0 6px; padding-top:8px; border-top:1px solid #EEF2F5; }
  .gchips { margin-top:5px; max-height:175px; overflow:auto; }
  .gchip { display:inline-flex; align-items:center; gap:5px; background:#EAF1F6; color:var(--bw-blue); border:1px solid #C6D2DA; border-radius:11px; padding:2px 8px; margin:2px 3px 2px 0; cursor:pointer; font-size:11px; }
  .gchip i { width:9px; height:9px; border-radius:50%; display:inline-block; }
  .gchip em { font-style:normal; color:var(--bw-mid); }
  .gchip.off { opacity:.35; text-decoration:line-through; }
  .gchip.rel { background:#E4EDE3; color:#2D5A27; border-color:#BFD4BC; }
  .gbtns button, .gpanel button { background:#fff; border:1px solid #C6D2DA; color:var(--bw-blue); border-radius:6px; padding:4px 9px; font-size:11.5px; font-weight:600; cursor:pointer; margin-right:4px; margin-top:3px; font-family:inherit; }
  .gbtns button:hover, .gpanel button:hover { background:#EAF1F6; border-color:var(--bw-blue); }
  .gbtns button.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .gmain { min-width:0; display:flex; flex-direction:column; gap:8px; }
  .gtoolbar { background:#fff; border:1px solid var(--border); border-radius:8px; padding:7px 12px; display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:8px; font-size:12px; }
  .glegend { display:flex; flex-wrap:wrap; gap:10px; align-items:center; font-size:11px; color:var(--bw-mid); background:#fff; border:1px solid var(--border); border-radius:8px; padding:5px 12px; }
  .gleg-item { display:inline-flex; align-items:center; gap:5px; font-weight:600; color:var(--ink); }
  .gleg-dot { width:11px; height:11px; border-radius:3px; display:inline-block; }
  .gcanvas { background:radial-gradient(circle at center, #FFFFFF 0%, #F4F7FA 100%); border:1px solid var(--border); border-radius:10px; height:660px; overflow:hidden; position:relative; box-shadow:inset 0 1px 4px rgba(0,0,0,.04); }
  .gcanvas svg { display:block; width:100%; height:100%; cursor:grab; }
  .gcanvas svg:active { cursor:grabbing; }
  .gk { stroke:#94A3B8; stroke-width:1.35; opacity:.78; }
  .gk.hi { stroke:#B45309; stroke-width:2.4; opacity:1; }
  .gk-lbl { font-size:8.5px; fill:#475569; paint-order:stroke; stroke:#FFFFFF; stroke-width:3px; pointer-events:none; }
  .gn { cursor:pointer; }
  .gn text.nlbl { font-size:11px; font-weight:600; fill:#0F172A; paint-order:stroke; stroke:#FFFFFF; stroke-width:3.2px; }
  .gn text.nst { font-size:8.5px; fill:#475569; paint-order:stroke; stroke:#FFFFFF; stroke-width:2.5px; }
  /* Knoten: Rand = ADMBw-Schichtfarbe, Füllung = heller Elementton */
  .gn .nshape { stroke-width:2; filter:drop-shadow(0 2px 3px rgba(0,0,0,.15)); }
  .gn.fdim { opacity:.14; }
  .gn.fsel .nshape { stroke:#B45309; stroke-width:3; }
  .ginfo { background:#fff; border:1px solid var(--border); border-radius:8px; padding:12px 14px; font-size:12.5px; }
  .gi-head { font-size:14.5px; color:var(--bw-blue); display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:8px; }
  .gi-dot { display:inline-block; width:11px; height:11px; border-radius:3px; margin-right:6px; }
  .gi-meta { color:var(--bw-mid); margin:4px 0; }
  .gi-nbs { max-height:210px; overflow:auto; margin-top:6px; border-top:1px dotted #E6EAEE; }
  .gi-nb { padding:4px 4px; border-bottom:1px dotted #F0F3F5; cursor:pointer; display:flex; align-items:center; gap:6px; }
  .gi-nb:hover { background:#F0F7FF; }

  /* --- Verbindungs-/Pfadanalyse (experimentell, ArAMIS-inspiriert) --- */
  .pathgrid { display:grid; grid-template-columns:360px 1fr; gap:14px; align-items:start; }
  @media (max-width:1024px){ .pathgrid { grid-template-columns:1fr; } }
  .pathpanel { background:#fff; border:1px solid var(--border); border-radius:10px; padding:14px 16px; }
  .pfield { position:relative; margin-bottom:6px; }
  .pfield label { font-weight:700; color:var(--bw-blue); font-size:12.5px; display:block; margin-bottom:4px; }
  .pfield input { width:100%; padding:9px 11px; border:2px solid var(--bw-blue); border-radius:8px; font-size:13px; font-family:inherit; background:#F8FAFC; }
  .pfield input:focus { outline:none; background:#fff; box-shadow:0 0 0 3px rgba(0,68,113,.15); }
  .ptypeahead { position:absolute; left:0; right:0; top:calc(100% - 14px); z-index:130; background:#fff; border:1px solid var(--bw-blue); border-radius:8px; max-height:300px; overflow:auto; box-shadow:0 12px 30px rgba(0,40,80,.22); }
  .ptrow { padding:7px 11px; border-bottom:1px solid #EEF2F5; cursor:pointer; font-size:12px; display:flex; gap:8px; align-items:center; }
  .ptrow:hover { background:#F0F7FF; }
  .ptrow .ptdot { width:9px; height:9px; border-radius:50%; flex:0 0 auto; }
  .ptrow .ptmeta { color:var(--bw-mid); font-size:10.5px; margin-left:auto; white-space:nowrap; }
  .pchipsel { display:inline-flex; align-items:center; gap:6px; background:#EAF1F6; border:1px solid #C6D2DA; border-radius:14px; padding:3px 10px; font-size:11.5px; margin-top:6px; max-width:100%; }
  .pchipsel b { overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
  .pchipsel a { color:#B45309; text-decoration:none; font-weight:700; }
  .pcontrols { margin:10px 0 4px; display:flex; flex-direction:column; gap:9px; }
  .pc-row { font-size:12px; color:var(--ink); }
  .pc-row button { background:#fff; border:1px solid #C6D2DA; color:var(--bw-blue); border-radius:6px; padding:5px 10px; font-size:11.5px; font-weight:600; cursor:pointer; font-family:inherit; margin-top:4px; margin-right:3px; }
  .pc-row button:hover { background:#EAF1F6; border-color:var(--bw-blue); }
  .pc-row button.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .pfind { width:100%; background:var(--bw-blue); color:#fff; border:none; border-radius:8px; padding:10px 14px; font-size:13.5px; font-weight:700; cursor:pointer; font-family:inherit; margin-top:8px; }
  .pfind:hover { background:var(--bw-dark); }
  .pnote { background:#F8FAFC; border:1px dashed var(--border); border-radius:8px; padding:14px; color:var(--bw-mid); font-size:12.5px; }
  .pbanner { border-radius:8px; padding:10px 14px; font-size:13px; margin-bottom:12px; }
  .pbanner.ok { background:#E6F4F1; border:1px solid #34D399; color:#065F46; }
  .pbanner.warn { background:#FEF3C7; border:1px solid #F59E0B; color:#92400E; }
  .pbanner.info { background:#EAF1F6; border:1px solid #93C5FD; color:#1E40AF; }
  .pathgrid2 { display:grid; grid-template-columns:1fr 1fr; gap:14px; align-items:start; margin-bottom:12px; }
  @media (max-width:1200px){ .pathgrid2 { grid-template-columns:1fr; } }
  .pcard { background:#fff; border:1px solid var(--border); border-radius:10px; padding:13px 15px; min-width:0; }
  .pchain { display:flex; flex-direction:column; }
  .pnode { display:flex; align-items:center; gap:8px; background:#fff; border:1.5px solid var(--bw-blue); border-radius:9px; padding:8px 12px; font-size:12.5px; cursor:pointer; transition:.12s; }
  .pnode:hover { background:#EAF2F8; box-shadow:0 2px 8px rgba(0,68,113,.14); }
  .pnode .ptdot { width:10px; height:10px; border-radius:50%; flex:0 0 auto; }
  .plink { margin:3px 0 3px 22px; padding:3px 10px; border-left:3px solid var(--amber); color:#92400E; font-size:11.5px; }
  .ppaths { display:flex; flex-wrap:wrap; gap:6px; margin:0 0 12px; }
  .ppathbtn { background:#fff; border:1px solid #C6D2DA; color:var(--bw-blue); border-radius:6px; padding:5px 11px; font-size:11.5px; font-weight:600; cursor:pointer; font-family:inherit; }
  .ppathbtn.on { background:var(--bw-blue); color:#fff; border-color:var(--bw-blue); }
  .ppathbtn:hover { border-color:var(--bw-blue); }
  .pathgraphbox { background:#FAFCFF; border:1px solid #E2E8F0; border-radius:8px; padding:8px; overflow:auto; max-height:430px; }
  .diag-row { font-size:12.5px; margin:7px 0; line-height:1.55; }

  /* Druck / PDF */
  @media print {
    body { background:#fff; }
    header { padding:6px 0 8px; background:#fff; color:#004471; border-bottom:3px solid #004471; }
    header h1 { font-size:16pt; color:#004471; }
    header p { color:#647B8A; font-size:8.5pt; }
    main { max-width:none; padding:0 4mm; }
    footer { padding:6px 0; font-size:8pt; }
    .vp-actions, .vexport, .vswitch, #legend, #upload, .drop, #modellbar, .main-tabs, .exp-tree-panel, .vpfilterwrap, #warnbar, .helpbox, .gtoolbar, .diagtools, .pathpanel { display:none !important; }
    .pathgrid { grid-template-columns:1fr !important; }
    .pathgrid2 { grid-template-columns:1fr !important; }
    .pathgraphbox { overflow:visible !important; max-height:none !important; }
    .exp-wrap { grid-template-columns:1fr !important; }
    #printmeta { display:block !important; border-bottom:2px solid #004471; padding:4px 0 8px; margin-bottom:10px; }
    .pm-title { font-size:14pt; font-weight:700; color:#004471; }
    .pm-sub { font-size:9pt; color:#647B8A; }
    .diagbox { page-break-inside:avoid; border:1px solid #B9C4CE; }
    .svgwrap { overflow:visible !important; max-height:none !important; }
    .svgwrap svg { max-width:100% !important; height:auto !important; }
    table.data { font-size:9pt; }
    table.data th { font-size:8.5pt; }
    .gcanvas { height:150mm !important; }
    .gwrap { grid-template-columns:1fr !important; }
    .gpanel { display:none !important; }
    * { -webkit-print-color-adjust:exact; print-color-adjust:exact; }
  }

    /* ---------- Designumschaltung: Standard = hell, Dunkel nur per Button ---------- */
  .theme-btn {
    font:inherit; font-size:13px; font-weight:600; cursor:pointer; white-space:nowrap;
    display:inline-flex; align-items:center; gap:7px;
    padding:8px 14px; border-radius:8px;
    background:rgba(255,255,255,.14); color:#fff; border:1px solid rgba(255,255,255,.45);
  }
  .theme-btn:hover { background:rgba(255,255,255,.26); }
  .theme-btn:focus-visible { outline:2px solid #fff; outline-offset:2px; }
  :root[data-theme="dark"] { --bw-blue:#5AA7DE; --bw-dark:#0A1E33; --bw-mid:#8CA3B5; --bw-light:#2E485E; --amber:#E8A23D; --amber-bg:#3B2F1B; --green:#57C2A2; --green-bg:#14332B; --ink:#DCE4EC; --bg:#0D1622; --card:#16222F; --border:#33465A; }
    .drop, .upbtn.one, .semwrap, .semwrap-details, .helpbox, #modellbar, .btn-sm, .gs-btn, .mtab, .exp-tree-panel, .exp-main, .dcard, .diagbox, .dchip, td.cell, table.data, .rulecol, .vp-actions button, .gpanel, .gbtns button, .gpanel button, .emodal, .modalbox { background:var(--card); color:var(--ink); }
    .drop:hover, .drop.over, .upbtn.one:hover, .btn-sm:hover, .gs-btn:hover, .mtab:hover, .pkg-card:hover, .dcard:hover, .vp-actions button:hover, .gbtns button:hover, .gpanel button:hover { background:#1E3044; }
    .search-input-wrap input { background:#14202E; color:var(--ink); }
    .search-input-wrap input:focus { background:#16222F; }
    .tree-filter, .vpfilter, .emodal input, .emodal textarea, .emodal select { background:#14202E; color:var(--ink); }
    .mmode { background:var(--card); color:var(--bw-mid); }
    .vedit button { background:#3A2A16; border-color:#7A5A2A; color:#F0C078; }
    .vedit button:hover { background:#4A3a1e; }
    .vedit button.delbtn { background:#3A1B1B; border-color:#7A3A3A; color:#F2A0A0; }
    .search-scopes, .gs-hdr, .semnote, .trow:hover, .gpill, .kpis span, .purpose, .vp-actions, .pkg-card, .dist-bar, .svgwrap, td.cell.nodata { background:#1A2736; color:var(--ink); }
    .semnote.warn, #warnbar { background:#3A2B15; border-color:#6B4E1E; color:#F2D08A; }
    .modelband { background:#182536; }
    .vp-actions button.exp-png { background:#3A2E14; color:#F2C66D; border-color:#8A6A25; }
    .vp-actions button.exp-xls { background:#14302A; color:#6FD6B0; border-color:#2E7A5F; }
    .mtab:hover { background:#1E3044; }
    .gsrow:hover, table.data tr:hover td { background:#1B2C3F; }
    table.grid th.rowhead { background:#22364B; }
    tr.bridge th.rowhead { background:#3A3219; color:#D9C072; }
    tr.xmodel { background:#33290F; }
    tr.xmodel:hover { background:#3E3318; }
    code, table.data code { background:#22364B; color:#9CC8EF; }
    .tbadge { background:#2A3A4D; color:#A8B9C8; }
    .tbadge.diag, .gs-kind.k-diag, .b-diag { background:#3A2E14; color:#F2C66D; }
    .gs-kind.k-pkg { background:#1C3452; color:#8FB8E8; }
    .gs-kind.k-el { background:#2A3A4D; color:#C3D0DC; }
    .gchip { background:#22364B; color:#9CC8EF; border-color:#3D5A78; }
    .mchip-m1 { background:#22364B; }
    .mchip-m2 { background:#3A2E14; color:#F2C66D; border-color:#6B4E1E; }
    .mchip-m3 { background:#14332B; color:#6FD6B0; border-color:#2E7A5F; }
    .up-hint, .mb-note, footer { color:var(--bw-mid); }
    .semopt b, .semopt em, .exp-tag { color:var(--ink); }
    .semopt:hover, .msvrow:hover { background:#1E3044; }
    header { background:linear-gradient(135deg, #0A1E33 0%, #123A5C 100%); }
  }
</style>
</head>
<body>
<header>
  <div class="hdr-inner">
    <div>
      <h1>🔍 ADMBw QEA Analyzer <span class="badge-v">v4.0</span></h1>
      <p>QEA-Architekturen verstehen: Pakete &amp; Sichten erkunden, im Graphen analysieren, Verbindungen zweier Elemente nachweisen und als PNG / Excel exportieren — 100&nbsp;% lokal im Browser, ohne KI.</p>
    </div>
  
    
    <button type="button" class="theme-btn" id="themeBtn" onclick="toggleTheme()" aria-pressed="false" title="Zur dunklen Ansicht wechseln">🌙 Dunkles Design</button>
  </div>
  </header>
<main>
  <div id="printmeta"></div>
  <div id="upload">
    <div class="drop" id="dropzone">
      <div class="big">📂 QEA- / EAPX-Architekturdatenmodell hier ablegen oder klicken</div>
      <div class="small">
        <b>Der Analyse-Werkzeugkasten für Architekturen:</b> Pakete &amp; Sichten erkunden, Gesamtzusammenhang im Graph analysieren, Verbindungen zweier Elemente nachweisen — <b>ohne KI, ohne Installation, ohne Namenskonventionen</b>.<br>
        Mit Sofort-Suche und <b>1-Klick-Export jeder Sicht als PNG oder Excel (.xlsx)</b>.<br>
        <span style="color:#004471;font-weight:600">Datenschutz: 100 % Offline-Verarbeitung im Browser — keine Daten verlassen Ihren Rechner.</span>
      </div>
      <input type="file" id="file" accept=".qea,.eapx,.qeax,.sqlite" style="display:none">
    </div>
  </div>

  <div id="workspace" style="display:none">
    <!-- Zentrale Such- & Modell-Kommandozentrale (Search-First!) -->
    <div id="modellbar">
      <div class="mb-top">
        <div class="mb-model">Modell: <b id="modellname">—</b> &nbsp;·&nbsp; <span id="stats"></span></div>
        <div class="mb-actions">
          <button class="btn-sm" onclick="el('file').click()" title="Andere QEA-/EAPX-Datei öffnen">📂 Andere Datei laden</button>
        </div>
      </div>

      <div class="mbsearch">
        <div class="search-hero">
          <div class="search-input-wrap">
            <input id="globalsearch" placeholder="🔍 Architektur durchsuchen: Sichten/Diagramme, Pakete, Elemente, Alias, Stereotyp oder Beschreibung … (Enter = Vollansicht aller Treffer)" oninput="globalSearch()" onkeydown="globalSearchKey(event)">
            <button id="gsclear" class="search-clear" onclick="clearGlobalSearch()" title="Suche zurücksetzen">✕</button>
          </div>
          <div class="search-scopes" id="searchscopes">
            <button class="scope-btn on" data-scope="all" onclick="setSearchScope('all')">Alle</button>
            <button class="scope-btn" data-scope="diag" onclick="setSearchScope('diag')">🖼️ Sichten</button>
            <button class="scope-btn" data-scope="pkg" onclick="setSearchScope('pkg')">📁 Pakete</button>
            <button class="scope-btn" data-scope="el" onclick="setSearchScope('el')">📦 Elemente</button>
          </div>
          <button class="btn-sm pri" onclick="openSearchResultsView()" title="Alle Suchtreffer als eigene auswertbare &amp; exportierbare Sicht öffnen">🔎 Treffer-Ansicht</button>
        </div>
        <div id="gsres"></div>
      </div>

      <div class="quick-bar" id="quickbar"></div>
    </div>

    <div id="warnbar" style="display:none"></div>

    <!-- Haupt-Navigationsreiter -->
    <div class="main-tabs" id="maintabs">
      <button class="mtab on" id="tab-explorer" onclick="showView('explorer')">🧭 Erkunden <span class="cnt" id="cnt-pkg">0</span></button>
      <button class="mtab" id="tab-diags" onclick="showView('diags')">🖼️ Sichten <span class="cnt" id="cnt-diag">0</span></button>
      <button class="mtab" id="tab-graphhub" onclick="openGlobalGraph()">🕸️ Graph</button>
      <button class="mtab" id="tab-path" onclick="showView('path')">🔗 Verbindungen <span class="cnt" id="cnt-path">0</span></button>
      <button class="mtab" id="tab-grid" onclick="showView('grid')">📐 Referenz-Grid <span class="cnt" id="cnt-grid">52</span></button>
    </div>

    <details class="helpbox">
      <summary>ℹ️ Kurzanleitung — So erkunden, analysieren und exportieren Sie jede Architektur</summary>
      <ol>
        <li><b>Direkt suchen (oben):</b> Begriff eingeben (z. B. Prozess, System, Projekt) → sofort Treffer in <b>🖼️ Sichten</b>, <b>📁 Paketen</b> und <b>📦 Elementen</b>.</li>
        <li><b>Durch Pakete &amp; Sichten klicken:</b> Im Reiter <b>„🧭 Erkunden“</b> links durch den echten Ordnerbaum navigieren — rechts erscheinen Unterordner, alle vorhandenen Sichten (Diagramme) und Elemente, auch ohne ADMBw-Namensschema.</li>
        <li><b>Analysieren:</b> Jede Sicht im Reiter <b>„🕸️ Graph“</b> als Netzwerk erkunden (Knotenzahl per Schieberegler oder Zahleneingabe). Im Reiter <b>„🔗 Verbindungen“</b> nachweisen, wie zwei Elemente zusammenhängen (Pfadanalyse mit Diagnose).</li>
        <li><b>Exportieren:</b> Jede Sicht, jedes Paket und jeden Pfad mit einem Klick als <b>📸 PNG</b> oder <b>📊 Excel (.xlsx)</b> sichern — die Buttons stehen direkt an der jeweiligen Ansicht.</li>
      </ol>
    </details>

    <!-- ANSICHT 1: PAKET- & STRUKTUR-EXPLORER (Standard) -->
    <div id="view-explorer" style="display:none">
      <div class="exp-wrap">
        <div class="exp-tree-panel">
          <div class="tree-hdr">
            <span>📁 Paketstruktur</span>
            <span>
              <button class="btn-sm" style="padding:2px 6px;font-size:11px" onclick="expandAllPkgs(true)" title="Alle Pakete ausklappen">＋ Alle</button>
              <button class="btn-sm" style="padding:2px 6px;font-size:11px" onclick="expandAllPkgs(false)" title="Alle Pakete einklappen">－</button>
            </span>
          </div>
          <input id="treefilter" class="tree-filter" placeholder="🔍 Paketname im Baum filtern …" oninput="renderPkgTree()">
          <div class="tree-scroll" id="pkgtree"></div>
        </div>
        <div class="exp-main" id="pkgmain"></div>
      </div>
    </div>

    <!-- ANSICHT 2: ALLE VORHANDENEN SICHTEN / DIAGRAMME -->
    <div id="view-diags" style="display:none">
      <div id="diagsbox"></div>
    </div>

    <!-- ANSICHT 2b: VERBINDUNGS-/PFADANALYSE (experimentell, ArAMIS-inspiriert) -->
    <div id="view-path" style="display:none">
      <div id="pathbox"></div>
    </div>

    <!-- ANSICHT 3: ADMBw-REFERENZ-GRID -->
    <div id="grid" style="display:none">
      <div style="display:flex;flex-wrap:wrap;justify-content:space-between;align-items:center;gap:10px">
        <h2>ADMBw-Referenz-Grid — 52 Standard-Viewpoints</h2>
        <label style="font-size:12.5px;color:var(--bw-blue);font-weight:600;cursor:pointer">
          <input type="checkbox" id="gridonlyfilled" onchange="renderGrid()"> Nur befüllte Sichten aktiv hervorheben
        </label>
      </div>
      <div id="overview" style="display:none"></div>
      <div id="legend"></div>
      <div id="gridbox"></div>
      <div class="footnote">Hinweis: Das ADMBw-Referenz-Grid ordnet Elemente nach NAFv4/ADMBw-Stereotypen zu. Frei benannte Diagramme und projektspezifische Ordnerstrukturen finden Sie vollständig unter <b>„🧭 Erkunden“</b> sowie <b>„🖼️ Sichten“</b>.</div>
    </div>

    <!-- ANSICHT 4: DETAIL-ANSICHT (Einzel-Sicht / Diagramm, Viewpoint, Element-Steckbrief, Suchtreffer, Graph) -->
    <div id="vp" style="display:none">
      <div id="vpbox"></div>
    </div>

    <!-- Offscreen-Hilfscontainer für direkten PNG-Export jeder Sicht aus Übersichten -->
    <div id="offscreen-render" style="position:fixed;left:-99999px;top:-99999px;width:1600px;height:1200px;overflow:hidden;pointer-events:none"></div>
  </div>
</main>
<footer>
  ADMBw QEA Analyzer v4.0 · 100 % Offline-Auswertung im Browser (keine Datenübertragung) · Farben gemäß ADMBw/NAFv4.
</footer>
<script>
/* QEA-Reader: nativer SQLite-Parser fuer Sparx-Enterprise-Architect .qea-Dateien.
   Vanilla-JS, kein WASM/CDN. Liest Tabellen-B-Trees inkl. Overflow-Seiten.
   Danach Abbildung ERB -> gemeinsames Datenmodell (Projekte, Meilensteine, Orgs, Kanten). */
'use strict';

/* ================= SQLite-Parser ================= */
function qeaOpen(buffer) {
  const u8 = new Uint8Array(buffer);
  const dv = new DataView(buffer);
  let magic = '';
  for (let i = 0; i < 16; i++) magic += String.fromCharCode(u8[i]);
  if (magic.indexOf('SQLite format 3') !== 0) throw new Error('Kein SQLite-Format erkannt. Unterstützt werden .qea/.qeax/.eapx im SQLite-Format (Sparx EA 13+). Ältere .eap-Dateien (MS Access/Jet) oder anders formatierte Dateien bitte in Enterprise Architect als SQLite-Projekt exportieren.');
  const psRaw = dv.getUint16(16, false);
  const pageSize = psRaw === 1 ? 65536 : psRaw;
  const reserved = u8[20];
  const usable = pageSize - reserved;
  const enc = dv.getUint32(56, false); // 1=utf8 2=utf16le 3=utf16be

  function varint(off) {
    let v = 0, i = 0, b;
    for (; i < 8; i++) {
      b = u8[off + i];
      v = v * 128 + (b & 0x7f);
      if (!(b & 0x80)) return [v, off + i + 1];
    }
    b = u8[off + 8];
    return [v * 256 + b, off + 9];
  }

  function decodeText(bytes) {
    if (enc === 2) return new TextDecoder('utf-16le').decode(bytes);
    if (enc === 3) return new TextDecoder('utf-16be').decode(bytes);
    return new TextDecoder('utf-8').decode(bytes);
  }

  function readPayload(cellOff) {
    const [pLen, o1] = varint(cellOff);
    const [rowid, o2] = varint(o1);
    let local = pLen;
    let overflowPage = 0;
    if (pLen > maxLocal) {
      const minLocal = Math.floor((usable - 12) * 32 / 255) - 23;
      local = minLocal + ((pLen - minLocal) % (usable - 4));
      if (local > maxLocal) local = minLocal;
      overflowPage = dv.getUint32(o2 + local, false);
    }
    const out = new Uint8Array(pLen);
    out.set(u8.subarray(o2, o2 + local), 0);
    let filled = local;
    let pg = overflowPage;
    while (pg !== 0 && filled < pLen) {
      const base = (pg - 1) * pageSize;
      const next = dv.getUint32(base, false);
      const take = Math.min(usable - 4, pLen - filled);
      out.set(u8.subarray(base + 4, base + 4 + take), filled);
      filled += take;
      pg = next;
    }
    return [out, rowid];
  }

  function decodeRecord(bytes) {
    const dvb = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);
    const [hdrSize, p0] = varintBuf(bytes, 0);
    const serials = [];
    let q = p0;
    while (q < hdrSize) {
      const [s, nq] = varintBuf(bytes, q);
      serials.push(s);
      q = nq;
    }
    const vals = [];
    let r = q;
    for (let i = 0; i < serials.length; i++) {
      const s = serials[i];
      if (s === 0) { vals.push(null); }
      else if (s >= 1 && s <= 6) {
        const sizes = [0, 1, 2, 3, 4, 6, 8];
        const n = sizes[s];
        let v = 0;
        for (let k = 0; k < n; k++) v = v * 256 + bytes[r + k];
        if (bytes[r] & 0x80) v -= Math.pow(2, n * 8); // signed BE
        vals.push(v);
        r += n;
      }
      else if (s === 7) { vals.push(dvb.getFloat64(r, false)); r += 8; }
      else if (s === 8) { vals.push(0); }
      else if (s === 9) { vals.push(1); }
      else if (s >= 12) {
        const even = (s % 2) === 0;
        const n = even ? (s - 12) / 2 : (s - 13) / 2;
        const raw = bytes.subarray(r, r + n);
        vals.push(even ? raw : decodeText(raw));
        r += n;
      }
    }
    return vals;
  }

  function varintBuf(bytes, off) {
    let v = 0, i = 0, b;
    for (; i < 8; i++) {
      b = bytes[off + i];
      v = v * 128 + (b & 0x7f);
      if (!(b & 0x80)) return [v, off + i + 1];
    }
    b = bytes[off + 8];
    return [v * 256 + b, off + 9];
  }

  const maxLocal = usable - 35;

  function walkTable(rootPage, sink) {
    const stack = [rootPage];
    while (stack.length) {
      const pg = stack.pop();
      const base = (pg - 1) * pageSize;
      const hdr = pg === 1 ? base + 100 : base;
      const type = u8[hdr];
      const cellCount = dv.getUint16(hdr + 3, false);
      const ptrStart = (type === 2 || type === 5) ? hdr + 12 : hdr + 8;
      if (type === 5 || type === 2) {
        const rightmost = dv.getUint32(hdr + 8, false);
        for (let i = 0; i < cellCount; i++) {
          const cell = dv.getUint16(ptrStart + i * 2, false);
          stack.push(dv.getUint32(base + cell, false));
        }
        if (rightmost) stack.push(rightmost);
      } else if (type === 13 || type === 10) {
        for (let i = 0; i < cellCount; i++) {
          const cell = dv.getUint16(ptrStart + i * 2, false);
          const [payload, rowid] = readPayload(base + cell);
          sink(decodeRecord(payload), rowid);
        }
      } else {
        throw new Error('Unbekannter B-Tree-Seitentyp ' + type + ' (Seite ' + pg + ')');
      }
    }
  }

  /* sqlite_master */
  const master = [];
  walkTable(1, function (rec) { master.push(rec); });

  const tables = {};
  master.forEach(function (rec) {
    const [type, name, tbl, root, sql] = rec;
    if (type !== 'table') return;
    const pc = parseCols(sql);
    tables[name] = { root: root, sql: sql, cols: pc.cols, pk: pc.pk };
  });

  function parseCols(sql) {
    const cols = [];
    let pk = -1;
    if (!sql) return { cols: cols, pk: pk };
    sql = String(sql).replace(/--[\s\S]*?(?:\r|$)/g, ''); // EA-DDL: Zeilenkommentare hinter jedem Feld
    const start = sql.indexOf('(');
    if (start < 0) return { cols: cols, pk: pk };
    let depth = 0, cur = '', inQ = false;
    for (let i = start + 1; i < sql.length; i++) {
      const ch = sql[i];
      if (ch === '"') { inQ = !inQ; cur += ch; continue; }
      if (inQ) { cur += ch; continue; }
      if (ch === '(') { depth++; cur += ch; continue; }
      if (ch === ')') {
        if (depth === 0) { if (cur.trim()) { if (/PRIMARY\s+KEY/i.test(cur) && pk < 0) pk = cols.length; cols.push(colName(cur)); } break; }
        depth--; cur += ch; continue;
      }
      if (ch === ',' && depth === 0) {
        if (/PRIMARY\s+KEY/i.test(cur) && pk < 0) pk = cols.length;
        cols.push(colName(cur)); cur = ''; continue;
      }
      cur += ch;
    }
    return { cols: cols, pk: pk };
  }
  function colName(part) {
    let t = part.trim();
    const m = t.match(/^["'\[]?([^"'\[\] (]+)["'\]]?/);
    return m ? m[1] : t;
  }

  return {
    pageSize: pageSize,
    tables: tables,
    tableNames: Object.keys(tables),
    hasTable: function (name) {
      if (tables[name]) return true;
      const ln = String(name).toLowerCase();
      for (const k in tables) { if (k.toLowerCase() === ln) return true; }
      return false;
    },
    rows: function (name) {
      let t = tables[name];
      if (!t) {
        const ln = String(name).toLowerCase();
        for (const k in tables) { if (k.toLowerCase() === ln) { t = tables[k]; break; } }
      }
      if (!t) return [];
      const out = [];
      walkTable(t.root, function (rec, rowid) {
        if (t.pk >= 0 && (rec[t.pk] === null || rec[t.pk] === undefined)) rec[t.pk] = rowid; // INTEGER PRIMARY KEY = rowid-Alias
        const o = {};
        for (let i = 0; i < t.cols.length; i++) o[t.cols[i]] = i < rec.length ? rec[i] : null;
        out.push(o);
      });
      return out;
    }
  };
}

/* ================= ERB -> Datenmodell ================= */
const QEA_FAMILY = {
  'SameAs': 'alias', 'IsResponsibleFor': 'resp', 'IsAccountableFor': 'acct',
  'NeedsResource': 'needs', 'Satisfy': 'satisfy', 'OwnedMilestone': 'owns',
  'MilestoneDependency': 'milestone'
};
const QEA_ORGKIND = /(Organization|Post)$/;

function qeaToModel(db) {
  const objRows = db.rows('t_object');
  const conRows = db.rows('t_connector');
  const tagRows = db.rows('t_objectproperties');
  const pkgRows = db.rows('t_package');

  const objects = {};
  objRows.forEach(function (r) {
    objects[r.Object_ID] = {
      id: r.Object_ID, name: String(r.Name || '').trim(), alias: String(r.Alias || ''),
      objectType: String(r.Object_Type || ''), stereotype: String(r.Stereotype || ''),
      status: String(r.Status || ''), note: String(r.Note || ''),
      packageId: r.Package_ID, parentId: r.ParentID || 0,
      author: String(r.Author || ''), version: String(r.Version || ''),
      created: String(r.CreatedDate || ''), modified: String(r.ModifiedDate || '')
    };
  });
  const tags = {};
  tagRows.forEach(function (r) {
    if (!tags[r.Object_ID]) tags[r.Object_ID] = {};
    tags[r.Object_ID][String(r.Property || '')] = String(r.Value == null ? '' : r.Value);
  });
  const pkgName = {};
  pkgRows.forEach(function (r) { pkgName[r.Package_ID] = String(r.Name || ''); });
  const pkgParent = {};
  pkgRows.forEach(function (r) { pkgParent[r.Package_ID] = r.Parent_ID || 0; });

  /* Paketfilter: Standardelemente-/Werkzeugkoffer-Pakete (Toolbox-Repertoire)
     sind KEINE Projektinhalte und werden aus Projekten/Kanten ausgeschlossen.
     Stark: "Standardelemente", "Standard Elements", "MDG Toolbox", "Werkzeugkoffer".
     Paar-Regel: (standard|repertoire|vorlage|template) + (element|katalog|modell). */
  const CATALOG_STRONG = /(standardelement|standard.?elem|werkzeug.?koffer|toolbox|stencil|mdg.?tech)/i;
  const CATALOG_A = /(standard|repertoire|vorlage|template)/i;
  const CATALOG_B = /(element|katalog|catalog|modell|sammlung)/i;
  function isCatalogName(nm) {
    return CATALOG_STRONG.test(nm) || (CATALOG_A.test(nm) && CATALOG_B.test(nm));
  }
  function pkgInCatalog(pid) {
    let cur = pid, guard = 0;
    while (cur && guard++ < 60) {
      if (isCatalogName(pkgName[cur] || '')) return true;
      cur = pkgParent[cur];
    }
    return false;
  }
  function objExcluded(o) {
    return !o || !o.packageId || pkgInCatalog(o.packageId);
  }

  /* Projekte + gleichnamige Layer-Zwillinge */
  const projects = [];
  const projBy = {};
  for (const id in objects) {
    const o = objects[id];
    if (o.stereotype === 'ActualProject' && !objExcluded(o)) {
      projBy[id] = projects.length;
      projects.push(o);
    }
  }
  const twinOf = {};
  for (const id in objects) {
    if (projBy[id] !== undefined) continue;
    const o = objects[id];
    if (!o.name || objExcluded(o)) continue;
    for (let pid in projBy) {
      if (norm(o.name) === norm(objects[pid].name)) { twinOf[id] = Number(pid); break; }
    }
  }
  function anchor(id) { return twinOf[id] !== undefined ? twinOf[id] : id; }

  /* Knotenverwaltung (fuer Stats + Graph-Shapes) */
  const nodes = {};   // key -> {label, kind: project|org|milestone|alias|other, stereotype}
  const orgKeys = new Set();
  const aliases = [];
  const edges = [];
  const relByProject = {};
  projects.forEach(function (p, idx) {
    const key = 'p' + idx;
    nodes[key] = { label: p.name, kind: 'project', stereotype: p.stereotype, projectRef: idx };
    relByProject[key] = [];
    p.key = key;
    p.qea = {
      key: key, tags: tags[p.id] || {}, twins: [],
      kind: (tags[p.id] || {})['projectKind'] || '', conf: { ebenen: [], domaenen: [], kategorien: [], standards: [], sonstige: [] }
    };
    p.measurements = []; p.milestones = []; p.degree = 0;
    p.resp = []; p.acct = []; p.needs = []; p.satisfy = []; p.aliases = [];
  });

  /* Zwillinge registrieren */
  for (const tid in twinOf) {
    const pk = 'p' + projBy[twinOf[tid]];
    projects[projBy[twinOf[tid]]].qea.twins.push({ id: Number(tid), name: objects[tid].name, stereotype: objects[tid].stereotype });
    nodes['x' + tid] = { label: objects[tid].name, kind: 'other', stereotype: objects[tid].stereotype, twinOf: pk };
  }

  function nodeKey(id) {
    const a = anchor(id);
    if (projBy[a] !== undefined) return 'p' + projBy[a];
    const o = objects[id];
    if (o.stereotype === 'ActualProjectMilestone') {
      const k = 'm:' + norm(o.name);
      if (!nodes[k]) nodes[k] = { label: o.name, kind: 'milestone', stereotype: o.stereotype, objectId: id, tags: tags[id] || {}, status: o.status };
      return k;
    }
    const k = 'x' + id;
    if (!nodes[k]) {
      const kind = QEA_ORGKIND.test(o.stereotype) ? 'org' : (o.stereotype === 'SameAs' ? 'other' : 'other');
      nodes[k] = { label: o.name, kind: kind, stereotype: o.stereotype || o.objectType, objectId: id, tags: tags[id] || {}, status: o.status };
      if (kind === 'org') orgKeys.add(k);
    }
    return k;
  }

  let eid = 0;
  function pushEdge(c, sObj, eObj, fam, orig) {
    const from = nodeKey(c.Start_Object_ID), to = nodeKey(c.End_Object_ID);
    edges.push({
      id: 'e' + (eid++), type: fam, origType: orig, connectorType: String(c.Type || ''),
      from: from, to: to,
      fromLabel: sObj.name, toLabel: eObj.name,
      fromKind: nodes[from] ? nodes[from].kind : 'other',
      toKind: nodes[to] ? nodes[to].kind : 'other',
      toStereo: eObj.stereotype || eObj.objectType,
      label: orig
    });
    return [from, to];
  }
  function peekKey(id) {
    const a = anchor(id);
    if (projBy[a] !== undefined) return 'p' + projBy[a];
    const o = objects[id];
    if (o.stereotype === 'ActualProjectMilestone') return 'm:' + norm(o.name);
    return 'x' + id;
  }
  /* Durchlauf 1: alles, was am Projektuniversum haengt */
  conRows.forEach(function (c) {
    const sObj = objects[c.Start_Object_ID], eObj = objects[c.End_Object_ID];
    if (!sObj || !eObj || objExcluded(sObj) || objExcluded(eObj)) return;
    const a = anchor(c.Start_Object_ID), b = anchor(c.End_Object_ID);
    const aIn = projBy[a] !== undefined, bIn = projBy[b] !== undefined;
    if (!aIn && !bIn) return;
    const orig = String(c.Stereotype || '') || String(c.Type || '');
    const fam = QEA_FAMILY[orig] || orig;
    pushEdge(c, sObj, eObj, fam, orig);
    /* Projekt-Anker: unabhaengig von der Richtung der Relation */
    const projIdx = aIn ? projBy[a] : projBy[b];
    const p = projects[projIdx];
    const other = aIn ? eObj : sObj;
    const otherName = other.name;
    relByProject[p.qea.key].push({ st: orig, dir: aIn ? 'out' : 'in', other: otherName, otherStereo: other.stereotype || other.objectType, name: String(c.Name || '') });
    if (fam === 'resp' && p.resp.indexOf(otherName) < 0) p.resp.push(otherName);
    if (fam === 'acct' && p.acct.indexOf(otherName) < 0) p.acct.push(otherName);
    if (fam === 'needs' && p.needs.indexOf(otherName) < 0) p.needs.push(otherName);
    if (fam === 'satisfy' && p.satisfy.indexOf(otherName) < 0) p.satisfy.push(otherName);
    if (fam === 'alias' && p.aliases.indexOf(otherName) < 0) { p.aliases.push(otherName); aliases.push({ project: p.name, alias: otherName }); }
    p.degree++;
    if (aIn && bIn) projects[projBy[b]].degree++;
  });
  /* Durchlauf 2: Ketten zwischen bereits registrierten Knoten (Meilenstein-Abhaengigkeiten etc.) */
  conRows.forEach(function (c) {
    const sObj = objects[c.Start_Object_ID], eObj = objects[c.End_Object_ID];
    if (!sObj || !eObj || objExcluded(sObj) || objExcluded(eObj)) return;
    const a = anchor(c.Start_Object_ID), b = anchor(c.End_Object_ID);
    if (projBy[a] !== undefined || projBy[b] !== undefined) return; // schon in Durchlauf 1
    const kf = peekKey(c.Start_Object_ID), kt = peekKey(c.End_Object_ID);
    if (!nodes[kf] || !nodes[kt]) return;
    const orig = String(c.Stereotype || '') || String(c.Type || '');
    const fam = QEA_FAMILY[orig] || orig;
    pushEdge(c, sObj, eObj, fam, orig);
  });

  /* Meilensteine je Projekt (OwnedMilestone + MilestoneDependency) */
  edges.forEach(function (e) {
    if (e.type === 'owns') {
      const pk = e.from.charAt(0) === 'p' ? e.from : (e.to.charAt(0) === 'p' ? e.to : null);
      const mk = e.to.indexOf('m:') === 0 ? e.to : (e.from.indexOf('m:') === 0 ? e.from : null);
      if (pk && mk && nodes[mk]) {
        const p = projects[Number(pk.slice(1))];
        if (p && !p.milestones.some(function (m) { return m.name === nodes[mk].label; })) {
          p.milestones.push({ name: nodes[mk].label, dep: '' });
        }
      }
    }
    if (e.type === 'milestone') {
      const mk = e.from.indexOf('m:') === 0 ? e.from : e.to;
      const dk = e.to.indexOf('m:') === 0 ? e.to : e.from;
      for (let i = 0; i < projects.length; i++) {
        const p = projects[i];
        for (let j = 0; j < p.milestones.length; j++) {
          if (norm(p.milestones[j].name) === mk.replace(/^m:/, '') && nodes[dk]) {
            p.milestones[j].dep = nodes[dk].label;
          }
        }
      }
    }
  });

  /* Klassifikation: ConformsTo-Abbildung aus ALLEN Roh-Connectoren (reihenfolgeunabhaengig) */
  const confBy = {};
  conRows.forEach(function (c) {
    if (String(c.Stereotype || '') !== 'ConformsTo') return;
    const s = objects[c.Start_Object_ID], e = objects[c.End_Object_ID];
    if (!s || !e) return;
    const k = norm(s.name);
    if (!confBy[k]) confBy[k] = [];
    confBy[k].push(e.name);
  });
  projects.forEach(function (p, idx) {
    const key = 'p' + idx;
    const keys = [key];
    p.milestones.forEach(function (m) { keys.push('m:' + norm(m.name)); });
    const labels = [p.name].concat(p.milestones.map(function (m) { return m.name; }));
    edges.forEach(function (e) {
      if ((keys.indexOf(e.from) >= 0 || keys.indexOf(e.to) >= 0) && /Arch/i.test(e.origType) && e.origType !== 'ConformsTo') {
        if (nodes[e.from]) labels.push(nodes[e.from].label);
        if (nodes[e.to]) labels.push(nodes[e.to].label);
      }
    });
    const vals = [];
    labels.forEach(function (l) {
      (confBy[norm(l)] || []).forEach(function (v) { vals.push(v); });
    });
    p.qea.conf = classifyConforms([...new Set(vals)]);
    p.conf = p.qea.conf;
    p.status = p.qea.tags.projectStatus || p.status;
    p.projectId = p.qea.tags['project-ID'] || '';
    p.shortTitle = p.qea.tags.projectShortTitle || '';
    p.parentPackage = pkgName[p.packageId] || '';
    p.startDate = p.qea.tags.startDate || '';
    p.endDate = p.qea.tags.endDate || '';
    p.notes = p.note;
    p.rels = relByProject[key];
    nodes[key].tags = p.qea.tags;
    nodes[key].status = p.status;
  });

  /* Orgs auch aus resp/acct-Namen als Knoten (falls nur als Text) — dedupliziert */
  projects.forEach(function (p, idx) {
    p.resp.concat(p.acct).forEach(function (nm) {
      const k = 'o:' + norm(nm);
      if (nodes[k]) return;
      for (const nk in nodes) {
        if (nodes[nk].kind === 'org' && norm(nodes[nk].label) === norm(nm)) return;
      }
      nodes[k] = { label: nm, kind: 'org', stereotype: 'ActualOrganization' };
      orgKeys.add(k);
    });
  });

  return {
    projects: projects, edges: edges, aliases: aliases,
    nodes: nodes, orgKeys: orgKeys,
    counts: { projects: projects.length, edges: edges.length, milestones: edges.filter(function (e) { return e.type === 'owns'; }).length, obj: objRows.length, con: conRows.length }
  };
}

</script>
<script>
var ADMBW_DATA = {"grid":{"cols":["Taxonomy","Structure","Connectivity","Processes","States","Sequences","Information","Constraints","Roadmap"],"col_de":["Taxonomie","Struktur","Konnektivität","Prozesse","Zustände","Sequenzen","Information","Restriktionen","Roadmap"],"rows":[{"layer":"Concept","label":"Konzepte","desc":"Strategischer Kontext: Fähigkeiten, Vision, Abhängigkeiten","cells":["C1","C2","C3","C4","C5",null,"C7","C8","Cr"]},{"layer":"Service","label":"Dienste","desc":"Service-Spezifikation: Dienste, Schnittstellen, Funktionen","cells":["S1","S2","S3","S4","S5","S6","S7","S8","Sr"]},{"layer":"Logical","label":"Logisch","desc":"Logische Spezifikation: Knoten, Aktivitäten, Informationsmodell","cells":["L1","L2","L3","L4","L5","L6","L7","L8","Lr"]},{"layer":"Physical","label":"Physisch","desc":"Physische Ressourcen: Typen, Struktur, Konnektivität","cells":["P1","P2","P3","P4","P5","P6","P7","P8","Pr"]},{"layer":"ArchFdn","label":"Architektur-Grundlagen","desc":"Architekturgrundlagen: Metadaten, Produkte, Standards","cells":["A1","A2","A3","A4","A5","A6","A7","A8","Ar"]},{"layer":"Req","label":"Anforderungen","desc":"Anforderungs-Viewpoints: Katalog, Abhängigkeiten, Erfüllung","cells":[null,"R2","R3",null,null,null,"R7","R8","Rr"]},{"layer":"Mapping","label":"Bridge/Mapping","desc":"Brücken-Sichten zwischen Bereichen","cells":["C1-S1","L2-L3","L4-P4",null,null,null,null,null,null],"bridge":true}]},"vp":{"C1":{"n":"Capability Taxonomy","layer":"Concept Viewpoints","cnt":9,"els":["Capability","CapabilityGeneralization","MeasurableElement","Measurement","MeasurementType","OwnsMeasurement","PropertySet","Satisfy","StrategicConstraint"],"desc":"The C1 Viewpoint specifies all the capabilities that are referenced throughout one or more architectures – i.e. one C1 may provide the definitive list of capabilities for a number of logical and resource architectures. The capabilities may be organised into specialisation hierarchies (taxonomies). Measures of Effectiveness (MoE) may be specified for each capability. Note that MoEs are inherited down a capability taxonomy."},"C2":{"n":"Enterprise Vision","layer":"Concept Viewpoints","cnt":23,"els":["ActualEnduringTask","ActualEnterprisePhase","Capability","CapabilityForTask","CapableElement","EnduringTask","EnterpriseGoal","EnterprisePhase","EnterpriseVision","Environment","EnvironmentalCondition","Exhibits","GoalForActualEnterprisePhase","OperationalArchitecture","OperationalArchitectureOfEnterprisePhase","PhysicalArchitectureOfEnterprisePhase","ResourceArchitecture","Satisfy","StatementTask","StrategicConstraint","TemporalPart","VisionForActualEnterprisePhase","WholeLifeEnterprise"],"desc":"The purpose of the C2 Viewpoint is to provide a strategic context for the capabilities described in the architecture and to specify the scope for the architecture. The C2 Viewpoint is high-level and describes the vision, goals, enduring tasks and capabilities using terminology that is easily understood by non-technical readers."},"C3":{"n":"Capability Dependencies","layer":"Concept Viewpoints","cnt":7,"els":["Capability","CapabilityDependency","CapabilityGeneralization","CapabilityRole","CapabilityRoleDependency","Satisfy","StrategicConstraint"],"desc":"The C3 Viewpoint is intended to provide a means of analysing the dependencies between capabilities and between capability clusters. The composition of capabilities (into clusters) is logical and the purpose of the clusters is to guide enterprise management."},"C4":{"n":"Standard Processes","layer":"Concept Viewpoints","cnt":11,"els":["ActualEnduringTask","BusinessProcess","Capability","CapabilityForTask","EnduringTask","MapsToCapability","OperationalActivity","OperationalActivityAction","Satisfy","StandardOperationalActivity","StrategicConstraint"],"desc":"The C4 Viewpoint specifies Standard Operational Activities that can be re-used across multiple logical architectures (e.g. in L4, Logical Activities)."},"C5":{"n":"Effects","layer":"Concept Viewpoints","cnt":28,"els":["AchievedEffect","Achiever","ActualEnterprisePhase","ActualOrganization","ActualOrganizationalResource","ActualPerson","ActualPost","ActualResource","ActualResponsibleResource","ActualState","Capability","CapabilityConfiguration","CapableElement","DesiredEffect","Desirer","Environment","EnvironmentalCondition","Exhibits","FieldedCapability","Organization","Person","Post","RealizedDesiredEffect","RealizingAchievedEffect","Satisfy","ServiceSpecification","StandardOperationalActivity","StrategicConstraint"],"desc":"The purpose of the C5 Viewpoint is to describe the operational effect of the capabilities, activities and services according to the expected goals. The C5 Viewpoint is high-level description that should be easily understood by non-technical readers."},"C7":{"n":"Performance Parameters","layer":"Concept Viewpoints","cnt":6,"els":["Capability","MeasurableElement","Measurement","MeasurementType","OwnsMeasurement","PropertySet"],"desc":"In the C7 Viewpoint the capability requirements (and existing capabilities) can be expressed in terms of Measures of Effectiveness (MoEs). These are high-level metrics used to judge the level of capability."},"C8":{"n":"Planning Assumption","layer":"Concept Viewpoints","cnt":9,"els":["Capability","Implements","JustifiedBy","OperationalConstraint","Reference","ResourceConstraint","Satisfy","ServicePolicy","StrategicConstraint"],"desc":"The C8 Viewpoint is concerned with identification and description of assumptions that have been made for the implementation of capabilities. Assumptions can be expressed by means of requirements."},"Cr":{"n":"Capability Roadmap","layer":"Concept Viewpoints","cnt":26,"els":["ActualProject","ActualProjectDependency","ActualProjectMilestone","ActualResource","ActualResourceNeededByActualProjectMilestone","ActualResourceToActualProjectMilestone","Capability","CapabilityConfiguration","CapableElement","Environment","EnvironmentalCondition","Exhibits","FieldedCapability","MilestoneDependency","OwnedMilestone","Project","ProjectMilestoneRole","ProjectMilestoneToProjectTheme","ProjectSequence","ProjectTheme","RequiredResource","ResourceArchitecture","ResourcePerformer","VersionReleased","VersionWithdrawn","VersionedElement"],"desc":"The Cr Viewpoint supports the Capability Audit process by providing a method to identify gaps or duplications in capability provision. Cr indicates capability increments, which are derived from delivery milestones within acquisition projects."},"S1":{"n":"Service Taxonomy","layer":"Service Specification Viewpoints","cnt":8,"els":["Measurement","MeasurementType","PropertySet","Satisfy","ServiceClassification","ServicePolicy","ServiceSpecification","ServiceSpecificationGeneralization"],"desc":"The purpose of the S1 Viewpoint is to provide a governance structure for a Service-Oriented Architecture. Along with S3, Service Interfaces, it specifies a standard library of service specifications for an enterprise, to which service implementers are expected to conform."},"S2":{"n":"Service Structure","layer":"Service Specification Viewpoints","cnt":15,"els":["IsAccountableFor","IsCapableToPerform","IsResponsibleFor","OperationalAgent","Organization","ProvidesServiceFunction","ResourcePerformer","ServiceDependency","ServiceFunction","ServiceInterface","ServiceMethod","ServiceParameter","ServicePort","ServiceSpecification","ServiceSpecificationRole"],"desc":"The S2 Viewpoint is concerned with identification and description of how services are structured to create a higher-aggregated service. To provide highlevel views, dependencies to other services, nodes and resources as well as service interfaces and service functions can be represented."},"S3":{"n":"Service Interfaces","layer":"Service Specification Viewpoints","cnt":8,"els":["Satisfy","ServiceConnector","ServiceInterface","ServiceMethod","ServiceParameter","ServicePolicy","ServicePort","ServiceSpecification"],"desc":"The S3 Viewpoint is concerned with the identification and definition of service interfaces."},"S4":{"n":"Service Functions","layer":"Service Specification Viewpoints","cnt":10,"els":["IsCapableToPerform","PerformsInContext","Satisfy","ServiceFunction","ServiceFunctionAction","ServiceMethod","ServiceParameter","ServicePolicy","ServiceSpecification","ServiceSpecificationRole"],"desc":"The S4 Viewpoint is the key behavioural specification for services. Equivalent in nature to L4, Logical Activities and P4, Resources Functions, it specifies a set of functions that a service implementation is expected to perform. Implementation of that behaviour is represented in P4, Resource Functions, and L4-P4, Activity to Function Mapping."},"S5":{"n":"Service States","layer":"Service Specification Viewpoints","cnt":3,"els":["ServiceSpecification","ServiceStateDescription","StateDescription"],"desc":"The S5 Viewpoint is a specification of the allowable states of a service, and the possible transitions between them. This specification constrains how implementations of the service will behave. It is, though, generally considered a good practice to make services stateless - i.e. consumers of a service are not aware of what state the service is in."},"S6":{"n":"Service Interactions","layer":"Service Specification Viewpoints","cnt":12,"els":["InteractionRole","OperationalAgent","OperationalExchange","OperationalMessage","OperationalRole","ResourceExchange","ResourceMessage","ResourceRole","ServiceMessage","ServiceMethod","ServiceSpecification","ServiceSpecificationRole"],"desc":"Service Interaction Descriptions, sometimes called sequence diagrams, event scenarios or timing diagrams, allow the tracing of interactions between services in a composition or critical sequence of events."},"S7":{"n":"Service Interface Parameters","layer":"Service Specification Viewpoints","cnt":6,"els":["ProvidesServiceFunction","ServiceFunction","ServiceInterface","ServiceMethod","ServiceParameter","ServiceSpecification"],"desc":"Specifies the interfaces that a service provides and uses, defines which services are compatible with which other services."},"S8":{"n":"Service Policy","layer":"Service Specification Viewpoints","cnt":7,"els":["Implements","OperationalConstraint","ResourceConstraint","Satisfy","ServicePolicy","ServiceSpecification","StrategicConstraint"],"desc":"The S8 Viewpoint specifies constraints against services to which implementations must conform."},"Sr":{"n":"Service Roadmap","layer":"Service Specification Viewpoints","cnt":25,"els":["ActualProject","ActualProjectDependency","ActualProjectMilestone","ActualService","IsAccountableFor","IsResponsibleFor","MilestoneDependency","NeedsService","Organization","OwnedMilestone","Project","ProjectMilestone","ProjectMilestoneRole","ProjectMilestoneToProjectTheme","ProjectSequence","ProjectTheme","ProvidedServiceLevel","RequiredResource","RequiredServiceLevel","ResourcePerformer","ServiceSpecification","ServiceSpecificationRole","VersionReleased","VersionWithdrawn","VersionedElement"],"desc":"The Sr Viewpoint supports the Service Audit process by providing a method to identify gaps or duplications in service provision. Sr indicates service lifetime evolutions, which are derived from delivery milestones within acquisition projects."},"C1-S1":{"n":"Capability to Service Mapping","layer":"Service Specification Viewpoints","cnt":6,"els":["Capability","CapableElement","Environment","EnvironmentalCondition","Exhibits","ServiceSpecification"],"desc":"A C1-S1 Viewpoint presents a simple mapping of services to capabilities, showing which services contribute to which capability."},"L1":{"n":"Node Types","layer":"Logical Specification Viewpoints","cnt":26,"els":["Asset","BusinessProcess","Capability","CapableElement","Environment","EnvironmentalCondition","Exhibits","IsCapableToPerform","JustifiedBy","MapsToCapability","MeasurableElement","Measurement","MeasurementType","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalAsset","OperationalConstraint","OperationalPerformer","OperationalRole","OwnsMeasurement","PerformsInContext","PropertySet","Reference","Satisfy","SubjectOfOperationalConstraint"],"desc":"The L1 Viewpoint defines all of the Nodes that will appear in a Logical Architecture. Nodes are elements of capability assembled and orchestrated in the Logical Architecture (see L2 - Logical Scenario and L4 - Logical Activities views). The levels of capability provided by each node are expressed as Measures of Performance (MoPs) and these may be dependent on the environments in which the Node is required to operate."},"L2":{"n":"Logical Scenario","layer":"Logical Specification Viewpoints","cnt":34,"els":["ActualEnvironment","ActualLocation","Asset","ConsumedBy","JustifiedBy","KnownResource","Location","LocationHolder","LocationType","MeasurableElement","Measurement","MeasurementType","OperationalAgent","OperationalArchitecture","OperationalAsset","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalExchangeItem","OperationalInterface","OperationalPerformer","OperationalPort","OperationalRole","OwnsMeasurement","PhysicalLocation","ProblemDomain","PropertySet","Provides","Reference","RequiredEnvironment","Satisfy","ServiceSpecification","ServiceSpecificationRole","SubjectOfOperationalConstraint"],"desc":"The L2 Viewpoint specifies Nodes (elements of capability) in context of each other. The context is usually expressed in terms of the information that flows between the nodes (e.g. the information flow requirements between capabilities in a given scenario) but may also be flows of materiel, human resource or energy."},"L3":{"n":"Node Interaction","layer":"Logical Specification Viewpoints","cnt":28,"els":["ConsumedBy","IsCapableToPerform","MeasurableElement","Measurement","MeasurementType","OperationalActivity","OperationalActivityAction","OperationalActivityEdge","OperationalAgent","OperationalArchitecture","OperationalConnector","OperationalConstraint","OperationalControlFlow","OperationalExchange","OperationalExchangeItem","OperationalInterface","OperationalObjectFlow","OperationalPerformer","OperationalPort","OperationalRole","OwnsMeasurement","PerformsInContext","ProblemDomain","Provides","Satisfy","ServiceSpecification","ServiceSpecificationRole","SubjectOfOperationalConstraint"],"desc":"L3 is used to provide further detail of the interoperability requirements associated with the operational capability of interest. The focus is on logical flows that cross the capability boundary. Although the primary purpose of the L3 Viewpoint is to specify information exchanges, the L3 may also list flows of materiel, energy and human resources."},"L4":{"n":"Logical Activities","layer":"Logical Specification Viewpoints","cnt":34,"els":["ActivityPerformableUnderCondition","ActivitySupportsService","ActsUpon","ActualCondition","ActualService","AffectedActivity","AffectedResource","BusinessProcess","Consumes","Implements","IsCapableToPerform","JustifiedBy","OperationalActivity","OperationalActivityAction","OperationalActivityEdge","OperationalAgent","OperationalConstraint","OperationalControlFlow","OperationalExchange","OperationalExchangeItem","OperationalMessageFlow","OperationalObjectFlow","OperationalParameter","OperationalPerformer","OperationalRole","PaperForm","PerformsInContext","ProcessParameter","Reference","RequiredServiceLevel","Satisfy","ServiceSpecification","StandardOperationalActivity","SubjectOfOperationalConstraint"],"desc":"The L4 Viewpoint describes the operational activities that are being conducted within the mission or scenario. These activities are defined at a logical, solution-neutral level so as to enable different solutions in the physical layer. The L4 Viewpoint describes the activities associated with the logical architecture."},"L5":{"n":"Logical States","layer":"Logical Specification Viewpoints","cnt":5,"els":["OperationalAgent","OperationalArchitecture","OperationalPerformer","OperationalStateDescription","StateDescription"],"desc":"The L5 Viewpoint specifies the typical states a node may have and the possible transitions between those states (i.e. changes of state). Triggers for state changes may also be defined. Actions may be associated with a given state or with the transition between states in response to stimuli (e.g. triggers and events)."},"L6":{"n":"Logical Sequence","layer":"Logical Specification Viewpoints","cnt":13,"els":["BusinessProcess","Exchange","InteractionMessage","InteractionRole","OperationalActivity","OperationalAgent","OperationalExchange","OperationalMessage","OperationalMethod","OperationalRole","ProcessOperation","ServiceSpecification","ServiceSpecificationRole"],"desc":"Operational Event-Trace Descriptions, sometimes called sequence diagrams, event scenarios or timing diagrams, allow the tracing of interactions between nodes in a scenario or critical sequence of events. The node interactions usually correspond to flows of information but may describe flows of energy, materiel or people specified in the L2, Logical Scenario."},"L7":{"n":"Information Model","layer":"Logical Specification Viewpoints","cnt":17,"els":["AssetRole","Classification","Classified","DataElement","DataModel","DataRole","Implements","InformationElement","InformationRole","JustifiedBy","MeasurableElement","OperationalAsset","OperationalConstraint","Reference","ResourceAsset","Satisfy","SubjectOfOperationalConstraint"],"desc":"The L7 Viewpoint is used to document the business information. It describes the information that can be exchanged along the logical flows in the architecture, specified in L2, L3 and L4."},"L8":{"n":"Logical Constraints","layer":"Logical Specification Viewpoints","cnt":16,"els":["DataModel","Implements","InformationElement","JustifiedBy","OperationalActivity","OperationalAgent","OperationalArchitecture","OperationalConstraint","OperationalExchange","OperationalPerformer","Reference","ResourceConstraint","Satisfy","ServicePolicy","StrategicConstraint","SubjectOfOperationalConstraint"],"desc":"The L8 Viewpoint is used to constrain the logical architecture without forcing a particular solution. L8 is used for rules which are not expressed as behavioural models, interactions or measures of effectiveness, i.e. they are textual statements of requirements that constrain the architecture."},"Lr":{"n":"Lines of Development","layer":"Logical Specification Viewpoints","cnt":28,"els":["ActualProject","ActualProjectConsults","ActualProjectDependency","ActualProjectInforms","ActualProjectMilestone","ArchitecturalDescription","ArchitectureForProject","IsAccountableFor","IsResponsibleFor","JustifiedBy","MilestoneDependency","OperationalConstraint","Organization","OwnedMilestone","Project","ProjectMilestone","ProjectMilestoneRole","ProjectMilestoneToProjectTheme","ProjectSequence","ProjectTheme","Reference","RequiredResource","ResourcePerformer","Satisfy","SubjectOfOperationalConstraint","VersionReleased","VersionWithdrawn","VersionedElement"],"desc":"The Lr Viewpoint is primarily intended to support the acquisition process across multiple projects or programmes, highlighting dependencies the logical dependencies between capabilities, projects and the integration of all lines of development to achieve a successfully integrated military capability. Use of the Lr Viewpoint should support the management of capability delivery and be aligned with Cr, Capability Roadmap."},"L2-L3":{"n":"Logical Concept","layer":"Logical Specification Viewpoints","cnt":25,"els":["ArbitraryConnector","Asset","CapabilityConfiguration","ConceptItem","ConceptRole","DataElement","HighLevelOperationalConcept","InformationElement","Location","NaturalResource","OperationalAgent","OperationalArchitecture","OperationalAsset","OperationalPerformer","Organization","OrganizationalResource","Person","PhysicalResource","Post","ResourceArchitecture","ResourceArtifact","ResourceAsset","ResourcePerformer","Software","System"],"desc":"The L2-L3 Viewpoint is concerned with providing an executive level, scenario-based communication of the architecture purpose, scope and content."},"P1":{"n":"Resource Types","layer":"Physical Resource Viewpoints","cnt":46,"els":["ActualEnterprisePhase","ActualResource","ActualService","Asset","CapabilityConfiguration","CapableElement","Competence","DataElement","DataElementStoredIn","Energy","Forecast","ForecastPeriod","FormStoredIn","Implements","MeasurableElement","Measurement","MeasurementType","NaturalResource","OperationalAgent","OperationalArchitecture","OperationalPerformer","OperationalRole","Organization","OrganizationalResource","OwnsMeasurement","PaperForm","Person","PhysicalResource","Post","PropertySet","RequiresCompetence","ResourceArchitecture","ResourceArtifact","ResourceAsset","ResourceConstraint","ResourceInterface","ResourcePerformer","Satisfy","ServiceInterface","ServiceProvision","ServiceSpecification","Software","StandardOperationalActivity","SubjectOfForecast","SubjectOfResourceConstraint","System"],"desc":"The P1 Viewpoint collects together all the Resource Types in the architecture together with a depiction of their performance characteristics. P1 also provides a summary of the technologies and competencies that impact on the Resources that constitute the architecture."},"P2":{"n":"Resource Structure","layer":"Physical Resource Viewpoints","cnt":57,"els":["ActualEnvironment","ActualLocation","ActualProject","ActualProjectConsults","ActualProjectInforms","CapabilityConfiguration","Command","Competence","CompetenceForRole","Control","DataElement","Energy","Function","GeoPoliticalExtentType","HostedOn","Implements","IsAccountableFor","IsResponsibleFor","Location","LocationHolder","LocationType","NaturalResource","NeedsModificationOf","NeedsResource","OperationalActivity","OperationalAgent","OperationalArchitecture","OperationalPerformer","OperationalRole","Organization","OrganizationalResource","Person","PhysicalLocation","PhysicalResource","Post","PostRole","ProjectProvidesFunction","ProjectSupportActivity","RequiredEnvironment","ResourceArchitecture","ResourceArtifact","ResourceConstraint","ResourceDependency","ResourceExchange","ResourceExchangeItem","ResourcePerformer","ResourceRole","ResourceToServiceDependency","Responsible","Satisfy","ServiceProvision","ServiceSpecification","ServiceSpecificationRole","Software","SubOrganization","SubjectOfResourceConstraint","System"],"desc":"The P2 Viewpoint links together the operational and physical architecture viewpoints by depicting how types of Resource are structured and interact to realize the logical architecture specified in L2, Logical Scenario. The P2 Viewpoint may represent the realization of a requirement specified in a L2 (i.e. in a “to-be” architecture) and so there may be many alternative Resource viewpoint suites that could realize the operational requirement. Alternatively, in an “as-is” architecture, a L2 may just be a simplified, logical representation of the P2 Viewpoint to allow communication of key information flows to non-technical stakeholders."},"P3":{"n":"Resource Connectivity","layer":"Physical Resource Viewpoints","cnt":22,"els":["Control","ImplementsProtocol","MeasurableElement","Measurement","MeasurementType","OwnsMeasurement","PhysicalResource","PropertySet","Protocol","ProtocolImplementation","ProtocolLayer","Protocolstack","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceExchangeItem","ResourceInterface","ResourcePerformer","ResourcePort","ResourceRole","Satisfy","SubjectOfResourceConstraint"],"desc":"The networks and pathways documented in a P3 Viewpoint represent the physical implementation of the logical flows identified in a L2, Logical Scenario, or L3, Node Interactions View."},"P4":{"n":"Resource Functions","layer":"Physical Resource Viewpoints","cnt":25,"els":["AffectedFunctions","DataElement","Function","FunctionAction","FunctionControlFlow","FunctionEdge","FunctionObjectFlow","FunctionSubject","Implements","IsCapableToPerform","MeasurableElement","Measurement","MeasurementType","OperationalActivity","OwnsMeasurement","PerformsInContext","ResourceConstraint","ResourceExchange","ResourceExchangeItem","ResourceMethod","ResourceParameter","ResourcePerformer","ResourceRole","Satisfy","SubjectOfResourceConstraint"],"desc":"The Functionality Description provides detailed information regarding the allocation of functions to resources, and flows between Resource Functions. The P4 Viewpoint is the Physical Resource counterpart to the L4 Logical Activities Viewpoint."},"P5":{"n":"Resource States","layer":"Physical Resource Viewpoints","cnt":3,"els":["ResourcePerformer","ResourceStateDescription","StateDescription"],"desc":"The P5 Viewpoint identifies the states a Resource can be, the allowable changes between those states, and the stimuli (e.g. triggers and events) that cause the state changes."},"P6":{"n":"Resource Sequence","layer":"Physical Resource Viewpoints","cnt":10,"els":["Function","InteractionMessage","InteractionRole","ResourceExchange","ResourceExchangeItem","ResourceMessage","ResourceMethod","ResourcePerformer","ResourceRole","ServiceSpecificationRole"],"desc":"The P6 Viewpoint is valuable for moving to the next level of detail from the initial solution design, to help define a sequence of functions and Resource Interactions, and to ensure that each participating Resource or Port has the necessary information, at the right time, in order to perform its assigned functionality."},"P7":{"n":"Data Model","layer":"Physical Resource Viewpoints","cnt":19,"els":["AssetRole","Classification","Classified","DataElement","DataModel","DataRole","Implements","InformationElement","InformationRole","JustifiedBy","MeasurableElement","OperationalAsset","OperationalConstraint","Reference","ResourceAsset","ResourceConstraint","Satisfy","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"desc":"The P7 Viewpoint is one of the architectural products closest to actual system design in the NAF. It is used to describe how the information represented in the L7 Logical Data Model Viewpoint is implemented."},"P8":{"n":"Resource Constraints","layer":"Physical Resource Viewpoints","cnt":28,"els":["ActualPerson","ActualPost","ActualResource","CapabilityConfiguration","DataElement","FillsPost","Function","Implements","JustifiedBy","NaturalResource","OperationalConstraint","Organization","OrganizationalResource","Person","PhysicalResource","Post","Reference","ResourceArchitecture","ResourceArtifact","ResourceConstraint","ResourcePerformer","ResourceRole","Satisfy","ServicePolicy","Software","StrategicConstraint","SubjectOfResourceConstraint","System"],"desc":"The P8 Viewpoint describes constraints on the Resources, Resource Functions, data and communications that make up a Physical Architecture."},"Pr":{"n":"Configuration Management","layer":"Physical Resource Viewpoints","cnt":22,"els":["ActualProject","ActualProjectDependency","ActualProjectMilestone","MilestoneDependency","OwnedMilestone","Project","ProjectMilestone","ProjectMilestoneRole","ProjectMilestoneToProjectTheme","ProjectSequence","ProjectTheme","RequiredResource","ResourcePerformer","ServiceSpecification","Standard","SuccessorOf","VersionOfConfiguration","VersionReleased","VersionSuccession","VersionWithdrawn","VersionedElement","WholeLifeConfiguration"],"desc":"The Pr Viewpoint provides an overview of how Resource Assets change over time (note that NAF v3.1 only allowed for Capability Configurations whereas now this is opened up to all Resource Types). It shows the structure of different versions of Resource Assets (usually Capability Configurations or Service Implementations) mapped against a timeline."},"L4-P4":{"n":"Activity to Function Mapping","layer":"Physical Resource Viewpoints","cnt":9,"els":["Function","Implements","IsCapableToPerform","OperationalActivity","OperationalAgent","ResourcePerformer","ServiceFunction","ServiceMethod","ServiceSpecification"],"desc":""},"A1":{"n":"Meta-Data Definitions","layer":"Architecture Foundation","cnt":11,"els":["ActualProject","ActualProjectMilestone","ArchitecturalDescription","Architecture","ArchitectureForProject","ArchitectureMetadata","Classification","Classified","DescribedBy","Expresses","Metadata"],"desc":"The A1 Viewpoint presents meta-data tags to aid with searching and discovery."},"A2":{"n":"Architecture Products","layer":"Architecture Foundation","cnt":20,"els":["ActualEnterprisePhase","ActualOrganizationalResource","ArchitecturalDescription","ArchitectureMetadata","CompliesViewpoint","Concern","ConcernForActualEnterprisePhase","ConcernForView","ConcernForViewpoint","EnterprisePhase","Metadata","OrganizationalResource","Stakeholder","StakeholderConcern","View","Viewpoint","ViewpointToStakeholder","ViewpointsInArchitecturalDescription","ViewsInArchitecturalDescription","WholeLifeEnterprise"],"desc":"The A2 Viewpoint specifies the structure of an architecture, and the products that describe the architecture. Each product may correspond to an architecture view."},"A3":{"n":"Architecture Correspondence","layer":"Architecture Foundation","cnt":2,"els":["ArchitecturalDescription","ArchitecturalReference"],"desc":"The A3 Viewpoint presents correspondence relations between elements of Architecture Descriptions. ISO/IEC/IEEE42010 introduces the idea of architecture correspondence and correspondence rules. Quoting from ISO/IEC/IEEE 42010: \"A correspondence defines a relation between AD (Architecture Description) elements. Correspondences are used to express architecture relations of interest within an architecture description (or between architecture descriptions). Correspondences can be governed by correspondence rules. Correspondence rules are used to enforce relations within an architecture description (or between architecture descriptions).\""},"A4":{"n":"Methodology Used","layer":"Architecture Foundation","cnt":1,"els":["ArchitecturalDescription"],"desc":"The A4 Viewpoint specifies the methodology used for the architecting activities."},"A5":{"n":"Architecture Status","layer":"Architecture Foundation","cnt":1,"els":["ArchitecturalDescription"],"desc":"The A5 Viewpoint shows the current version number and approval status for the architecture."},"A6":{"n":"Architecture Versions","layer":"Architecture Foundation","cnt":2,"els":["ArchitecturalDescription","ArchitecturalSequence"],"desc":"The A6 Viewpoint shows the complete history of the architecture."},"A7":{"n":"Architecture Compliance","layer":"Architecture Foundation","cnt":4,"els":["Alias","Information","SameAs","UAFElement"],"desc":"The A7 Viewpoint gives the overall specification of architecture meta-data."},"A8":{"n":"Standards","layer":"Architecture Foundation","cnt":6,"els":["ActualOrganization","Protocol","ProtocolLayer","Protocolstack","RatifiedStandards","Standard"],"desc":"The A8 Viewpoint encompasses both technical and non-technical standards. The standards specified in the A8 view can be applied across the architecture to a variety of structural and behavioural elements. Standards are essential to the coherent running of businesses and to the delivery of reliable, interoperable systems."},"Ar":{"n":"Architecture Roadmap","layer":"Architecture Foundation","cnt":2,"els":["ArchitecturalDescription","ArchitecturalSequence"],"desc":"The Ar Viewpoint shows the history of the architecture project as well as its future direction."},"R2":{"n":"Requirement Catalogue","layer":"Requirement Viewpoints","cnt":7,"els":["BWRequirement","FunctionalRequirement","NonfunctionalRequirement","PartOfCatalogue","PartOfCategory","RequirementCatalogue","RequirementCategory"],"desc":"The R2 represents a catalog of requirements in the architectural model. For this purpose, categories can be created in which the functional and non-functional requirements can be grouped."},"R3":{"n":"Requirement Dependencies","layer":"Requirement Viewpoints","cnt":9,"els":["BWRequirement","ConflictsWith","FunctionalRequirement","IsDuplicateOf","NonfunctionalRequirement","Refines","Replaces","Requires","StemsFrom"],"desc":"The R3 is used to show dependencies between different requirements."},"R7":{"n":"Requirement Derivation","layer":"Requirement Viewpoints","cnt":20,"els":["BWRequirement","DataElement","DerivedFrom","Function","FunctionalRequirement","Measurement","MeasurementType","NonfunctionalRequirement","Protocol","Protocolstack","ResourcePerformer","ResourcePort","ResourceRole","ServiceFunction","ServiceInterface","ServiceSpecification","ServiceSpecificationRole","Standard","ToBeRealizedBy","UAFElement"],"desc":"The R7 assigns functional and non-functional requirements to the demanding architectural elements. In addition, information about the planned realization can be shown."},"R8":{"n":"Requirement Fulfilment","layer":"Requirement Viewpoints","cnt":7,"els":["BWRequirement","Checks","Evaluates","FitCriterion","FulfilmentCriterion","FunctionalRequirement","NonfunctionalRequirement"],"desc":"The R8 is used to determine and map acceptance and evaluation criteria for the individual functional and non- functional requirements."},"Rr":{"n":"Requirement Realization","layer":"Requirement Viewpoints","cnt":18,"els":["BWRequirement","DataElement","Function","FunctionalRequirement","Measurement","MeasurementType","NonfunctionalRequirement","Protocol","Protocolstack","RealiseRequirement","ResourcePerformer","ResourcePort","ResourceRole","ServiceFunction","ServiceInterface","ServiceSpecification","ServiceSpecificationRole","Standard"],"desc":"In the Rr, requirements are assigned to the realizing architectural elements."}},"topo":{"C1":[{"rel":"CapabilityGeneralization","from":["Capability"],"to":["Capability"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"C2":[{"rel":"CapabilityForTask","from":["Capability"],"to":["ActualEnduringTask","EnduringTask"]},{"rel":"EnvironmentalCondition","from":["Exhibits"],"to":["Environment"]},{"rel":"Exhibits","from":["CapableElement"],"to":["Capability"]},{"rel":"GoalForActualEnterprisePhase","from":["ActualEnterprisePhase"],"to":["EnterpriseGoal"]},{"rel":"OperationalArchitectureOfEnterprisePhase","from":["ActualEnterprisePhase"],"to":["OperationalArchitecture"]},{"rel":"PhysicalArchitectureOfEnterprisePhase","from":["ActualEnterprisePhase"],"to":["ResourceArchitecture"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"StatementTask","from":["ActualEnterprisePhase"],"to":["ActualEnduringTask"]},{"rel":"VisionForActualEnterprisePhase","from":["ActualEnterprisePhase"],"to":["EnterpriseVision"]}],"C3":[{"rel":"CapabilityDependency","from":["Capability"],"to":["Capability"]},{"rel":"CapabilityGeneralization","from":["Capability"],"to":["Capability"]},{"rel":"CapabilityRoleDependency","from":["CapabilityRole"],"to":["CapabilityRole"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"C4":[{"rel":"CapabilityForTask","from":["Capability"],"to":["ActualEnduringTask","EnduringTask"]},{"rel":"MapsToCapability","from":["BusinessProcess"],"to":["Capability"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"C5":[{"rel":"AchievedEffect","from":["Achiever"],"to":["ActualState"]},{"rel":"DesiredEffect","from":["Desirer"],"to":["ActualState"]},{"rel":"EnvironmentalCondition","from":["Exhibits"],"to":["Environment"]},{"rel":"Exhibits","from":["CapableElement"],"to":["Capability"]},{"rel":"RealizedDesiredEffect","from":["AchievedEffect"],"to":["DesiredEffect"]},{"rel":"RealizingAchievedEffect","from":["DesiredEffect"],"to":["AchievedEffect"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"C7":[{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]}],"C8":[{"rel":"ActualProjectDependency","from":["ActualProject"],"to":["ActualProject"]},{"rel":"ActualResourceNeededByActualProjectMilestone","from":["ActualResource"],"to":["ActualProjectMilestone"]},{"rel":"ActualResourceToActualProjectMilestone","from":["ActualResource"],"to":["ActualProjectMilestone"]},{"rel":"EnvironmentalCondition","from":["Exhibits"],"to":["Environment"]},{"rel":"Exhibits","from":["CapableElement"],"to":["Capability"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"MilestoneDependency","from":["ActualProjectMilestone"],"to":["ActualProjectMilestone"]},{"rel":"OwnedMilestone","from":["ActualProject"],"to":["ActualProjectMilestone"]},{"rel":"ProjectMilestoneToProjectTheme","from":["ProjectMilestone"],"to":["ProjectTheme"]},{"rel":"ProjectSequence","from":["ActualProject"],"to":["ActualProject"]},{"rel":"RequiredResource","from":["ProjectMilestone"],"to":["ResourcePerformer"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"VersionReleased","from":["ActualProjectMilestone"],"to":["VersionedElement"]},{"rel":"VersionWithdrawn","from":["ActualProjectMilestone"],"to":["VersionedElement"]}],"S1":[{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"ServiceClassification","from":["ServiceSpecification"],"to":["ServiceSpecification"]},{"rel":"ServiceSpecificationGeneralization","from":["ServiceSpecification"],"to":["ServiceSpecification"]}],"S2":[{"rel":"IsAccountableFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"IsResponsibleFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"ProvidesServiceFunction","from":["ServiceInterface"],"to":["ServiceFunction"]},{"rel":"ServiceDependency","from":["ServiceSpecification"],"to":["OperationalAgent","ResourcePerformer","ServiceSpecification"]}],"S3":[{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"S4":[{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"S6":[{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]}],"S7":[{"rel":"ProvidesServiceFunction","from":["ServiceInterface"],"to":["ServiceFunction"]}],"S8":[{"rel":"ActualProjectDependency","from":["ActualProject"],"to":["ActualProject"]},{"rel":"EnvironmentalCondition","from":["Exhibits"],"to":["Environment"]},{"rel":"Exhibits","from":["CapableElement"],"to":["Capability"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"IsAccountableFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"IsResponsibleFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"MilestoneDependency","from":["ActualProjectMilestone"],"to":["ActualProjectMilestone"]},{"rel":"NeedsService","from":["ActualProject"],"to":["ServiceSpecification","ServiceSpecificationRole"]},{"rel":"OwnedMilestone","from":["ActualProject"],"to":["ActualProjectMilestone"]},{"rel":"ProjectMilestoneToProjectTheme","from":["ProjectMilestone"],"to":["ProjectTheme"]},{"rel":"ProjectSequence","from":["ActualProject"],"to":["ActualProject"]},{"rel":"RequiredResource","from":["ProjectMilestone"],"to":["ResourcePerformer"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"VersionReleased","from":["ActualProjectMilestone"],"to":["VersionedElement"]},{"rel":"VersionWithdrawn","from":["ActualProjectMilestone"],"to":["VersionedElement"]}],"L1":[{"rel":"EnvironmentalCondition","from":["Exhibits"],"to":["Environment"]},{"rel":"Exhibits","from":["CapableElement"],"to":["Capability"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"MapsToCapability","from":["BusinessProcess"],"to":["Capability"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"L2":[{"rel":"ConsumedBy","from":["ServiceSpecification","ServiceSpecificationRole"],"to":["OperationalPerformer","OperationalRole"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"LocationHolder","from":["LocationHolder"],"to":["Location"]},{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"PhysicalLocation","from":["LocationHolder"],"to":["ActualLocation"]},{"rel":"Provides","from":["OperationalPerformer","OperationalRole"],"to":["ServiceSpecification","ServiceSpecificationRole"]},{"rel":"RequiredEnvironment","from":["LocationHolder"],"to":["ActualEnvironment"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"L3":[{"rel":"ConsumedBy","from":["ServiceSpecification","ServiceSpecificationRole"],"to":["OperationalPerformer","OperationalRole"]},{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"Provides","from":["OperationalPerformer","OperationalRole"],"to":["ServiceSpecification","ServiceSpecificationRole"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"L4":[{"rel":"ActivityPerformableUnderCondition","from":["BusinessProcess"],"to":["ActualCondition"]},{"rel":"ActivitySupportsService","from":["OperationalActivity"],"to":["ServiceSpecification"]},{"rel":"ActsUpon","from":["OperationalActivity","OperationalActivityAction"],"to":["OperationalExchangeItem","PaperForm"]},{"rel":"AffectedActivity","from":["OperationalExchangeItem"],"to":["OperationalActivity"]},{"rel":"AffectedResource","from":["OperationalActivity"],"to":["OperationalExchangeItem"]},{"rel":"Consumes","from":["OperationalActivity","OperationalActivityAction"],"to":["ActualService","ServiceSpecification"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"L6":[{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]}],"L7":[{"rel":"Classified","from":["ArchitecturalDescription","DataElement","DocumentReference","InformationElement","ServiceSpecification"],"to":["Classification"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"L8":[{"rel":"ActualProjectConsults","from":["ActualProject"],"to":["Organization"]},{"rel":"ActualProjectDependency","from":["ActualProject"],"to":["ActualProject"]},{"rel":"ActualProjectInforms","from":["ActualProject"],"to":["Organization"]},{"rel":"ArbitraryConnector","from":["ConceptRole"],"to":["ConceptRole"]},{"rel":"ArchitectureForProject","from":["ActualProject","ActualProjectMilestone"],"to":["ArchitecturalDescription"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"IsAccountableFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"IsResponsibleFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"MilestoneDependency","from":["ActualProjectMilestone"],"to":["ActualProjectMilestone"]},{"rel":"OperationalExchange","from":["OperationalActivity"],"to":["OperationalActivity"]},{"rel":"OwnedMilestone","from":["ActualProject"],"to":["ActualProjectMilestone"]},{"rel":"ProjectMilestoneToProjectTheme","from":["ProjectMilestone"],"to":["ProjectTheme"]},{"rel":"ProjectSequence","from":["ActualProject"],"to":["ActualProject"]},{"rel":"RequiredResource","from":["ProjectMilestone"],"to":["ResourcePerformer"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"VersionReleased","from":["ActualProjectMilestone"],"to":["VersionedElement"]},{"rel":"VersionWithdrawn","from":["ActualProjectMilestone"],"to":["VersionedElement"]}],"P1":[{"rel":"DataElementStoredIn","from":["DataElement"],"to":["ResourcePerformer","ResourceRole"]},{"rel":"Forecast","from":["SubjectOfForecast"],"to":["SubjectOfForecast"]},{"rel":"ForecastPeriod","from":["Forecast"],"to":["ActualEnterprisePhase"]},{"rel":"FormStoredIn","from":["PaperForm"],"to":["Software"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"RequiresCompetence","from":["OrganizationalResource"],"to":["Competence"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"ServiceProvision","from":["ActualResource","ResourcePerformer","ResourceRole"],"to":["ActualService","ServiceSpecification","ServiceSpecificationRole"]}],"P2":[{"rel":"ActualProjectConsults","from":["ActualProject"],"to":["Organization"]},{"rel":"ActualProjectInforms","from":["ActualProject"],"to":["Organization"]},{"rel":"CompetenceForRole","from":["ResourceRole"],"to":["Competence"]},{"rel":"HostedOn","from":["ResourceArchitecture","ResourceArtifact","ResourceRole"],"to":["ResourceArchitecture","ResourceArtifact","ResourceRole"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"IsAccountableFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"IsResponsibleFor","from":["Organization"],"to":["ActualProject","ResourcePerformer","ServiceSpecification"]},{"rel":"LocationHolder","from":["LocationHolder"],"to":["Location"]},{"rel":"NeedsModificationOf","from":["ActualProject"],"to":["PhysicalResource","ResourceArchitecture","ResourceRole"]},{"rel":"NeedsResource","from":["ActualProject"],"to":["PhysicalResource","ResourceArchitecture","ResourceRole"]},{"rel":"PhysicalLocation","from":["LocationHolder"],"to":["ActualLocation"]},{"rel":"ProjectProvidesFunction","from":["ActualProject"],"to":["Function"]},{"rel":"ProjectSupportActivity","from":["ActualProject"],"to":["OperationalActivity"]},{"rel":"RequiredEnvironment","from":["LocationHolder"],"to":["ActualEnvironment"]},{"rel":"ResourceDependency","from":["ResourcePerformer","ResourcePort","ResourceRole"],"to":["ResourcePerformer","ResourcePort","ResourceRole"]},{"rel":"ResourceToServiceDependency","from":["ResourcePerformer","ResourceRole"],"to":["ServiceSpecification","ServiceSpecificationRole"]},{"rel":"Responsible","from":["ActualProject"],"to":["PhysicalResource","ResourceArchitecture","ResourceRole","ServiceSpecification"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"ServiceProvision","from":["ActualResource","ResourcePerformer","ResourceRole"],"to":["ActualService","ServiceSpecification","ServiceSpecificationRole"]}],"P3":[{"rel":"ImplementsProtocol","from":["ProtocolImplementation"],"to":["Protocol"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"P4":[{"rel":"AffectedFunctions","from":["ResourceExchangeItem"],"to":["Function"]},{"rel":"FunctionSubject","from":["Function"],"to":["ResourceExchangeItem"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"OwnsMeasurement","from":["MeasurableElement"],"to":["Measurement","MeasurementType"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"P7":[{"rel":"Classified","from":["ArchitecturalDescription","DataElement","DocumentReference","InformationElement","ServiceSpecification"],"to":["Classification"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]}],"P8":[{"rel":"ActualProjectDependency","from":["ActualProject"],"to":["ActualProject"]},{"rel":"FillsPost","from":["ActualPerson"],"to":["ActualPost"]},{"rel":"Implements","from":["DataElement","Function","InformationElement","OperationalActivity","OperationalActivityAction","OperationalConstraint","ResourceConnector","ResourceConstraint","ResourceExchange","ResourceInterface","ResourcePerformer","ResourceRole","ServicePolicy"],"to":["ActualEnduringTask","InformationElement","OperationalActivity","OperationalActivityAction","OperationalAgent","OperationalConnector","OperationalConstraint","OperationalExchange","OperationalInterface","OperationalRole","ResourceConnector","ServiceFunction","ServiceInterface","ServicePolicy","StrategicConstraint"]},{"rel":"JustifiedBy","from":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"],"to":["Reference"]},{"rel":"MilestoneDependency","from":["ActualProjectMilestone"],"to":["ActualProjectMilestone"]},{"rel":"OwnedMilestone","from":["ActualProject"],"to":["ActualProjectMilestone"]},{"rel":"ProjectMilestoneToProjectTheme","from":["ProjectMilestone"],"to":["ProjectTheme"]},{"rel":"ProjectSequence","from":["ActualProject"],"to":["ActualProject"]},{"rel":"RequiredResource","from":["ProjectMilestone"],"to":["ResourcePerformer"]},{"rel":"Satisfy","from":["Capability","OperationalActivityAction","ServiceSpecification","SubjectOfOperationalConstraint","SubjectOfResourceConstraint"],"to":["OperationalConstraint","ResourceConstraint","ServicePolicy","StrategicConstraint"]},{"rel":"SuccessorOf","from":["ResourcePerformer","ServiceSpecification","Standard"],"to":["ResourcePerformer","ServiceSpecification","Standard"]},{"rel":"VersionReleased","from":["ActualProjectMilestone"],"to":["VersionedElement"]},{"rel":"VersionSuccession","from":["VersionOfConfiguration"],"to":["VersionOfConfiguration"]},{"rel":"VersionWithdrawn","from":["ActualProjectMilestone"],"to":["VersionedElement"]}],"A1":[{"rel":"ArchitectureForProject","from":["ActualProject","ActualProjectMilestone"],"to":["ArchitecturalDescription"]},{"rel":"Classified","from":["ArchitecturalDescription","DataElement","DocumentReference","InformationElement","ServiceSpecification"],"to":["Classification"]},{"rel":"DescribedBy","from":["Architecture"],"to":["ArchitecturalDescription"]},{"rel":"Expresses","from":["Architecture"],"to":["ArchitecturalDescription"]}],"A2":[{"rel":"CompliesViewpoint","from":["View"],"to":["Viewpoint"]},{"rel":"ConcernForActualEnterprisePhase","from":["ActualEnterprisePhase"],"to":["Concern"]},{"rel":"ConcernForView","from":["View"],"to":["Concern"]},{"rel":"ConcernForViewpoint","from":["Viewpoint"],"to":["Concern"]},{"rel":"ViewpointToStakeholder","from":["Viewpoint"],"to":["Stakeholder"]},{"rel":"ViewpointsInArchitecturalDescription","from":["ArchitecturalDescription"],"to":["Viewpoint"]},{"rel":"ViewsInArchitecturalDescription","from":["ArchitecturalDescription"],"to":["View"]}],"A3":[{"rel":"ArchitecturalReference","from":["ArchitecturalDescription"],"to":["ArchitecturalDescription"]}],"A6":[{"rel":"ArchitecturalSequence","from":["ArchitecturalDescription"],"to":["ArchitecturalDescription"]}],"A7":[{"rel":"SameAs","from":["Software","UAFElement"],"to":["Software","UAFElement"]}],"A8":[{"rel":"ArchitecturalSequence","from":["ArchitecturalDescription"],"to":["ArchitecturalDescription"]},{"rel":"RatifiedStandards","from":["ActualOrganization"],"to":["Standard"]}],"R2":[{"rel":"PartOfCatalogue","from":["RequirementCategory"],"to":["RequirementCatalogue"]},{"rel":"PartOfCategory","from":["BWRequirement","RequirementCategory"],"to":["RequirementCategory"]}],"R3":[{"rel":"ConflictsWith","from":["BWRequirement"],"to":["BWRequirement"]},{"rel":"IsDuplicateOf","from":["BWRequirement"],"to":["BWRequirement"]},{"rel":"Refines","from":["BWRequirement"],"to":["BWRequirement"]},{"rel":"Replaces","from":["BWRequirement"],"to":["BWRequirement"]},{"rel":"Requires","from":["BWRequirement"],"to":["BWRequirement"]},{"rel":"StemsFrom","from":["BWRequirement"],"to":["BWRequirement"]}],"R7":[{"rel":"DerivedFrom","from":["BWRequirement"],"to":["UAFElement"]},{"rel":"ToBeRealizedBy","from":["BWRequirement"],"to":["DataElement","Function","Measurement","MeasurementType","Protocol","Protocolstack","ResourcePerformer","ResourcePort","ResourceRole","ServiceFunction","ServiceInterface","ServiceSpecification","ServiceSpecificationRole","Standard"]}],"R8":[{"rel":"Evaluates","from":["FulfilmentCriterion"],"to":["FitCriterion"]},{"rel":"RealiseRequirement","from":["DataElement","Function","Measurement","MeasurementType","Protocol","Protocolstack","ResourcePerformer","ResourcePort","ResourceRole","ServiceFunction","ServiceInterface","ServiceSpecification","ServiceSpecificationRole","Standard"],"to":["BWRequirement"]}]}};

</script>
<script>
/* ADMBw QEA Analyzer v4.0 — Teil 1: Kern, Suche, Paket-Explorer, Sichten-Katalog, PNG- & XLSX-Export */
/* global qeaOpen, ADMBW_DATA */

var DB = null, OBJS = {}, CONS = [], PKG = {}, PKG_ROOTS = [], PKG_OPEN = {};
var DIAGS = [], DIAGMAP = {}, DIAGOBJ = {}, DIAGLINK = {}, OBJ_DIAGS = {};
var VPSTAT = {}, TAGS = {}, CONNCOUNT = {};
var CURVP = null, CURPKG = null, CURDIAG = null, CURVIEW = 'explorer', MODELLNAME = '';
var PKG_DEEP = true;
var CURDATA = { els: [], rels: [], diags: [] };
var VPMODE = 'list';
var SEARCH_SCOPE = 'all', GLOBHITS = [];
var DIAG_FILTER = { q: '', pkg: '', layer: 'all' };
var EXPCTX = null, PRINTCTX = '';
var G = {
  vp: null, built: false, baseNodes: [], baseLinks: [], viewNodes: [], viewLinks: [],
  nbr: {}, pos: {}, focus: null, fset: null, vb: null, simTimer: null,
  mode: 'vp', root: null, key: null, hops: 1, capped: false, keepFilters: false,
  layout: 'force', lblMode: 'auto', showEdgeLbl: false,
  f: { q: '', types: {}, rels: {}, only: true, maxN: 120, hops: 0 }
};

/* ---------- Basis-Helfer ---------- */
function el(id) { return document.getElementById(id); }
function decodeEntities(s) {
  s = String(s == null ? '' : s);
  if (s.indexOf('&') < 0) return s;
  var map = { amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ', auml: 'ä', ouml: 'ö', uuml: 'ü', Auml: 'Ä', Ouml: 'Ö', Uuml: 'Ü', szlig: 'ß', ndash: '–', mdash: '—', bull: '•', euro: '€' };
  return s
    .replace(/&#(\d+);/g, function (_, d) { var c = parseInt(d, 10); return c ? String.fromCharCode(c) : ''; })
    .replace(/&#x([0-9a-fA-F]+);/g, function (_, h) { var c = parseInt(h, 16); return c ? String.fromCharCode(c) : ''; })
    .replace(/&([a-zA-Z]+);/g, function (m, k) { return map.hasOwnProperty(k) ? map[k] : m; });
}
function cleanNote(s) {
  s = decodeEntities(String(s == null ? '' : s));
  s = s.replace(/<br\s*\/?>/gi, '\n').replace(/<\/p>/gi, '\n').replace(/<[^>]+>/g, '');
  return decodeEntities(s).replace(/\r\n/g, '\n').replace(/\n{3,}/g, '\n\n').trim();
}
function esc(s) { return String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;'); }
function norm(s) { return decodeEntities(String(s == null ? '' : s)).replace(/\s+/g, ' ').trim(); }
function fmt(n) { return String(n || 0).replace(/\B(?=(\d{3})+(?!\d))/g, '.'); }
function pad2(n) { return (n < 10 ? '0' : '') + n; }
function dateStamp() {
  var d = new Date();
  return d.getFullYear() + '-' + pad2(d.getMonth() + 1) + '-' + pad2(d.getDate());
}
function dateTimeDE() {
  var d = new Date();
  return pad2(d.getDate()) + '.' + pad2(d.getMonth() + 1) + '.' + d.getFullYear() + ' ' + pad2(d.getHours()) + ':' + pad2(d.getMinutes());
}
function safeName(s) { return String(s || 'Export').replace(/\.[a-z0-9]+$/i, '').replace(/[^\wäöüÄÖÜß\-]+/g, '_').replace(/^_+|_+$/g, '').substring(0, 60) || 'Export'; }
function findUp(node, cls) {
  while (node && node !== document) {
    if (node.className && typeof node.className === 'string' && (' ' + node.className + ' ').indexOf(' ' + cls + ' ') >= 0) return node;
    if (node.getAttribute && node.getAttribute('class') && (' ' + node.getAttribute('class') + ' ').indexOf(' ' + cls + ' ') >= 0) return node;
    node = node.parentNode;
  }
  return null;
}
function shortLabel(s, max) {
  s = String(s || '');
  return s.length > max ? s.substring(0, max - 1) + '…' : s;
}
function qcol(row, name) {
  if (row == null) return undefined;
  var v = row[name];
  if (v !== undefined) return v;
  var ln = String(name).toLowerCase(), ln2 = ln.replace(/_/g, '');
  for (var k in row) {
    if (!Object.prototype.hasOwnProperty.call(row, k)) continue;
    var lk = String(k).toLowerCase();
    if (lk === ln || lk.replace(/_/g, '') === ln2) return row[k];
  }
  return undefined;
}

/* ---------- Architektur-Schicht & Farblogik (prägnante EAM-Farben) ---------- */
function archCategory(st) {
  var s = String(st || '').toLowerCase();
  if (!s) return 'other';
  if (/capability|vision|enterprise|goal|strategic|concept/.test(s)) return 'concept';
  if (/service/.test(s)) return 'service';
  if (/node|activity|process|logical|information|business|rule|state|exchange|role/.test(s)) return 'logical';
  if (/system|resource|physical|software|artifact|hardware|device|network|platform|protocol|data|application|port|interface/.test(s)) return 'physical';
  if (/project|milestone|workpackage|roadmap|configuration/.test(s)) return 'project';
  if (/requirement|constraint|standard|measurement|measurable|property|stakeholder|concern|viewpoint|architecture/.test(s)) return 'req';
  if (/organization|person|post|actor/.test(s)) return 'org';
  return 'other';
}
/* Farben gemäß ADMBw/NAFv4: color = Schichtfarbe (Header/Rand), fill = heller Elementton.
   Quellen: NAFv4.1 Fig. 18; Bw „Grundlagen Methode Architektur nach NAFv4“ Abb. 36 (S. 58);
   Bw „Verwendung des ADMBw im Sparx EA“ Abb. 35 (S. 42) — siehe docs/ADMBw-Farben.md */
var CAT_META = {
  concept:  { label: 'Konzepte & Fähigkeiten', color: '#C8D300', fill: '#F6FF5D', rank: 0 },
  service:  { label: 'Dienste (Services)',     color: '#CE8ABB', fill: '#E7C7DE', rank: 1 },
  logical:  { label: 'Logik & Prozesse',       color: '#66B2E4', fill: '#B2D8F1', rank: 2 },
  org:      { label: 'Organisation & Akteure', color: '#EF7D00', fill: '#FFCA90', rank: 3 },
  physical: { label: 'Systeme & Ressourcen',   color: '#EF7D00', fill: '#FFCA90', rank: 3 },
  project:  { label: 'Projekte & Roadmap',     color: '#66B2E4', fill: '#B2D8F1', rank: 4 },
  req:      { label: 'Anforderungen & Normen', color: '#C9C9C9', fill: '#EDEDED', rank: 4 },
  other:    { label: 'Weitere Elemente',       color: '#DADADA', fill: '#F2F2F2', rank: 3 }
};
function stColor(st) {
  var cat = archCategory(st);
  return (CAT_META[cat] && CAT_META[cat].color) || '#64748B';
}
function stFill(st) {
  var cat = archCategory(st);
  return (CAT_META[cat] && CAT_META[cat].fill) || '#F2F2F2';
}

/* ================================================================
   NATIVER EXCEL (.XLSX) GENERATOR (OpenXML ZIP, 100 % Offline)
   ================================================================ */
var _CRC_TABLE = null;
function crc32(u8) {
  if (!_CRC_TABLE) {
    _CRC_TABLE = new Uint32Array(256);
    for (var n = 0; n < 256; n++) {
      var c = n;
      for (var k = 0; k < 8; k++) c = (c & 1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1);
      _CRC_TABLE[n] = c >>> 0;
    }
  }
  var crc = 0xFFFFFFFF;
  for (var i = 0; i < u8.length; i++) crc = _CRC_TABLE[(crc ^ u8[i]) & 0xFF] ^ (crc >>> 8);
  return (crc ^ 0xFFFFFFFF) >>> 0;
}
function utf8Bytes(str) {
  if (typeof TextEncoder !== 'undefined') return new TextEncoder().encode(String(str));
  var s = unescape(encodeURIComponent(String(str))), arr = new Uint8Array(s.length);
  for (var i = 0; i < s.length; i++) arr[i] = s.charCodeAt(i);
  return arr;
}
function makeZipStore(files) {
  /* files: [{name: 'xl/workbook.xml', data: Uint8Array}] */
  var localParts = [], centralParts = [], offset = 0, i;
  for (i = 0; i < files.length; i++) {
    var nameBytes = utf8Bytes(files[i].name);
    var data = files[i].data;
    var crc = crc32(data);
    var lh = new Uint8Array(30 + nameBytes.length);
    var dv = new DataView(lh.buffer);
    dv.setUint32(0, 0x04034b50, true);
    dv.setUint16(4, 20, true);
    dv.setUint16(6, 0x0800, true); /* UTF-8 flag */
    dv.setUint16(8, 0, true);      /* STORE (0) */
    dv.setUint16(10, 0, true);
    dv.setUint16(12, 0x5421, true);
    dv.setUint32(14, crc, true);
    dv.setUint32(18, data.length, true);
    dv.setUint32(22, data.length, true);
    dv.setUint16(26, nameBytes.length, true);
    dv.setUint16(28, 0, true);
    lh.set(nameBytes, 30);
    localParts.push(lh, data);

    var ch = new Uint8Array(46 + nameBytes.length);
    var cdv = new DataView(ch.buffer);
    cdv.setUint32(0, 0x02014b50, true);
    cdv.setUint16(4, 20, true);
    cdv.setUint16(6, 20, true);
    cdv.setUint16(8, 0x0800, true);
    cdv.setUint16(10, 0, true);
    cdv.setUint16(12, 0, true);
    cdv.setUint16(14, 0x5421, true);
    cdv.setUint32(16, crc, true);
    cdv.setUint32(20, data.length, true);
    cdv.setUint32(24, data.length, true);
    cdv.setUint16(28, nameBytes.length, true);
    cdv.setUint16(30, 0, true);
    cdv.setUint16(32, 0, true);
    cdv.setUint16(34, 0, true);
    cdv.setUint16(36, 0, true);
    cdv.setUint32(38, 0, true);
    cdv.setUint32(42, offset, true);
    ch.set(nameBytes, 46);
    centralParts.push(ch);

    offset += lh.length + data.length;
  }
  var centralSize = 0;
  for (i = 0; i < centralParts.length; i++) centralSize += centralParts[i].length;
  var eocd = new Uint8Array(22);
  var edv = new DataView(eocd.buffer);
  edv.setUint32(0, 0x06054b50, true);
  edv.setUint16(4, 0, true);
  edv.setUint16(6, 0, true);
  edv.setUint16(8, files.length, true);
  edv.setUint16(10, files.length, true);
  edv.setUint32(12, centralSize, true);
  edv.setUint32(16, offset, true);
  edv.setUint16(20, 0, true);
  return new Blob(localParts.concat(centralParts, [eocd]), {
    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  });
}
function xmlEsc(s) {
  return String(s == null ? '' : s)
    .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, '')
    .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
function colLetters(idx) {
  var s = '', n = idx + 1;
  while (n > 0) { var m = (n - 1) % 26; s = String.fromCharCode(65 + m) + s; n = Math.floor((n - 1) / 26); }
  return s;
}
function buildWorksheetXml(rows, colWidths, hasHeader) {
  var xml = [];
  xml.push('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
  xml.push('<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">');
  if (colWidths && colWidths.length) {
    xml.push('<cols>');
    for (var c = 0; c < colWidths.length; c++) {
      xml.push('<col min="' + (c + 1) + '" max="' + (c + 1) + '" width="' + colWidths[c] + '" customWidth="1"/>');
    }
    xml.push('</cols>');
  }
  xml.push('<sheetData>');
  for (var r = 0; r < rows.length; r++) {
    var row = rows[r];
    var rnum = r + 1;
    var ht = (r === 0 && hasHeader) ? ' ht="24" customHeight="1"' : '';
    xml.push('<row r="' + rnum + '"' + ht + '>');
    for (var j = 0; j < row.length; j++) {
      var val = row[j];
      var ref = colLetters(j) + rnum;
      var style = (r === 0 && hasHeader) ? 1 : (r % 2 === 1 ? 2 : 3);
      if (typeof val === 'number' && isFinite(val)) {
        xml.push('<c r="' + ref + '" s="' + style + '"><v>' + val + '</v></c>');
      } else {
        xml.push('<c r="' + ref + '" t="inlineStr" s="' + style + '"><is><t xml:space="preserve">' + xmlEsc(val) + '</t></is></c>');
      }
    }
    xml.push('</row>');
  }
  xml.push('</sheetData>');
  if (hasHeader && rows.length > 1 && rows[0].length > 0) {
    xml.push('<autoFilter ref="A1:' + colLetters(rows[0].length - 1) + rows.length + '"/>');
  }
  xml.push('</worksheet>');
  return xml.join('');
}
function downloadXLSX(filename, sheets) {
  /* sheets: [{name, rows, widths, hasHeader}] */
  var files = [];
  var ct = ['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
    '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">',
    '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>',
    '<Default Extension="xml" ContentType="application/xml"/>',
    '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>',
    '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>'];
  var wbXml = ['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
    '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets>'];
  var wbRels = ['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
    '<Relationship Id="rIdStyles" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>'];

  for (var i = 0; i < sheets.length; i++) {
    var idx = i + 1;
    var sname = String(sheets[i].name || ('Blatt' + idx)).replace(/[\\/?*\[\]:]/g, '_').substring(0, 31);
    ct.push('<Override PartName="/xl/worksheets/sheet' + idx + '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>');
    wbXml.push('<sheet name="' + xmlEsc(sname) + '" sheetId="' + idx + '" r:id="rId' + idx + '"/>');
    wbRels.push('<Relationship Id="rId' + idx + '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet' + idx + '.xml"/>');
    var wsStr = buildWorksheetXml(sheets[i].rows || [[]], sheets[i].widths || [], sheets[i].hasHeader !== false);
    files.push({ name: 'xl/worksheets/sheet' + idx + '.xml', data: utf8Bytes(wsStr) });
  }
  ct.push('</Types>');
  wbXml.push('</sheets></workbook>');
  wbRels.push('</Relationships>');

  var rootRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>';
  var stylesXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
    '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' +
    '<fonts count="2">' +
      '<font><sz val="10"/><color rgb="FF1E293B"/><name val="Segoe UI"/></font>' +
      '<font><b/><sz val="10.5"/><color rgb="FFFFFFFF"/><name val="Segoe UI"/></font>' +
    '</fonts>' +
    '<fills count="4">' +
      '<fill><patternFill patternType="none"/></fill>' +
      '<fill><patternFill patternType="gray125"/></fill>' +
      '<fill><patternFill patternType="solid"><fgColor rgb="FF004471"/></patternFill></fill>' +
      '<fill><patternFill patternType="solid"><fgColor rgb="FFF8FAFC"/></patternFill></fill>' +
    '</fills>' +
    '<borders count="2">' +
      '<border><left/><right/><top/><bottom/><diagonal/></border>' +
      '<border><left style="thin"><color rgb="FFCBD5E1"/></left><right style="thin"><color rgb="FFCBD5E1"/></right><top style="thin"><color rgb="FFCBD5E1"/></top><bottom style="thin"><color rgb="FFCBD5E1"/></bottom><diagonal/></border>' +
    '</borders>' +
    '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>' +
    '<cellXfs count="4">' +
      '<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>' +
      '<xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment vertical="center" wrapText="1"/></xf>' +
      '<xf numFmtId="0" fontId="0" fillId="0" borderId="1" xfId="0" applyFont="1" applyBorder="1" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf>' +
      '<xf numFmtId="0" fontId="0" fillId="3" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf>' +
    '</cellXfs>' +
    '</styleSheet>';

  files.unshift(
    { name: '[Content_Types].xml', data: utf8Bytes(ct.join('')) },
    { name: '_rels/.rels', data: utf8Bytes(rootRels) },
    { name: 'xl/workbook.xml', data: utf8Bytes(wbXml.join('')) },
    { name: 'xl/_rels/workbook.xml.rels', data: utf8Bytes(wbRels.join('')) },
    { name: 'xl/styles.xml', data: utf8Bytes(stylesXml) }
  );

  var blob = makeZipStore(files);
  var url = URL.createObjectURL(blob);
  var a = document.createElement('a');
  a.href = url; a.download = filename;
  document.body.appendChild(a); a.click();
  setTimeout(function () { document.body.removeChild(a); URL.revokeObjectURL(url); }, 250);
}

function exportDataAsXLSX(els, rels, contextLabel, contextKind, fnameBase) {
  var i, o, c;
  var ovRows = [
    ['Eigenschaft', 'Wert'],
    ['Anwendung', 'ADMBw QEA Analyzer v4.0'],
    ['Exportierte Sicht / Bereich', contextLabel || 'Architektur-Auswertung'],
    ['Art des Exports', contextKind || 'Sicht'],
    ['Geladenes Modell (.qea)', MODELLNAME || '—'],
    ['Export-Zeitpunkt', dateTimeDE()],
    ['Anzahl Elemente in dieser Sicht', els.length],
    ['Anzahl Beziehungen in dieser Sicht', rels.length]
  ];
  /* Verteilung der Elementtypen ergänzen */
  var tc = {}, types = [];
  for (i = 0; i < els.length; i++) {
    var st = els[i].st || '(ohne Stereotyp)';
    tc[st] = (tc[st] || 0) + 1;
  }
  for (var k in tc) if (tc.hasOwnProperty(k)) types.push(k);
  types.sort(function (a, b) { return tc[b] - tc[a]; });
  if (types.length) {
    ovRows.push(['', '']);
    ovRows.push(['Elementtyp (Stereotype)', 'Anzahl in dieser Sicht']);
    for (i = 0; i < types.length; i++) ovRows.push([types[i], tc[types[i]]]);
  }

  var elRows = [['Name', 'Stereotype', 'EA-Metatyp', 'Alias', 'Paketpfad', 'Verbindungen (Gesamt)', 'Auf Sichten (Diagrammen)', 'Beschreibung / Notiz']];
  var tagRows = [['Element-Name', 'Stereotype', 'Eigenschaft (Tagged Value)', 'Wert', 'Notiz']];
  for (i = 0; i < els.length; i++) {
    o = els[i];
    var dlist = OBJ_DIAGS[String(o.id)] || [];
    var dnames = [];
    for (var d = 0; d < dlist.length && d < 10; d++) {
      if (DIAGMAP[dlist[d]]) dnames.push(DIAGMAP[dlist[d]].name);
    }
    elRows.push([
      o.name || '', o.st || '', o.type || '', o.alias || '', o.pkg || '',
      CONNCOUNT[String(o.id)] || 0,
      dnames.join(' | ') + (dlist.length > 10 ? ' (+' + (dlist.length - 10) + ')' : ''),
      shortLabel(o.note || '', 500)
    ]);
    var tlist = TAGS[String(o.id)] || [];
    for (var t = 0; t < tlist.length; t++) {
      tagRows.push([o.name || '', o.st || '', tlist[t].p || '', tlist[t].v || '', tlist[t].n || '']);
    }
  }

  var relRows = [['Quelle (Start)', 'Quelle-Stereotype', 'Beziehung (Stereotype)', 'Beziehungsname', 'Ziel (Ende)', 'Ziel-Stereotype']];
  for (i = 0; i < rels.length; i++) {
    c = rels[i];
    var a = OBJS[c.a], b = OBJS[c.b];
    relRows.push([
      a ? a.name : '?', a ? a.st : '',
      c.st || '(Verbindung)', c.name || '',
      b ? b.name : '?', b ? b.st : ''
    ]);
  }

  var sheets = [
    { name: '1_Uebersicht', rows: ovRows, widths: [36, 68], hasHeader: true },
    { name: '2_Elemente (' + els.length + ')', rows: elRows, widths: [34, 24, 15, 18, 42, 16, 36, 48], hasHeader: true },
    { name: '3_Beziehungen (' + rels.length + ')', rows: relRows, widths: [34, 22, 24, 20, 34, 22], hasHeader: true }
  ];
  if (tagRows.length > 1) {
    sheets.push({ name: '4_Tagged_Values', rows: tagRows, widths: [32, 22, 28, 42, 32], hasHeader: true });
  }
  var fn = 'ADMBw_QEA-Analyzer_' + safeName(fnameBase || contextLabel) + '_' + safeName(MODELLNAME) + '_' + dateStamp() + '.xlsx';
  downloadXLSX(fn, sheets);
}

function exportCurrentXLSX() {
  if (VPMODE === 'graph' && G.built && G.viewNodes.length) {
    exportGraphXLSX();
    return;
  }
  var lbl = (EXPCTX && EXPCTX.label) || PRINTCTX || 'Architektur-Sicht';
  var knd = (EXPCTX && EXPCTX.kind) || 'Sicht';
  var fnb = (EXPCTX && EXPCTX.fname) || lbl;
  exportDataAsXLSX(CURDATA.els || [], CURDATA.rels || [], lbl, knd, fnb);
}

function exportGraphXLSX() {
  var els = [], i;
  for (i = 0; i < G.viewNodes.length; i++) {
    var o = OBJS[G.viewNodes[i].id];
    if (o) els.push(o);
  }
  var rels = [];
  for (i = 0; i < G.viewLinks.length; i++) {
    rels.push({ a: G.viewLinks[i].a, b: G.viewLinks[i].b, st: G.viewLinks[i].st, name: '' });
  }
  var lbl = ((EXPCTX && EXPCTX.label) || 'Graph') + ' (Gefilterter Graph: ' + els.length + ' Knoten)';
  exportDataAsXLSX(els, rels, lbl, 'Graph-Visualisierung', 'Graph_' + ((EXPCTX && EXPCTX.fname) || 'Ansicht'));
}

function exportDiagramXLSX(diagId) {
  var diag = DIAGMAP[diagId];
  if (!diag) return;
  var ddata = getDiagramData(diagId);
  exportDataAsXLSX(ddata.els, ddata.rels, 'Sicht: ' + diag.name + ' (' + diag.pkgPath + ')', 'Einzel-Sicht (Diagramm)', 'Sicht_' + diag.name);
}

/* ================================================================
   HOCHAUFLÖSENDER PNG-EXPORT FÜR JEDE SICHT & JEDEN GRAPHEN
   ================================================================ */
function exportSvgElementToPNG(svgEl, titleText, subText, filename) {
  if (!svgEl) {
    alert('In der aktuellen Ansicht ist kein Schaubild oder Graph zum PNG-Export sichtbar.\nTipp: Öffnen Sie eine Sicht mit Diagramm oder schalten Sie auf „◉ Zusammenhänge (Graph)“.');
    return;
  }
  var clone = svgEl.cloneNode(true);
  var vbAttr = clone.getAttribute('viewBox');
  var vb = [0, 0, 1200, 800];
  if (vbAttr) {
    var parts = vbAttr.trim().split(/[\s,]+/);
    if (parts.length === 4) vb = [parseFloat(parts[0]) || 0, parseFloat(parts[1]) || 0, parseFloat(parts[2]) || 1200, parseFloat(parts[3]) || 800];
  } else {
    vb = [0, 0, parseFloat(clone.getAttribute('width')) || 1200, parseFloat(clone.getAttribute('height')) || 800];
  }

  /* Inline-Styles für Standalone-SVG-Rendering im Image/Canvas einbetten */
  var styleEl = document.createElementNS('http://www.w3.org/2000/svg', 'style');
  styleEl.textContent =
    'text { font-family: "Segoe UI", Arial, Helvetica, sans-serif; } ' +
    '.gk { stroke:#94A3B8; stroke-width:1.4px; opacity:.82; } ' +
    '.gk.hi { stroke:#B45309; stroke-width:2.5px; opacity:1; } ' +
    '.gk-lbl { font-size:8.5px; fill:#475569; paint-order:stroke; stroke:#FFFFFF; stroke-width:3px; } ' +
    '.gn text.nlbl { font-size:11px; font-weight:600; fill:#0F172A; paint-order:stroke; stroke:#FFFFFF; stroke-width:3.2px; } ' +
    '.gn text.nst { font-size:8.5px; fill:#475569; paint-order:stroke; stroke:#FFFFFF; stroke-width:2.5px; } ' +
    '.gn .nshape { stroke-width:2px; } ' +
    '.gn.fdim { opacity:.15; } ' +
    '.gn.fsel .nshape { stroke:#B45309; stroke-width:3px; }';
  clone.insertBefore(styleEl, clone.firstChild);

  var targetW = Math.max(960, Math.min(2600, Math.round(vb[2] * 1.4)));
  var targetH = Math.max(540, Math.min(2200, Math.round(vb[3] * 1.4)));
  clone.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
  clone.setAttribute('width', String(targetW));
  clone.setAttribute('height', String(targetH));

  var xml = new XMLSerializer().serializeToString(clone);
  var svgBlob = new Blob([xml], { type: 'image/svg+xml;charset=utf-8' });
  var url = URL.createObjectURL(svgBlob);
  var img = new Image();
  img.onload = function () {
    var scale = 2; /* 2x Retina-Qualität */
    var headerH = 58;
    var pad = 20;
    var canvas = document.createElement('canvas');
    canvas.width = (targetW + pad * 2) * scale;
    canvas.height = (targetH + headerH + pad * 2) * scale;
    var ctx = canvas.getContext('2d');
    ctx.scale(scale, scale);

    /* Weißer Hintergrund */
    ctx.fillStyle = '#FFFFFF';
    ctx.fillRect(0, 0, targetW + pad * 2, targetH + headerH + pad * 2);

    /* Kopfbalken im Bw-Design */
    ctx.fillStyle = '#004471';
    ctx.fillRect(0, 0, targetW + pad * 2, headerH - 4);
    ctx.fillStyle = '#B45309';
    ctx.fillRect(0, headerH - 4, targetW + pad * 2, 4);

    ctx.fillStyle = '#FFFFFF';
    ctx.font = 'bold 16px "Segoe UI", Arial, sans-serif';
    ctx.fillText(String(titleText || 'ADMBw Architektur-Sicht').substring(0, 110), 18, 24);

    ctx.fillStyle = '#D2E3EE';
    ctx.font = '12px "Segoe UI", Arial, sans-serif';
    var metaLine = (subText ? subText + '  ·  ' : '') + 'Modell: ' + (MODELLNAME || '—') + '  ·  Export: ' + dateTimeDE();
    ctx.fillText(metaLine.substring(0, 150), 18, 43);

    /* SVG-Grafik zeichnen */
    ctx.drawImage(img, pad, headerH + pad / 2, targetW, targetH);
    URL.revokeObjectURL(url);

    if (canvas.toBlob) {
      canvas.toBlob(function (pngBlob) {
        if (!pngBlob) return;
        var purl = URL.createObjectURL(pngBlob);
        var a = document.createElement('a');
        a.href = purl;
        a.download = filename || ('ADMBw_Sicht_' + dateStamp() + '.png');
        document.body.appendChild(a);
        a.click();
        setTimeout(function () { document.body.removeChild(a); URL.revokeObjectURL(purl); }, 250);
      }, 'image/png');
    } else {
      var durl = canvas.toDataURL('image/png');
      var a2 = document.createElement('a');
      a2.href = durl;
      a2.download = filename || ('ADMBw_Sicht_' + dateStamp() + '.png');
      document.body.appendChild(a2);
      a2.click();
      setTimeout(function () { document.body.removeChild(a2); }, 250);
    }
  };
  img.onerror = function () {
    URL.revokeObjectURL(url);
    alert('PNG-Rendering fehlgeschlagen.');
  };
  img.src = url;
}

function exportDiagramPNG(diagId) {
  var diag = DIAGMAP[diagId];
  if (!diag) return;
  var host = el('diag-' + diagId);
  var svg = host ? host.querySelector('svg') : null;
  if (!svg) {
    var off = el('offscreen-render');
    off.innerHTML = '<div id="off-diag"></div>';
    renderDiagram(diag, el('off-diag'));
    svg = off.querySelector('svg');
  }
  if (!svg) {
    alert('Dieses Diagramm enthält keine darstellbaren Geometrie-Elemente.');
    return;
  }
  var fn = 'ADMBw_QEA-Analyzer_Sicht_' + safeName(diag.name) + '_' + dateStamp() + '.png';
  exportSvgElementToPNG(svg, 'Sicht: ' + diag.name, 'Paket: ' + (diag.pkgPath || '—'), fn);
}

function exportGraphPNG() {
  var svg = el('gsvg');
  if (!svg) {
    alert('Bitte zuerst die Graph-Ansicht öffnen.');
    return;
  }
  var lbl = (EXPCTX && EXPCTX.label) || PRINTCTX || 'Architektur-Graph';
  var fn = 'ADMBw_QEA-Analyzer_Graph_' + safeName(lbl) + '_' + dateStamp() + '.png';
  exportSvgElementToPNG(svg, 'Architektur-Graph: ' + lbl, G.viewNodes.length + ' Knoten · ' + G.viewLinks.length + ' Beziehungen', fn);
}

function exportCurrentPNG() {
  if (VPMODE === 'graph' && el('gsvg')) {
    exportGraphPNG();
    return;
  }
  /* Prüfen, ob in der aktuellen Ansicht ein Diagramm-SVG sichtbar ist */
  var visibleSvg = document.querySelector('#vp svg, #pkgmain svg');
  if (visibleSvg) {
    if (visibleSvg.id === 'gsvg') { exportGraphPNG(); return; }
    var lbl = (EXPCTX && EXPCTX.label) || PRINTCTX || 'Architektur-Sicht';
    exportSvgElementToPNG(visibleSvg, lbl, (EXPCTX && EXPCTX.kind) || '', 'ADMBw_QEA-Analyzer_' + safeName(lbl) + '_' + dateStamp() + '.png');
    return;
  }
  /* Wenn nicht im Graph-Modus und kein Diagramm offen: Graph kurz initialisieren oder Hinweis */
  if (CURDATA && CURDATA.els && CURDATA.els.length) {
    setVPMode('graph');
    setTimeout(function () {
      if (el('gsvg')) exportGraphPNG();
    }, 350);
  } else {
    alert('Bitte öffnen Sie eine Sicht (Diagramm) oder wechseln Sie in die Graph-Ansicht, um ein PNG zu exportieren.');
  }
}

/* ---------- CSV & PDF Export (kompatibel zu v2) ---------- */
function downloadText(filename, text) {
  try {
    var blob = new Blob([text], { type: 'text/csv;charset=utf-8;' });
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    a.href = url; a.download = filename;
    document.body.appendChild(a); a.click();
    setTimeout(function () { document.body.removeChild(a); URL.revokeObjectURL(url); }, 120);
  } catch (e) {
    var enc = encodeURIComponent(text);
    window.open('data:text/csv;charset=utf-8,' + enc);
  }
}
function csvQ(v) {
  v = String(v == null ? '' : v);
  if (v.indexOf(';') >= 0 || v.indexOf('"') >= 0 || v.indexOf('\n') >= 0 || v.indexOf('\r') >= 0) {
    return '"' + v.replace(/"/g, '""') + '"';
  }
  return v;
}
function exportElementsCSV() {
  if (!EXPCTX) return;
  var rows = [], i, o;
  for (i = 0; i < CURDATA.els.length; i++) {
    o = CURDATA.els[i];
    rows.push([o.name, o.st, o.alias, o.pkg]);
  }
  var lines = [];
  lines.push('sep=;');
  lines.push('ADMBw QEA Analyzer — Elemente;' + csvQ(EXPCTX.label));
  lines.push('Umfang;' + csvQ(EXPCTX.kind));
  lines.push('Modell;' + csvQ(MODELLNAME));
  lines.push('Export;' + csvQ(dateTimeDE()));
  lines.push('');
  lines.push(['Name', 'Stereotype', 'Alias', 'Paketpfad'].join(';'));
  for (i = 0; i < rows.length; i++) {
    var r = rows[i], out = [];
    for (var j = 0; j < r.length; j++) out.push(csvQ(r[j]));
    lines.push(out.join(';'));
  }
  downloadText('ADMBw_QEA-Analyzer_' + safeName(EXPCTX.fname) + '_Elemente_' + safeName(MODELLNAME) + '_' + dateStamp() + '.csv', '\ufeff' + lines.join('\r\n'));
}
function exportRelsCSV() {
  if (!EXPCTX) return;
  var lines = [], i;
  lines.push('sep=;');
  lines.push('ADMBw QEA Analyzer — Beziehungen;' + csvQ(EXPCTX.label));
  lines.push('Umfang;' + csvQ(EXPCTX.kind));
  lines.push('Modell;' + csvQ(MODELLNAME));
  lines.push('Export;' + csvQ(dateTimeDE()));
  lines.push('');
  lines.push(['Quelle', 'Quelle-Stereotype', 'Beziehung', 'Ziel', 'Ziel-Stereotype'].join(';'));
  for (i = 0; i < CURDATA.rels.length; i++) {
    var c = CURDATA.rels[i];
    var a = OBJS[c.a], b = OBJS[c.b];
    lines.push([csvQ(a ? a.name : '?'), csvQ(a ? a.st : ''), csvQ(c.st), csvQ(b ? b.name : '?'), csvQ(b ? b.st : '')].join(';'));
  }
  downloadText('ADMBw_QEA-Analyzer_' + safeName(EXPCTX.fname) + '_Beziehungen_' + safeName(MODELLNAME) + '_' + dateStamp() + '.csv', '\ufeff' + lines.join('\r\n'));
}
function exportPDF() {
  updatePrintMeta();
  window.print();
}
function updatePrintMeta() {
  var m = el('printmeta');
  if (!m) return;
  m.innerHTML = '<div class="pm-title">ADMBw QEA Analyzer</div>' +
    '<div class="pm-sub">' + esc(PRINTCTX || '—') + ' &nbsp;·&nbsp; Modell: ' + esc(MODELLNAME) + ' &nbsp;·&nbsp; Stand: ' + esc(dateTimeDE()) + '</div>';
}

/* ================================================================
   MODELL LADEN & PAKET-/SICHTEN-STRUKTUR AUFBAUEN
   ================================================================ */
function loadQea(buffer, name) {
  try {
    DB = qeaOpen(buffer);
  } catch (e) {
    alert('Datei konnte nicht gelesen werden:\n\n' + e.message + '\n\nUnterstützt werden QEA-/EAPX-Dateien im SQLite-Format (Sparx Enterprise Architect).');
    return;
  }
  MODELLNAME = name;
  G.built = false;
  buildModel();
  if (!Object.keys(OBJS).length && !DIAGS.length && !Object.keys(PKG).length) {
    alert('In der Datei wurde keine Sparx-EA-Struktur gefunden (Kern-Tabelle t_object fehlt oder ist leer).');
    return;
  }
  if (typeof EDIT !== 'undefined' && EDIT.setSource) EDIT.setSource(buffer, name);
  var nPkg = Object.keys(PKG).length;
  el('upload').style.display = 'none';
  el('workspace').style.display = 'block';
  el('modellname').textContent = name;
  el('stats').innerHTML =
    '<b>' + fmt(nPkg) + '</b> Pakete &nbsp;·&nbsp; ' +
    '<b>' + fmt(DIAGS.length) + '</b> Sichten (Diagramme) &nbsp;·&nbsp; ' +
    '<b>' + fmt(Object.keys(OBJS).length) + '</b> Elemente &nbsp;·&nbsp; ' +
    '<b>' + fmt(CONS.length) + '</b> Beziehungen';
  if (el('cnt-pkg')) el('cnt-pkg').textContent = fmt(nPkg);
  if (el('cnt-diag')) el('cnt-diag').textContent = fmt(DIAGS.length);

  renderWarnbar();
  computeStats();
  renderQuickBar();
  renderGrid();
  renderDiagsCatalog();

  /* Verbindungs-/Pfadanalyse (v4.0): Zustand zurücksetzen und Reiter aufbauen */
  if (el('cnt-path')) el('cnt-path').textContent = fmt(CONS.length);
  PATH = { start: null, end: null, directed: false, maxHops: 5, mode: 'shortest', last: null, selPath: 0, ctx: false };
  PATH_ADJ = null; PATH_COMP = null;
  pathRenderTab();

  /* Standardmäßig Wurzelpaket im Explorer öffnen! */
  var startPkg = PKG_ROOTS.length ? PKG_ROOTS[0].id : null;
  if (startPkg != null) {
    PKG_OPEN[startPkg] = true;
    for (var i = 0; i < PKG_ROOTS[0].children.length; i++) {
      PKG_OPEN[PKG_ROOTS[0].children[i].id] = true;
    }
  }
  renderPkgTree();
  showView('explorer');
  if (startPkg != null) openPackage(startPkg, true);
}

function renderWarnbar() {
  var wb = el('warnbar');
  if (!wb) return;
  var need = ['t_object', 't_connector', 't_package', 't_diagram', 't_diagramobjects', 't_diagramlinks'];
  var labels = { t_object: 'Elemente (t_object)', t_connector: 'Beziehungen (t_connector)', t_package: 'Pakete (t_package)', t_diagram: 'Diagramme (t_diagram)', t_diagramobjects: 'Diagramm-Inhalte (t_diagramobjects)', t_diagramlinks: 'Diagramm-Links (t_diagramlinks)' };
  var missing = [], i;
  for (i = 0; i < need.length; i++) {
    if (!DB.hasTable(need[i])) missing.push(labels[need[i]]);
  }
  if (!missing.length) { wb.style.display = 'none'; wb.innerHTML = ''; return; }
  wb.innerHTML = '⚠ Hinweis: Diese Datei enthält nicht alle EA-Kerntabellen — fehlend: ' + esc(missing.join(', ')) + '. Die Auswertung läuft; einzelne Bereiche können eingeschränkt sein.';
  wb.style.display = 'block';
}

function detectViewpointPrefix(nm) {
  /* Erkennt sowohl "C1 : ...", "C1:S1 : ..." (-> C1-S1), "L4-P4 : ..." als auch Paketnamen */
  var m = String(nm || '').match(/^([A-Za-z]+[0-9]*(?:[\-:][A-Za-z]+[0-9]+)?)\s*:/);
  if (!m) return '';
  var p = m[1].replace(':', '-');
  if (ADMBW_DATA && ADMBW_DATA.vp && ADMBW_DATA.vp[p]) return p;
  /* Case-insensitive Abgleich gegen ADMBW_DATA.vp */
  for (var k in ADMBW_DATA.vp) {
    if (ADMBW_DATA.vp.hasOwnProperty(k) && k.toLowerCase() === p.toLowerCase()) return k;
  }
  return m[1];
}

function buildModel() {
  OBJS = {}; CONS = []; PKG = {}; PKG_ROOTS = []; PKG_OPEN = {};
  DIAGS = []; DIAGMAP = {}; DIAGOBJ = {}; DIAGLINK = {}; OBJ_DIAGS = {}; TAGS = {};

  var rows = DB.rows('t_package');
  var i, r;
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var pid = qcol(r, 'Package_ID');
    if (pid == null) continue;
    PKG[pid] = {
      id: pid,
      name: norm(qcol(r, 'Name')) || ('Paket ' + pid),
      parent: qcol(r, 'Parent_ID') || 0,
      tpos: parseInt(qcol(r, 'TPos'), 10) || 0,
      notes: cleanNote(qcol(r, 'Notes')),
      children: [],
      diags: [],
      objs: [],
      allDiagsCount: 0,
      allObjsCount: 0,
      path: '',
      pathIds: []
    };
  }

  /* Baum verknüpfen */
  for (var k in PKG) {
    if (!PKG.hasOwnProperty(k)) continue;
    var pk = PKG[k];
    if (pk.parent && PKG[pk.parent] && pk.parent !== pk.id) {
      PKG[pk.parent].children.push(pk);
    } else {
      PKG_ROOTS.push(pk);
    }
  }
  function sortPkgs(list) {
    list.sort(function (a, b) {
      if (a.tpos !== b.tpos) return a.tpos - b.tpos;
      return a.name.localeCompare(b.name, 'de');
    });
    for (var j = 0; j < list.length; j++) sortPkgs(list[j].children);
  }
  sortPkgs(PKG_ROOTS);

  function buildPkgPaths(node, ancestryNames, ancestryIds) {
    var names = ancestryNames.concat([node.name]);
    var ids = ancestryIds.concat([node.id]);
    node.path = names.join(' / ');
    node.shortPath = names.slice(-3).join(' / ');
    node.pathIds = ids;
    for (var j = 0; j < node.children.length; j++) {
      buildPkgPaths(node.children[j], names, ids);
    }
  }
  for (i = 0; i < PKG_ROOTS.length; i++) buildPkgPaths(PKG_ROOTS[i], [], []);

  rows = DB.rows('t_object');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var oidV = qcol(r, 'Object_ID');
    if (oidV == null) continue;
    var opkg = qcol(r, 'Package_ID');
    var pObj = PKG[opkg];
    var oItem = {
      id: oidV,
      name: norm(qcol(r, 'Name')),
      st: norm(qcol(r, 'Stereotype')),
      alias: norm(qcol(r, 'Alias')),
      note: cleanNote(qcol(r, 'Note')),
      pkgId: opkg,
      pkg: pObj ? (pObj.shortPath || pObj.path) : '',
      pkgFull: pObj ? pObj.path : '',
      type: qcol(r, 'Object_Type')
    };
    OBJS[oidV] = oItem;
    if (pObj && oItem.type !== 'Boundary' && !/^proxyconn?ector$/i.test(oItem.st)) {
      pObj.objs.push(oItem);
    }
  }

  rows = DB.rows('t_connector');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    CONS.push({
      id: qcol(r, 'Connector_ID'),
      name: norm(qcol(r, 'Name')),
      st: norm(qcol(r, 'Stereotype')),
      type: norm(qcol(r, 'Connector_Type')),
      a: qcol(r, 'Start_Object_ID'),
      b: qcol(r, 'End_Object_ID')
    });
  }

  rows = DB.rows('t_diagramobjects');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var did = qcol(r, 'Diagram_ID');
    var doid = qcol(r, 'Object_ID');
    if (did == null) continue;
    if (!DIAGOBJ[did]) DIAGOBJ[did] = [];
    DIAGOBJ[did].push({
      oid: doid,
      l: qcol(r, 'RectLeft'),
      t: qcol(r, 'RectTop'),
      r: qcol(r, 'RectRight'),
      b: qcol(r, 'RectBottom'),
      seq: qcol(r, 'Sequence') || 0
    });
    if (doid != null) {
      var sk = String(doid);
      if (!OBJ_DIAGS[sk]) OBJ_DIAGS[sk] = [];
      if (OBJ_DIAGS[sk].indexOf(did) < 0) OBJ_DIAGS[sk].push(did);
    }
  }

  rows = DB.rows('t_diagramlinks');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var hid = qcol(r, 'Hidden');
    if (hid === 1 || hid === '1') continue;
    var dgid = qcol(r, 'DiagramID');
    if (dgid == null) dgid = qcol(r, 'Diagram_ID');
    if (dgid == null) continue;
    var cid = qcol(r, 'ConnectorID');
    if (cid == null) cid = qcol(r, 'Connector_ID');
    if (!DIAGLINK[dgid]) DIAGLINK[dgid] = [];
    DIAGLINK[dgid].push({ cid: cid });
  }

  rows = DB.rows('t_diagram');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var dId = qcol(r, 'Diagram_ID');
    var nm = norm(qcol(r, 'Name'));
    var dpkgId = qcol(r, 'Package_ID');
    var dpkg = PKG[dpkgId];
    var pref = detectViewpointPrefix(nm);
    /* Falls kein Präfix im Namen, prüfen ob das Elternpaket exakt wie ein Viewpoint heißt (z. B. "P2", "L4-P4") */
    if (!pref && dpkg && ADMBW_DATA.vp[dpkg.name]) pref = dpkg.name;
    var dobjs = DIAGOBJ[dId] || [];
    var dlinks = DIAGLINK[dId] || [];
    var dItem = {
      id: dId,
      name: nm || ('Diagramm ' + dId),
      pkgId: dpkgId,
      pkgPath: dpkg ? (dpkg.shortPath || dpkg.path) : '',
      pkgFull: dpkg ? dpkg.path : '',
      rootPkgName: (dpkg && dpkg.pathIds && dpkg.pathIds.length > 1 && PKG[dpkg.pathIds[1]]) ? PKG[dpkg.pathIds[1]].name : (dpkg ? dpkg.name : ''),
      type: norm(qcol(r, 'Diagram_Type')) || 'Custom',
      notes: cleanNote(qcol(r, 'Notes')),
      prefix: pref,
      objCount: dobjs.length,
      linkCount: dlinks.length
    };
    DIAGS.push(dItem);
    DIAGMAP[dId] = dItem;
    if (dpkg) dpkg.diags.push(dItem);
  }

  /* Rekursive Zählung für den Paketbaum */
  function countTree(node) {
    var dc = node.diags.length;
    var oc = node.objs.length;
    for (var j = 0; j < node.children.length; j++) {
      countTree(node.children[j]);
      dc += node.children[j].allDiagsCount;
      oc += node.children[j].allObjsCount;
    }
    node.allDiagsCount = dc;
    node.allObjsCount = oc;
  }
  for (i = 0; i < PKG_ROOTS.length; i++) countTree(PKG_ROOTS[i]);

  rows = DB.rows('t_objectproperties');
  for (i = 0; i < rows.length; i++) {
    r = rows[i];
    var toid = qcol(r, 'Object_ID');
    if (toid == null) continue;
    var key = String(toid);
    if (!TAGS[key]) TAGS[key] = [];
    TAGS[key].push({
      p: norm(qcol(r, 'Property')),
      v: cleanNote(qcol(r, 'Value')),
      n: cleanNote(qcol(r, 'Notes'))
    });
  }

  var cmap = {};
  for (i = 0; i < CONS.length; i++) cmap[CONS[i].id] = CONS[i];
  DB._cmap = cmap;

  CONNCOUNT = {};
  for (i = 0; i < CONS.length; i++) {
    var ca = String(CONS[i].a), cb = String(CONS[i].b);
    CONNCOUNT[ca] = (CONNCOUNT[ca] || 0) + 1;
    CONNCOUNT[cb] = (CONNCOUNT[cb] || 0) + 1;
  }
}

/* Hilfsfunktion: Alle Elemente und Beziehungen einer einzelnen Sicht (Diagramm) ermitteln */
function getDiagramData(diagId) {
  var dobjs = DIAGOBJ[diagId] || [];
  var dlinks = DIAGLINK[diagId] || [];
  var elSet = {}, els = [], rels = [], relAdded = {}, i;
  for (i = 0; i < dobjs.length; i++) {
    var o = OBJS[dobjs[i].oid];
    if (!o || o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
    if (!elSet[o.id]) { elSet[o.id] = true; els.push(o); }
  }
  var cmap = (DB && DB._cmap) || {};
  for (i = 0; i < dlinks.length; i++) {
    var cn = cmap[dlinks[i].cid];
    if (cn && !relAdded[cn.id]) {
      relAdded[cn.id] = true;
      rels.push(cn);
    }
  }
  /* Falls t_diagramlinks leer ist, alle Beziehungen zwischen den platzierten Elementen ergänzen */
  for (i = 0; i < CONS.length; i++) {
    var c = CONS[i];
    if (!relAdded[c.id] && elSet[c.a] && elSet[c.b]) {
      relAdded[c.id] = true;
      rels.push(c);
    }
  }
  els.sort(function (a, b) { return (a.st || '').localeCompare(b.st || '', 'de') || (a.name || '').localeCompare(b.name || '', 'de'); });
  return { els: els, rels: rels };
}

/* Hilfsfunktion: Alle Diagramme, Elemente & Beziehungen eines Pakets (wahlweise inkl. Unterpakete) */
function getPackageData(pkgId, includeSub) {
  var root = PKG[pkgId];
  if (!root) return { diags: [], els: [], rels: [] };
  var diags = [], els = [], elSet = {}, i;
  function walk(node) {
    for (var d = 0; d < node.diags.length; d++) diags.push(node.diags[d]);
    for (var o = 0; o < node.objs.length; o++) {
      var obj = node.objs[o];
      if (!elSet[obj.id]) { elSet[obj.id] = true; els.push(obj); }
    }
    if (includeSub) {
      for (var c = 0; c < node.children.length; c++) walk(node.children[c]);
    }
  }
  walk(root);
  /* Auch Elemente hinzunehmen, die auf den Diagrammen dieses Pakets platziert sind */
  for (i = 0; i < diags.length; i++) {
    var dobjs = DIAGOBJ[diags[i].id] || [];
    for (var j = 0; j < dobjs.length; j++) {
      var xo = OBJS[dobjs[j].oid];
      if (xo && xo.type !== 'Boundary' && !/^proxyconn?ector$/i.test(xo.st) && !elSet[xo.id]) {
        elSet[xo.id] = true;
        els.push(xo);
      }
    }
  }
  var rels = [];
  for (i = 0; i < CONS.length; i++) {
    var cn = CONS[i];
    if (elSet[cn.a] || elSet[cn.b]) rels.push(cn);
  }
  els.sort(function (a, b) { return (a.st || '').localeCompare(b.st || '', 'de') || (a.name || '').localeCompare(b.name || '', 'de'); });
  return { diags: diags, els: els, rels: rels };
}

/* ---------- Schnell-Einstieg / Kompass unter dem Suchfeld ---------- */
function renderQuickBar() {
  var qb = el('quickbar');
  if (!qb) return;
  var h = [], i;

  /* 1. Einstiegs-/Übersichts-Diagramme finden */
  var heroDiags = [];
  for (i = 0; i < DIAGS.length; i++) {
    var d = DIAGS[i];
    if (/startseite|overview|übersicht|introduction|gesamtgefüge|projects|architekturauftrag/i.test(d.name)) {
      heroDiags.push(d);
    }
  }
  if (!heroDiags.length) heroDiags = DIAGS.slice(0, 5);
  else heroDiags = heroDiags.slice(0, 6);

  if (heroDiags.length) {
    h.push('<div class="qb-row"><span class="qb-lbl">🌟 Einstiegs-Sichten:</span>');
    for (i = 0; i < heroDiags.length; i++) {
      h.push('<span class="gchip" style="background:#FEF3C7;color:#92400E;border-color:#FCD34D" onclick="openDiagramView(' + heroDiags[i].id + ')" title="Sicht direkt öffnen: ' + esc(heroDiags[i].pkgFull) + '">🖼️ ' + esc(shortLabel(heroDiags[i].name, 38)) + '</span>');
    }
    h.push('</div>');
  }

  /* 2. Hauptpakete (Kinder des Root-Pakets oder Root-Pakete) */
  var topPkgs = (PKG_ROOTS.length === 1 && PKG_ROOTS[0].children.length) ? PKG_ROOTS[0].children : PKG_ROOTS;
  if (topPkgs.length) {
    h.push('<div class="qb-row"><span class="qb-lbl">📁 Hauptbereiche (Pakete):</span>');
    for (i = 0; i < topPkgs.length && i < 8; i++) {
      var p = topPkgs[i];
      h.push('<span class="gchip" onclick="showView(\'explorer\');openPackage(' + p.id + ')" title="Paket im Explorer öffnen">' + esc(p.name) + ' <em>(' + p.allDiagsCount + ' Sichten · ' + p.allObjsCount + ' El.)</em></span>');
    }
    h.push('</div>');
  }

  /* 3. Häufigste Elementtypen */
  var tc = {}, types = [];
  for (var oid in OBJS) {
    if (!OBJS.hasOwnProperty(oid)) continue;
    var st = OBJS[oid].st;
    if (!st || /^proxyconn?ector$/i.test(st)) continue;
    tc[st] = (tc[st] || 0) + 1;
  }
  for (var k in tc) if (tc.hasOwnProperty(k)) types.push(k);
  types.sort(function (a, b) { return tc[b] - tc[a]; });
  if (types.length) {
    h.push('<div class="qb-row"><span class="qb-lbl">🏷️ Häufigste Elementtypen:</span>');
    for (i = 0; i < types.length && i < 10; i++) {
      var t = types[i];
      h.push('<span class="gchip" onclick="fillSearch(\'' + esc(t).replace(/'/g, '&#39;') + '\')" title="Nach «' + esc(t) + '» suchen"><i style="background:' + stColor(t) + '"></i>' + esc(t) + ' <em>' + tc[t] + '</em></span>');
    }
    h.push('</div>');
  }

  qb.innerHTML = '<details style="cursor:pointer"><summary style="font-weight:700;color:var(--bw-blue);font-size:12px">⚡ Schnell-Einstieg (Einstiegs-Sichten, Hauptpakete &amp; häufigste Elementtypen) ein-/ausblenden</summary><div style="margin-top:7px;display:flex;flex-direction:column;gap:6px">' + h.join('') + '</div></details>';
}

/* ================================================================
   ANSICHT 1: INTERAKTIVER PAKET- & STRUKTUR-EXPLORER
   ================================================================ */
function renderPkgTree() {
  var host = el('pkgtree');
  if (!host) return;
  var q = (el('treefilter') ? el('treefilter').value : '').trim().toLowerCase();

  function matchesFilter(node) {
    if (!q) return true;
    if (node.name.toLowerCase().indexOf(q) >= 0) return true;
    for (var d = 0; d < node.diags.length; d++) {
      if (node.diags[d].name.toLowerCase().indexOf(q) >= 0) return true;
    }
    for (var i = 0; i < node.children.length; i++) {
      if (matchesFilter(node.children[i])) return true;
    }
    return false;
  }

  var h = [];
  function renderNode(node) {
    if (!matchesFilter(node)) return;
    var hasKids = node.children.length > 0;
    var isOpen = q ? true : !!PKG_OPEN[node.id];
    var isAct = (CURPKG === node.id && CURVIEW === 'explorer');
    h.push('<div class="tnode">');
    h.push('<div class="trow' + (isAct ? ' active' : '') + '" onclick="openPackage(' + node.id + ')">');
    if (hasKids) {
      h.push('<span class="ttog" onclick="event.stopPropagation();togglePkgNode(' + node.id + ')">' + (isOpen ? '▾' : '▸') + '</span>');
    } else {
      h.push('<span class="ttog">·</span>');
    }
    h.push('<span class="tname" title="' + esc(node.path) + '">📁 ' + esc(node.name) + '</span>');
    if (node.allDiagsCount > 0) h.push('<span class="tbadge diag" title="Enthaltene Sichten / Diagramme">🖼️ ' + node.allDiagsCount + '</span>');
    if (node.allObjsCount > 0) h.push('<span class="tbadge" title="Enthaltene Elemente">' + node.allObjsCount + '</span>');
    h.push('</div>');
    if (hasKids && isOpen) {
      h.push('<div class="tchildren">');
      for (var i = 0; i < node.children.length; i++) renderNode(node.children[i]);
      h.push('</div>');
    }
    h.push('</div>');
  }
  for (var r = 0; r < PKG_ROOTS.length; r++) renderNode(PKG_ROOTS[r]);
  host.innerHTML = h.join('') || '<div class="hint">Keine passenden Pakete gefunden.</div>';
}

function togglePkgNode(pid) {
  PKG_OPEN[pid] = !PKG_OPEN[pid];
  renderPkgTree();
}

function expandAllPkgs(open) {
  for (var k in PKG) {
    if (PKG.hasOwnProperty(k)) PKG_OPEN[k] = !!open;
  }
  if (!open && PKG_ROOTS.length) PKG_OPEN[PKG_ROOTS[0].id] = true;
  renderPkgTree();
}

function togglePkgDeep(cb) {
  PKG_DEEP = !!cb.checked;
  if (CURPKG != null) openPackage(CURPKG, true);
}

function renderDistBar(els, targetContainerId) {
  if (!els || !els.length) return '';
  var tc = {}, types = [], i;
  for (i = 0; i < els.length; i++) {
    var st = els[i].st || '(ohne Stereotyp)';
    tc[st] = (tc[st] || 0) + 1;
  }
  for (var k in tc) if (tc.hasOwnProperty(k)) types.push(k);
  types.sort(function (a, b) { return tc[b] - tc[a]; });
  var maxC = tc[types[0]] || 1;
  var h = [];
  h.push('<div class="dist-bar"><div class="dist-title"><span>📊 Verteilung der genutzten Elemente (' + types.length + ' Typen, ' + els.length + ' gesamt — Klick filtert Tabelle):</span><a href="javascript:void(0)" onclick="filterByStereotype(\'\',\'' + targetContainerId + '\')" style="color:var(--bw-blue);text-decoration:none;font-weight:600">Alle zeigen</a></div><div class="dist-chips">');
  for (i = 0; i < types.length && i < 16; i++) {
    var t = types[i];
    var pct = Math.max(12, Math.round((tc[t] / maxC) * 100));
    h.push('<span class="dchip" onclick="filterByStereotype(\'' + esc(t).replace(/'/g, '&#39;') + '\',\'' + targetContainerId + '\')">');
    h.push('<i style="width:8px;height:8px;border-radius:50%;background:' + stColor(t) + ';display:inline-block"></i>');
    h.push('<span>' + esc(t) + '</span> <b>' + tc[t] + '</b>');
    h.push('<span class="dchip-bar"><span class="dchip-fill" style="width:' + pct + '%;background:' + stColor(t) + '"></span></span>');
    h.push('</span>');
  }
  h.push('</div></div>');
  return h.join('');
}

function filterByStereotype(st, containerId) {
  var wrap = el(containerId || 'vp-list') || document;
  var inp = wrap.querySelector('.vpfilter');
  if (inp) {
    inp.value = st === '(ohne Stereotyp)' ? '' : st;
    filterRows(inp);
  }
}

function openPackage(pid, stayInExplorer) {
  var pkg = PKG[pid];
  if (!pkg) return;
  CURPKG = pid;
  /* Pfad im Baum aufklappen */
  for (var i = 0; i < pkg.pathIds.length; i++) PKG_OPEN[pkg.pathIds[i]] = true;
  if (!stayInExplorer) showView('explorer');
  renderPkgTree();

  var pdata = getPackageData(pid, PKG_DEEP);
  CURDATA = { els: pdata.els, rels: pdata.rels, diags: pdata.diags };
  EXPCTX = { fname: 'Paket_' + pkg.name, kind: 'Paket (' + (PKG_DEEP ? 'inkl. Unterpakete' : 'nur direkt') + ')', label: 'Paket: ' + pkg.path };
  PRINTCTX = 'Paket: ' + pkg.path;
  G.mode = 'pkg'; G.root = null; G.built = false;
  VPMODE = 'list';

  var host = el('pkgmain');
  if (!host) return;
  if (el('vpbox')) el('vpbox').innerHTML = '';
  var h = [];

  /* Breadcrumb */
  h.push('<div class="crumb">');
  for (i = 0; i < pkg.pathIds.length; i++) {
    var anc = PKG[pkg.pathIds[i]];
    if (!anc) continue;
    if (i > 0) h.push(' <span>▸</span> ');
    if (i === pkg.pathIds.length - 1) h.push('<b>📁 ' + esc(anc.name) + '</b>');
    else h.push('<a href="javascript:openPackage(' + anc.id + ')">' + esc(anc.name) + '</a>');
  }
  h.push('</div>');

  h.push('<h2>📁 ' + esc(pkg.name) + '</h2>');
  h.push('<div class="kpis">' +
    '<span><b>' + pkg.children.length + '</b> Unterordner</span>' +
    '<span><b>' + pdata.diags.length + '</b> vorhandene Sichten (Diagramme)</span>' +
    '<span><b>' + pdata.els.length + '</b> Elemente</span>' +
    '<span><b>' + pdata.rels.length + '</b> Beziehungen</span>' +
    '</div>');
  if (pkg.notes) {
    if (pkg.notes.length > 180) {
      h.push('<details class="purpose" style="cursor:pointer"><summary><b>Paket-Beschreibung:</b> ' + esc(shortLabel(pkg.notes.replace(/\n+/g, ' '), 150)) + ' <span class="dim">(aufklappen)</span></summary><div style="margin-top:6px;white-space:pre-line">' + esc(pkg.notes) + '</div></details>');
    } else {
      h.push('<div class="purpose"><b>Paket-Beschreibung:</b> ' + esc(pkg.notes) + '</div>');
    }
  }

  /* Aktions- & Exportleiste */
  h.push('<div class="vp-actions">');
  h.push('<span class="vswitch">' +
    '<button id="btn-mode-list" class="on" onclick="setVPMode(\'list\')">☰ Paket-Inhalt (Sichten &amp; Elemente)</button>' +
    '<button id="btn-mode-graph" onclick="setVPMode(\'graph\')">◉ Paket im Graph visualisieren</button>' +
    '<label style="margin-left:8px;cursor:pointer;color:var(--ink);font-weight:600"><input type="checkbox" ' + (PKG_DEEP ? 'checked ' : '') + 'onchange="togglePkgDeep(this)"> Inkl. Unterpakete</label>' +
    '</span>');
  if (typeof EDIT !== 'undefined') {
    h.push('<span class="vedit">✏️ Bearbeiten: ' +
      '<button onclick="EDIT.pkgEdit(' + pid + ')" title="Paketname &amp; Beschreibung ändern">Paket</button>' +
      '<button onclick="EDIT.elNew(' + pid + ')" title="Neues Element in diesem Paket anlegen">＋ Element</button>' +
      '</span>');
  }
  h.push('<span class="vexport">' +
    '<button class="exp-xls" onclick="exportCurrentXLSX()" title="Dieses Paket inkl. Elementen, Beziehungen &amp; Tagged Values als Excel (.xlsx) exportieren">📊 Paket als Excel (.xlsx)</button>' +
    '<button class="exp-png" onclick="exportCurrentPNG()" title="Schaubild oder Graph als PNG exportieren">📸 Als PNG</button>' +
    '<button onclick="exportElementsCSV()">⤓ CSV</button>' +
    '<button onclick="exportPDF()">🖨 PDF</button>' +
    '</span>');
  h.push('</div>');

  h.push('<div id="vp-list">');

  /* 1. Unterpakete als Ordner-Kacheln */
  if (pkg.children.length) {
    h.push('<h3>Unterpakete / Ordner (' + pkg.children.length + ')</h3>');
    h.push('<div class="subpkg-grid">');
    for (i = 0; i < pkg.children.length; i++) {
      var ch = pkg.children[i];
      h.push('<div class="pkg-card" onclick="openPackage(' + ch.id + ')">');
      h.push('<div class="pkg-card-title">📁 ' + esc(ch.name) + '</div>');
      h.push('<div class="pkg-card-meta"><b>' + ch.allDiagsCount + '</b> Sichten &nbsp;·&nbsp; <b>' + ch.allObjsCount + '</b> Elemente' + (ch.children.length ? ' &nbsp;·&nbsp; ' + ch.children.length + ' Unterordner' : '') + '</div>');
      h.push('</div>');
    }
    h.push('</div>');
  }

  /* 2. Vorhandene Sichten (Diagramme) in diesem Paket */
  h.push('<h3>Vorhandene Sichten / Diagramme in diesem Bereich (' + pdata.diags.length + ')</h3>');
  if (!pdata.diags.length) {
    h.push('<div class="hint">Keine Diagramme in diesem Paket vorhanden.</div>');
  } else if (pdata.diags.length <= 4) {
    /* Direkt interaktive Schaubilder mit Einzel-Export (PNG & Excel) rendern! */
    h.push('<div class="diaglist">');
    for (i = 0; i < pdata.diags.length; i++) {
      var dg = pdata.diags[i];
      h.push('<div class="diagbox">');
      h.push('<div class="diagbox-hdr">' +
        '<div><span class="diagtitle">🖼️ ' + esc(dg.name) + '</span><span class="diagsub">(' + esc(dg.pkgPath) + ' · ' + dg.objCount + ' Elemente)</span></div>' +
        '<div class="diagtools">' +
          '<button class="btn-sm pri" onclick="openDiagramView(' + dg.id + ')">🔍 Einzel-Sicht öffnen</button>' +
          '<button class="btn-sm" onclick="openDiagramView(' + dg.id + ', \'graph\')">◉ Im Graph</button>' +
          '<button class="btn-sm amber" onclick="exportDiagramPNG(' + dg.id + ')">📸 Sicht als PNG</button>' +
          '<button class="btn-sm green" onclick="exportDiagramXLSX(' + dg.id + ')">📊 Sicht als Excel (.xlsx)</button>' +
        '</div></div>');
      h.push('<div class="svgwrap" id="diag-' + dg.id + '"></div>');
      h.push('</div>');
    }
    h.push('</div>');
  } else {
    /* Übersichtliche Sichten-Karten-Galerie (mit Direkt-Export pro Sicht!) */
    h.push('<div class="diag-cards">');
    for (i = 0; i < pdata.diags.length && i < 60; i++) {
      var d2 = pdata.diags[i];
      h.push('<div class="dcard">');
      h.push('<div>');
      h.push('<div class="dcard-title" onclick="openDiagramView(' + d2.id + ')">🖼️ ' + esc(d2.name) + '</div>');
      h.push('<div class="dcard-path">📁 ' + esc(d2.pkgPath) + '</div>');
      h.push('<div class="dcard-badges">' +
        '<span class="b b-els">' + d2.objCount + ' Elemente</span>' +
        '<span class="b b-rel">' + d2.linkCount + ' Kanten</span>' +
        (d2.prefix ? '<span class="b b-diag">' + esc(d2.prefix) + '</span>' : '<span class="b b-none">' + esc(d2.type) + '</span>') +
        '</div>');
      h.push('</div>');
      h.push('<div class="dcard-acts">' +
        '<button class="btn-sm pri" onclick="openDiagramView(' + d2.id + ')">🔍 Sicht öffnen</button>' +
        '<button class="btn-sm" onclick="openDiagramView(' + d2.id + ', \'graph\')" title="Diese Sicht als Graph visualisieren">◉ Graph</button>' +
        '<button class="btn-sm amber" onclick="exportDiagramPNG(' + d2.id + ')" title="Diese Sicht direkt als PNG herunterladen">📸 PNG</button>' +
        '<button class="btn-sm green" onclick="exportDiagramXLSX(' + d2.id + ')" title="Diese Sicht direkt als Excel (.xlsx) herunterladen">📊 Excel</button>' +
        '</div>');
      h.push('</div>');
    }
    h.push('</div>');
    if (pdata.diags.length > 60) {
      h.push('<div class="hint">… ' + (pdata.diags.length - 60) + ' weitere Sichten in Unterpaketen — klicken Sie links im Baum auf ein Unterpaket oder nutzen Sie den Reiter „🖼️ Sichten“.</div>');
    }
  }

  /* 3. Verteilung der genutzten Elementtypen */
  h.push(renderDistBar(pdata.els, 'vp-list'));

  /* 4. Elemente- & Beziehungstabellen */
  h.push('<div class="vpfilterwrap"><input class="vpfilter" placeholder="🔍 Elemente &amp; Beziehungen in diesem Paket filtern (Name, Alias, Stereotype) …" oninput="filterRows(this)"></div>');
  h.push('<h3>Elemente in diesem Paket (' + pdata.els.length + ')</h3>');
  if (!pdata.els.length) {
    h.push('<div class="hint">Keine Elemente in diesem Paket.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Name</th><th>Stereotype</th><th>Alias</th><th>Paketpfad</th><th>Sichten</th><th>Verb.</th></tr></thead><tbody>');
    for (i = 0; i < pdata.els.length && i < 250; i++) {
      var o = pdata.els[i];
      var dc = (OBJ_DIAGS[String(o.id)] || []).length;
      h.push('<tr class="clickable" onclick="openElement(\'' + o.id + '\')">' +
        '<td><b>' + esc(o.name || '(ohne Name)') + '</b></td>' +
        '<td><code>' + esc(o.st || '–') + '</code></td>' +
        '<td>' + esc(o.alias) + '</td>' +
        '<td class="dim">' + esc(o.pkg) + '</td>' +
        '<td>' + (dc ? '<span class="b b-diag">' + dc + ' Sicht(en)</span>' : '–') + '</td>' +
        '<td><span class="b b-rel">' + (CONNCOUNT[String(o.id)] || 0) + '</span></td>' +
        '</tr>');
    }
    h.push('</tbody></table>');
    if (pdata.els.length > 250) h.push('<div class="hint">… ' + (pdata.els.length - 250) + ' weitere Elemente (vollständig im Excel-/CSV-Export).</div>');
  }

  h.push('</div>'); /* /vp-list */
  h.push('<div class="vp-graph" id="vp-graph" style="display:none"></div>');

  host.innerHTML = h.join('');
  if (pdata.diags.length > 0 && pdata.diags.length <= 4) {
    for (i = 0; i < pdata.diags.length; i++) {
      renderDiagram(pdata.diags[i], el('diag-' + pdata.diags[i].id));
    }
  }
}

/* ================================================================
   ANSICHT 2: KATALOG ALLER VORHANDENEN SICHTEN (DIAGRAMME)
   ================================================================ */
function renderDiagsCatalog() {
  var host = el('diagsbox');
  if (!host) return;
  var i, d;
  var rootNames = {}, rlist = [];
  for (i = 0; i < DIAGS.length; i++) {
    var rn = DIAGS[i].rootPkgName || 'Allgemein';
    rootNames[rn] = (rootNames[rn] || 0) + 1;
  }
  for (var k in rootNames) if (rootNames.hasOwnProperty(k)) rlist.push(k);
  rlist.sort();

  var h = [];
  h.push('<h2>🖼️ Alle vorhandenen Sichten (Diagramme) im Modell (' + DIAGS.length + ')</h2>');
  h.push('<div class="purpose">Hier sehen Sie <b>alle tatsächlich in der QEA-Datei modellierten Sichten (Diagramme)</b> — unabhängig davon, ob sie nach dem generischen ADMBw-Schema benannt sind oder projektspezifische Namen tragen. Jede Sicht kann direkt geöffnet, im Graphen analysiert oder als <b>PNG / Excel (.xlsx)</b> exportiert werden.</div>');

  h.push('<div class="vp-actions" style="justify-content:flex-start;gap:10px">');
  h.push('<input id="df-q" class="vpfilter" style="max-width:360px" placeholder="🔍 Sicht suchen (Name, Paket, Präfix) …" value="' + esc(DIAG_FILTER.q) + '" oninput="updateDiagCatalogFilter()">');
  h.push('<select id="df-pkg" style="padding:7px 10px;border:1px solid #C6D2DA;border-radius:6px;font-size:12.5px" onchange="updateDiagCatalogFilter()">');
  h.push('<option value="">📁 Alle Hauptpakete (' + DIAGS.length + ')</option>');
  for (i = 0; i < rlist.length; i++) {
    var sel = DIAG_FILTER.pkg === rlist[i] ? ' selected' : '';
    h.push('<option value="' + esc(rlist[i]) + '"' + sel + '>' + esc(rlist[i]) + ' (' + rootNames[rlist[i]] + ')</option>');
  }
  h.push('</select>');

  var layers = [
    ['all', 'Alle Schichten'],
    ['custom', 'Ohne Standard-Präfix / Frei benannt'],
    ['C', 'Konzepte (C)'],
    ['S', 'Dienste (S)'],
    ['L', 'Logisch (L)'],
    ['P', 'Physisch (P)'],
    ['A', 'Grundlagen (A)'],
    ['R', 'Anforderungen (R)'],
    ['B', 'Brücken (C1-S1 / L4-P4)']
  ];
  h.push('<select id="df-layer" style="padding:7px 10px;border:1px solid #C6D2DA;border-radius:6px;font-size:12.5px" onchange="updateDiagCatalogFilter()">');
  for (i = 0; i < layers.length; i++) {
    var lsel = DIAG_FILTER.layer === layers[i][0] ? ' selected' : '';
    h.push('<option value="' + layers[i][0] + '"' + lsel + '>📐 ' + layers[i][1] + '</option>');
  }
  h.push('</select>');
  h.push('</div>');

  h.push('<div id="diags-grid-list"></div>');
  host.innerHTML = h.join('');
  updateDiagCatalogFilter();
}

function updateDiagCatalogFilter() {
  var qEl = el('df-q'), pEl = el('df-pkg'), lEl = el('df-layer');
  if (qEl) DIAG_FILTER.q = qEl.value.trim().toLowerCase();
  if (pEl) DIAG_FILTER.pkg = pEl.value;
  if (lEl) DIAG_FILTER.layer = lEl.value;

  var filtered = [], i, d;
  for (i = 0; i < DIAGS.length; i++) {
    d = DIAGS[i];
    if (DIAG_FILTER.pkg && d.rootPkgName !== DIAG_FILTER.pkg) continue;
    if (DIAG_FILTER.layer !== 'all') {
      var pr = d.prefix || '';
      if (DIAG_FILTER.layer === 'custom') {
        if (pr && ADMBW_DATA.vp[pr]) continue;
      } else if (DIAG_FILTER.layer === 'B') {
        if (pr.indexOf('-') < 0) continue;
      } else {
        if (pr.indexOf('-') >= 0 || pr.charAt(0).toUpperCase() !== DIAG_FILTER.layer) continue;
      }
    }
    if (DIAG_FILTER.q && (d.name + ' ' + d.pkgFull + ' ' + d.prefix + ' ' + d.type).toLowerCase().indexOf(DIAG_FILTER.q) < 0) continue;
    filtered.push(d);
  }

  var box = el('diags-grid-list');
  if (!box) return;
  if (!filtered.length) {
    box.innerHTML = '<div class="hint">Keine Sichten für diese Filterkombination gefunden.</div>';
    return;
  }
  var h = [];
  h.push('<div class="dim" style="margin-bottom:8px">Zeige <b>' + filtered.length + '</b> von ' + DIAGS.length + ' vorhandenen Sichten:</div>');
  h.push('<div class="diag-cards">');
  for (i = 0; i < filtered.length; i++) {
    d = filtered[i];
    h.push('<div class="dcard">');
    h.push('<div>');
    h.push('<div class="dcard-title" onclick="openDiagramView(' + d.id + ')">🖼️ ' + esc(d.name) + '</div>');
    h.push('<div class="dcard-path">📁 <a href="javascript:openPackage(' + d.pkgId + ')" style="color:var(--bw-mid);text-decoration:none">' + esc(d.pkgFull || d.pkgPath) + '</a></div>');
    h.push('<div class="dcard-badges">' +
      '<span class="b b-els">' + d.objCount + ' Elemente</span>' +
      '<span class="b b-rel">' + d.linkCount + ' Kanten</span>' +
      (d.prefix ? '<span class="b b-diag">Viewpoint ' + esc(d.prefix) + '</span>' : '<span class="b b-none">Typ: ' + esc(d.type) + '</span>') +
      '</div>');
    h.push('</div>');
    h.push('<div class="dcard-acts">' +
      '<button class="btn-sm pri" onclick="openDiagramView(' + d.id + ')">🔍 Sicht öffnen</button>' +
      '<button class="btn-sm" onclick="openDiagramView(' + d.id + ', \'graph\')">◉ Graph</button>' +
      '<button class="btn-sm amber" onclick="exportDiagramPNG(' + d.id + ')">📸 PNG</button>' +
      '<button class="btn-sm green" onclick="exportDiagramXLSX(' + d.id + ')">📊 Excel</button>' +
      '</div>');
    h.push('</div>');
  }
  h.push('</div>');
  box.innerHTML = h.join('');
}

/* ================================================================
   EINZEL-SICHT-ANSICHT (openDiagramView) — Diagramm + Graph + PNG/Excel
   ================================================================ */
function openDiagramView(diagId, mode) {
  var diag = DIAGMAP[diagId];
  if (!diag) return;
  CURDIAG = diagId;
  var d = el('gsres'); if (d) d.style.display = 'none';

  var ddata = getDiagramData(diagId);
  CURDATA = { els: ddata.els, rels: ddata.rels, diags: [diag] };
  EXPCTX = { fname: 'Sicht_' + diag.name, kind: 'Einzel-Sicht (Diagramm)', label: 'Sicht: ' + diag.name };
  PRINTCTX = 'Sicht: ' + diag.name + ' (' + diag.pkgPath + ')';
  G.mode = 'diag'; G.root = null; G.built = false;

  var h = [];
  h.push('<div class="crumb">' +
    '<a href="javascript:showView(\'explorer\')">🧭 Erkunden</a> &nbsp;·&nbsp; ' +
    '<a href="javascript:showView(\'diags\')">🖼️ Sichten</a>' +
    (diag.pkgId && PKG[diag.pkgId] ? ' &nbsp;·&nbsp; 📁 <a href="javascript:openPackage(' + diag.pkgId + ')">' + esc(diag.pkgPath) + '</a>' : '') +
    ' &nbsp;▸&nbsp; <b>🖼️ ' + esc(diag.name) + '</b></div>');

  h.push('<h2>🖼️ ' + esc(diag.name) + '</h2>');
  h.push('<div class="kpis">' +
    '<span><b>' + ddata.els.length + '</b> Elemente auf dieser Sicht</span>' +
    '<span><b>' + ddata.rels.length + '</b> Beziehungen</span>' +
    '<span>Diagrammtyp: <b>' + esc(diag.type) + '</b></span>' +
    (diag.prefix && ADMBW_DATA.vp[diag.prefix] ? '<span style="cursor:pointer" onclick="openVP(\'' + diag.prefix + '\')">ADMBw-Sicht: <b>' + esc(diag.prefix) + '</b></span>' : '') +
    '</div>');
  if (diag.notes) h.push('<div class="purpose"><b>Sicht-Beschreibung:</b> ' + esc(diag.notes) + '</div>');

  /* Prominente Aktions- & Exportleiste für diese Sicht */
  h.push('<div class="vp-actions">');
  h.push('<span class="vswitch">Ansicht: ' +
    '<button id="btn-mode-list" class="' + (mode === 'graph' ? '' : 'on') + '" onclick="setVPMode(\'list\')">🖼️ Original-Schaubild &amp; Tabellen</button>' +
    '<button id="btn-mode-graph" class="' + (mode === 'graph' ? 'on' : '') + '" onclick="setVPMode(\'graph\')">◉ Sicht im interaktiven Graph erkunden</button>' +
    '</span>');
  if (typeof EDIT !== 'undefined') {
    h.push('<span class="vedit">✏️ ' +
      '<button onclick="EDIT.diagEdit(' + diag.id + ')" title="Sicht-/Diagrammnamen &amp; Beschreibung ändern">Sicht bearbeiten</button>' +
      '</span>');
  }
  h.push('<span class="vexport">' +
    '<button class="exp-png" onclick="exportCurrentPNG()" title="Diese Sicht (Schaubild oder Graph) als hochauflösendes PNG exportieren">📸 Sicht als PNG exportieren</button>' +
    '<button class="exp-xls" onclick="exportCurrentXLSX()" title="Alle Elemente, Beziehungen &amp; Tagged Values dieser Sicht als Excel (.xlsx) exportieren">📊 Sicht als Excel (.xlsx) exportieren</button>' +
    '<button onclick="exportElementsCSV()">⤓ Elemente (CSV)</button>' +
    '<button onclick="exportRelsCSV()">⤓ Beziehungen (CSV)</button>' +
    '<button onclick="exportPDF()">🖨 PDF</button>' +
    '</span>');
  h.push('</div>');

  h.push('<div class="vp-list" id="vp-list">');
  h.push('<div class="diagbox">' +
    '<div class="diagbox-hdr">' +
      '<div><span class="diagtitle">Original-Schaubild aus Sparx EA</span><span class="diagsub">💡 Tipp: Klicken Sie direkt auf ein Kästchen im Schaubild, um dessen Steckbrief &amp; Umfeld zu öffnen!</span></div>' +
      '<div class="diagtools">' +
        '<button class="btn-sm" onclick="zoomDiagSvg(' + diag.id + ', 0.85)">🔍－</button>' +
        '<button class="btn-sm" onclick="zoomDiagSvg(' + diag.id + ', 1.0, true)">100%</button>' +
        '<button class="btn-sm" onclick="zoomDiagSvg(' + diag.id + ', 1.18)">🔍＋</button>' +
      '</div>' +
    '</div>' +
    '<div class="svgwrap" id="diag-' + diag.id + '"></div>' +
  '</div>');

  h.push(renderDistBar(ddata.els, 'vp-list'));

  h.push('<div class="vpfilterwrap"><input class="vpfilter" placeholder="🔍 Tabellen dieser Sicht filtern (Name, Alias, Stereotype) …" oninput="filterRows(this)"></div>');
  h.push('<h3>Elemente auf dieser Sicht (' + ddata.els.length + ')</h3>');
  if (!ddata.els.length) {
    h.push('<div class="hint">Keine Modell-Elemente auf dieser Sicht platziert.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Name</th><th>Stereotype</th><th>Alias</th><th>Paketpfad</th><th>Verb.</th></tr></thead><tbody>');
    for (var i = 0; i < ddata.els.length; i++) {
      var o = ddata.els[i];
      h.push('<tr class="clickable" onclick="openElement(\'' + o.id + '\')">' +
        '<td><b>' + esc(o.name) + '</b></td>' +
        '<td><code>' + esc(o.st) + '</code></td>' +
        '<td>' + esc(o.alias) + '</td>' +
        '<td class="dim">' + esc(o.pkg) + '</td>' +
        '<td><span class="b b-rel">' + (CONNCOUNT[String(o.id)] || 0) + '</span></td>' +
      '</tr>');
    }
    h.push('</tbody></table>');
  }

  h.push('<h3>Beziehungen auf dieser Sicht (' + ddata.rels.length + ')</h3>');
  if (!ddata.rels.length) {
    h.push('<div class="hint">Keine Beziehungen auf dieser Sicht.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Quelle</th><th>Beziehung</th><th>Ziel</th></tr></thead><tbody>');
    for (i = 0; i < ddata.rels.length; i++) {
      var c = ddata.rels[i];
      var a = OBJS[c.a], b = OBJS[c.b];
      h.push('<tr class="clickable" onclick="openElement(\'' + c.a + '\')">' +
        '<td>' + esc(a ? a.name : '?') + ' <span class="dim">«' + esc(a ? a.st : '') + '»</span></td>' +
        '<td><code>' + esc(c.st || c.type || '→') + '</code></td>' +
        '<td>' + esc(b ? b.name : '?') + ' <span class="dim">«' + esc(b ? b.st : '') + '»</span></td>' +
      '</tr>');
    }
    h.push('</tbody></table>');
  }

  h.push('</div>'); /* /vp-list */
  h.push('<div class="vp-graph" id="vp-graph" style="display:none"></div>');

  el('vpbox').innerHTML = h.join('');
  showView('vp');
  renderDiagram(diag, el('diag-' + diag.id));
  setVPMode(mode === 'graph' ? 'graph' : 'list');
}

function zoomDiagSvg(diagId, factor, reset) {
  var wrap = el('diag-' + diagId);
  if (!wrap) return;
  var svg = wrap.querySelector('svg');
  if (!svg) return;
  var baseW = parseFloat(svg.getAttribute('data-base-w')) || parseFloat(svg.getAttribute('width')) || 800;
  var baseH = parseFloat(svg.getAttribute('data-base-h')) || parseFloat(svg.getAttribute('height')) || 600;
  if (!svg.getAttribute('data-base-w')) {
    svg.setAttribute('data-base-w', String(baseW));
    svg.setAttribute('data-base-h', String(baseH));
  }
  var curW = reset ? baseW : (parseFloat(svg.getAttribute('width')) || baseW) * factor;
  var curH = reset ? baseH : (parseFloat(svg.getAttribute('height')) || baseH) * factor;
  svg.setAttribute('width', String(Math.round(curW)));
  svg.setAttribute('height', String(Math.round(curH)));
}

/* ---------- Designumschaltung: Standard hell, Dunkel nur per Button ---------- */
/* Designumschaltung: Standard hell, Wahl wird gespeichert (kein System-Dark mehr) */
(function () {
  try {
    if (localStorage.getItem('eam-theme') === 'dark') {
      document.documentElement.setAttribute('data-theme', 'dark');
    }
  } catch (e) {}
  function sync() {
    var b = document.getElementById('themeBtn');
    if (!b) return;
    var dark = document.documentElement.getAttribute('data-theme') === 'dark';
    b.textContent = dark ? '\u2600\uFE0F Helles Design' : '\u{1F319} Dunkles Design';
    b.setAttribute('aria-pressed', dark ? 'true' : 'false');
    b.title = dark ? 'Zur hellen Ansicht wechseln' : 'Zur dunklen Ansicht wechseln';
  }
  window.toggleTheme = function () {
    var root = document.documentElement;
    if (root.getAttribute('data-theme') === 'dark') {
      root.removeAttribute('data-theme');
      try { localStorage.setItem('eam-theme', 'light'); } catch (e) {}
    } else {
      root.setAttribute('data-theme', 'dark');
      try { localStorage.setItem('eam-theme', 'dark'); } catch (e) {}
    }
    sync();
  };
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', sync);
  else sync();
})();

/* ADMBw QEA Analyzer v4.0 — Teil 2: Globale Suche, Viewpoints, Steckbrief, Interaktives Diagramm & Prägnanter Graph */

/* ---------- Statistik pro ADMBw-Viewpoint ---------- */
function computeStats() {
  VPSTAT = {};
  var d = ADMBW_DATA, k, i;
  for (k in d.vp) {
    if (!d.vp.hasOwnProperty(k)) continue;
    VPSTAT[k] = { els: 0, rels: 0, diags: 0 };
  }
  var byvp = {};
  for (k in d.vp) {
    if (!d.vp.hasOwnProperty(k)) continue;
    var els = d.vp[k].els, j;
    for (j = 0; j < els.length; j++) {
      if (!byvp[els[j]]) byvp[els[j]] = [];
      byvp[els[j]].push(k);
    }
  }
  for (var oid in OBJS) {
    if (!OBJS.hasOwnProperty(oid)) continue;
    var st = OBJS[oid].st;
    if (!st || !byvp[st]) continue;
    var vlist = byvp[st];
    for (i = 0; i < vlist.length; i++) VPSTAT[vlist[i]].els++;
  }
  for (k in d.topo) {
    if (!d.topo.hasOwnProperty(k) || !VPSTAT[k]) continue;
    var rules = d.topo[k], relSet = {};
    for (i = 0; i < rules.length; i++) relSet[rules[i].rel] = 1;
    for (i = 0; i < CONS.length; i++) {
      if (relSet[CONS[i].st]) VPSTAT[k].rels++;
    }
  }
  for (i = 0; i < DIAGS.length; i++) {
    var p = DIAGS[i].prefix;
    if (p && VPSTAT[p]) VPSTAT[p].diags++;
  }
}

/* ---------- ADMBw-Referenz-Grid ---------- */
function renderGrid() {
  var d = ADMBW_DATA.grid;
  var onlyFilled = el('gridonlyfilled') ? el('gridonlyfilled').checked : false;
  var h = [];
  h.push('<table class="grid"><thead><tr><th class="corner">Schicht&nbsp;/&nbsp;Aspekt</th>');
  var c;
  for (c = 0; c < d.cols.length; c++) {
    h.push('<th>' + esc(d.cols[c]) + '<span>' + esc(d.col_de[c]) + '</span></th>');
  }
  h.push('</tr></thead><tbody>');
  for (var r = 0; r < d.rows.length; r++) {
    var row = d.rows[r];
    h.push('<tr' + (row.bridge ? ' class="bridge"' : '') + '>');
    h.push('<th class="rowhead"><b>' + esc(row.label) + '</b><span>' + esc(row.desc) + '</span></th>');
    for (c = 0; c < row.cells.length; c++) {
      var vp = row.cells[c];
      if (!vp) { h.push('<td class="empty"></td>'); continue; }
      var info = ADMBW_DATA.vp[vp] || { n: vp, els: [] };
      var st = VPSTAT[vp] || { els: 0, rels: 0, diags: 0 };
      var hasData = (st.els > 0 || st.diags > 0);
      var cls = !hasData ? 'cell nodata' : 'cell';
      var styleExtra = (onlyFilled && !hasData) ? ' style="opacity:0.25"' : '';
      h.push('<td class="' + cls + '"' + styleExtra + ' onclick="openVP(\'' + vp + '\')" title="' + esc(info.n) + ' (' + st.els + ' Elemente, ' + st.diags + ' Diagramme)">');
      h.push('<div class="vpcode">' + esc(vp) + '</div>');
      h.push('<div class="vpname">' + esc(info.n) + '</div>');
      h.push('<div class="badges">');
      if (st.diags) h.push('<span class="b b-diag">🖼️ ' + st.diags + ' Diagr.</span>');
      if (st.els) h.push('<span class="b b-els">' + st.els + ' El.</span>');
      if (st.rels) h.push('<span class="b b-rel">' + st.rels + ' Bez.</span>');
      if (!st.els && !st.rels && !st.diags) h.push('<span class="b b-none">keine Daten</span>');
      h.push('</div></td>');
    }
    h.push('</tr>');
  }
  h.push('</tbody></table>');
  el('gridbox').innerHTML = h.join('');
  el('legend').innerHTML = '<span class="b b-diag">🖼️ n Diagr.</span> Vorhandene Diagramme &nbsp; <span class="b b-els">n El.</span> Elemente &nbsp; <span class="b b-rel">n Bez.</span> Beziehungen &nbsp; <span class="b b-none">keine Daten</span> keine sichtkonformen Inhalte';
  renderOverview();
}

function renderOverview() {
  var ov = el('overview');
  if (!ov) return;
  var filled = 0, empty = 0, k;
  for (k in VPSTAT) {
    if (!VPSTAT.hasOwnProperty(k)) continue;
    if (VPSTAT[k].els || VPSTAT[k].diags) filled++; else empty++;
  }
  if (el('cnt-grid')) el('cnt-grid').textContent = filled + '/' + (filled + empty);
  ov.innerHTML = '<div class="ov-line"><b>' + filled + '</b> von ' + (filled + empty) + ' ADMBw-Referenzsichten sind mit Elementen oder Diagrammen befüllt. (Alle <b>' + DIAGS.length + '</b> real vorhandenen Diagramme finden Sie im Reiter <b>„🖼️ Sichten“</b> und im <b>„🧭 Erkunden“</b>-Bereich.)</div>';
  ov.style.display = 'block';
}

/* ---------- ADMBw-Viewpoint öffnen ---------- */
function openVP(id) {
  CURVP = id;
  var vp = ADMBW_DATA.vp[id];
  if (!vp) return;
  EXPCTX = { fname: 'Viewpoint_' + id, kind: 'ADMBw-Viewpoint', label: 'Sicht ' + id + ' – ' + vp.n };
  PRINTCTX = 'Sicht ' + id + ' – ' + vp.n;
  G.mode = 'vp'; G.root = null; G.built = false;
  var st = VPSTAT[id] || { els: 0, rels: 0, diags: 0 };
  var d = ADMBW_DATA;
  var h = [];
  h.push('<div class="crumb"><a href="javascript:showView(\'explorer\')">🧭 Erkunden</a> &nbsp;·&nbsp; <a href="javascript:showView(\'grid\')">📐 ADMBw-Grid</a> &nbsp;▸&nbsp; <b>' + esc(id) + '</b></div>');
  h.push('<h2>' + esc(id) + ' &ndash; ' + esc(vp.n) + '</h2>');
  h.push('<div class="kpis"><span><b>' + st.diags + '</b> Diagramme</span><span><b>' + st.els + '</b> Elemente</span><span><b>' + st.rels + '</b> Beziehungen</span></div>');
  if (vp.desc) h.push('<div class="purpose"><b>Zweck (ADMBw-Dokumentation):</b> ' + esc(vp.desc) + '</div>');

  h.push('<div class="vp-actions">');
  h.push('<span class="vswitch">Ansicht: <button id="btn-mode-list" class="on" onclick="setVPMode(\'list\')">☰ Diagramme &amp; Tabellen</button><button id="btn-mode-graph" onclick="setVPMode(\'graph\')">◉ Zusammenhänge (Graph)</button></span>');
  h.push('<span class="vexport">' +
    '<button class="exp-png" onclick="exportCurrentPNG()" title="Schaubild oder Graph dieser Sicht als PNG exportieren">📸 Als PNG exportieren</button>' +
    '<button class="exp-xls" onclick="exportCurrentXLSX()" title="Elemente &amp; Beziehungen dieser Sicht als Excel (.xlsx) exportieren">📊 Als Excel (.xlsx) exportieren</button>' +
    '<button onclick="exportElementsCSV()">⤓ Elemente (CSV)</button>' +
    '<button onclick="exportRelsCSV()">⤓ Beziehungen (CSV)</button>' +
    '<button onclick="exportPDF()">🖨 PDF</button></span>');
  h.push('</div>');

  h.push('<div class="vp-list" id="vp-list">');

  var diags = [], i;
  for (i = 0; i < DIAGS.length; i++) if (DIAGS[i].prefix === id) diags.push(DIAGS[i]);
  h.push('<h3>Vorhandene Diagramme zu dieser Sicht (' + diags.length + ')</h3>');
  if (!diags.length) {
    h.push('<div class="hint">Keine Diagramme mit dem Präfix „' + esc(id) + '“ im Modell gefunden. Tipp: Prüfen Sie den Reiter <b>„🧭 Erkunden“</b> für frei benannte Diagramme.</div>');
  } else {
    h.push('<div class="diaglist">');
    for (i = 0; i < diags.length; i++) {
      var dg = diags[i];
      h.push('<div class="diagbox">' +
        '<div class="diagbox-hdr">' +
          '<div><span class="diagtitle">🖼️ ' + esc(dg.name) + '</span><span class="diagsub">(📁 ' + esc(dg.pkgPath) + ')</span></div>' +
          '<div class="diagtools">' +
            '<button class="btn-sm pri" onclick="openDiagramView(' + dg.id + ')">🔍 Einzel-Sicht</button>' +
            '<button class="btn-sm" onclick="openDiagramView(' + dg.id + ', \'graph\')">◉ Graph</button>' +
            '<button class="btn-sm amber" onclick="exportDiagramPNG(' + dg.id + ')">📸 PNG</button>' +
            '<button class="btn-sm green" onclick="exportDiagramXLSX(' + dg.id + ')">📊 Excel (.xlsx)</button>' +
          '</div>' +
        '</div>' +
        '<div class="svgwrap" id="diag-' + dg.id + '"></div></div>');
    }
    h.push('</div>');
  }

  var els = [], want = {};
  for (i = 0; i < vp.els.length; i++) want[vp.els[i]] = 1;
  for (var oid in OBJS) {
    if (!OBJS.hasOwnProperty(oid)) continue;
    if (want[OBJS[oid].st]) els.push(OBJS[oid]);
  }
  els.sort(function (a, b) { return a.st === b.st ? a.name.localeCompare(b.name, 'de') : a.st.localeCompare(b.st, 'de'); });

  h.push(renderDistBar(els, 'vp-list'));
  h.push('<div class="vpfilterwrap"><input class="vpfilter" placeholder="🔍 Tabellen filtern (Name, Alias, Stereotype, Paket) …" oninput="filterRows(this)"></div>');
  h.push('<h3>Elemente im Modell (' + els.length + ')</h3>');
  if (!els.length) {
    h.push('<div class="hint">Keine Modell-Elemente dieser Sicht vorhanden.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Name</th><th>Stereotype</th><th>Alias</th><th>Paketpfad</th><th>Sichten</th></tr></thead><tbody>');
    for (i = 0; i < els.length; i++) {
      var dc = (OBJ_DIAGS[String(els[i].id)] || []).length;
      h.push('<tr class="clickable" onclick="openElement(\'' + els[i].id + '\')"><td><b>' + esc(els[i].name) + '</b></td><td><code>' + esc(els[i].st) + '</code></td><td>' + esc(els[i].alias) + '</td><td class="dim">' + esc(els[i].pkg) + '</td><td>' + (dc ? '<span class="b b-diag">' + dc + '</span>' : '–') + '</td></tr>');
    }
    h.push('</tbody></table>');
  }

  var rules = d.topo[id] || [], relSet = {};
  for (i = 0; i < rules.length; i++) relSet[rules[i].rel] = 1;
  var rels = [];
  for (i = 0; i < CONS.length; i++) {
    if (relSet[CONS[i].st]) rels.push(CONS[i]);
  }
  h.push('<h3>Beziehungen im Modell (' + rels.length + ')</h3>');
  if (!rels.length) {
    h.push('<div class="hint">Keine Modell-Beziehungen dieser Sicht vorhanden.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Quelle</th><th>Beziehung</th><th>Ziel</th></tr></thead><tbody>');
    var shown = 0;
    for (i = 0; i < rels.length && shown < 300; i++) {
      var a = OBJS[rels[i].a], b = OBJS[rels[i].b];
      h.push('<tr class="clickable" onclick="openElement(\'' + rels[i].a + '\')"><td>' + esc(a ? a.name : '?') + '</td><td><code>' + esc(rels[i].st) + '</code></td><td>' + esc(b ? b.name : '?') + '</td></tr>');
      shown++;
    }
    h.push('</tbody></table>');
    if (rels.length > 300) h.push('<div class="hint">… ' + (rels.length - 300) + ' weitere (vollständig im Excel-/CSV-Export).</div>');
  }

  h.push('<h3>ADMBw-Regelwerk dieser Sicht</h3>');
  h.push('<div class="rules"><div class="rulecol"><b>Erlaubte Meta-Modell-Elemente (' + vp.els.length + ')</b><div class="rulelist">');
  for (i = 0; i < vp.els.length; i++) h.push('<code>' + esc(vp.els[i]) + '</code> ');
  h.push('</div></div><div class="rulecol"><b>Erlaubte Topologie (' + rules.length + ' Regeln)</b><div class="rulelist">');
  for (i = 0; i < rules.length; i++) {
    h.push('<div class="rule"><span class="dim">' + esc(rules[i]['from'].join('; ')) + '</span> &rarr; <code>' + esc(rules[i].rel) + '</code> &rarr; <span class="dim">' + esc(rules[i].to.join('; ')) + '</span></div>');
  }
  if (!rules.length) h.push('<span class="dim">Keine Topologie-Regeln hinterlegt.</span>');
  h.push('</div></div></div>');

  h.push('</div>'); /* /vp-list */
  h.push('<div class="vp-graph" id="vp-graph" style="display:none"></div>');

  CURDATA = { els: els, rels: rels, diags: diags };
  VPMODE = 'list';
  el('vpbox').innerHTML = h.join('');
  showView('vp');

  for (i = 0; i < diags.length; i++) renderDiagram(diags[i], el('diag-' + diags[i].id));
}

/* ================================================================
   SEARCH-FIRST: GLOBALE SUCHE ÜBER SICHTEN, PAKETE & ELEMENTE
   ================================================================ */
function setSearchScope(sc) {
  SEARCH_SCOPE = sc;
  var btns = document.querySelectorAll('#searchscopes .scope-btn');
  for (var i = 0; i < btns.length; i++) {
    btns[i].className = 'scope-btn' + (btns[i].getAttribute('data-scope') === sc ? ' on' : '');
  }
  globalSearch();
}

function clearGlobalSearch() {
  var inp = el('globalsearch'), box = el('gsres'), clr = el('gsclear');
  if (inp) inp.value = '';
  if (box) { box.style.display = 'none'; box.innerHTML = ''; }
  if (clr) clr.style.display = 'none';
  GLOBHITS = [];
}

function fillSearch(q) {
  var si = el('globalsearch');
  if (!si) return;
  si.value = q;
  globalSearch();
  si.focus();
}

function collectSearchHits(q) {
  var diagHits = [], pkgHits = [], elHits = [], i, k;
  if (SEARCH_SCOPE === 'all' || SEARCH_SCOPE === 'diag') {
    for (i = 0; i < DIAGS.length; i++) {
      var d = DIAGS[i];
      if ((d.name + ' ' + d.pkgFull + ' ' + d.prefix + ' ' + d.type + ' ' + d.notes).toLowerCase().indexOf(q) >= 0) {
        diagHits.push(d);
      }
    }
  }
  if (SEARCH_SCOPE === 'all' || SEARCH_SCOPE === 'pkg') {
    for (k in PKG) {
      if (!PKG.hasOwnProperty(k)) continue;
      var p = PKG[k];
      if ((p.name + ' ' + p.path + ' ' + p.notes).toLowerCase().indexOf(q) >= 0) {
        pkgHits.push(p);
      }
    }
  }
  if (SEARCH_SCOPE === 'all' || SEARCH_SCOPE === 'el') {
    for (k in OBJS) {
      if (!OBJS.hasOwnProperty(k)) continue;
      var o = OBJS[k];
      if (o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
      if ((o.name + ' ' + o.alias + ' ' + o.st + ' ' + o.pkg + ' ' + o.note).toLowerCase().indexOf(q) >= 0) {
        elHits.push(o);
      }
    }
    elHits.sort(function (a, b) { return (CONNCOUNT[b.id] || 0) - (CONNCOUNT[a.id] || 0); });
  }
  return { diags: diagHits, pkgs: pkgHits, els: elHits };
}

function globalSearch() {
  var inp = el('globalsearch'), box = el('gsres'), clr = el('gsclear');
  if (!inp || !box) return;
  var q = (inp.value || '').trim().toLowerCase();
  if (clr) clr.style.display = q.length ? 'block' : 'none';
  if (q.length < 2) { box.style.display = 'none'; box.innerHTML = ''; GLOBHITS = []; return; }

  var res = collectSearchHits(q);
  var total = res.diags.length + res.pkgs.length + res.els.length;
  GLOBHITS = res.els;

  if (!total) {
    box.innerHTML = '<div class="gsrow dim">Keine Treffer für „' + esc(q) + '“</div>';
    box.style.display = 'block';
    return;
  }

  var h = [], i;
  h.push('<div class="gs-hdr">' +
    '<span>Treffer für „' + esc(q) + '“: ' + res.diags.length + ' Sichten · ' + res.pkgs.length + ' Pakete · ' + res.els.length + ' Elemente</span>' +
    '<button class="gs-btn" onclick="openSearchResultsView()">🔎 Alle als Sicht öffnen &amp; exportieren</button>' +
  '</div>');

  /* 1. Sichten / Diagramme */
  var maxD = SEARCH_SCOPE === 'diag' ? 30 : 8;
  for (i = 0; i < res.diags.length && i < maxD; i++) {
    var d = res.diags[i];
    h.push('<div class="gsrow">' +
      '<span class="gs-kind k-diag">🖼️ Sicht</span>' +
      '<span class="gs-name" onclick="openDiagramView(' + d.id + ')"><b>' + esc(d.name) + '</b> <span class="gs-meta">📁 ' + esc(d.pkgPath) + ' (' + d.objCount + ' El.)</span></span>' +
      '<button class="gs-btn" onclick="event.stopPropagation();openDiagramView(' + d.id + ', \'graph\')">◉ Graph</button>' +
      '<button class="gs-btn" onclick="event.stopPropagation();exportDiagramPNG(' + d.id + ')">📸 PNG</button>' +
      '<button class="gs-btn" onclick="event.stopPropagation();exportDiagramXLSX(' + d.id + ')">📊 Excel</button>' +
    '</div>');
  }

  /* 2. Pakete */
  var maxP = SEARCH_SCOPE === 'pkg' ? 30 : 6;
  for (i = 0; i < res.pkgs.length && i < maxP; i++) {
    var p = res.pkgs[i];
    h.push('<div class="gsrow">' +
      '<span class="gs-kind k-pkg">📁 Paket</span>' +
      '<span class="gs-name" onclick="openPackage(' + p.id + ')"><b>' + esc(p.name) + '</b> <span class="gs-meta">' + esc(p.path) + ' (' + p.allDiagsCount + ' Sichten · ' + p.allObjsCount + ' El.)</span></span>' +
      '<button class="gs-btn" onclick="event.stopPropagation();openPackage(' + p.id + ')">🧭 Im Explorer</button>' +
    '</div>');
  }

  /* 3. Elemente */
  var maxE = SEARCH_SCOPE === 'el' ? 40 : 20;
  for (i = 0; i < res.els.length && i < maxE; i++) {
    var o = res.els[i];
    var n = CONNCOUNT[o.id] || 0;
    h.push('<div class="gsrow">' +
      '<span class="gs-kind k-el">📦 Element</span>' +
      '<span class="gs-name" onclick="openElement(\'' + o.id + '\')"><b>' + esc(o.name || '(ohne Name)') + '</b> <code>' + esc(o.st) + '</code><span class="gs-meta">' + esc(shortLabel(o.pkg || '', 42)) + '</span></span>' +
      '<span class="gs-conn">' + n + ' Verb.</span>' +
      '<button class="gs-btn" onclick="event.stopPropagation();openElement(\'' + o.id + '\', \'graph\')">◉ Umfeld-Graph</button>' +
    '</div>');
  }

  box.innerHTML = h.join('');
  box.style.display = 'block';
}

function globalSearchKey(e) {
  if (e.keyCode === 13) {
    e.preventDefault();
    openSearchResultsView();
  } else if (e.keyCode === 27) {
    var box = el('gsres'); if (box) box.style.display = 'none';
  }
}

/* Öffnet alle Suchergebnisse als vollwertige, im Graphen visualisierbare & als Excel/PNG exportierbare Sicht! */
function openSearchResultsView() {
  var inp = el('globalsearch');
  var q = (inp ? inp.value : '').trim();
  if (!q) {
    alert('Bitte geben Sie zuerst einen Suchbegriff in das Suchfeld ein.');
    return;
  }
  var box = el('gsres'); if (box) box.style.display = 'none';
  var res = collectSearchHits(q.toLowerCase());
  var elSet = {}, i;
  for (i = 0; i < res.els.length; i++) elSet[res.els[i].id] = true;
  var rels = [];
  for (i = 0; i < CONS.length; i++) {
    if (elSet[CONS[i].a] || elSet[CONS[i].b]) rels.push(CONS[i]);
  }

  CURDATA = { els: res.els, rels: rels, diags: res.diags };
  EXPCTX = { fname: 'Suche_' + q, kind: 'Suchergebnis', label: 'Suchergebnis: „' + q + '“' };
  PRINTCTX = 'Suchergebnis für „' + q + '“';
  G.mode = 'search'; G.root = null; G.built = false;

  var h = [];
  h.push('<div class="crumb"><a href="javascript:showView(\'explorer\')">🧭 Erkunden</a> &nbsp;▸&nbsp; <b>🔎 Suchergebnisse für „' + esc(q) + '“</b></div>');
  h.push('<h2>🔎 Suchergebnisse für „' + esc(q) + '“</h2>');
  h.push('<div class="kpis">' +
    '<span><b>' + res.diags.length + '</b> gefundene Sichten (Diagramme)</span>' +
    '<span><b>' + res.pkgs.length + '</b> gefundene Pakete</span>' +
    '<span><b>' + res.els.length + '</b> gefundene Elemente</span>' +
    '<span><b>' + rels.length + '</b> verknüpfte Beziehungen</span>' +
  '</div>');

  h.push('<div class="vp-actions">');
  h.push('<span class="vswitch">Ansicht: ' +
    '<button id="btn-mode-list" class="on" onclick="setVPMode(\'list\')">☰ Trefferliste (Sichten, Pakete &amp; Elemente)</button>' +
    '<button id="btn-mode-graph" onclick="setVPMode(\'graph\')">◉ Gefundene Elemente im Graph visualisieren</button>' +
  '</span>');
  h.push('<span class="vexport">' +
    '<button class="exp-xls" onclick="exportCurrentXLSX()">📊 Treffer als Excel (.xlsx) exportieren</button>' +
    '<button class="exp-png" onclick="exportCurrentPNG()">📸 Graph als PNG exportieren</button>' +
    '<button onclick="exportElementsCSV()">⤓ CSV</button>' +
    '<button onclick="exportPDF()">🖨 PDF</button>' +
  '</span>');
  h.push('</div>');

  h.push('<div id="vp-list">');
  if (res.diags.length) {
    h.push('<h3>Gefundene Sichten / Diagramme (' + res.diags.length + ')</h3>');
    h.push('<div class="diag-cards">');
    for (i = 0; i < res.diags.length && i < 24; i++) {
      var d = res.diags[i];
      h.push('<div class="dcard">' +
        '<div><div class="dcard-title" onclick="openDiagramView(' + d.id + ')">🖼️ ' + esc(d.name) + '</div>' +
        '<div class="dcard-path">📁 ' + esc(d.pkgPath) + '</div>' +
        '<div class="dcard-badges"><span class="b b-els">' + d.objCount + ' El.</span><span class="b b-rel">' + d.linkCount + ' Kanten</span></div></div>' +
        '<div class="dcard-acts">' +
          '<button class="btn-sm pri" onclick="openDiagramView(' + d.id + ')">🔍 Öffnen</button>' +
          '<button class="btn-sm amber" onclick="exportDiagramPNG(' + d.id + ')">📸 PNG</button>' +
          '<button class="btn-sm green" onclick="exportDiagramXLSX(' + d.id + ')">📊 Excel</button>' +
        '</div></div>');
    }
    h.push('</div>');
  }
  if (res.pkgs.length) {
    h.push('<h3>Gefundene Pakete (' + res.pkgs.length + ')</h3>');
    h.push('<div class="subpkg-grid">');
    for (i = 0; i < res.pkgs.length && i < 16; i++) {
      var p = res.pkgs[i];
      h.push('<div class="pkg-card" onclick="openPackage(' + p.id + ')"><div class="pkg-card-title">📁 ' + esc(p.name) + '</div><div class="pkg-card-meta">' + esc(p.path) + '<br><b>' + p.allDiagsCount + '</b> Sichten · <b>' + p.allObjsCount + '</b> Elemente</div></div>');
    }
    h.push('</div>');
  }
  h.push(renderDistBar(res.els, 'vp-list'));
  h.push('<h3>Gefundene Elemente (' + res.els.length + ')</h3>');
  if (!res.els.length) {
    h.push('<div class="hint">Keine Elemente gefunden.</div>');
  } else {
    h.push('<table class="data"><thead><tr><th>Name</th><th>Stereotype</th><th>Alias</th><th>Paketpfad</th><th>Sichten</th><th>Verb.</th></tr></thead><tbody>');
    for (i = 0; i < res.els.length && i < 200; i++) {
      var o = res.els[i];
      var dc = (OBJ_DIAGS[String(o.id)] || []).length;
      h.push('<tr class="clickable" onclick="openElement(\'' + o.id + '\')">' +
        '<td><b>' + esc(o.name) + '</b></td>' +
        '<td><code>' + esc(o.st) + '</code></td>' +
        '<td>' + esc(o.alias) + '</td>' +
        '<td class="dim">' + esc(o.pkg) + '</td>' +
        '<td>' + (dc ? '<span class="b b-diag">' + dc + '</span>' : '–') + '</td>' +
        '<td><span class="b b-rel">' + (CONNCOUNT[String(o.id)] || 0) + '</span></td>' +
      '</tr>');
    }
    h.push('</tbody></table>');
  }
  h.push('</div>');
  h.push('<div class="vp-graph" id="vp-graph" style="display:none"></div>');

  el('vpbox').innerHTML = h.join('');
  showView('vp');
}

/* ================================================================
   ELEMENT-STECKBRIEF & NACHBARSCHAFT
   ================================================================ */
function elementNeighborhood(oid, hops, cap) {
  oid = String(oid); cap = cap || 600;
  var set = {}, order = [oid], frontier = [oid], capped = false;
  var i, j, s, c, other;
  set[oid] = 1;
  for (s = 0; s < hops && !capped; s++) {
    var nf = [];
    for (i = 0; i < frontier.length; i++) {
      var fid = frontier[i];
      for (j = 0; j < CONS.length; j++) {
        c = CONS[j];
        var ca = String(c.a), cb = String(c.b);
        other = null;
        if (ca === fid) other = cb; else if (cb === fid) other = ca;
        if (other && !set[other]) {
          if (order.length >= cap) { capped = true; break; }
          set[other] = 1; order.push(other); nf.push(other);
        }
      }
      if (capped) break;
    }
    frontier = nf;
  }
  var els = [], rels = [];
  for (i = 0; i < order.length; i++) { if (OBJS[order[i]]) els.push(OBJS[order[i]]); }
  for (i = 0; i < CONS.length; i++) {
    c = CONS[i];
    if (set[String(c.a)] && set[String(c.b)]) rels.push(c);
  }
  return { els: els, rels: rels, capped: capped, count: order.length };
}

function vpsForStereotype(st) {
  var out = [], k;
  for (k in ADMBW_DATA.vp) {
    if (!ADMBW_DATA.vp.hasOwnProperty(k)) continue;
    if (ADMBW_DATA.vp[k].els && ADMBW_DATA.vp[k].els.indexOf(st) >= 0) out.push(k);
  }
  return out;
}

function openElement(oid, mode) {
  oid = String(oid);
  var o = OBJS[oid];
  if (!o) return;
  var d = el('gsres'); if (d) d.style.display = 'none';
  var i, c, other;
  var outgoing = [], incoming = [];
  for (i = 0; i < CONS.length; i++) {
    c = CONS[i];
    if (String(c.a) === oid) outgoing.push(c);
    else if (String(c.b) === oid) incoming.push(c);
  }
  var nb = elementNeighborhood(oid, 1, 500);
  CURDATA = { els: nb.els, rels: nb.rels, diags: [] };
  G.mode = 'elem'; G.root = oid; G.hops = 1; G.capped = nb.capped; G.built = false;
  EXPCTX = { fname: 'Element_' + (o.name || 'Steckbrief'), kind: 'Element-Umfeld (1 Ebene)', label: 'Element: ' + (o.name || '(ohne Name)') };
  PRINTCTX = 'Element – ' + (o.name || '') + ' «' + (o.st || '') + '»';

  var usedDiagIds = OBJ_DIAGS[oid] || [];
  var h = [];
  h.push('<div class="crumb"><a href="javascript:showView(\'explorer\')">🧭 Erkunden</a>' +
    (o.pkgId && PKG[o.pkgId] ? ' &nbsp;·&nbsp; 📁 <a href="javascript:openPackage(' + o.pkgId + ')">' + esc(o.pkg) + '</a>' : '') +
    ' &nbsp;▸&nbsp; <b>📦 ' + esc(o.name || '(ohne Name)') + '</b></div>');

  h.push('<h2>📦 ' + esc(o.name || '(ohne Name)') + '</h2>');
  h.push('<div class="kpis">' +
    '<span>Stereotype: <code>' + esc(o.st || '–') + '</code></span>' +
    '<span><b>' + (CONNCOUNT[oid] || 0) + '</b> Verbindungen</span>' +
    '<span><b>' + usedDiagIds.length + '</b> vorhandene Sicht(en)</span>' +
    '<span class="dim">📁 ' + esc(o.pkg || '') + '</span>' +
  '</div>');
  if (o.alias) h.push('<div class="purpose"><b>Alias:</b> ' + esc(o.alias) + '</div>');
  if (o.note) h.push('<div class="purpose"><b>Beschreibung / Notiz:</b> ' + esc(o.note) + '</div>');

  h.push('<div class="vp-actions">');
  h.push('<span class="vswitch">Ansicht: ' +
    '<button id="btn-mode-list" class="' + (mode === 'graph' ? '' : 'on') + '" onclick="setVPMode(\'list\')">☰ Steckbrief &amp; Verwendung</button>' +
    '<button id="btn-mode-graph" class="' + (mode === 'graph' ? 'on' : '') + '" onclick="setVPMode(\'graph\')">◉ Umfeld im Graph visualisieren</button>' +
  '</span>');
  h.push('<span class="vswitch" style="margin-left:6px">🔗 Pfadanalyse: ' +
    '<button onclick="pathSetEndpoint(\'start\',\'' + oid + '\')" title="Dieses Element als Start der Verbindungsanalyse setzen">als Start setzen</button>' +
    '<button onclick="pathSetEndpoint(\'end\',\'' + oid + '\')" title="Dieses Element als Ziel der Verbindungsanalyse setzen">als Ziel setzen</button>' +
  '</span>');
  var veditBtns = (typeof EDIT === 'undefined') ? '' : ((o.type === 'Package')
    ? '<button onclick="EDIT.pkgEdit(EDIT.pkgIdForObject(\'' + oid + '\'))">✏️ Paket bearbeiten</button>'
    : '<button onclick="EDIT.elEdit(\'' + oid + '\')">✏️ Element bearbeiten</button>' +
      '<button onclick="EDIT.connNew(\'' + oid + '\')">＋ Beziehung</button>' +
      '<button class="delbtn" onclick="EDIT.elDel(\'' + oid + '\')">🗑 Löschen</button>');
  if (veditBtns) h.push('<span class="vedit">✏️ ' + veditBtns + '</span>');
  h.push('<span class="vexport">' +
    '<button class="exp-xls" onclick="exportCurrentXLSX()">📊 Umfeld als Excel (.xlsx)</button>' +
    '<button class="exp-png" onclick="exportCurrentPNG()">📸 Graph als PNG</button>' +
    '<button onclick="exportElementsCSV()">⤓ Elemente (CSV)</button>' +
    '<button onclick="exportRelsCSV()">⤓ Beziehungen (CSV)</button>' +
    '<button onclick="exportPDF()">🖨 PDF</button>' +
  '</span>');
  h.push('</div>');

  h.push('<div class="vp-list" id="vp-list">');

  /* NEU: Tatsächlich vorhandene Sichten (Diagramme), auf denen dieses Element vorkommt! */
  h.push('<h3>🖼️ Dargestellt auf vorhandenen Sichten / Diagrammen (' + usedDiagIds.length + ')</h3>');
  if (!usedDiagIds.length) {
    h.push('<div class="hint">Dieses Element ist auf keinem Diagramm direkt platziert (nur im Paketbaum/Modellkatalog geführt).</div>');
  } else {
    h.push('<div class="diag-cards">');
    for (i = 0; i < usedDiagIds.length; i++) {
      var dg = DIAGMAP[usedDiagIds[i]];
      if (!dg) continue;
      h.push('<div class="dcard">' +
        '<div><div class="dcard-title" onclick="openDiagramView(' + dg.id + ')">🖼️ ' + esc(dg.name) + '</div>' +
        '<div class="dcard-path">📁 ' + esc(dg.pkgPath) + '</div>' +
        '<div class="dcard-badges"><span class="b b-els">' + dg.objCount + ' El.</span><span class="b b-rel">' + dg.linkCount + ' Kanten</span></div></div>' +
        '<div class="dcard-acts">' +
          '<button class="btn-sm pri" onclick="openDiagramView(' + dg.id + ')">🔍 Sicht öffnen</button>' +
          '<button class="btn-sm amber" onclick="exportDiagramPNG(' + dg.id + ')">📸 PNG</button>' +
          '<button class="btn-sm green" onclick="exportDiagramXLSX(' + dg.id + ')">📊 Excel</button>' +
        '</div></div>');
    }
    h.push('</div>');
  }

  h.push('<div class="vpfilterwrap"><input class="vpfilter" placeholder="🔍 Beziehungen &amp; Eigenschaften filtern …" oninput="filterRows(this)"></div>');
  h.push('<h3>Ausgehende Beziehungen (' + outgoing.length + ')</h3>');
  if (!outgoing.length) h.push('<div class="hint">Keine ausgehenden Beziehungen.</div>');
  else {
    h.push('<table class="data"><thead><tr><th>Ziel</th><th>Beziehung</th><th>Ziel-Stereotype</th><th>Paket</th><th style="width:36px"></th></tr></thead><tbody>');
    for (i = 0; i < outgoing.length && i < 300; i++) {
      c = outgoing[i];
      other = OBJS[String(c.b)];
      h.push('<tr class="clickable" onclick="openElement(\'' + String(c.b) + '\')"><td><b>' + esc(other ? other.name : '?') + '</b></td><td><code>' + esc(c.st || c.type || '→') + '</code></td><td>' + esc(other ? other.st : '') + '</td><td class="dim">' + esc(other ? other.pkg : '') + '</td><td>' + (typeof EDIT !== 'undefined' ? '<button class="btn-sm" style="padding:2px 7px;font-size:11px" onclick="event.stopPropagation();EDIT.connEdit(' + c.id + ')" title="Diese Beziehung bearbeiten">✏️</button>' : '') + '</td></tr>');
    }
    h.push('</tbody></table>');
  }

  h.push('<h3>Eingehende Beziehungen (' + incoming.length + ')</h3>');
  if (!incoming.length) h.push('<div class="hint">Keine eingehenden Beziehungen.</div>');
  else {
    h.push('<table class="data"><thead><tr><th>Quelle</th><th>Beziehung</th><th>Quelle-Stereotype</th><th>Paket</th><th style="width:36px"></th></tr></thead><tbody>');
    for (i = 0; i < incoming.length && i < 300; i++) {
      c = incoming[i];
      other = OBJS[String(c.a)];
      h.push('<tr class="clickable" onclick="openElement(\'' + String(c.a) + '\')"><td><b>' + esc(other ? other.name : '?') + '</b></td><td><code>' + esc(c.st || c.type || '→') + '</code></td><td>' + esc(other ? other.st : '') + '</td><td class="dim">' + esc(other ? other.pkg : '') + '</td><td>' + (typeof EDIT !== 'undefined' ? '<button class="btn-sm" style="padding:2px 7px;font-size:11px" onclick="event.stopPropagation();EDIT.connEdit(' + c.id + ')" title="Diese Beziehung bearbeiten">✏️</button>' : '') + '</td></tr>');
    }
    h.push('</tbody></table>');
  }

  var tags = TAGS[oid] || [];
  h.push('<h3>Tagged Values / Eigenschaften (' + tags.length + ')' + (typeof EDIT !== 'undefined' ? ' <button class="btn-sm" style="margin-left:8px;vertical-align:middle" onclick="EDIT.tagOpen(\'' + oid + '\')" title="Tags dieses Elements bearbeiten (ändern, ergänzen, entfernen)">🏷️ Bearbeiten</button>' : '') + '</h3>');
  if (!tags.length) h.push('<div class="hint">Keine Tagged Values zu diesem Element erfasst.</div>');
  else {
    h.push('<table class="data"><thead><tr><th>Eigenschaft</th><th>Wert</th><th>Notiz</th></tr></thead><tbody>');
    for (i = 0; i < tags.length && i < 150; i++) {
      h.push('<tr><td><b>' + esc(tags[i].p) + '</b></td><td>' + esc(shortLabel(tags[i].v, 140)) + '</td><td class="dim">' + esc(shortLabel(tags[i].n, 90)) + '</td></tr>');
    }
    h.push('</tbody></table>');
  }

  var vps = vpsForStereotype(o.st);
  h.push('<h3>Theoretische Zuordnung im ADMBw-Referenz-Grid (' + vps.length + ')</h3>');
  if (!vps.length) h.push('<div class="hint">Kein Standard-ADMBw-Viewpoint für Stereotyp „' + esc(o.st) + '“.</div>');
  else {
    h.push('<div class="rulelist">');
    for (i = 0; i < vps.length; i++) {
      var vp = ADMBW_DATA.vp[vps[i]];
      h.push('<span class="gchip vpchip" onclick="openVP(\'' + vps[i] + '\')" title="' + esc(vp.n) + '">' + esc(vps[i]) + ' <em>' + esc(shortLabel(vp.n, 34)) + '</em></span> ');
    }
    h.push('</div>');
  }
  h.push('</div>');
  h.push('<div class="vp-graph" id="vp-graph" style="display:none"></div>');

  el('vpbox').innerHTML = h.join('');
  showView('vp');
  setVPMode(mode === 'graph' ? 'graph' : 'list');
}

function elementExpand(hops) {
  if (!G.root) return;
  var res = elementNeighborhood(G.root, hops, 600);
  G.hops = hops;
  G.capped = res.capped;
  CURDATA = { els: res.els, rels: res.rels, diags: [] };
  G.keepFilters = true;
  G.built = false;
  initGraph();
}

function filterRows(inp) {
  var q = (inp.value || '').toLowerCase();
  var wrap = findUp(inp, 'vp-list') || el('vp-list') || document;
  var tables = wrap.querySelectorAll('table.data');
  for (var t = 0; t < tables.length; t++) {
    var tb = tables[t].getElementsByTagName('tbody')[0];
    if (!tb) continue;
    var rows = tb.getElementsByTagName('tr');
    for (var r = 0; r < rows.length; r++) {
      rows[r].style.display = (!q || rows[r].textContent.toLowerCase().indexOf(q) >= 0) ? '' : 'none';
    }
  }
}

/* ---------- Ansicht Umschalten (Liste / Graph) ---------- */
function setVPMode(m) {
  VPMODE = m;
  var scope = (CURVIEW === 'explorer') ? el('pkgmain') : el('vpbox');
  if (!scope) scope = document;
  var l = scope.querySelector('#vp-list, .vp-list'), g = scope.querySelector('#vp-graph, .vp-graph');
  if (l) { l.id = 'vp-list'; l.style.display = m === 'list' ? 'block' : 'none'; }
  if (g) { g.id = 'vp-graph'; g.style.display = m === 'graph' ? 'block' : 'none'; }
  var bl = scope.querySelector('#btn-mode-list'), bg = scope.querySelector('#btn-mode-graph');
  if (bl) bl.className = m === 'list' ? 'on' : '';
  if (bg) bg.className = m === 'graph' ? 'on' : '';
  if (m === 'graph' && g) initGraph(g);
}

/* ---------- Klickbares EA-Diagramm als SVG rendern ---------- */
function renderDiagram(diag, host) {
  if (!host) return;
  var objs = DIAGOBJ[diag.id] || [];
  var links = DIAGLINK[diag.id] || [];
  if (!objs.length) { host.innerHTML = '<div class="hint">Leeres Diagramm (keine platzierten Elemente).</div>'; return; }

  var minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  var i, o, rects = {};
  for (i = 0; i < objs.length; i++) {
    o = objs[i];
    var obj = OBJS[o.oid];
    if (!obj) continue;
    var x = o.l, y = -o.t, w = o.r - o.l, hgt = o.t - o.b;
    rects[o.oid] = { oid: o.oid, x: x, y: y, w: w, h: hgt, name: obj.name, st: obj.st, seq: o.seq || 0, type: obj.type };
    if (x < minX) minX = x;
    if (x + w > maxX) maxX = x + w;
    if (y < minY) minY = y;
    if (y + hgt > maxY) maxY = y + hgt;
  }
  if (minX === Infinity) { host.innerHTML = '<div class="hint">Leeres Diagramm.</div>'; return; }
  var pad = 20;
  var W = maxX - minX + 2 * pad, H = maxY - minY + 2 * pad;
  var fs = 11;
  var ox = -minX + pad, oy = -minY + pad;

  function clipseg(x1, y1, x2, y2, rx, ry, rw, rh) {
    var dx = x2 - x1, dy = y2 - y1, t = 1;
    if (dx > 0) t = Math.min(t, (rx + rw - x1) / dx); else if (dx < 0) t = Math.min(t, (rx - x1) / dx);
    if (dy > 0) t = Math.min(t, (ry + rh - y1) / dy); else if (dy < 0) t = Math.min(t, (ry - y1) / dy);
    return { x: x1 + dx * t, y: y1 + dy * t };
  }

  var parts = [];
  parts.push('<svg xmlns="http://www.w3.org/2000/svg" width="' + Math.round(W) + '" height="' + Math.round(H) + '" viewBox="0 0 ' + W + ' ' + H + '">');
  parts.push('<defs><marker id="arr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="#004471"/></marker></defs>');

  var cmap = DB._cmap || {};
  for (i = 0; i < links.length; i++) {
    var cn = cmap[links[i].cid];
    if (!cn) continue;
    var ra = rects[cn.a], rb = rects[cn.b];
    if (!ra || !rb || ra === rb) continue;
    var x1 = ra.x + ra.w / 2, y1 = ra.y + ra.h / 2, x2 = rb.x + rb.w / 2, y2 = rb.y + rb.h / 2;
    var p1 = clipseg(x1, y1, x2, y2, ra.x, ra.y, ra.w, ra.h);
    var p2 = clipseg(x2, y2, x1, y1, rb.x, rb.y, rb.w, rb.h);
    var mx = (p1.x + p2.x) / 2, my = (p1.y + p2.y) / 2;
    parts.push('<line x1="' + (p1.x + ox).toFixed(1) + '" y1="' + (p1.y + oy).toFixed(1) + '" x2="' + (p2.x + ox).toFixed(1) + '" y2="' + (p2.y + oy).toFixed(1) + '" stroke="#004471" stroke-width="1.3" marker-end="url(#arr)"/>');
    var llen = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
    if (cn.st && llen > 85) {
      parts.push('<text x="' + (mx + ox).toFixed(1) + '" y="' + ((my + oy) - 3).toFixed(1) + '" font-size="8.5" fill="#475569" text-anchor="middle" style="paint-order:stroke;stroke:#FFFFFF;stroke-width:2.5px">' + esc(cn.st.length > 28 ? cn.st.substring(0, 26) + '…' : cn.st) + '</text>');
    }
  }

  var list = [];
  for (var key in rects) { if (rects.hasOwnProperty(key)) list.push(rects[key]); }
  list.sort(function (a, b) { return a.seq - b.seq; });
  for (var bi = 0; bi < list.length; bi++) {
    var rc = list[bi];
    if (!rc.name && !rc.st) continue;
    if (/^proxyconn?ector$/i.test(rc.st)) continue;
    var isBoundary = (rc.type === 'Boundary');
    var isLane = /^(pool|lane)$/i.test(rc.st);
    var fill = stFill(rc.st), dash = '', stroke = stColor(rc.st);
    if (isBoundary) { fill = 'none'; dash = ' stroke-dasharray="5 4"'; stroke = '#8AA0B0'; }
    else if (isLane) { fill = '#EEF4F8'; stroke = '#004471'; }
    var clickAttr = (!isBoundary && rc.oid) ? ' class="diag-node" onclick="openElement(\'' + rc.oid + '\')"' : '';
    parts.push('<g' + clickAttr + '><title>' + esc(rc.name + (rc.st ? '  «' + rc.st + '»' : '') + ' — Klick öffnet Element-Steckbrief') + '</title>');
    parts.push('<rect x="' + (rc.x + ox).toFixed(1) + '" y="' + (rc.y + oy).toFixed(1) + '" width="' + rc.w.toFixed(1) + '" height="' + rc.h.toFixed(1) + '" rx="4" fill="' + fill + '" stroke="' + stroke + '" stroke-width="1.4"' + dash + '/>');
    var nm = rc.name.replace(/\r?\n/g, ' ');
    if (rc.st && !isBoundary && rc.w >= 58) {
      var bandTxt = '«' + rc.st + '»';
      if (isLane && nm) bandTxt = '«' + rc.st + '» ' + nm;
      var maxB = Math.max(6, Math.floor((rc.w - 10) / 4.6));
      if (bandTxt.length > maxB) bandTxt = bandTxt.substring(0, Math.max(5, maxB - 1)) + '…';
      parts.push('<rect x="' + (rc.x + ox).toFixed(1) + '" y="' + (rc.y + oy).toFixed(1) + '" width="' + rc.w.toFixed(1) + '" height="13" rx="3" fill="' + stroke + '" opacity="0.14"/>');
      parts.push('<text x="' + (rc.x + ox + rc.w / 2).toFixed(1) + '" y="' + (rc.y + oy + 9.5).toFixed(1) + '" font-size="7.5" font-weight="600" fill="' + stroke + '" text-anchor="middle">' + esc(bandTxt) + '</text>');
    }
    if (isBoundary) {
      var maxL = Math.max(6, Math.floor((rc.w - 10) / (fs * 0.66)));
      var lab = nm.length > maxL ? nm.substring(0, Math.max(3, maxL - 1)) + '…' : nm;
      parts.push('<text x="' + (rc.x + ox + 6).toFixed(1) + '" y="' + (rc.y + oy + 12).toFixed(1) + '" font-size="' + fs.toFixed(1) + '" font-weight="600" fill="#5A7285" text-anchor="start">' + esc(lab) + '</text>');
    } else if (isLane) {
      /* Name im Band */
    } else if (rc.w < 72) {
      var shortN = nm.length > 24 ? nm.substring(0, 22) + '…' : nm;
      parts.push('<text x="' + (rc.x + ox + rc.w + 4).toFixed(1) + '" y="' + (rc.y + oy + rc.h / 2 + 3).toFixed(1) + '" font-size="8.5" fill="#1A1A1A" text-anchor="start">' + esc(shortN) + '</text>');
    } else {
      var lines = [];
      var maxc = Math.max(6, Math.floor((rc.w - 8) / (fs * 0.66)));
      if (nm.length <= maxc) { lines.push(nm); }
      else {
        var cut = nm.lastIndexOf(' ', maxc);
        if (cut < 4) cut = maxc;
        lines.push(nm.substring(0, cut));
        var rest = nm.substring(cut + 1);
        if (rest.length > maxc) rest = rest.substring(0, Math.max(1, maxc - 1)) + '…';
        lines.push(rest);
      }
      var ty = rc.y + oy + 13 + (rc.h - 15) / 2 - (lines.length - 1) * (fs * 0.62);
      for (var li = 0; li < lines.length; li++) {
        parts.push('<text x="' + (rc.x + ox + rc.w / 2).toFixed(1) + '" y="' + (ty + li * fs * 1.2).toFixed(1) + '" font-size="' + fs.toFixed(1) + '" font-weight="600" fill="#1A1A1A" text-anchor="middle">' + esc(lines[li]) + '</text>');
      }
    }
    parts.push('</g>');
  }
  parts.push('</svg>');
  host.innerHTML = parts.join('');
}

/* ================================================================
   PRÄGNANTE GRAPH-VISUALISIERUNG v3.0
   (Manuelle Knotenzahl + Schieberegler step=1 + 3 Layouts + PNG/Excel)
   ================================================================ */
function openGlobalGraph() {
  /* Wenn noch keine spezifische Sicht geladen oder der Nutzer auf den Graph-Reiter klickt:
     Aktuelle Auswahl (oder das gesamte Modell) im großen Graph-Modus öffnen */
  if (!CURDATA || !CURDATA.els || !CURDATA.els.length) {
    var allEls = [];
    for (var oid in OBJS) {
      if (!OBJS.hasOwnProperty(oid)) continue;
      var o = OBJS[oid];
      if (o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
      allEls.push(o);
    }
    CURDATA = { els: allEls, rels: CONS.slice(0), diags: DIAGS };
    EXPCTX = { fname: 'Gesamtmodell_Graph', kind: 'Gesamtmodell', label: 'Gesamtarchitektur: ' + MODELLNAME };
    PRINTCTX = 'Gesamtarchitektur-Graph: ' + MODELLNAME;
    G.mode = 'all'; G.root = null; G.built = false;
  }
  var h = [];
  h.push('<div class="crumb"><a href="javascript:showView(\'explorer\')">🧭 Erkunden</a> &nbsp;·&nbsp; <a href="javascript:showView(\'diags\')">🖼️ Sichten</a> &nbsp;▸&nbsp; <b>🕸️ Interaktiver Architektur-Graph</b></div>');
  h.push('<div style="display:flex;flex-wrap:wrap;justify-content:space-between;align-items:center;gap:10px">' +
    '<h2>🕸️ Architektur-Graph: ' + esc((EXPCTX && EXPCTX.label) || MODELLNAME) + '</h2>' +
    '<div>' +
      '<button class="btn-sm" onclick="loadFullModelIntoGraph()">🌐 Gesamtes Modell in den Graph laden (' + Object.keys(OBJS).length + ' Elemente)</button> ' +
      '<button class="btn-sm amber" onclick="exportGraphPNG()">📸 Graph als PNG</button> ' +
      '<button class="btn-sm green" onclick="exportGraphXLSX()">📊 Graph als Excel (.xlsx)</button>' +
    '</div></div>');
  h.push('<div class="vp-graph" id="vp-graph" style="display:block"></div>');
  el('vpbox').innerHTML = h.join('');
  showView('vp', 'graphhub');
  VPMODE = 'graph';
  G.built = false;
  initGraph(el('vp-graph'));
}

function loadFullModelIntoGraph() {
  var allEls = [];
  for (var oid in OBJS) {
    if (!OBJS.hasOwnProperty(oid)) continue;
    var o = OBJS[oid];
    if (o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
    allEls.push(o);
  }
  CURDATA = { els: allEls, rels: CONS.slice(0), diags: DIAGS };
  EXPCTX = { fname: 'Gesamtmodell_Graph', kind: 'Gesamtmodell', label: 'Gesamtarchitektur: ' + MODELLNAME };
  PRINTCTX = 'Gesamtarchitektur-Graph: ' + MODELLNAME;
  G.mode = 'all'; G.root = null; G.built = false;
  openGlobalGraph();
}

function getActiveGraphHost() {
  if (CURVIEW === 'explorer' && el('pkgmain')) {
    var g1 = el('pkgmain').querySelector('#vp-graph');
    if (g1) return g1;
  }
  return el('vp-graph');
}

function initGraph(hostOverride) {
  var host = hostOverride || getActiveGraphHost();
  if (!host) return;
  G.hostEl = host;

  var i;
  var nodes = [], byId = {};
  for (i = 0; i < CURDATA.els.length; i++) {
    var o = CURDATA.els[i];
    if (o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
    var n = { id: String(o.id), name: o.name, st: o.st, alias: o.alias, pkg: o.pkg, deg: 0, x: 0, y: 0, dx: 0, dy: 0 };
    nodes.push(n); byId[String(o.id)] = n;
    if (!G.keepFilters || !G.f.types.hasOwnProperty(o.st)) G.f.types[o.st] = true;
  }
  var links = [], relTypes = {};
  for (i = 0; i < CURDATA.rels.length; i++) {
    var c = CURDATA.rels[i];
    var na = byId[String(c.a)], nb = byId[String(c.b)];
    if (!na || !nb || na === nb) continue;
    var rst = c.st || c.type || 'Verbindung';
    links.push({ a: String(c.a), b: String(c.b), st: rst, na: na, nb: nb });
    relTypes[rst] = (relTypes[rst] || 0) + 1;
  }
  for (i = 0; i < links.length; i++) { links[i].na.deg++; links[i].nb.deg++; }

  var typeCount = {};
  for (i = 0; i < nodes.length; i++) typeCount[nodes[i].st] = (typeCount[nodes[i].st] || 0) + 1;

  G.baseNodes = nodes;
  G.baseLinks = links;
  G.typeCount = typeCount;
  G.relTypes = relTypes;

  if (!G.keepFilters) {
    G.pos = {};
    var defMax = Math.min(Math.max(nodes.length, 10), 120);
    G.f = { q: '', types: {}, rels: {}, only: links.length > 0, maxN: defMax, hops: 0 };
    for (var tk in typeCount) if (typeCount.hasOwnProperty(tk)) G.f.types[tk] = true;
    for (var rk in relTypes) if (relTypes.hasOwnProperty(rk)) G.f.rels[rk] = true;
  }
  G.keepFilters = false;
  G.built = true;

  G.nbr = {};
  for (i = 0; i < links.length; i++) {
    var l = links[i];
    if (!G.nbr[l.a]) G.nbr[l.a] = [];
    if (!G.nbr[l.b]) G.nbr[l.b] = [];
    G.nbr[l.a].push({ id: l.b, st: l.st, dir: 1 });
    G.nbr[l.b].push({ id: l.a, st: l.st, dir: -1 });
  }

  if (G.mode === 'elem' && G.root && byId[String(G.root)]) {
    G.focus = String(G.root);
    var fset0 = {}; fset0[String(G.root)] = true;
    var rn0 = G.nbr[String(G.root)] || [];
    for (i = 0; i < rn0.length; i++) fset0[rn0[i].id] = true;
    G.fset = fset0;
  } else {
    G.focus = null; G.fset = null;
  }

  buildGraphPanel(host);
  syncGraphPanelUI();
  applyGraphFilters(true);
}

function syncGraphPanelUI() {
  var slider = el('gmax'), numInp = el('gmaxnum');
  if (slider) slider.value = G.f.maxN;
  if (numInp) numInp.value = G.f.maxN;
  if (el('gq')) el('gq').value = G.f.q;
  if (el('gonly')) el('gonly').checked = G.f.only;
}

/* Synchronisierte Steuerung: Schieberegler + Manuelles Zahlenfeld + Schnellwahl-Pills! */
function graphSetMaxN(val, fromInput) {
  var total = Math.max(1, G.baseNodes.length || 500);
  var n = parseInt(val, 10);
  if (isNaN(n) || n < 1) n = 1;
  if (n > 5000) n = 5000;
  G.f.maxN = n;
  G.pos = {};
  var slider = el('gmax'), numInp = el('gmaxnum');
  if (slider) {
    if (n > parseInt(slider.max, 10)) slider.max = String(n);
    if (fromInput !== 'slider') slider.value = String(n);
  }
  if (numInp && String(numInp.value) !== String(n)) {
    numInp.value = String(n);
  }
  var pills = document.querySelectorAll('.gpill');
  for (var i = 0; i < pills.length; i++) {
    var pv = parseInt(pills[i].getAttribute('data-n'), 10);
    pills[i].className = 'gpill' + (pv === n ? ' on' : '');
  }
  applyGraphFilters(true);
}

function graphSetLayout(lay) {
  G.layout = lay;
  G.pos = {};
  var btns = document.querySelectorAll('.glay-btn');
  for (var i = 0; i < btns.length; i++) {
    btns[i].className = (btns[i].getAttribute('data-lay') === lay) ? 'on' : '';
  }
  graphSim();
}

function graphSetLblMode(m) {
  G.lblMode = m;
  drawGraph(true);
}

function graphToggleEdgeLbl(cb) {
  G.showEdgeLbl = !!cb.checked;
  drawGraph(true);
}

function buildGraphPanel(host) {
  host = host || getActiveGraphHost();
  if (!host) return;
  var maxSlider = Math.max(50, G.baseNodes.length || 300);
  var i, k, h = [];
  h.push('<div class="gwrap">');
  h.push('<div class="gpanel">');
  h.push('<div class="ghead">🎛️ Graph-Steuerung &amp; Filter</div>');

  h.push('<div class="grow"><input id="gq" class="gq" placeholder="🔍 Knoten im Graph filtern …" oninput="graphQuickChange()"></div>');
  h.push('<div class="grow"><label class="gcb"><input type="checkbox" id="gonly" ' + (G.f.only ? 'checked ' : '') + 'onchange="applyGraphFilters(true)"> Nur verbundene Knoten zeigen</label></div>');

  /* FEINGRANULARE KNOTENANZAHL: Manuelles Zahlenfeld + Schieberegler (step=1) + Schnellwahl */
  h.push('<div class="grow" style="background:#F8FAFC;border:1px solid var(--border);border-radius:8px;padding:8px 10px">');
  h.push('<div class="g-num-row">' +
    '<label for="gmaxnum" style="font-weight:700;color:var(--bw-blue);font-size:12px">Max. Knotenanzahl:</label>' +
    '<input type="number" id="gmaxnum" class="g-num-inp" min="1" max="5000" step="1" value="' + G.f.maxN + '" title="Knotenanzahl manuell eingeben" oninput="graphSetMaxN(this.value, \'number\')">' +
  '</div>');
  h.push('<input type="range" id="gmax" style="width:100%;accent-color:var(--bw-blue);cursor:pointer" min="1" max="' + maxSlider + '" step="1" value="' + G.f.maxN + '" oninput="graphSetMaxN(this.value, \'slider\')">');
  var allN = Math.max(1, G.baseNodes.length);
  h.push('<div class="g-quick-pills">' +
    '<span class="gpill" data-n="15" onclick="graphSetMaxN(15)">15</span>' +
    '<span class="gpill" data-n="30" onclick="graphSetMaxN(30)">30</span>' +
    '<span class="gpill" data-n="50" onclick="graphSetMaxN(50)">50</span>' +
    '<span class="gpill" data-n="100" onclick="graphSetMaxN(100)">100</span>' +
    '<span class="gpill" data-n="250" onclick="graphSetMaxN(250)">250</span>' +
    '<span class="gpill" data-n="' + allN + '" onclick="graphSetMaxN(' + allN + ')">Alle (' + allN + ')</span>' +
  '</div>');
  h.push('</div>');

  /* Layout-Wahl */
  h.push('<div class="gsect"><b>Darstellungs-Layout</b>' +
    '<div class="gbtns" style="margin-top:4px">' +
      '<button class="glay-btn' + (G.layout === 'force' ? ' on' : '') + '" data-lay="force" onclick="graphSetLayout(\'force\')" title="Kraftbasiertes Cluster-Netzwerk">⚡ Netzwerk</button>' +
      '<button class="glay-btn' + (G.layout === 'layered' ? ' on' : '') + '" data-lay="layered" onclick="graphSetLayout(\'layered\')" title="Geordnet nach Architektur-Schichten (Konzept → Service → Logisch → Technik)">🏛️ Schichten</button>' +
      '<button class="glay-btn' + (G.layout === 'radial' ? ' on' : '') + '" data-lay="radial" onclick="graphSetLayout(\'radial\')" title="Konzentrische Ringe um das zentrale Element">🎯 Radial</button>' +
    '</div></div>');

  if (G.mode === 'elem' && G.root) {
    var rn = OBJS[String(G.root)];
    h.push('<div class="gsect"><b>Umfeld-Tiefe von:</b><div class="dim">' + esc(rn ? rn.name : '') + '</div>');
    h.push('<div class="gbtns" style="margin-top:4px">Ebenen: ' +
      '<button class="' + (G.hops === 1 ? 'on' : '') + '" onclick="elementExpand(1)">1 Ebene</button>' +
      '<button class="' + (G.hops === 2 ? 'on' : '') + '" onclick="elementExpand(2)">2 Ebenen</button>' +
      '<button class="' + (G.hops === 3 ? 'on' : '') + '" onclick="elementExpand(3)">3 Ebenen</button>' +
    '</div>');
    h.push('<div class="dim" id="glvl">aktuell: ' + G.hops + ' Ebene(n) · ' + G.baseNodes.length + ' Knoten</div></div>');
  }

  h.push('<div class="gsect"><b>Elementtypen</b> <span class="dim">(Klick = ein/aus)</span>' +
    '<div style="margin:3px 0"><a href="javascript:graphAllTypes(true)" style="font-size:11px;color:var(--bw-blue)">Alle an</a> · <a href="javascript:graphAllTypes(false)" style="font-size:11px;color:var(--bw-blue)">Alle aus</a></div>' +
    '<div class="gchips" id="gtypes"></div></div>');
  h.push('<div class="gsect"><b>Beziehungstypen</b><div class="gchips" id="grels"></div></div>');

  h.push('<div class="gsect"><b>Fokus &amp; Isolation</b><div class="dim" id="gfocus">Knoten anklicken für Details (Doppelklick = Nachbarschaft isolieren)</div>' +
    '<div class="grow" id="ghops" style="display:' + (G.focus ? 'block' : 'none') + '">Nachbarschaft isolieren: <select id="ghopsel" onchange="applyGraphFilters(true)"><option value="0">Aus (alle zeigen)</option><option value="1">1 Ebene um Fokus</option><option value="2">2 Ebenen um Fokus</option><option value="3">3 Ebenen um Fokus</option></select></div></div>');
  h.push('<div class="gsect dim" id="gstat"></div>');
  h.push('</div>'); /* /gpanel */

  /* Rechte Hauptspalte: Toolbar + Farblegende + Großer Canvas + Info-Steckbrief */
  h.push('<div class="gmain">');
  h.push('<div class="gtoolbar">' +
    '<div class="gbtns">' +
      '<b>Zoom &amp; Beschriftung:</b> ' +
      '<button onclick="graphZoom(0.5, 0.5, 0.82)">🔍＋</button>' +
      '<button onclick="graphZoom(0.5, 0.5, 1.22)">🔍－</button>' +
      '<button onclick="graphResetView()">⛶ Einpassen</button>' +
      '<button onclick="graphRelayout()">🔄 Neu berechnen</button>' +
      '<span style="margin-left:6px">Labels: ' +
        '<select onchange="graphSetLblMode(this.value)" style="padding:3px 6px;border:1px solid #C6D2DA;border-radius:5px;font-size:11.5px">' +
          '<option value="auto"' + (G.lblMode === 'auto' ? ' selected' : '') + '>Automatisch</option>' +
          '<option value="all"' + (G.lblMode === 'all' ? ' selected' : '') + '>Alle Knoten beschriften</option>' +
          '<option value="hubs"' + (G.lblMode === 'hubs' ? ' selected' : '') + '>Nur Hauptknoten</option>' +
        '</select>' +
      '</span> ' +
      '<label style="margin-left:6px;cursor:pointer"><input type="checkbox" ' + (G.showEdgeLbl ? 'checked ' : '') + 'onchange="graphToggleEdgeLbl(this)"> Beziehungsnamen an Pfeilen</label>' +
    '</div>' +
    '<div class="gbtns">' +
      '<button style="background:#FEF3C7;color:#92400E;border-color:#F59E0B" onclick="exportGraphPNG()">📸 Graph als PNG</button>' +
      '<button style="background:#E6F4F1;color:#065F46;border-color:#10B981" onclick="exportGraphXLSX()">📊 Graph als Excel (.xlsx)</button>' +
    '</div>' +
  '</div>');

  /* Farblegende der Architekturschichten */
  h.push('<div class="glegend"><span title="Farben gemäß ADMBw/NAFv4: hell = Elementfüllung, Rand = Schichtfarbe"><b>Schicht-Farben (ADMBw/NAFv4):</b></span>');
  for (var ck in CAT_META) {
    if (!CAT_META.hasOwnProperty(ck)) continue;
    h.push('<span class="gleg-item"><i class="gleg-dot" style="background:' + CAT_META[ck].fill + ';border:2px solid ' + CAT_META[ck].color + ';border-radius:50%"></i>' + esc(CAT_META[ck].label) + '</span>');
  }
  h.push('</div>');

  h.push('<div class="gcanvas" id="gcanvas"><div class="hint" style="padding:24px">Graph-Layout wird berechnet …</div></div>');
  h.push('<div class="ginfo" id="ginfo" style="display:none"></div>');
  h.push('</div>'); /* /gmain */
  h.push('</div>'); /* /gwrap */
  host.innerHTML = h.join('');

  var tc = [], t, types = [];
  for (k in G.typeCount) { if (G.typeCount.hasOwnProperty(k)) types.push(k); }
  types.sort(function (a, b) { return G.typeCount[b] - G.typeCount[a]; });
  for (i = 0; i < types.length; i++) {
    t = types[i];
    tc.push('<span class="gchip' + (G.f.types[t] ? '' : ' off') + '" onclick="graphToggleType(\'' + esc(t).replace(/'/g, '&#39;') + '\')"><i style="background:' + stColor(t) + '"></i>' + esc(t || '(ohne)') + ' <em>' + G.typeCount[t] + '</em></span>');
  }
  if (el('gtypes')) el('gtypes').innerHTML = tc.join('') || '<span class="dim">—</span>';

  var rc = [], rels = [];
  for (k in G.relTypes) { if (G.relTypes.hasOwnProperty(k)) rels.push(k); }
  rels.sort(function (a, b) { return G.relTypes[b] - G.relTypes[a]; });
  for (i = 0; i < rels.length; i++) {
    t = rels[i];
    if (!G.f.rels.hasOwnProperty(t)) G.f.rels[t] = true;
    rc.push('<span class="gchip rel' + (G.f.rels[t] ? '' : ' off') + '" onclick="graphToggleRel(\'' + esc(t).replace(/'/g, '&#39;') + '\')">' + esc(t) + ' <em>' + G.relTypes[t] + '</em></span>');
  }
  if (el('grels')) el('grels').innerHTML = rc.join('') || '<span class="dim">—</span>';
}

function graphAllTypes(on) {
  for (var k in G.typeCount) {
    if (G.typeCount.hasOwnProperty(k)) G.f.types[k] = !!on;
  }
  buildGraphPanel(G.hostEl);
  syncGraphPanelUI();
  applyGraphFilters(true);
}

function graphQuickChange() {
  var q = el('gq'); if (q) G.f.q = q.value;
  applyGraphFilters(false);
}
function graphToggleType(t) {
  G.f.types[t] = !G.f.types[t];
  buildGraphPanel(G.hostEl);
  syncGraphPanelUI();
  applyGraphFilters(false);
}
function graphToggleRel(t) {
  G.f.rels[t] = !G.f.rels[t];
  buildGraphPanel(G.hostEl);
  syncGraphPanelUI();
  applyGraphFilters(false);
}

function applyGraphFilters(doLayout) {
  var i, j;
  var only = el('gonly') ? el('gonly').checked : G.f.only;
  G.f.only = only;
  var q = (el('gq') ? el('gq').value : G.f.q) || '';
  G.f.q = q;
  var ql = q.toLowerCase();

  var links = [];
  for (i = 0; i < G.baseLinks.length; i++) {
    if (G.f.rels[G.baseLinks[i].st] === false) continue;
    links.push(G.baseLinks[i]);
  }
  var nodeSet = {}, keep = [];
  for (i = 0; i < G.baseNodes.length; i++) {
    var n = G.baseNodes[i];
    if (!G.f.types[n.st]) continue;
    if (ql && (n.name + ' ' + n.alias + ' ' + n.st).toLowerCase().indexOf(ql) < 0) continue;
    nodeSet[n.id] = n;
    keep.push(n);
  }
  var flinks = [];
  for (i = 0; i < links.length; i++) {
    if (nodeSet[links[i].a] && nodeSet[links[i].b]) flinks.push(links[i]);
  }
  if (G.f.only && flinks.length > 0) {
    var deg = {};
    for (i = 0; i < flinks.length; i++) { deg[flinks[i].a] = (deg[flinks[i].a] || 0) + 1; deg[flinks[i].b] = (deg[flinks[i].b] || 0) + 1; }
    var keep2 = [];
    for (i = 0; i < keep.length; i++) {
      if (deg[keep[i].id]) keep2.push(keep[i]);
    }
    keep = keep2;
  }

  var hops = el('ghopsel') ? parseInt(el('ghopsel').value, 10) || 0 : G.f.hops;
  G.f.hops = hops;
  if (hops > 0 && G.focus) {
    var allowed = {}, frontier = [G.focus];
    allowed[G.focus] = true;
    for (var s = 0; s < hops; s++) {
      var nf = [];
      for (i = 0; i < frontier.length; i++) {
        var nb = G.nbr[frontier[i]] || [];
        for (j = 0; j < nb.length; j++) {
          if (!allowed[nb[j].id]) { allowed[nb[j].id] = true; nf.push(nb[j].id); }
        }
      }
      frontier = nf;
    }
    var keep3 = [];
    for (i = 0; i < keep.length; i++) { if (allowed[keep[i].id]) keep3.push(keep[i]); }
    keep = keep3;
    var fl2 = [];
    for (i = 0; i < flinks.length; i++) { if (allowed[flinks[i].a] && allowed[flinks[i].b]) fl2.push(flinks[i]); }
    flinks = fl2;
  }

  /* Max. Knoten (Top nach Verbindungsgrad + verbundene Nachbarn bevorzugen) */
  if (keep.length > G.f.maxN) {
    var sorted = keep.slice(0);
    sorted.sort(function (a, b) {
      if (G.focus) {
        if (a.id === G.focus) return -1;
        if (b.id === G.focus) return 1;
      }
      return b.deg - a.deg;
    });
    var adjMap = {};
    for (i = 0; i < flinks.length; i++) {
      if (!adjMap[flinks[i].a]) adjMap[flinks[i].a] = [];
      if (!adjMap[flinks[i].b]) adjMap[flinks[i].b] = [];
      adjMap[flinks[i].a].push(nodeSet[flinks[i].b]);
      adjMap[flinks[i].b].push(nodeSet[flinks[i].a]);
    }
    var cut = {}, fin = [];
    for (i = 0; i < sorted.length && fin.length < G.f.maxN; i++) {
      var seed = sorted[i];
      if (!cut[seed.id]) {
        cut[seed.id] = seed;
        fin.push(seed);
      }
      if (G.f.only && adjMap[seed.id]) {
        var nbs = adjMap[seed.id].slice(0).sort(function (x, y) { return y.deg - x.deg; });
        for (j = 0; j < nbs.length && fin.length < G.f.maxN && j < 5; j++) {
          if (nbs[j] && !cut[nbs[j].id]) {
            cut[nbs[j].id] = nbs[j];
            fin.push(nbs[j]);
          }
        }
      }
    }
    keep = fin;
    var fl3 = [];
    for (i = 0; i < flinks.length; i++) { if (cut[flinks[i].a] && cut[flinks[i].b]) fl3.push(flinks[i]); }
    flinks = fl3;
  }

  /* Aktuellen Sicht-Grad je Knoten aktualisieren */
  var vdeg = {};
  for (i = 0; i < flinks.length; i++) {
    vdeg[flinks[i].a] = (vdeg[flinks[i].a] || 0) + 1;
    vdeg[flinks[i].b] = (vdeg[flinks[i].b] || 0) + 1;
  }
  for (i = 0; i < keep.length; i++) keep[i].vdeg = vdeg[keep[i].id] || 0;

  G.viewNodes = keep;
  G.viewLinks = flinks;

  var stat = el('gstat');
  if (stat) stat.innerHTML = 'Angezeigt: <b>' + keep.length + '</b> von ' + G.baseNodes.length + ' Knoten · <b>' + flinks.length + '</b> von ' + G.baseLinks.length + ' Beziehungen';

  graphSim();
}

function layoutLayered(nodes) {
  /* Ordnet Knoten in 5 klaren horizontalen Architektur-Schichten (Top-Down) an */
  var bands = [[], [], [], [], []], i;
  for (i = 0; i < nodes.length; i++) {
    var cat = archCategory(nodes[i].st);
    var r = (CAT_META[cat] && CAT_META[cat].rank != null) ? CAT_META[cat].rank : 3;
    bands[r].push(nodes[i]);
  }
  var yStep = 145;
  var curY = -220;
  for (var b = 0; b < bands.length; b++) {
    var row = bands[b];
    if (!row.length) continue;
    row.sort(function (x, y) { return (y.vdeg || y.deg) - (x.vdeg || x.deg); });
    var cols = Math.min(row.length, Math.max(6, Math.ceil(Math.sqrt(row.length) * 2.2)));
    var xStep = 145;
    for (i = 0; i < row.length; i++) {
      var rIdx = Math.floor(i / cols);
      var cIdx = i % cols;
      var rowCount = Math.min(cols, row.length - rIdx * cols);
      row[i].x = (cIdx - (rowCount - 1) / 2) * xStep;
      row[i].y = curY + rIdx * 68;
      G.pos[row[i].id] = { x: row[i].x, y: row[i].y };
    }
    curY += yStep + Math.floor((row.length - 1) / cols) * 68;
  }
}

function layoutRadial(nodes, links) {
  /* Konzentrische Ringe um das Fokus-Element bzw. den stärksten Hub */
  var centerId = G.focus;
  var i, j;
  if (!centerId || ! nodes.some(function (n) { return n.id === centerId; })) {
    var best = nodes[0];
    for (i = 1; i < nodes.length; i++) if ((nodes[i].vdeg || nodes[i].deg) > (best.vdeg || best.deg)) best = nodes[i];
    centerId = best ? best.id : null;
  }
  var dist = {}, adj = {};
  for (i = 0; i < nodes.length; i++) adj[nodes[i].id] = [];
  for (i = 0; i < links.length; i++) {
    if (adj[links[i].a] && adj[links[i].b]) {
      adj[links[i].a].push(links[i].b);
      adj[links[i].b].push(links[i].a);
    }
  }
  if (centerId) {
    dist[centerId] = 0;
    var q = [centerId];
    while (q.length) {
      var cur = q.shift();
      var nbs = adj[cur] || [];
      for (i = 0; i < nbs.length; i++) {
        if (dist[nbs[i]] === undefined) {
          dist[nbs[i]] = dist[cur] + 1;
          q.push(nbs[i]);
        }
      }
    }
  }
  var rings = [[], [], [], [], []];
  for (i = 0; i < nodes.length; i++) {
    var d = dist[nodes[i].id];
    if (d === undefined || d > 4) d = 4;
    rings[d].push(nodes[i]);
  }
  for (var r = 0; r < rings.length; r++) {
    var list = rings[r];
    if (!list.length) continue;
    if (r === 0) {
      list[0].x = 0; list[0].y = 0;
      G.pos[list[0].id] = { x: 0, y: 0 };
    } else {
      var rad = r * 145 + Math.max(0, list.length - 12) * 3.5;
      for (j = 0; j < list.length; j++) {
        var ang = (j / list.length) * Math.PI * 2 - Math.PI / 2;
        list[j].x = Math.cos(ang) * rad;
        list[j].y = Math.sin(ang) * rad;
        G.pos[list[j].id] = { x: list[j].x, y: list[j].y };
      }
    }
  }
}

function graphSim() {
  var nodes = G.viewNodes;
  if (G.simTimer) { clearTimeout(G.simTimer); G.simTimer = null; }
  if (!nodes.length) { drawGraph(true); return; }

  if (G.layout === 'layered') {
    layoutLayered(nodes);
    G._autoFit = true;
    drawGraph(true);
    return;
  }
  if (G.layout === 'radial') {
    layoutRadial(nodes, G.viewLinks);
    G._autoFit = true;
    drawGraph(true);
    return;
  }

  var i;
  var R = Math.max(120, 28 * Math.sqrt(nodes.length));
  for (i = 0; i < nodes.length; i++) {
    var n = nodes[i];
    if (G.pos[n.id]) { n.x = G.pos[n.id].x; n.y = G.pos[n.id].y; }
    else {
      var ang = (i / nodes.length) * Math.PI * 2;
      var jit = ((i * 2654435761) % 1000) / 1000 - 0.5;
      n.x = Math.cos(ang) * R * (1 + jit * 0.15);
      n.y = Math.sin(ang) * R * (1 + jit * 0.15);
    }
  }
  var iters = nodes.length > 260 ? 150 : (nodes.length > 120 ? 200 : 280);
  var k = 96;
  var t0 = k * 1.3;
  var iter = 0;
  function stepSim() {
    var chunk = Math.max(6, Math.round(3000 / Math.max(1, nodes.length)));
    var temp;
    for (var s = 0; s < chunk && iter < iters; s++, iter++) {
      temp = t0 * (1 - iter / iters) + 0.3;
      simulateOnce(nodes, G.viewLinks, k, temp);
    }
    drawGraph(false);
    if (iter < iters) { G.simTimer = setTimeout(stepSim, 6); }
    else {
      G.simTimer = null;
      /* Ausreißer sanft begrenzen + Mindestabstand (Collision-Push) gegen Label-Überlappung */
      var maxR = Math.max(260, 62 * Math.sqrt(nodes.length)), q, p2;
      for (q = 0; q < nodes.length; q++) {
        var dist0 = Math.sqrt(nodes[q].x * nodes[q].x + nodes[q].y * nodes[q].y);
        if (dist0 > maxR) {
          nodes[q].x = (nodes[q].x / dist0) * maxR;
          nodes[q].y = (nodes[q].y / dist0) * maxR;
        }
      }
      var boxW = 165, boxH = 38;
      for (var pass = 0; pass < 14; pass++) {
        for (q = 0; q < nodes.length; q++) {
          for (p2 = q + 1; p2 < nodes.length; p2++) {
            var dx = nodes[q].x - nodes[p2].x, dy = nodes[q].y - nodes[p2].y;
            var adx = Math.abs(dx), ady = Math.abs(dy);
            if (adx < boxW && ady < boxH) {
              var ox = (boxW - adx) * 0.52, oy = (boxH - ady) * 0.52;
              if (ox < oy) {
                var sx = dx >= 0 ? 1 : -1;
                nodes[q].x += sx * ox * 0.5; nodes[p2].x -= sx * ox * 0.5;
              } else {
                var sy = dy >= 0 ? 1 : -1;
                nodes[q].y += sy * oy * 0.5; nodes[p2].y -= sy * oy * 0.5;
              }
            }
          }
        }
      }
      for (q = 0; q < nodes.length; q++) {
        G.pos[nodes[q].id] = { x: nodes[q].x, y: nodes[q].y };
      }
      G._autoFit = true;
      drawGraph(true);
    }
  }
  stepSim();
}

function simulateOnce(nodes, links, k, temp) {
  var i, j, dx, dy, d2, d, f, ux, uy, len, lim;
  var n = nodes.length;
  for (i = 0; i < n; i++) { nodes[i].dx = 0; nodes[i].dy = 0; }
  for (i = 0; i < n; i++) {
    var a = nodes[i];
    for (j = i + 1; j < n; j++) {
      var b = nodes[j];
      dx = a.x - b.x; dy = a.y - b.y;
      d2 = dx * dx + dy * dy;
      if (d2 < 1) { d2 = 1; dx = 0.05 + (i - j) * 0.01; dy = 0.05; }
      d = Math.sqrt(d2);
      f = (k * k * 1.1) / d;
      ux = dx / d; uy = dy / d;
      a.dx += ux * f; a.dy += uy * f;
      b.dx -= ux * f; b.dy -= uy * f;
    }
  }
  for (i = 0; i < links.length; i++) {
    var l = links[i];
    if (!l.na || !l.nb) continue;
    dx = l.nb.x - l.na.x; dy = l.nb.y - l.na.y;
    d2 = dx * dx + dy * dy; if (d2 < 1) d2 = 1;
    d = Math.sqrt(d2);
    f = d2 / k;
    ux = dx / d; uy = dy / d;
    l.na.dx += ux * f; l.na.dy += uy * f;
    l.nb.dx -= ux * f; l.nb.dy -= uy * f;
  }
  for (i = 0; i < n; i++) {
    var m = nodes[i];
    var grav = (m.vdeg && m.vdeg > 0) ? 0.14 : 0.42;
    m.dx += -m.x * grav;
    m.dy += -m.y * grav;
    len = Math.sqrt(m.dx * m.dx + m.dy * m.dy);
    if (len > 0) {
      lim = Math.min(len, temp);
      m.x += (m.dx / len) * lim;
      m.y += (m.dy / len) * lim;
    }
  }
}

function applyViewBox(svg) {
  if (!svg || !G.vb) return;
  svg.setAttribute('viewBox', G.vb.x.toFixed(1) + ' ' + G.vb.y.toFixed(1) + ' ' + G.vb.w.toFixed(1) + ' ' + G.vb.h.toFixed(1));
}
function graphFit() {
  var nodes = G.viewNodes;
  if (!nodes.length) { G.vb = { x: -100, y: -100, w: 200, h: 200 }; return; }
  var minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  for (var i = 0; i < nodes.length; i++) {
    var n = nodes[i];
    if (n.x < minX) minX = n.x; if (n.x > maxX) maxX = n.x;
    if (n.y < minY) minY = n.y; if (n.y > maxY) maxY = n.y;
  }
  var pad = 85;
  var w = maxX - minX + 2 * pad, h = maxY - minY + 2 * pad;
  if (w < 240) w = 240;
  if (h < 180) h = 180;
  G.vb = { x: minX - pad, y: minY - pad, w: w, h: h };
}
function graphResetView() {
  graphFit();
  applyViewBox(el('gsvg'));
}
function graphRelayout() {
  G.pos = {};
  graphSim();
}
function graphZoom(fx, fy, factor) {
  if (!G.vb) return;
  var vb = G.vb;
  var mx = vb.x + fx * vb.w, my = vb.y + fy * vb.h;
  var nw = vb.w * factor, nh = vb.h * factor;
  if (nw < 60 || nw > 25000) return;
  vb.x = mx - (mx - vb.x) * factor;
  vb.y = my - (my - vb.y) * factor;
  vb.w = nw; vb.h = nh;
  applyViewBox(el('gsvg'));
}

function drawGraph(final) {
  var host = el('gcanvas');
  if (!host) return;
  var nodes = G.viewNodes, links = G.viewLinks;
  if (!nodes.length) {
    host.innerHTML = '<div class="hint" style="padding:30px">Keine Knoten mit den aktuellen Filtern — bitte Filter anpassen oder „Nur verbundene Knoten“ deaktivieren.</div>';
    return;
  }
  var i;
  var showAll = (G.lblMode === 'all') || (G.lblMode === 'auto' && nodes.length <= 65);
  var degMin = G.lblMode === 'hubs' ? 4 : (nodes.length > 140 ? 5 : (nodes.length > 75 ? 3 : 2));
  var parts = [];
  var minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  for (i = 0; i < nodes.length; i++) {
    var n = nodes[i];
    if (n.x < minX) minX = n.x; if (n.x > maxX) maxX = n.x;
    if (n.y < minY) minY = n.y; if (n.y > maxY) maxY = n.y;
  }
  var pad = 85;
  var bx = minX - pad, by = minY - pad, bw = (maxX - minX) + 2 * pad, bh = (maxY - minY) + 2 * pad;
  if (!G.vb || G._autoFit) { G.vb = { x: bx, y: by, w: Math.max(bw, 240), h: Math.max(bh, 180) }; G._autoFit = false; }

  parts.push('<svg id="gsvg" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid meet" viewBox="' + G.vb.x.toFixed(1) + ' ' + G.vb.y.toFixed(1) + ' ' + G.vb.w.toFixed(1) + ' ' + G.vb.h.toFixed(1) + '">');
  parts.push('<defs>' +
    '<marker id="garr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6.5" markerHeight="6.5" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="#94A3B8"/></marker>' +
    '<marker id="garrH" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="#B45309"/></marker>' +
  '</defs>');

  /* Kanten */
  for (i = 0; i < links.length; i++) {
    var l = links[i];
    var hi = G.fset && G.fset[l.a] && G.fset[l.b];
    parts.push('<line class="gk' + (hi ? ' hi' : '') + '" x1="' + l.na.x.toFixed(1) + '" y1="' + l.na.y.toFixed(1) + '" x2="' + l.nb.x.toFixed(1) + '" y2="' + l.nb.y.toFixed(1) + '" marker-end="' + (hi ? 'url(#garrH)' : 'url(#garr)') + '"/>');
    if ((G.showEdgeLbl || hi) && l.st) {
      var mx = (l.na.x + l.nb.x) / 2, my = (l.na.y + l.nb.y) / 2;
      parts.push('<text class="gk-lbl" x="' + mx.toFixed(1) + '" y="' + (my - 3).toFixed(1) + '" text-anchor="middle">' + esc(shortLabel(l.st, 22)) + '</text>');
    }
  }

  /* Knoten (prägnant, mit Halo, Farb-Dot und Verbindungszahl) */
  for (i = 0; i < nodes.length; i++) {
    var nd = nodes[i];
    var degVal = nd.vdeg != null ? nd.vdeg : nd.deg;
    var r = 9 + Math.min(11, Math.sqrt(degVal) * 2.5);
    var dim = G.fset && !G.fset[nd.id];
    var sel = G.focus === nd.id;
    var col = stColor(nd.st), fl = stFill(nd.st);
    var showLbl = showAll || degVal >= degMin || sel || (G.fset && G.fset[nd.id]);
    var lbl = showLbl ? shortLabel(nd.name || '(ohne Name)', 28) : '';
    parts.push('<g class="gn' + (dim ? ' fdim' : '') + (sel ? ' fsel' : '') + '" data-oid="' + nd.id + '" transform="translate(' + nd.x.toFixed(1) + ',' + nd.y.toFixed(1) + ')">');
    if (sel) parts.push('<circle r="' + (r + 7).toFixed(1) + '" fill="none" stroke="#B45309" stroke-width="2.5" stroke-dasharray="4 2"/>');
    parts.push('<circle class="nshape" r="' + r.toFixed(1) + '" fill="' + fl + '" stroke="' + col + '"/>');
    if (degVal >= 1) {
      parts.push('<text y="3.5" text-anchor="middle" font-size="9" font-weight="700" fill="#1F2937" style="pointer-events:none">' + degVal + '</text>');
    }
    if (lbl) {
      parts.push('<text class="nlbl" y="' + (-r - 5).toFixed(1) + '" text-anchor="middle">' + esc(lbl) + '</text>');
      if ((sel || (G.fset && G.fset[nd.id])) && nd.st) {
        parts.push('<text class="nst" y="' + (r + 12).toFixed(1) + '" text-anchor="middle">«' + esc(shortLabel(nd.st, 22)) + '»</text>');
      }
    }
    parts.push('<title>' + esc(nd.name + (nd.st ? '  «' + nd.st + '»' : '') + ' (' + degVal + ' Verbindungen) — Klick: Fokus, Doppelklick: Nachbarschaft isolieren') + '</title>');
    parts.push('</g>');
  }
  parts.push('</svg>');
  host.innerHTML = parts.join('');

  var svg = el('gsvg');
  if (!svg) return;
  svg.addEventListener('mousedown', graphPanStart);
  svg.addEventListener('wheel', graphWheel, false);
  svg.addEventListener('click', graphClick);
  svg.addEventListener('dblclick', function (e) {
    var g = findUp(e.target, 'gn');
    if (!g) return;
    var oid = g.getAttribute('data-oid');
    G.focus = oid;
    var sel = el('ghopsel');
    if (sel && sel.value === '0') sel.value = '1';
    G._autoFit = true;
    applyGraphFilters(true);
  });
  if (final) renderGraphInfo();
}

var _pan = null, _panned = false;
function graphPanStart(e) {
  var svg = el('gsvg');
  if (!svg || !G.vb) return;
  var rect = svg.getBoundingClientRect();
  if (!rect.width) return;
  _panned = false;
  _pan = { sx: e.clientX, sy: e.clientY, vx: G.vb.x, vy: G.vb.y, kx: G.vb.w / rect.width, ky: G.vb.h / rect.height };
  window.addEventListener('mousemove', graphPanMove);
  window.addEventListener('mouseup', graphPanEnd);
}
function graphPanMove(e) {
  if (!_pan || !G.vb) return;
  if (Math.abs(e.clientX - _pan.sx) + Math.abs(e.clientY - _pan.sy) > 5) _panned = true;
  G.vb.x = _pan.vx - (e.clientX - _pan.sx) * _pan.kx;
  G.vb.y = _pan.vy - (e.clientY - _pan.sy) * _pan.ky;
  applyViewBox(el('gsvg'));
}
function graphPanEnd() {
  _pan = null;
  window.removeEventListener('mousemove', graphPanMove);
  window.removeEventListener('mouseup', graphPanEnd);
}
function graphWheel(e) {
  e.preventDefault();
  var svg = el('gsvg');
  if (!svg || !G.vb) return;
  var rect = svg.getBoundingClientRect();
  if (!rect.width) return;
  var fx = (e.clientX - rect.left) / rect.width;
  var fy = (e.clientY - rect.top) / rect.height;
  graphZoom(fx, fy, e.deltaY < 0 ? 0.85 : 1.18);
}
function graphClick(e) {
  if (_panned) { _panned = false; return; }
  var g = findUp(e.target, 'gn');
  if (g) {
    var oid = g.getAttribute('data-oid');
    graphFocus(oid);
  } else {
    G.focus = null; G.fset = null;
    var sel = el('ghopsel'); if (sel) sel.value = '0'; G.f.hops = 0;
    drawGraph(true);
    var fdiv = el('gfocus'); if (fdiv) fdiv.textContent = 'Knoten anklicken für Details (Doppelklick = Nachbarschaft isolieren)';
    var hops = el('ghops'); if (hops) hops.style.display = 'none';
  }
}
function graphFocus(oid) {
  var node = null, i;
  for (i = 0; i < G.baseNodes.length; i++) if (G.baseNodes[i].id === oid) { node = G.baseNodes[i]; break; }
  if (!node) return;
  G.focus = oid;
  var fs = {}; fs[oid] = true;
  var nb = G.nbr[oid] || [];
  for (i = 0; i < nb.length; i++) fs[nb[i].id] = true;
  G.fset = fs;
  drawGraph(true);
  var fdiv = el('gfocus');
  if (fdiv) fdiv.textContent = 'Fokus: ' + node.name;
  var hops = el('ghops');
  if (hops) hops.style.display = 'block';
}
function renderGraphInfo() {
  var box = el('ginfo');
  if (!box) return;
  if (!G.focus) { box.style.display = 'none'; return; }
  var node = null, i;
  for (i = 0; i < G.baseNodes.length; i++) if (G.baseNodes[i].id === G.focus) { node = G.baseNodes[i]; break; }
  if (!node) { box.style.display = 'none'; return; }
  var nb = G.nbr[G.focus] || [];
  var h = [];
  h.push('<div class="gi-head">' +
    '<span><span class="gi-dot" style="background:' + stColor(node.st) + '"></span><b>' + esc(node.name) + '</b> <code>' + esc(node.st) + '</code></span>' +
    '<span>' +
      '<button class="btn-sm pri" onclick="openElement(\'' + node.id + '\')">📋 Vollständigen Steckbrief öffnen</button> ' +
      '<button class="btn-sm" onclick="openElement(\'' + node.id + '\', \'graph\')">🎯 Als Umfeld-Zentrum öffnen</button> ' +
      '<button class="btn-sm" onclick="pathSetEndpoint(\'start\',\'' + node.id + '\')" title="Als Start der Verbindungsanalyse setzen">🔗 Als Start</button> ' +
      '<button class="btn-sm" onclick="pathSetEndpoint(\'end\',\'' + node.id + '\')" title="Als Ziel der Verbindungsanalyse setzen">🔗 Als Ziel</button>' +
    '</span>' +
  '</div>');
  h.push('<div class="gi-meta">' + (node.alias ? 'Alias: <b>' + esc(node.alias) + '</b> · ' : '') + '📁 Paket: ' + esc(node.pkg || '—') + ' · Vernetzung in dieser Sicht: <b>' + nb.length + '</b> Beziehungen</div>');
  if (nb.length) {
    h.push('<div class="gi-nbs">');
    for (i = 0; i < nb.length && i < 45; i++) {
      var x = OBJS[nb[i].id];
      if (!x) continue;
      var arrow = nb[i].dir > 0 ? '→' : '←';
      h.push('<div class="gi-nb" onclick="graphFocus(\'' + nb[i].id + '\')">' +
        '<span class="dim">' + arrow + ' <code>' + esc(shortLabel(nb[i].st, 26)) + '</code></span> ' +
        '<b>' + esc(x.name) + '</b> <span class="dim">«' + esc(x.st) + '»</span>' +
      '</div>');
    }
    if (nb.length > 45) h.push('<div class="dim">… ' + (nb.length - 45) + ' weitere Verbindungen</div>');
    h.push('</div>');
  }
  box.innerHTML = h.join('');
  box.style.display = 'block';
}

/* ---------- Hauptansicht wechseln ---------- */
function showView(v, activeTabOverride) {
  CURVIEW = v;
  if (v === 'vp' && el('pkgmain')) {
    var oldG = el('pkgmain').querySelector('#vp-graph');
    if (oldG) { oldG.innerHTML = ''; oldG.removeAttribute('id'); }
    var oldL = el('pkgmain').querySelector('#vp-list');
    if (oldL) { oldL.removeAttribute('id'); }
  } else if (v === 'explorer' && el('vpbox')) {
    el('vpbox').innerHTML = '';
  }
  var views = {
    explorer: el('view-explorer'),
    diags: el('view-diags'),
    grid: el('grid'),
    path: el('view-path'),
    vp: el('vp')
  };
  for (var k in views) {
    if (views.hasOwnProperty(k) && views[k]) {
      views[k].style.display = (k === v) ? 'block' : 'none';
    }
  }
  var tabKey = activeTabOverride || (v === 'vp' ? '' : v);
  var tabs = ['explorer', 'diags', 'graphhub', 'path', 'grid'];
  for (var i = 0; i < tabs.length; i++) {
    var tb = el('tab-' + tabs[i]);
    if (tb) tb.className = 'mtab' + (tabs[i] === tabKey ? ' on' : '');
  }
  updatePrintMeta();
}

/* ---------- Upload-Verdrahtung ---------- */
function wireUpload() {
  var zone = el('dropzone'), input = el('file');
  zone.onclick = function () { input.click(); };
  input.onchange = function () {
    if (input.files && input.files[0]) {
      var f = input.files[0];
      var rd = new FileReader();
      rd.onload = function () { loadQea(rd.result, f.name); };
      rd.readAsArrayBuffer(f);
    }
  };
  function handleFiles(files) {
    if (files && files[0]) {
      var f = files[0];
      var rd = new FileReader();
      rd.onload = function () { loadQea(rd.result, f.name); };
      rd.readAsArrayBuffer(f);
    }
  }
  zone.addEventListener('dragenter', function (e) { e.preventDefault(); zone.className = 'drop over'; });
  zone.addEventListener('dragover', function (e) { e.preventDefault(); zone.className = 'drop over'; });
  zone.addEventListener('dragleave', function (e) { e.preventDefault(); zone.className = 'drop'; });
  zone.addEventListener('drop', function (e) {
    e.preventDefault(); zone.className = 'drop';
    if (e.dataTransfer && e.dataTransfer.files) handleFiles(e.dataTransfer.files);
  });
  document.addEventListener('click', function (e) {
    var d = el('gsres');
    if (d && d.style.display === 'block' && !findUp(e.target, 'mbsearch')) d.style.display = 'none';
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', wireUpload);
} else { wireUpload(); }

/* ADMBw QEA Analyzer v4.0 — Teil 4: Verbindungs- und Pfadanalyse (experimentell)
   Inspiriert von ArAMIS Web (Architekturmanagement-Informationssystem der Bundeswehr).
   Findet die Verbindungskette zwischen zwei Elementen über t_connector-Beziehungen,
   visualisiert sie als Schritt-Kette, Tabelle und Graph und diagnostiziert fehlende
   Verbindungen (Komponenten, Erreichbarkeit, gemeinsame Nachbarn).
   100 % Vanilla-JS / ES5, keine Bibliotheken, offline. */

var PATH = { start: null, end: null, directed: false, maxHops: 5, mode: 'shortest', last: null, selPath: 0, ctx: false };
var PATH_ADJ = null, PATH_COMP = null;

/* ================================================================
   ALGORITHMEN: ADJAZENZLISTE, BFS (kürzester Pfad), BOUNDED DFS (Alternativpfade)
   ================================================================ */
function buildAdjacency() {
  var adj = {}, i, c, a, b;
  for (i = 0; i < CONS.length; i++) {
    c = CONS[i];
    a = String(c.a); b = String(c.b);
    if (a === b) continue;                       /* Selbstschlingen verwerfen */
    if (!OBJS[a] || !OBJS[b]) continue;          /* verwaiste Enden verwerfen */
    if (!adj[a]) adj[a] = [];
    if (!adj[b]) adj[b] = [];
    /* dir = +1: Kante läuft in Modellierungsrichtung (a -> b), -1: invers */
    adj[a].push({ to: b, cid: c.id, st: c.st || c.type || '', name: c.name || '', type: c.type || '', dir: 1 });
    adj[b].push({ to: a, cid: c.id, st: c.st || c.type || '', name: c.name || '', type: c.type || '', dir: -1 });
  }
  return adj;
}

function pathNowMs() {
  return (typeof performance !== 'undefined' && performance.now) ? performance.now() : Date.now();
}

/* Kürzester Pfad (BFS, O(V+E)) — liefert {steps, hops, ms} oder {steps:null} */
function findShortestPath(adj, startId, endId, directed, maxHops) {
  var t0 = pathNowMs();
  startId = String(startId); endId = String(endId);
  if (startId === endId) return { steps: [], hops: 0, ms: 0 };
  var queue = [startId], visited = {}, parent = {}, level = {}, i;
  visited[startId] = true; level[startId] = 0;
  var found = false;
  while (queue.length) {
    var cur = queue.shift();
    if (cur === endId) { found = true; break; }
    var edges = adj[cur] || [];
    for (i = 0; i < edges.length; i++) {
      var e = edges[i];
      if (directed && e.dir !== 1) continue;     /* Richtungsfilter */
      if (visited[e.to]) continue;
      if (level[cur] + 1 > maxHops) continue;    /* Hop-Begrenzung */
      visited[e.to] = true;
      level[e.to] = level[cur] + 1;
      parent[e.to] = { prev: cur, e: e };
      queue.push(e.to);
    }
  }
  if (!visited[endId]) return { steps: null, hops: -1, ms: pathNowMs() - t0 };
  /* Pfad rekonstruieren */
  var steps = [], curN = endId;
  while (curN !== startId) {
    var p = parent[curN];
    steps.push({ from: p.prev, to: curN, cid: p.e.cid, st: p.e.st, name: p.e.name, type: p.e.type, forward: (p.e.dir === 1) });
    curN = p.prev;
  }
  steps.reverse();
  return { steps: steps, hops: steps.length, ms: pathNowMs() - t0 };
}

/* Alternative Pfade: tiefenbeschränktes DFS mit Backtracking (Simple Paths).
   Budget: max. 50.000 DFS-Schritte oder 2.000 ms. Wird das Budget erreicht,
   liefert das Ergebnis capped=true — die UI meldet den Abbruch dann sichtbar
   (kein stillschweigend unvollständiges Ergebnis mehr). */
function findAltPaths(adj, startId, endId, directed, maxHops, maxPaths) {
  var t0 = pathNowMs();
  startId = String(startId); endId = String(endId);
  maxPaths = maxPaths || 5;
  var paths = [], stepsCount = 0;
  var maxSteps = 50000, maxMs = 2000, stopped = false;
  var inBranch = {};
  inBranch[startId] = true;

  function deg(id) { return adj[id] ? adj[id].length : 0; }

  function dfs(cur, curPath) {
    if (stopped || paths.length >= maxPaths) return;
    stepsCount++;
    if (stepsCount >= maxSteps) { stopped = true; return; }
    if ((stepsCount % 256) === 0 && (pathNowMs() - t0) > maxMs) { stopped = true; return; }
    if (cur === endId && curPath.length > 0) { paths.push(curPath.slice(0)); return; }
    if (curPath.length >= maxHops) return;
    var edges = (adj[cur] || []).slice(0);
    /* Hubs zuletzt traversieren (Verzweigungsexplosion eindämmen) */
    edges.sort(function (x, y) { return deg(x.to) - deg(y.to); });
    for (var i = 0; i < edges.length; i++) {
      var e = edges[i];
      if (directed && e.dir !== 1) continue;
      if (inBranch[e.to]) continue;              /* Zyklusvermeidung */
      inBranch[e.to] = true;
      curPath.push({ from: cur, to: e.to, cid: e.cid, st: e.st, name: e.name, type: e.type, forward: (e.dir === 1) });
      dfs(e.to, curPath);
      curPath.pop();
      delete inBranch[e.to];
      if (stopped || paths.length >= maxPaths) return;
    }
  }
  dfs(startId, []);

  /* Duplikate (gleiche Knotensequenz) entfernen */
  var seen = {}, uniq = [];
  for (var p = 0; p < paths.length; p++) {
    var key = [startId].concat(paths[p].map(function (s) { return s.to; })).join('>');
    if (!seen[key]) { seen[key] = 1; uniq.push(paths[p]); }
  }
  return { paths: uniq, ms: pathNowMs() - t0, capped: stopped, steps: stepsCount };
}

/* Erreichbarkeit: Wie viele Knoten erreicht id innerhalb maxHops? */
function pathReachCount(adj, id, maxHops, directed) {
  var seen = {}, queue = [id], level = {}, i;
  seen[id] = true; level[id] = 0;
  while (queue.length) {
    var cur = queue.shift();
    if (level[cur] >= maxHops) continue;
    var edges = adj[cur] || [];
    for (i = 0; i < edges.length; i++) {
      var e = edges[i];
      if (directed && e.dir !== 1) continue;
      if (seen[e.to]) continue;
      seen[e.to] = true; level[e.to] = level[cur] + 1;
      queue.push(e.to);
    }
  }
  var n = 0, k;
  for (k in seen) if (seen.hasOwnProperty(k)) n++;
  return n - 1; /* ohne den Startknoten selbst */
}

/* Zusammenhangskomponenten (ungerichtet) — gecacht */
function ensureComponents() {
  if (PATH_COMP) return;
  if (!PATH_ADJ) PATH_ADJ = buildAdjacency();
  var compOf = {}, sizes = {}, comp = 0, seen = {}, i, j;
  var ids = [];
  for (var k in OBJS) if (OBJS.hasOwnProperty(k)) ids.push(k);
  for (i = 0; i < ids.length; i++) {
    var id = ids[i];
    if (seen[id]) continue;
    comp++;
    var queue = [id], cnt = 0;
    seen[id] = true;
    while (queue.length) {
      var cur = queue.shift();
      cnt++;
      compOf[cur] = comp;
      var edges = (PATH_ADJ[cur] || []);
      for (j = 0; j < edges.length; j++) {
        if (!seen[edges[j].to]) { seen[edges[j].to] = true; queue.push(edges[j].to); }
      }
    }
    sizes[comp] = cnt;
  }
  PATH_COMP = { compOf: compOf, sizes: sizes, count: comp };
}

/* ================================================================
   UI: STEUERPANEL, TYPEAHEAD-AUSWAHL, ERGEBNISDARSTELLUNG
   ================================================================ */
function pathRenderTab() {
  var box = el('pathbox');
  if (!box) return;
  /* Klick außerhalb schließt die Typeahead-Dropdowns */
  if (!window._pathDocClickBound) {
    window._pathDocClickBound = true;
    document.addEventListener('click', function (e) {
      if (!findUp(e.target, 'pfield')) {
        var a = el('pstartlist'); if (a) a.style.display = 'none';
        var b = el('pendlist'); if (b) b.style.display = 'none';
      }
    });
  }
  var h = [];
  h.push('<h2>🔗 Verbindung zweier Elemente finden <span class="dim" style="font-size:13px;font-weight:400">(Pfadanalyse – experimentell, inspiriert von ArAMIS Web)</span></h2>');
  h.push('<div class="purpose">Wie hängt <b>Element A</b> mit <b>Element B</b> zusammen? Wählen Sie Start- und Ziel-Element — der Analyzer findet die <b>Verbindungskette</b> durch das Modell, zeigt sie als Schrittfolge, Tabelle und Graph und erklärt nachvollziehbar, <b>wenn keine Verbindung existiert</b> (z.&nbsp;B. getrennte Teilarchitekturen).</div>');
  h.push('<div class="pathgrid">');

  /* Steuerpanel */
  h.push('<div class="pathpanel pcontrols-hide">');
  h.push('<div class="pfield"><label>🚩 Start-Element</label>' +
    '<input id="pstartinp" placeholder="Suchen: Name, Alias oder Stereotyp …" autocomplete="off" oninput="pathTypeahead(\'start\')" onkeydown="pathKey(event)">' +
    '<div class="ptypeahead" id="pstartlist" style="display:none"></div>' +
    '<div id="pstartchosen"></div></div>');
  h.push('<div style="text-align:center;margin:0 0 8px"><button class="btn-sm" onclick="pathSwap()" title="Start- und Ziel-Element tauschen">⇄ Tauschen</button></div>');
  h.push('<div class="pfield"><label>🎯 Ziel-Element</label>' +
    '<input id="pendinp" placeholder="Suchen: Name, Alias oder Stereotyp …" autocomplete="off" oninput="pathTypeahead(\'end\')" onkeydown="pathKey(event)">' +
    '<div class="ptypeahead" id="pendlist" style="display:none"></div>' +
    '<div id="pendchosen"></div></div>');

  h.push('<div class="pcontrols">');
  h.push('<div class="pc-row"><b>Richtung:</b><br>' +
    '<button id="pdir-u" class="on" onclick="pathSetDir(false)" title="Alle Verbindungen unabhängig von der Pfeilrichtung (Architektur-Gesamtzusammenhang)">↔ Ungerichtet</button> ' +
    '<button id="pdir-d" onclick="pathSetDir(true)" title="Nur Kanten in Modellierungsrichtung (Nutzungs-/Kausalfluss)">⇶ Gerichtet (A ➜ B)</button></div>');
  h.push('<div class="pc-row"><b>Max. Hops:</b><br>' +
    '<input type="range" id="phops" min="1" max="10" step="1" value="5" style="width:100%;accent-color:var(--bw-blue);cursor:pointer" oninput="pathSlideHops(this.value,\'slider\')">' +
    '<div style="display:flex;align-items:center;gap:6px;margin-top:4px"><input type="number" id="phopsnum" min="1" max="10" step="1" value="5" style="width:64px;padding:3px 6px;border:1px solid var(--bw-blue);border-radius:6px;font-size:12.5px;text-align:right" oninput="pathSlideHops(this.value,\'number\')"> <span class="dim">Hops (Zwischenschritte)</span></div></div>');
  h.push('<div class="pc-row"><b>Suchmodus:</b><br>' +
    '<button id="pmode-s" class="on" onclick="pathSetPathMode(\'shortest\')" title="Minimale Anzahl Zwischenschritte (BFS)">Kürzester Pfad</button> ' +
    '<button id="pmode-m" onclick="pathSetPathMode(\'multi\')" title="Bis zu 5 alternative Verbindungsketten">Alternative Pfade (bis 5)</button></div>');
  h.push('</div>');
  h.push('<button class="pfind" onclick="pathFind()">🔎 Verbindung suchen</button>');
  h.push('<div class="dim" style="margin-top:9px">💡 Tipp: In Element-Steckbriefen (📦), Graph-Infos und Tabellen gibt es „🔗 Als Start/Ziel setzen“-Buttons. Die Suche reagiert in Millisekunden — auch im Gesamtmodell.</div>');
  h.push('</div>'); /* /pathpanel */

  h.push('<div id="pathresults" style="min-width:0"><div class="pnote">Wählen Sie links <b>Start- und Ziel-Element</b>, dann „🔎 Verbindung suchen“ (oder direkt aus einem Steckbrief übernehmen).</div></div>');
  h.push('</div>'); /* /pathgrid */
  box.innerHTML = h.join('');
  pathSyncControls();
  pathRenderChosen();
}

function pathSyncControls() {
  var sl = el('phops'), num = el('phopsnum');
  if (sl) sl.value = PATH.maxHops;
  if (num) num.value = PATH.maxHops;
  var du = el('pdir-u'), dd = el('pdir-d');
  if (du) du.className = PATH.directed ? '' : 'on';
  if (dd) dd.className = PATH.directed ? 'on' : '';
  var ms = el('pmode-s'), mm = el('pmode-m');
  if (ms) ms.className = PATH.mode === 'shortest' ? 'on' : '';
  if (mm) mm.className = PATH.mode === 'multi' ? 'on' : '';
}

function pathRenderChosen() {
  var sBox = el('pstartchosen'), eBox = el('pendchosen');
  function chip(which) {
    var oid = which === 'start' ? PATH.start : PATH.end;
    if (!oid || !OBJS[oid]) return '';
    var o = OBJS[oid];
    return '<span class="pchipsel"><span class="ptdot" style="background:' + stColor(o.st) + '"></span><b>' + esc(shortLabel(o.name, 34)) + '</b> <code>' + esc(o.st) + '</code> <span class="dim">🔗 ' + (CONNCOUNT[oid] || 0) + '</span> <a href="javascript:void(0)" onclick="pathClear(\'' + which + '\')" title="Auswahl löschen">✕</a></span>';
  }
  if (sBox) sBox.innerHTML = chip('start');
  if (eBox) eBox.innerHTML = chip('end');
}

function pathClear(which) {
  if (which === 'start') { PATH.start = null; var a = el('pstartinp'); if (a) a.value = ''; }
  else { PATH.end = null; var b = el('pendinp'); if (b) b.value = ''; }
  PATH.last = null;
  pathRenderChosen();
  var res = el('pathresults');
  if (res) res.innerHTML = '<div class="pnote">Wählen Sie links <b>Start- und Ziel-Element</b>, dann „🔎 Verbindung suchen“.</div>';
}

function pathSwap() {
  var t = PATH.start; PATH.start = PATH.end; PATH.end = t;
  var ai = el('pstartinp'), bi = el('pendinp');
  if (ai) ai.value = (PATH.start && OBJS[PATH.start]) ? OBJS[PATH.start].name : '';
  if (bi) bi.value = (PATH.end && OBJS[PATH.end]) ? OBJS[PATH.end].name : '';
  pathRenderChosen();
  if (PATH.start && PATH.end && PATH.last) pathFind();
}

function pathSetDir(dir) {
  PATH.directed = !!dir;
  pathSyncControls();
  if (PATH.start && PATH.end && PATH.last) pathFind();
}

function pathSetPathMode(m) {
  PATH.mode = m === 'multi' ? 'multi' : 'shortest';
  pathSyncControls();
  if (PATH.start && PATH.end && PATH.last) pathFind();
}

function pathSlideHops(v, from) {
  var n = parseInt(v, 10);
  if (isNaN(n)) n = 5;
  if (n < 1) n = 1;
  if (n > 10) n = 10;
  PATH.maxHops = n;
  var sl = el('phops'), num = el('phopsnum');
  if (sl && from !== 'slider') sl.value = n;
  if (num && from !== 'number') num.value = n;
  if (PATH.start && PATH.end && PATH.last) pathFind();
}

function pathKey(e) {
  if (e.keyCode === 13) { e.preventDefault(); pathFind(); }
  else if (e.keyCode === 27) {
    var a = el('pstartlist'); if (a) a.style.display = 'none';
    var b = el('pendlist'); if (b) b.style.display = 'none';
  }
}

/* Typeahead-Sofortsuche für Start/Ziel */
function pathTypeahead(which) {
  var inp = el(which === 'start' ? 'pstartinp' : 'pendinp');
  var box = el(which === 'start' ? 'pstartlist' : 'pendlist');
  if (!inp || !box) return;
  var q = (inp.value || '').trim().toLowerCase();
  if (q.length < 2) { box.style.display = 'none'; box.innerHTML = ''; return; }
  var hits = [], k, o;
  for (k in OBJS) {
    if (!OBJS.hasOwnProperty(k)) continue;
    o = OBJS[k];
    if (o.type === 'Boundary' || /^proxyconn?ector$/i.test(o.st)) continue;
    if ((o.name + ' ' + o.alias + ' ' + o.st).toLowerCase().indexOf(q) >= 0) hits.push(o);
  }
  hits.sort(function (a, b) { return (CONNCOUNT[b.id] || 0) - (CONNCOUNT[a.id] || 0); });
  hits = hits.slice(0, 30);
  var h = [];
  for (var i = 0; i < hits.length; i++) {
    o = hits[i];
    h.push('<div class="ptrow" onclick="pathChoose(\'' + which + '\',\'' + o.id + '\')">' +
      '<span class="ptdot" style="background:' + stColor(o.st) + '"></span>' +
      '<span><b>' + esc(shortLabel(o.name || '(ohne Name)', 46)) + '</b> <code>' + esc(o.st) + '</code></span>' +
      '<span class="ptmeta">📁 ' + esc(shortLabel(o.pkg || '—', 30)) + ' · 🔗 ' + (CONNCOUNT[o.id] || 0) + '</span>' +
    '</div>');
  }
  box.innerHTML = h.join('') || '<div class="ptrow dim">Keine Treffer</div>';
  box.style.display = 'block';
}

function pathChoose(which, oid) {
  oid = String(oid);
  if (!OBJS[oid]) return;
  if (which === 'start') PATH.start = oid; else PATH.end = oid;
  var inp = el(which === 'start' ? 'pstartinp' : 'pendinp');
  var box = el(which === 'start' ? 'pstartlist' : 'pendlist');
  if (inp) inp.value = OBJS[oid].name;
  if (box) box.style.display = 'none';
  pathRenderChosen();
  if (PATH.start && PATH.end) pathFind();   /* beide gewählt -> sofort suchen */
}

/* Aus Steckbrief / Graph heraus als Start oder Ziel übernehmen */
function pathSetEndpoint(which, oid) {
  oid = String(oid);
  if (!OBJS[oid]) return;
  if (which === 'start') PATH.start = oid; else PATH.end = oid;
  var inp = el(which === 'start' ? 'pstartinp' : 'pendinp');
  if (inp) inp.value = OBJS[oid].name;
  pathRenderChosen();
  showView('path');
  var res = el('pathresults');
  if (res) res.innerHTML = '<div class="pnote">„' + esc(OBJS[oid].name) + '“ als <b>' + (which === 'start' ? 'Start' : 'Ziel') + '</b> übernommen — ' + (PATH.start && PATH.end ? 'Suche läuft …' : 'bitte noch das ' + (which === 'start' ? 'Ziel' : 'Start') + ' wählen.') + '</div>';
  if (PATH.start && PATH.end) pathFind();
}

/* ================================================================
   SUCHE AUSFÜHREN & ERGEBNISSE DARSTELLEN
   ================================================================ */
function pathFind() {
  var res = el('pathresults');
  if (!res) return;
  if (!PATH.start || !PATH.end) {
    res.innerHTML = '<div class="pnote">⚠ Bitte erst <b>Start- und Ziel-Element</b> wählen (Suchfelder links).</div>';
    return;
  }
  if (!PATH_ADJ) { PATH_ADJ = buildAdjacency(); PATH_COMP = null; }
  var s = OBJS[PATH.start], e = OBJS[PATH.end];
  var out = { s: s, e: e, mode: PATH.mode, directed: PATH.directed, maxHops: PATH.maxHops, none: false };
  PATH.last = out;
  PATH.selPath = 0;

  if (PATH.start === PATH.end) { out.trivial = true; pathRenderResults(); return; }
  var sDeg = (PATH_ADJ[PATH.start] || []).length;
  var eDeg = (PATH_ADJ[PATH.end] || []).length;
  if (!sDeg || !eDeg) { out.isolated = { s: !sDeg, e: !eDeg }; pathRenderResults(); return; }

  if (PATH.mode === 'multi') {
    var r = findAltPaths(PATH_ADJ, PATH.start, PATH.end, PATH.directed, PATH.maxHops, 5);
    out.paths = r.paths; out.ms = r.ms; out.capped = r.capped;
    out.none = !r.paths.length;
  } else {
    var r2 = findShortestPath(PATH_ADJ, PATH.start, PATH.end, PATH.directed, PATH.maxHops);
    out.steps = r2.steps; out.ms = r2.ms;
    out.none = !r2.steps;
  }
  pathRenderResults();
}

function pathRenderResults() {
  var host = el('pathresults');
  if (!host || !PATH.last) return;
  var o = PATH.last, s = o.s, e = o.e;
  var h = [];

  /* ---- Status-Banner ---- */
  var dirTxt = o.directed ? 'gerichtet' : 'ungerichtet';
  if (o.trivial) {
    h.push('<div class="pbanner info">ℹ️ Start und Ziel sind identisch — <b>0 Hops</b>. Bitte zwei verschiedene Elemente wählen.</div>');
  } else if (o.isolated) {
    var parts = [];
    if (o.isolated.s) parts.push('das <b>Start-Element</b>');
    if (o.isolated.e) parts.push('das <b>Ziel-Element</b>');
    h.push('<div class="pbanner warn">⚠ ' + parts.join(' und ') + ' besitzt im Modell <b>keine einzige Beziehung</b> (isolierter Knoten, Grad 0) — eine Pfadsuche ist nicht möglich.</div>');
    h.push(pathDiagHtml(s, e));
  } else if (o.none) {
    h.push('<div class="pbanner warn">⚠ <b>Keine Verbindung</b> zwischen „' + esc(shortLabel(s.name, 40)) + '“ und „' + esc(shortLabel(e.name, 40)) + '“ innerhalb von <b>' + o.maxHops + ' Hops</b> gefunden (' + dirTxt + ').</div>');
    h.push(pathDiagHtml(s, e));
  } else {
    var steps = o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps;
    var hops = steps.length;
    h.push('<div class="pbanner ok">✔ <b>Verbindung gefunden:</b> ' + hops + ' Hop' + (hops === 1 ? '' : 's') + ' · ' + (hops + 1) + ' Elemente · ' + hops + ' Beziehung' + (hops === 1 ? '' : 'en') + ' · Modus: ' + (o.mode === 'multi' ? 'Alternativpfade' : 'kürzester Pfad') + ' (' + dirTxt + ') · Berechnung: ' + (Math.round(o.ms * 100) / 100) + ' ms</div>');
  }

  /* Sichtbarer Hinweis, wenn die Alternativpfad-Suche das interne Budget
     erreicht hat — das Ergebnis ist dann möglicherweise unvollständig. */
  if (o.mode === 'multi' && o.capped && !o.trivial && !o.isolated) {
    h.push('<div class="pbanner warn">⚠ <b>Suche limitiert:</b> Die Alternativpfad-Suche wurde wegen des internen Suchlimits vorzeitig abgebrochen — '
      + (o.none
        ? '„Keine Verbindung“ ist deshalb nicht abschließend; es können trotzdem Pfade existieren (Hops erhöhen oder erneut suchen).'
        : 'es können <b>weitere alternative Pfade</b> existieren (angezeigt: ' + o.paths.length + ' von max. 5).')
      + '</div>');
  }

  var showResult = !o.none && !o.trivial && !o.isolated;

  /* ---- Alternativpfad-Auswahl ---- */
  if (showResult && o.mode === 'multi' && o.paths.length > 1) {
    h.push('<div class="ppaths"><span class="dim" style="align-self:center">' + o.paths.length + ' Pfade gefunden:</span>');
    for (var pi = 0; pi < o.paths.length; pi++) {
      h.push('<button class="ppathbtn' + (pi === PATH.selPath ? ' on' : '') + '" onclick="pathSelectPath(' + pi + ')">Pfad ' + (pi + 1) + ' · ' + o.paths[pi].length + ' Hops</button>');
    }
    h.push('</div>');
  }

  if (showResult) {
    var cur = o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps;
    h.push('<div class="pathgrid2">');
    /* Schritt-Kette */
    h.push('<div class="pcard"><h3 style="margin-top:0">Verbindungskette (Schritt für Schritt)</h3>');
    h.push(pathChainHtml(cur, PATH.start));
    h.push('</div>');
    /* Graph */
    h.push('<div class="pcard"><h3 style="margin-top:0">Graph-Ausschnitt</h3>' +
      '<label style="font-size:12px;cursor:pointer;display:inline-block;margin-bottom:6px"><input type="checkbox" ' + (PATH.ctx ? 'checked ' : '') + ' onchange="pathToggleCtx(this)"> Auch direkte Nachbarn der Pfad-Elemente anzeigen (Kontext)</label>' +
      '<div class="pathgraphbox" id="pathgraph"></div></div>');
    h.push('</div>');
    /* Tabelle */
    h.push('<div class="pcard"><h3 style="margin-top:0">Detail-Tabelle der Verbindung (' + cur.length + ' Schritte)</h3>');
    h.push(pathTableHtml(cur));
    h.push('</div>');
    /* Exporte */
    h.push('<div class="vp-actions" style="margin-top:12px"><span class="vexport">' +
      '<button class="exp-xls" onclick="pathExportXLSX()">📊 Pfad als Excel (.xlsx)</button>' +
      '<button class="exp-png" onclick="pathExportPNG()">📸 Pfad-Graph als PNG</button>' +
      '</span></div>');
  }

  host.innerHTML = h.join('');
  if (showResult) {
    var cur2 = o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps;
    pathDrawSVG(cur2, PATH.start);
  }
}

function pathSelectPath(i) {
  PATH.selPath = i;
  pathRenderResults();
}

function pathToggleCtx(cb) {
  PATH.ctx = !!cb.checked;
  var o = PATH.last;
  if (o && o.paths || o && o.steps) {
    var cur = o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps;
    if (cur) pathDrawSVG(cur, PATH.start);
  }
}

/* Diagnose bei fehlender Verbindung */
function pathDiagHtml(s, e) {
  ensureComponents();
  var adj = PATH_ADJ;
  var cs = PATH_COMP.compOf[s.id], ce = PATH_COMP.compOf[e.id];
  var sizeS = PATH_COMP.sizes[cs] || 0, sizeE = PATH_COMP.sizes[ce] || 0;
  var h = [];
  h.push('<div class="pcard"><h3 style="margin-top:0">🔬 Architektur-Diagnose: Warum gibt es keine Verbindung?</h3>');

  h.push('<div class="diag-row"><b>1. Teilarchitekturen (Zusammenhangskomponenten):</b> ');
  if (cs === ce) {
    h.push('Beide Elemente liegen in <b>derselben</b> Komponente (' + fmt(sizeS) + ' Elemente) — die Verbindung existiert also nur über mehr als ' + PATH.maxHops + ' Hops oder verläuft über ausgeblendete Richtungen. Tipp: <b>Max. Hops erhöhen</b> oder Richtung auf <b>ungerichtet</b> stellen.</div>');
  } else {
    h.push('„' + esc(shortLabel(s.name, 34)) + '“ liegt in einer Komponente mit <b>' + fmt(sizeS) + '</b> Elementen, „' + esc(shortLabel(e.name, 34)) + '“ in einer anderen mit <b>' + fmt(sizeE) + '</b> Elementen. Diese Teilarchitekturen sind <b>vollständig voneinander getrennt</b> — es fehlt eine verbindende Beziehung (z.&nbsp;B. Realization, Dependency oder Traceability) zwischen den Fachpaketen.</div>');
  }

  var reachS = pathReachCount(adj, s.id, PATH.maxHops, PATH.directed);
  var reachE = pathReachCount(adj, e.id, PATH.maxHops, PATH.directed);
  h.push('<div class="diag-row"><b>2. Erreichbarkeits-Horizont (± ' + PATH.maxHops + ' Hops):</b> Das Start-Element kann <b>' + fmt(reachS) + '</b> Elemente erreichen, das Ziel-Element <b>' + fmt(reachE) + '</b> Elemente — gegenseitig aber keines.</div>');

  /* Gemeinsame Nachbarn (1 Hop, ungerichtet) */
  var nbS = {}, nbE = {}, common = [], i;
  var es = adj[s.id] || [], ee = adj[e.id] || [];
  for (i = 0; i < es.length; i++) nbS[es[i].to] = true;
  for (i = 0; i < ee.length; i++) nbE[ee[i].to] = true;
  for (var k in nbS) if (nbS.hasOwnProperty(k) && nbE[k]) common.push(k);
  h.push('<div class="diag-row"><b>3. Gemeinsame Nachbarn (Brücken-Kandidaten):</b> ');
  if (common.length) {
    h.push('<b>' + common.length + '</b> Element(e) stehen mit beiden in direkter Beziehung: ');
    for (i = 0; i < common.length && i < 8; i++) {
      var co = OBJS[common[i]];
      h.push('<span class="gchip" onclick="openElement(\'' + common[i] + '\')"><i style="background:' + stColor(co ? co.st : '') + '"></i>' + esc(shortLabel(co ? co.name : '?', 30)) + '</span> ');
    }
    if (common.length > 8) h.push('<span class="dim">… +' + (common.length - 8) + ' weitere</span>');
  } else {
    h.push('Keine gemeinsamen direkten Nachbarn vorhanden.</div>');
  }

  /* Gemeinsames Paket & gemeinsame Sichten */
  var samePkg = s.pkgFull && s.pkgFull === e.pkgFull;
  h.push('<div class="diag-row"><b>4. Kontext:</b> ');
  h.push(samePkg ? 'Beide Elemente liegen im <b>selben Paket</b> (' + esc(shortLabel(s.pkgFull, 60)) + '). ' : 'Beide liegen in <b>unterschiedlichen Paketen</b>. ');
  var ds = OBJ_DIAGS[s.id] || [], de = OBJ_DIAGS[e.id] || [];
  var shared = [];
  for (i = 0; i < ds.length; i++) if (de.indexOf(ds[i]) >= 0) shared.push(ds[i]);
  if (shared.length) {
    h.push('Sie erscheinen gemeinsam auf <b>' + shared.length + '</b> Sicht(en): ');
    for (i = 0; i < shared.length && i < 5; i++) {
      var dg = DIAGMAP[shared[i]];
      if (dg) h.push('<a href="javascript:openDiagramView(' + dg.id + ')" class="dim">🖼️ ' + esc(shortLabel(dg.name, 34)) + '</a> ');
    }
  } else {
    h.push('Sie erscheinen auf <b>keiner gemeinsamen</b> Sicht.');
  }
  h.push('</div>');

  h.push('<div class="diag-row dim">💡 <b>Handlungsempfehlung für Modellierer:</b> Prüfen Sie, ob zwischen den beteiligten Paketen eine fachliche oder methodische Beziehung fehlt (z.&nbsp;B. «realizes», «implements», «dependency»), um den Schichtenübergang herzustellen — oder erhöhen Sie die Hop-Grenze bzw. stellen Sie auf ungerichtete Suche um.</div>');
  h.push('</div>');
  return h.join('');
}

function pathChainHtml(steps, sOid) {
  var h = [], i;
  h.push('<div class="pchain">');
  var nodes = [String(sOid)];
  for (i = 0; i < steps.length; i++) nodes.push(String(steps[i].to));
  for (i = 0; i < nodes.length; i++) {
    var oid = nodes[i], oo = OBJS[oid];
    if (!oo) continue;
    h.push('<div class="pnode" onclick="openElement(\'' + oid + '\')" title="Element-Steckbrief öffnen">' +
      '<span class="ptdot" style="background:' + stColor(oo.st) + '"></span>' +
      '<b>' + esc(shortLabel(oo.name || '(ohne Name)', 52)) + '</b> <code>' + esc(oo.st) + '</code>' +
      '<span class="dim" style="margin-left:6px">📁 ' + esc(shortLabel(oo.pkg || '', 30)) + '</span></div>');
    if (i < steps.length) {
      var st = steps[i];
      h.push('<div class="plink"><code>' + esc(st.st || st.type || 'Verbindung') + '</code> ' + (st.forward ? '➔ in Modellrichtung' : '◄ invers modelliert') + (st.name ? ' · „' + esc(shortLabel(st.name, 40)) + '“' : '') + '</div>');
    }
  }
  h.push('</div>');
  return h.join('');
}

function pathTableHtml(steps) {
  var h = [], i;
  h.push('<div style="overflow:auto"><table class="data"><thead><tr><th>#</th><th>Quell-Element</th><th>Quell-Stereotyp</th><th>Beziehung</th><th>Richtung</th><th>Ziel-Element</th><th>Ziel-Stereotyp</th><th>Ziel-Paket</th></tr></thead><tbody>');
  for (i = 0; i < steps.length; i++) {
    var st = steps[i];
    var a = OBJS[st.from], b = OBJS[st.to];
    h.push('<tr class="clickable" onclick="openElement(\'' + st.from + '\')">' +
      '<td><b>' + (i + 1) + '</b></td>' +
      '<td>' + esc(shortLabel(a ? a.name : '?', 34)) + '</td>' +
      '<td><code>' + esc(a ? a.st : '') + '</code></td>' +
      '<td><code>' + esc(st.st || st.type || '→') + '</code>' + (st.name ? ' <span class="dim">„' + esc(shortLabel(st.name, 24)) + '“</span>' : '') + '</td>' +
      '<td>' + (st.forward ? '➔ vorwärts' : '◄ invers') + '</td>' +
      '<td>' + esc(shortLabel(b ? b.name : '?', 34)) + '</td>' +
      '<td><code>' + esc(b ? b.st : '') + '</code></td>' +
      '<td class="dim">' + esc(shortLabel(b ? (b.pkg || '') : '', 30)) + '</td>' +
    '</tr>');
  }
  h.push('</tbody></table></div>');
  return h.join('');
}

/* SVG-Ausschnitt des Pfades (horizontal, optional mit 1-Hop-Kontext) */
function pathDrawSVG(steps, sOid) {
  var host = el('pathgraph');
  if (!host) return;
  var i, j;
  var nodes = [String(sOid)];
  for (i = 0; i < steps.length; i++) nodes.push(String(steps[i].to));
  var n = nodes.length;
  var gapX = 235, cx = 90;
  var pts = [];
  for (i = 0; i < n; i++) pts.push({ x: cx + i * gapX, y: 0 });

  var parts = [];
  var padL = 80, padR = 80, padT = 130, padB = 130;
  var W = pts[n - 1].x + padR;
  var H = padT + padB;
  var vbX = -padL + 40, vbY = -padT, vbW = W + padL - 40 + 40, vbH = H;

  parts.push('<svg xmlns="http://www.w3.org/2000/svg" viewBox="' + vbX + ' ' + vbY + ' ' + vbW + ' ' + vbH + '" style="width:100%;max-width:' + Math.round(vbW) + 'px;height:auto;display:block;margin:0 auto" preserveAspectRatio="xMidYMid meet">');
  parts.push('<defs>' +
    '<marker id="parr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7.5" markerHeight="7.5" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="#004471"/></marker>' +
  '</defs>');

  /* Kontext-Nachbarn (1 Hop) */
  var ctxSet = {};
  if (PATH.ctx && PATH_ADJ) {
    var pathSet = {};
    for (i = 0; i < n; i++) pathSet[nodes[i]] = true;
    for (i = 0; i < n; i++) {
      var es = PATH_ADJ[nodes[i]] || [];
      var upDown = 1, added = 0;
      for (j = 0; j < es.length; j++) {
        var nid = es[j].to;
        if (pathSet[nid] || ctxSet[nid]) continue;
        if (added >= 6) break;
        var cy = upDown * (108 + Math.floor(added / 2) * 52);
        var cxo = pts[i].x;
        parts.push('<line x1="' + pts[i].x + '" y1="' + pts[i].y + '" x2="' + cxo + '" y2="' + cy + '" stroke="#CBD5E1" stroke-width="1" stroke-dasharray="4 4"/>');
        var co = OBJS[nid];
        var ccol = stColor(co ? co.st : '');
        parts.push('<g class="pgn" data-oid="' + nid + '" transform="translate(' + cxo + ',' + cy + ')" style="cursor:pointer">' +
          '<circle r="9" fill="' + stFill(co ? co.st : '') + '" stroke="' + ccol + '" stroke-width="1.6" opacity="0.85"/>' +
          '<text y="24" text-anchor="middle" font-size="9" fill="#64748B">' + esc(shortLabel(co ? co.name : '?', 22)) + '</text>' +
          '<title>' + esc((co ? co.name : '') + ' «' + (co ? co.st : '') + '» (Kontext)') + '</title></g>');
        ctxSet[nid] = true;
        upDown = -upDown; added++;
      }
    }
  }

  /* Kanten des Pfades */
  for (i = 0; i < steps.length; i++) {
    var p1 = pts[i], p2 = pts[i + 1];
    parts.push('<line x1="' + p1.x + '" y1="' + p1.y + '" x2="' + p2.x + '" y2="' + p2.y + '" stroke="#004471" stroke-width="2.4" marker-end="url(#parr)"/>');
    var mx = (p1.x + p2.x) / 2, my = -16;
    var st = steps[i];
    parts.push('<text x="' + mx + '" y="' + my + '" text-anchor="middle" font-size="10.5" font-weight="600" fill="#0F172A" style="paint-order:stroke;stroke:#FFFFFF;stroke-width:3px">' + esc(shortLabel(st.st || st.type || '→', 26)) + ' ' + (st.forward ? '➔' : '◄') + '</text>');
  }

  /* Pfad-Knoten */
  for (i = 0; i < n; i++) {
    var oo = OBJS[nodes[i]];
    var col = stColor(oo ? oo.st : ''), fl = stFill(oo ? oo.st : '');
    parts.push('<g class="pgn" data-oid="' + nodes[i] + '" transform="translate(' + pts[i].x + ',' + pts[i].y + ')" style="cursor:pointer">' +
      '<circle r="19" fill="' + fl + '" stroke="' + col + '" stroke-width="2.6"/>' +
      '<text y="4" text-anchor="middle" font-size="10.5" font-weight="700" fill="#1F2937" style="pointer-events:none">' + (i + 1) + '</text>' +
      '<text y="-30" text-anchor="middle" font-size="11" font-weight="600" fill="#0F172A" style="paint-order:stroke;stroke:#FFFFFF;stroke-width:3.2px">' + esc(shortLabel(oo ? oo.name : '?', 28)) + '</text>' +
      '<text y="37" text-anchor="middle" font-size="9" fill="#475569" style="paint-order:stroke;stroke:#FFFFFF;stroke-width:2.5px">«' + esc(shortLabel(oo ? oo.st : '', 24)) + '»</text>' +
      '<title>' + esc((oo ? oo.name : '') + ' «' + (oo ? oo.st : '') + '» — Klick: Steckbrief') + '</title></g>');
  }
  parts.push('</svg>');
  host.innerHTML = parts.join('');

  var gs = host.querySelectorAll('.pgn');
  for (i = 0; i < gs.length; i++) {
    gs[i].addEventListener('click', function (ev) {
      var oid = ev.currentTarget.getAttribute('data-oid');
      if (oid) openElement(oid);
    });
  }
}

/* ================================================================
   EXPORTE DER PFADANALYSE (Excel & PNG)
   ================================================================ */
function pathExportXLSX() {
  var o = PATH.last;
  if (!o) { alert('Bitte zuerst eine Verbindung suchen.'); return; }
  var showResult = !o.none && !o.trivial && !o.isolated;
  var cur = showResult ? (o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps) : [];
  var i;

  var ovRows = [
    ['Eigenschaft', 'Wert'],
    ['Anwendung', 'ADMBw QEA Analyzer v4.0'],
    ['Funktion', 'Verbindungs-/Pfadanalyse (ArAMIS-inspiriert)'],
    ['Start-Element', o.s ? o.s.name : '—'],
    ['Start-Stereotype', o.s ? o.s.st : ''],
    ['Ziel-Element', o.e ? o.e.name : '—'],
    ['Ziel-Stereotype', o.e ? o.e.st : ''],
    ['Suchmodus', o.mode === 'multi' ? 'Alternative Pfade (bis 5)' : 'Kürzester Pfad'],
    ['Richtung', o.directed ? 'gerichtet (A ➜ B)' : 'ungerichtet'],
    ['Max. Hops', o.maxHops],
    ['Ergebnis', o.trivial ? 'Start = Ziel (0 Hops)' : (o.isolated ? 'Isoliertes Element (Grad 0)' : (o.none ? 'Keine Verbindung gefunden' : cur.length + ' Hops, ' + (cur.length + 1) + ' Elemente'))],
    ['Berechnung (ms)', Math.round((o.ms || 0) * 100) / 100],
    ['Geladenes Modell (.qea)', MODELLNAME || '—'],
    ['Export-Zeitpunkt', dateTimeDE()]
  ];

  var stepRows = [['#', 'Quelle', 'Quelle-Stereotype', 'Beziehung', 'Beziehungsname', 'Richtung', 'Ziel', 'Ziel-Stereotype', 'Ziel-Paket']];
  var relRows = [['EA-Connector-ID', 'Quelle', 'Quelle-Stereotype', 'Connector-Typ', 'Stereotype', 'Name', 'Ziel', 'Ziel-Stereotype']];
  var elSeen = {}, elRows = [['Name', 'Stereotype', 'Alias', 'Paketpfad', 'Verbindungen (Gesamt)', 'Beschreibung / Notiz']];
  function addEl(oid) {
    if (elSeen[oid]) return;
    elSeen[oid] = true;
    var x = OBJS[oid];
    if (!x) return;
    elRows.push([x.name || '', x.st || '', x.alias || '', x.pkgFull || x.pkg || '', CONNCOUNT[oid] || 0, shortLabel(x.note || '', 400)]);
  }
  if (o.s) addEl(PATH.start);
  if (o.e) addEl(PATH.end);
  for (i = 0; i < cur.length; i++) {
    var st = cur[i];
    var a = OBJS[st.from], b = OBJS[st.to];
    addEl(st.from); addEl(st.to);
    stepRows.push([i + 1, a ? a.name : '?', a ? a.st : '', st.st || st.type || '', st.name || '', st.forward ? '➜ vorwärts' : '◄ invers', b ? b.name : '?', b ? b.st : '', b ? b.pkgFull : '']);
    relRows.push([st.cid, a ? a.name : '?', a ? a.st : '', st.type || '', st.st || '', st.name || '', b ? b.name : '?', b ? b.st : '']);
  }

  var sheets = [
    { name: '1_Uebersicht', rows: ovRows, widths: [30, 80], hasHeader: true },
    { name: '2_Schrittkette (' + cur.length + ')', rows: stepRows, widths: [5, 34, 20, 22, 22, 12, 34, 20, 40], hasHeader: true },
    { name: '3_Elemente (' + (elRows.length - 1) + ')', rows: elRows, widths: [36, 22, 18, 44, 16, 52], hasHeader: true }
  ];
  if (relRows.length > 1) sheets.push({ name: '4_Beziehungen', rows: relRows, widths: [12, 34, 20, 18, 20, 22, 34, 20], hasHeader: true });
  var fn = 'ADMBw_QEA-Analyzer_Pfad_' + safeName(o.s ? o.s.name : 'Start') + '_' + safeName(o.e ? o.e.name : 'Ziel') + '_' + safeName(MODELLNAME) + '_' + dateStamp() + '.xlsx';
  downloadXLSX(fn, sheets);
}

function pathExportPNG() {
  var svg = document.querySelector('#pathgraph svg');
  if (!svg) { alert('Bitte zuerst eine Verbindung suchen (der Pfad-Graph wird dann angezeigt).'); return; }
  var o = PATH.last;
  var title = 'Pfadanalyse: ' + (o && o.s ? shortLabel(o.s.name, 44) : '') + ' ➜ ' + (o && o.e ? shortLabel(o.e.name, 44) : '');
  var cur = o ? (o.mode === 'multi' ? o.paths[PATH.selPath] : o.steps) : null;
  var sub = cur ? (cur.length + ' Hops · ' + (o.directed ? 'gerichtet' : 'ungerichtet') + ' · ' + (o.mode === 'multi' ? 'Alternativpfad ' + (PATH.selPath + 1) : 'kürzester Pfad')) : '';
  var fn = 'ADMBw_QEA-Analyzer_Pfad_' + safeName(o && o.s ? o.s.name : 'Start') + '_' + safeName(o && o.e ? o.e.name : 'Ziel') + '_' + dateStamp() + '.png';
  exportSvgElementToPNG(svg, title, sub, fn);
}
</script>
</body>
</html>
