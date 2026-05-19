# Costa Rica Countdown — Tropical Redesign
# Run inside the cr-2026 repo folder:
#   cd cr-2026
#   powershell -ExecutionPolicy Bypass -File apply_redesign.ps1
#   git add -A; git commit -m "redesign: tropical palette"; git push

$file = Join-Path $PSScriptRoot "index.html"
if (-not (Test-Path $file)) { Write-Host "ERROR: index.html not found. Run this inside the cr-2026 folder." -ForegroundColor Red; exit 1 }

$html = Get-Content $file -Raw -Encoding UTF8
$original = $html.Length
Write-Host "Read index.html ($original bytes)" -ForegroundColor Cyan

# ── FONT IMPORTS ──
$html = $html.Replace(
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Tenor+Sans&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=Instrument+Sans:wght@300;400;500;600",
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Outfit:wght@300;400;500;600;700&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400"
)

# ── CSS VARIABLES ──
$html = $html.Replace("--dusk:#1a0e08;",       "--dusk:#1B3A24;")
$html = $html.Replace("--dusk2:#261508;",      "--dusk2:#0D2B17;")
$html = $html.Replace("--dusk3:#321b0a;",      "--dusk3:#2B5B33;")
$html = $html.Replace("--ember:#c45a1a;",      "--ember:#F4B41A;")
$html = $html.Replace("--ember2:#e07030;",     "--ember2:#F7C948;")
$html = $html.Replace("--amber:#d4940a;",      "--amber:#E54B4B;")
$html = $html.Replace("--amber2:#f0b830;",     "--amber2:#FF6B6B;")
$html = $html.Replace("--champagne:#f5e6c8;",  "--champagne:#E0EDE2;")
$html = $html.Replace("--champagne2:#faf3e4;", "--champagne2:#F9FBFB;")
$html = $html.Replace("--warm-white:#fdf8f0;", "--warm-white:#F9FBFB;")
$html = $html.Replace("--mahogany:#4a1e0a;",   "--mahogany:#0D2B17;")
$html = $html.Replace("--sand:#c8a878;",       "--sand:#7DA07D;")
$html = $html.Replace("--sand2:#e8d4b0;",      "--sand2:#C8DCC8;")
$html = $html.Replace("--muted:#8a7060;",      "--muted:#4A6B4A;")
$html = $html.Replace("--dim:#5a4030;",        "--dim:#2B5B33;")
$html = $html.Replace("--text:#f0e4d0;",       "--text:#FFFFFF;")
$html = $html.Replace("--ocean:#3a7a9a;",      "--ocean:#028090;")
$html = $html.Replace("--ocean2:#5a9ab8;",     "--ocean2:#03A8B8;")

# ── BODY FONT ──
$html = $html.Replace("font-family:'Instrument Sans',sans-serif;", "font-family:'Outfit',sans-serif;")

# ── COVER GRADIENTS ──
$html = $html.Replace("rgba(74,30,10,.8)", "rgba(13,43,23,.9)")
$html = $html.Replace("linear-gradient(160deg,#120a04 0%,#1a0e08 45%,#1e1008 100%)", "linear-gradient(160deg,#0A1F12 0%,#1B3A24 45%,#0D2B17 100%)")

# ── HEADLINE STROKE ──
$html = $html.Replace("-webkit-text-stroke:1.5px var(--ember);", "-webkit-text-stroke:1.5px var(--ocean);")

# ── ROUTE LINE ──
$html = $html.Replace("background:linear-gradient(to right,var(--ember),", "background:linear-gradient(to right,var(--ocean),")

# ── TAB BUTTONS ──
$html = $html.Replace(".tab-btn.active{color:var(--ember);background:rgba(196,90,26,.08);border-color:rgba(196,90,26,.25)}", ".tab-btn.active{color:var(--dusk3);background:rgba(43,91,51,.08);border-color:rgba(43,91,51,.3)}")

# ── RESORT LINK PRIMARY ──
$html = $html.Replace(".rlb-primary{background:var(--ember);color:var(--warm-white)}", ".rlb-primary{background:var(--dusk3);color:var(--warm-white);transition:all .3s ease}")
$html = $html.Replace(".rlb-primary:hover{background:#a84a12}", ".rlb-primary:hover{background:var(--ocean);transform:scale(1.05)}")

# ── ROADMAP ACTIVE ──
$html = $html.Replace(".roadmap-item.active-phase{border-color:var(--ember);box-shadow:0 0 0 2px rgba(196,90,26,.15)}", ".roadmap-item.active-phase{border-color:var(--ocean);box-shadow:0 0 0 2px rgba(2,128,144,.2)}")
$html = $html.Replace(".status-now{background:rgba(196,90,26,.15);color:var(--ember)}", ".status-now{background:rgba(2,128,144,.15);color:var(--ocean)}")

# ── ESSENTIAL BADGE ──
$html = $html.Replace("color:var(--ember2);background:rgba(196,90,26,.08);border:1px solid rgba(196,90,26,.2)", "color:var(--dusk3);background:rgba(43,91,51,.08);border:1px solid rgba(43,91,51,.2)")

# ── LEAFLET POPUP ──
$html = $html.Replace(".leaflet-popup-content-wrapper{border-radius:3px;box-shadow:0 8px 32px rgba(0,0,0,.15)}", ".leaflet-popup-content-wrapper{border-radius:8px;box-shadow:0 8px 32px rgba(13,43,23,.2)}")

# ── BULK: Brown shadows → green ──
$html = $html.Replace("rgba(26,14,8,", "rgba(13,43,23,")

# ── BULK: Ember rgba → yellow/teal ──
$html = $html.Replace("rgba(196,90,26,.2)", "rgba(244,180,26,.2)")
$html = $html.Replace("rgba(196,90,26,.25)", "rgba(2,128,144,.25)")
$html = $html.Replace("rgba(196,90,26,.3)", "rgba(2,128,144,.25)")
$html = $html.Replace("rgba(196,90,26,.06)", "rgba(43,91,51,.06)")
$html = $html.Replace("rgba(196,90,26,.05)", "rgba(43,91,51,.05)")
$html = $html.Replace("rgba(196,90,26,.08)", "rgba(43,91,51,.08)")
$html = $html.Replace("rgba(196,90,26,.04)", "rgba(43,91,51,.04)")
$html = $html.Replace("rgba(196,90,26,.15)", "rgba(2,128,144,.15)")
$html = $html.Replace("rgba(196,90,26,.5)", "rgba(2,128,144,.4)")

# ── Amber refs ──
$html = $html.Replace("rgba(212,148,10,.15)", "rgba(229,75,75,.12)")
$html = $html.Replace("rgba(212,148,10,.25)", "rgba(229,75,75,.2)")
$html = $html.Replace("rgba(212,148,10,.1)", "rgba(2,128,144,.1)")
$html = $html.Replace("rgba(212,148,10,.08)", "rgba(244,180,26,.06)")
$html = $html.Replace("rgba(212,148,10,.03)", "rgba(244,180,26,.03)")

# ── Champagne refs → white ──
$html = $html.Replace("rgba(245,230,200,", "rgba(255,255,255,")

# ── Ocean tag refs ──
$html = $html.Replace("rgba(58,122,154,.2)", "rgba(2,128,144,.15)")
$html = $html.Replace("rgba(58,122,154,.3)", "rgba(2,128,144,.25)")
$html = $html.Replace("rgba(58,122,154,.25)", "rgba(2,128,144,.2)")

# ── Active BG gradient ──
$html = $html.Replace("rgba(196,90,26,.12),rgba(196,90,26,.04)", "rgba(2,128,144,.12),rgba(2,128,144,.04)")

# ── MAP LEGEND DOTS ──
$html = $html.Replace('style="background:#c45a1a"', 'style="background:#2B5B33"')
$html = $html.Replace('style="background:#3a7a9a"', 'style="background:#028090"')
$html = $html.Replace('style="background:#b8960c"', 'style="background:#F4B41A"')
$html = $html.Replace('style="background:#5a8a5a"', 'style="background:#3CB371"')
$html = $html.Replace('style="background:#6a4a8a"', 'style="background:#E54B4B"')

# ── JS MAP MARKER COLORS ──
$html = $html.Replace("c:'#c45a1a',s:18", "c:'#2B5B33',s:18")
$html = $html.Replace("c:'#c45a1a',s:16", "c:'#2B5B33',s:16")
$html = $html.Replace("c:'#6a4a8a'", "c:'#E54B4B'")
$html = $html.Replace("c:'#5a8a5a'", "c:'#3CB371'")
$html = $html.Replace("c:'#3a7a9a'", "c:'#028090'")
$html = $html.Replace("c:'#b8960c'", "c:'#F4B41A'")
$html = $html.Replace("c:'#d4940a'", "c:'#028090'")
$html = $html.Replace("c:'#c45a1a'", "c:'#2B5B33'")

# ── INJECT INTERACTION CSS ──
$interactionCSS = @"

/* -- TROPICAL INTERACTIONS -- */
.tag{transition:all .2s ease}
.tag:hover{transform:translateY(-1px);box-shadow:0 2px 8px rgba(13,43,23,.12)}
.perk-card{transition:all .3s cubic-bezier(.4,0,.2,1)}
.perk-card:hover{box-shadow:0 8px 32px rgba(13,43,23,.15);transform:translateY(-3px) scale(1.01)}
.flight-card{transition:all .3s cubic-bezier(.4,0,.2,1)}
.flight-card:hover{box-shadow:0 12px 40px rgba(13,43,23,.12);transform:translateY(-2px)}
.activity-item{transition:all .3s cubic-bezier(.4,0,.2,1)}
.activity-item:hover{box-shadow:0 10px 36px rgba(13,43,23,.12);transform:translateY(-3px) scale(1.005)}
.dining-card{transition:all .3s cubic-bezier(.4,0,.2,1)}
.dining-card:hover{box-shadow:0 10px 36px rgba(13,43,23,.12);transform:translateY(-2px)}
.timing-item{transition:all .25s ease}
.timing-item:hover{box-shadow:0 8px 28px rgba(13,43,23,.1);transform:translateY(-1px)}
.roadmap-item{transition:all .25s ease}
.roadmap-item:hover{box-shadow:0 6px 24px rgba(13,43,23,.1);transform:translateY(-1px)}
.rec-card{transition:all .3s ease}
.rec-card:hover{box-shadow:0 8px 28px rgba(13,43,23,.1);transform:translateY(-2px)}
.resort-link-btn{transition:all .25s ease}
.rlb-secondary:hover{transform:scale(1.03)}
.cl-item{transition:background .15s ease}
.cl-item:hover{background:rgba(43,91,51,.03);border-radius:4px}
.info-card{transition:all .25s ease}
.info-card:hover{box-shadow:0 6px 24px rgba(13,43,23,.08);transform:translateY(-1px)}
.stat-card{transition:all .2s ease}
.stat-card:hover{box-shadow:0 4px 16px rgba(13,43,23,.08)}
a{transition:color .2s ease}
"@

$html = $html.Replace("</style>", "$interactionCSS`n</style>")

# ── WRITE OUTPUT ──
[System.IO.File]::WriteAllText($file, $html, [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host "Redesign applied!" -ForegroundColor Green
Write-Host "  $original -> $($html.Length) bytes" -ForegroundColor Gray
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  git add -A"
Write-Host '  git commit -m "redesign: tropical palette"'
Write-Host "  git push"
Write-Host "  Then: GitHub > Actions > Run workflow"