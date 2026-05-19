# Costa Rica Countdown — Vintage Travel Poster Redesign
# Run inside the cr-2026 repo folder (E:\Git\cr-2026):
#   powershell -ExecutionPolicy Bypass -File poster_redesign.ps1
#   Then commit + push via GitHub Desktop or git CLI

$file = Join-Path $PSScriptRoot "index.html"
if (-not (Test-Path $file)) { Write-Host "ERROR: index.html not found." -ForegroundColor Red; exit 1 }


$html = Get-Content $file -Raw -Encoding UTF8
$original = $html.Length
Write-Host "Read index.html ($original bytes)" -ForegroundColor Cyan

# ══════════════════════════════════════════
# FONT SWAP
# ══════════════════════════════════════════
$html = $html.Replace(
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Tenor+Sans&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=Instrument+Sans:wght@300;400;500;600",
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Outfit:wght@300;400;500;600;700&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400"
)
$html = $html.Replace("font-family:'Instrument Sans',sans-serif;", "font-family:'Outfit',sans-serif;")

# ══════════════════════════════════════════
# CSS VARIABLE PALETTE — Vintage Poster
# ══════════════════════════════════════════
$html = $html.Replace("--dusk:#1a0e08;",       "--dusk:#0F1D11;")
$html = $html.Replace("--dusk2:#261508;",      "--dusk2:#1E4623;")
$html = $html.Replace("--dusk3:#321b0a;",      "--dusk3:#3D7844;")
$html = $html.Replace("--ember:#c45a1a;",      "--ember:#FF851B;")
$html = $html.Replace("--ember2:#e07030;",     "--ember2:#FFA040;")
$html = $html.Replace("--amber:#d4940a;",      "--amber:#FFB347;")
$html = $html.Replace("--amber2:#f0b830;",     "--amber2:#FFD080;")
$html = $html.Replace("--champagne:#f5e6c8;",  "--champagne:#D4E8F0;")
$html = $html.Replace("--champagne2:#faf3e4;", "--champagne2:rgba(255,255,255,.06);")
$html = $html.Replace("--warm-white:#fdf8f0;", "--warm-white:#EAF4F8;")
$html = $html.Replace("--mahogany:#4a1e0a;",   "--mahogany:#0F1D11;")
$html = $html.Replace("--sand:#c8a878;",       "--sand:#5A9A6A;")
$html = $html.Replace("--sand2:#e8d4b0;",      "--sand2:rgba(255,255,255,.12);")
$html = $html.Replace("--muted:#8a7060;",      "--muted:#7AADA0;")
$html = $html.Replace("--dim:#5a4030;",        "--dim:#3D7844;")
$html = $html.Replace("--text:#f0e4d0;",       "--text:#FFFFFF;")
$html = $html.Replace("--ocean:#3a7a9a;",      "--ocean:#6CAAD3;")
$html = $html.Replace("--ocean2:#5a9ab8;",     "--ocean2:#8DC4E0;")

# ══════════════════════════════════════════
# COVER — Deep jungle canopy gradient
# ══════════════════════════════════════════
$html = $html.Replace(
  "radial-gradient(ellipse 120% 60% at 100% 0%,rgba(196,90,26,.5) 0%,transparent 55%),`n    radial-gradient(ellipse 80% 80% at 0% 100%,rgba(74,30,10,.8) 0%,transparent 60%),`n    radial-gradient(ellipse 60% 40% at 50% 50%,rgba(212,148,10,.08) 0%,transparent 60%),`n    linear-gradient(160deg,#120a04 0%,#1a0e08 45%,#1e1008 100%);",
  "radial-gradient(ellipse 120% 60% at 100% 0%,rgba(108,170,211,.35) 0%,transparent 55%),`n    radial-gradient(ellipse 80% 80% at 0% 100%,rgba(30,70,35,.9) 0%,transparent 60%),`n    radial-gradient(ellipse 60% 40% at 50% 50%,rgba(255,133,27,.06) 0%,transparent 60%),`n    linear-gradient(160deg,#0A1810 0%,#0F1D11 45%,#1E4623 100%);"
)

# Cover rays — tropical shimmer
$html = $html.Replace("rgba(196,90,26,.04) 0deg,", "rgba(108,170,211,.03) 0deg,")
$html = $html.Replace("rgba(212,148,10,.03) 13deg,", "rgba(255,133,27,.02) 13deg,")

# Headline stroke — ocean blue instead of ember
$html = $html.Replace("-webkit-text-stroke:1.5px var(--ember);", "-webkit-text-stroke:1.5px var(--ocean);")

# ══════════════════════════════════════════
# BODY — Full poster gradient background
# ══════════════════════════════════════════
$html = $html.Replace(
  "body{background:var(--warm-white);color:var(--dusk);",
  "body{background:linear-gradient(180deg,#6CAAD3 0%,#4A8FB8 20%,#275D74 50%,#1E4623 80%,#0F1D11 100%);background-attachment:fixed;color:var(--dusk);"
)

# ══════════════════════════════════════════
# APP CONTAINER — Semi-transparent
# ══════════════════════════════════════════
$html = $html.Replace(
  ".app{max-width:920px;margin:0 auto;padding:0 0 100px}",
  ".app{max-width:920px;margin:0 auto;padding:0 0 100px;position:relative;z-index:2}"
)

# ══════════════════════════════════════════
# TAB NAV — Glassmorphism
# ══════════════════════════════════════════
$html = $html.Replace(
  ".tab-nav-wrap{position:sticky;top:0;z-index:100;background:var(--warm-white);border-bottom:1px solid var(--sand2);box-shadow:0 4px 24px rgba(26,14,8,.07);display:flex;align-items:stretch}",
  ".tab-nav-wrap{position:sticky;top:0;z-index:100;background:rgba(15,29,17,.75);backdrop-filter:blur(20px) saturate(1.6);-webkit-backdrop-filter:blur(20px) saturate(1.6);border-bottom:1px solid rgba(255,255,255,.1);box-shadow:0 4px 32px rgba(15,29,17,.3);display:flex;align-items:stretch}"
)
$html = $html.Replace(
  ".tab-nav-chevron{flex-shrink:0;width:36px;display:flex;align-items:center;justify-content:center;background:var(--warm-white);border:none;cursor:pointer;color:var(--muted);transition:all .15s;z-index:3}",
  ".tab-nav-chevron{flex-shrink:0;width:36px;display:flex;align-items:center;justify-content:center;background:transparent;border:none;cursor:pointer;color:rgba(255,255,255,.5);transition:all .15s;z-index:3}"
)
$html = $html.Replace(".tab-nav-chevron:hover{color:var(--ember);background:var(--champagne2)}", ".tab-nav-chevron:hover{color:var(--ember);background:rgba(255,133,27,.15)}")
$html = $html.Replace(".tab-nav-chevron.left{border-right:1px solid var(--sand2)}", ".tab-nav-chevron.left{border-right:1px solid rgba(255,255,255,.08)}")
$html = $html.Replace(".tab-nav-chevron.right{border-left:1px solid var(--sand2)}", ".tab-nav-chevron.right{border-left:1px solid rgba(255,255,255,.08)}")

# Tab buttons — glass style
$html = $html.Replace(
  ".tab-btn{padding:7px 14px;font-size:.63rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:var(--muted);background:none;border:1px solid transparent;border-radius:100px;cursor:pointer;white-space:nowrap;transition:all .18s;flex-shrink:0;line-height:1}",
  ".tab-btn{padding:7px 14px;font-size:.63rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:rgba(255,255,255,.55);background:none;border:1px solid transparent;border-radius:100px;cursor:pointer;white-space:nowrap;transition:all .25s;flex-shrink:0;line-height:1}"
)
$html = $html.Replace(".tab-btn:hover{color:var(--dusk2);background:var(--champagne2);border-color:var(--sand2)}", ".tab-btn:hover{color:#FFF;background:rgba(255,255,255,.08);border-color:rgba(255,255,255,.15)}")
$html = $html.Replace(".tab-btn.active{color:var(--ember);background:rgba(196,90,26,.08);border-color:rgba(196,90,26,.25)}", ".tab-btn.active{color:#FF851B;background:rgba(255,133,27,.12);border-color:rgba(255,133,27,.3)}")

# Tab fade gradients
$html = $html.Replace("background:linear-gradient(to right,transparent,var(--warm-white) 80%)", "background:linear-gradient(to right,transparent,rgba(15,29,17,.75) 80%)")
$html = $html.Replace("background:linear-gradient(to left,transparent,var(--warm-white) 80%)", "background:linear-gradient(to left,transparent,rgba(15,29,17,.75) 80%)")

# ══════════════════════════════════════════
# PANELS — Glass cards on tropical bg
# ══════════════════════════════════════════
$html = $html.Replace(
  ".panel{display:none;padding:52px 36px 0}",
  ".panel{display:none;padding:52px 36px 0;color:#E8F0E8}"
)

# ══════════════════════════════════════════
# SECTION HEADERS — Light text
# ══════════════════════════════════════════
$html = $html.Replace(".sec-headline{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,4vw,2.6rem);font-weight:700;color:var(--dusk);", ".sec-headline{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,4vw,2.6rem);font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".sec-headline em{font-style:italic;font-weight:400;color:var(--ember)}", ".sec-headline em{font-style:italic;font-weight:400;color:#FFB347}")
$html = $html.Replace(".sec-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:var(--muted);", ".sec-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(255,255,255,.55);")

# ══════════════════════════════════════════
# STAT + CARD BACKGROUNDS — Glassmorphism
# ══════════════════════════════════════════
$html = $html.Replace(".stat-card{background:var(--champagne2);padding:22px 20px}", ".stat-card{background:rgba(255,255,255,.06);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);padding:22px 20px}")
$html = $html.Replace(".stat-label{font-size:.55rem;font-weight:600;letter-spacing:.3em;text-transform:uppercase;color:var(--muted);", ".stat-label{font-size:.55rem;font-weight:600;letter-spacing:.3em;text-transform:uppercase;color:rgba(255,255,255,.4);")
$html = $html.Replace(".stat-value{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--dusk);", ".stat-value{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".stat-sub{font-size:.7rem;color:var(--muted);margin-top:4px}", ".stat-sub{font-size:.7rem;color:rgba(255,255,255,.35);margin-top:4px}")
$html = $html.Replace(".requests-card{background:var(--champagne2);padding:22px 24px}", ".requests-card{background:rgba(255,255,255,.06);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);padding:22px 24px}")

# ══════════════════════════════════════════
# PERK CARDS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".perk-card{background:var(--champagne2);padding:28px;border:1px solid var(--sand2);transition:box-shadow .2s,transform .2s;break-inside:avoid}",
  ".perk-card{background:rgba(255,255,255,.05);backdrop-filter:blur(14px);-webkit-backdrop-filter:blur(14px);padding:28px;border:1px solid rgba(255,255,255,.1);transition:all .3s cubic-bezier(.4,0,.2,1);break-inside:avoid}"
)
$html = $html.Replace(".perk-card:hover{box-shadow:0 8px 32px rgba(26,14,8,.1);transform:translateY(-1px)}", ".perk-card:hover{box-shadow:0 12px 40px rgba(15,29,17,.3);transform:translateY(-3px) scale(1.01);border-color:rgba(255,133,27,.2)}")
$html = $html.Replace(".perk-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:var(--dusk);", ".perk-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".perk-desc{font-size:.83rem;color:var(--muted);line-height:1.7}", ".perk-desc{font-size:.83rem;color:rgba(255,255,255,.6);line-height:1.7}")
$html = $html.Replace("background:rgba(196,90,26,.06);border-left:2px solid var(--ember)", "background:rgba(255,133,27,.08);border-left:2px solid rgba(255,133,27,.5)")

# ══════════════════════════════════════════
# FLIGHT CARDS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".flight-card{background:var(--champagne2);border:1px solid var(--sand2);padding:32px 36px;margin-bottom:3px;position:relative;overflow:hidden;transition:box-shadow .2s}",
  ".flight-card{background:rgba(255,255,255,.05);backdrop-filter:blur(14px);-webkit-backdrop-filter:blur(14px);border:1px solid rgba(255,255,255,.1);padding:32px 36px;margin-bottom:3px;position:relative;overflow:hidden;transition:all .3s cubic-bezier(.4,0,.2,1)}"
)
$html = $html.Replace(".flight-card:hover{box-shadow:0 8px 32px rgba(26,14,8,.08)}", ".flight-card:hover{box-shadow:0 12px 40px rgba(15,29,17,.3);transform:translateY(-2px);border-color:rgba(108,170,211,.25)}")
$html = $html.Replace(".airport-code{font-family:'Playfair Display',serif;font-size:clamp(2.5rem,7vw,4.5rem);font-weight:900;color:var(--dusk);", ".airport-code{font-family:'Playfair Display',serif;font-size:clamp(2.5rem,7vw,4.5rem);font-weight:900;color:#FFFFFF;")
$html = $html.Replace(".airport-city{font-size:.7rem;color:var(--muted);", ".airport-city{font-size:.7rem;color:rgba(255,255,255,.45);")
$html = $html.Replace(".fc-num{position:absolute;top:32px;right:36px;font-family:'Playfair Display',serif;font-size:2rem;font-weight:700;color:var(--sand2);", ".fc-num{position:absolute;top:32px;right:36px;font-family:'Playfair Display',serif;font-size:2rem;font-weight:700;color:rgba(255,255,255,.08);")
$html = $html.Replace("background:linear-gradient(to right,var(--ember),rgba(196,90,26,.15))", "background:linear-gradient(to right,var(--ocean),rgba(108,170,211,.15))")
$html = $html.Replace(".flight-footer{display:flex;justify-content:space-between;margin-top:20px;padding-top:18px;border-top:1px solid var(--sand2)}", ".flight-footer{display:flex;justify-content:space-between;margin-top:20px;padding-top:18px;border-top:1px solid rgba(255,255,255,.1)}")
$html = $html.Replace(".ft-time{font-size:.9rem;font-weight:600;color:var(--dusk2)}", ".ft-time{font-size:.9rem;font-weight:600;color:#FFFFFF}")

# ══════════════════════════════════════════
# ACTIVITY CARDS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".activity-item{display:grid;grid-template-columns:72px 1fr;gap:0;margin-bottom:3px;background:var(--champagne2);border:1px solid var(--sand2);overflow:hidden;transition:box-shadow .2s,transform .2s}",
  ".activity-item{display:grid;grid-template-columns:72px 1fr;gap:0;margin-bottom:3px;background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);overflow:hidden;transition:all .3s cubic-bezier(.4,0,.2,1)}"
)
$html = $html.Replace(".activity-item:hover{box-shadow:0 8px 32px rgba(26,14,8,.1);transform:translateY(-1px)}", ".activity-item:hover{box-shadow:0 10px 36px rgba(15,29,17,.3);transform:translateY(-3px)}")
$html = $html.Replace(".ai-title{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--dusk);", ".ai-title{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".ai-desc{font-size:.83rem;color:var(--muted);", ".ai-desc{font-size:.83rem;color:rgba(255,255,255,.55);")
$html = $html.Replace("background:rgba(196,90,26,.05);border-left:2px solid var(--ember)", "background:rgba(255,133,27,.08);border-left:2px solid rgba(255,133,27,.5)")

# ══════════════════════════════════════════
# DINING CARDS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".dining-card{background:var(--champagne2);border:1px solid var(--sand2);overflow:hidden;transition:box-shadow .2s}",
  ".dining-card{background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);overflow:hidden;transition:all .3s cubic-bezier(.4,0,.2,1)}"
)
$html = $html.Replace(".dining-card:hover{box-shadow:0 8px 32px rgba(26,14,8,.1)}", ".dining-card:hover{box-shadow:0 10px 36px rgba(15,29,17,.3);transform:translateY(-2px)}")
$html = $html.Replace(".dc-name{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--dusk);", ".dc-name{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".dc-desc{font-size:.82rem;color:var(--muted);", ".dc-desc{font-size:.82rem;color:rgba(255,255,255,.55);")
$html = $html.Replace(".dc-divider{height:1px;background:var(--sand2);margin:0 26px}", ".dc-divider{height:1px;background:rgba(255,255,255,.08);margin:0 26px}")

# ══════════════════════════════════════════
# TIMING ITEMS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".timing-item{display:grid;grid-template-columns:180px 1fr;background:var(--champagne2);border:1px solid var(--sand2);overflow:hidden;transition:box-shadow .2s}",
  ".timing-item{display:grid;grid-template-columns:180px 1fr;background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);overflow:hidden;transition:all .25s ease}"
)
$html = $html.Replace(".timing-item:hover{box-shadow:0 4px 20px rgba(26,14,8,.07)}", ".timing-item:hover{box-shadow:0 8px 28px rgba(15,29,17,.25);transform:translateY(-1px)}")
$html = $html.Replace("background:rgba(196,90,26,.06);padding:22px;border-right:1px solid var(--sand2)", "background:rgba(255,133,27,.06);padding:22px;border-right:1px solid rgba(255,255,255,.08)")
$html = $html.Replace(".ti-place{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:var(--dusk);", ".ti-place{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".ti-desc{font-size:.82rem;color:var(--muted);line-height:1.7}", ".ti-desc{font-size:.82rem;color:rgba(255,255,255,.55);line-height:1.7}")

# ══════════════════════════════════════════
# INFO CARDS — Glass
# ══════════════════════════════════════════
$html = $html.Replace(".info-card{background:var(--champagne2);border:1px solid var(--sand2);padding:26px}", ".info-card{background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);padding:26px}")
$html = $html.Replace(".ic-value{font-size:.88rem;color:var(--dusk2);line-height:1.7}", ".ic-value{font-size:.88rem;color:rgba(255,255,255,.75);line-height:1.7}")

# ══════════════════════════════════════════
# ROADMAP — Glass
# ══════════════════════════════════════════
$html = $html.Replace(
  ".roadmap-item{display:grid;grid-template-columns:160px 1fr;background:var(--champagne2);border:1px solid var(--sand2);overflow:hidden;transition:box-shadow .2s;break-inside:avoid}",
  ".roadmap-item{display:grid;grid-template-columns:160px 1fr;background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);overflow:hidden;transition:all .25s ease;break-inside:avoid}"
)
$html = $html.Replace(".roadmap-item:hover{box-shadow:0 4px 20px rgba(26,14,8,.08)}", ".roadmap-item:hover{box-shadow:0 6px 24px rgba(15,29,17,.25);transform:translateY(-1px)}")
$html = $html.Replace(".roadmap-item.active-phase{border-color:var(--ember);box-shadow:0 0 0 2px rgba(196,90,26,.15)}", ".roadmap-item.active-phase{border-color:rgba(255,133,27,.4);box-shadow:0 0 0 2px rgba(255,133,27,.15)}")
$html = $html.Replace(".ri-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:var(--dusk);", ".ri-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".ri-desc{font-size:.8rem;color:var(--muted);", ".ri-desc{font-size:.8rem;color:rgba(255,255,255,.5);")
$html = $html.Replace("background:rgba(196,90,26,.04)}", "background:rgba(255,133,27,.04)}")
$html = $html.Replace(".ri-left.active-bg{background:linear-gradient(135deg,rgba(196,90,26,.12),rgba(196,90,26,.04))}", ".ri-left.active-bg{background:linear-gradient(135deg,rgba(255,133,27,.15),rgba(255,133,27,.04))}")
$html = $html.Replace(".status-now{background:rgba(196,90,26,.15);color:var(--ember)}", ".status-now{background:rgba(255,133,27,.2);color:#FF851B}")

# Roadmap banner
$html = $html.Replace(".roadmap-now-banner{background:var(--ember);", ".roadmap-now-banner{background:linear-gradient(135deg,#FF851B,#E06A10);")
$html = $html.Replace(".roadmap-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:var(--muted);", ".roadmap-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(255,255,255,.5);")

# ══════════════════════════════════════════
# PACKING / CHECKLIST — Glass + Light text
# ══════════════════════════════════════════
$html = $html.Replace(".cl-group-label{font-size:.58rem;font-weight:600;letter-spacing:.35em;text-transform:uppercase;color:var(--muted);margin-bottom:8px;padding-bottom:8px;border-bottom:1px solid var(--sand2)}", ".cl-group-label{font-size:.58rem;font-weight:600;letter-spacing:.35em;text-transform:uppercase;color:rgba(255,255,255,.35);margin-bottom:8px;padding-bottom:8px;border-bottom:1px solid rgba(255,255,255,.1)}")
$html = $html.Replace(".cl-item{display:flex;align-items:center;gap:16px;padding:13px 0;border-bottom:1px solid var(--sand2);", ".cl-item{display:flex;align-items:center;gap:16px;padding:13px 0;border-bottom:1px solid rgba(255,255,255,.06);")
$html = $html.Replace(".cl-box{width:20px;height:20px;flex-shrink:0;border:1.5px solid var(--sand);", ".cl-box{width:20px;height:20px;flex-shrink:0;border:1.5px solid rgba(255,255,255,.25);")
$html = $html.Replace(".cl-text{font-size:.88rem;color:var(--dusk);", ".cl-text{font-size:.88rem;color:rgba(255,255,255,.8);")
$html = $html.Replace(".cl-item.done .cl-text{color:var(--muted);text-decoration:line-through}", ".cl-item.done .cl-text{color:rgba(255,255,255,.3);text-decoration:line-through}")
$html = $html.Replace(".progress-bar-wrap{background:var(--sand2);", ".progress-bar-wrap{background:rgba(255,255,255,.1);")

# Rec cards
$html = $html.Replace(".rec-card{background:var(--champagne2);border:1px solid var(--sand2);padding:22px 24px;transition:box-shadow .2s}", ".rec-card{background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);padding:22px 24px;transition:all .3s ease}")
$html = $html.Replace(".rec-card:hover{box-shadow:0 4px 20px rgba(26,14,8,.08)}", ".rec-card:hover{box-shadow:0 8px 28px rgba(15,29,17,.25);transform:translateY(-2px)}")
$html = $html.Replace(".rc-name{font-family:'Playfair Display',serif;font-size:1.05rem;font-weight:700;color:var(--dusk);", ".rc-name{font-family:'Playfair Display',serif;font-size:1.05rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".rc-why{font-size:.8rem;color:var(--muted);", ".rc-why{font-size:.8rem;color:rgba(255,255,255,.55);")
$html = $html.Replace("color:var(--ember2);background:rgba(196,90,26,.08);border:1px solid rgba(196,90,26,.2)", "color:#FFB347;background:rgba(255,133,27,.1);border:1px solid rgba(255,133,27,.25)")

# Pack recs titles
$html = $html.Replace(".pack-recs-title{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:700;color:var(--dusk);", ".pack-recs-title{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".pack-recs-sub{font-size:.82rem;color:var(--muted);", ".pack-recs-sub{font-size:.82rem;color:rgba(255,255,255,.45);")

# ══════════════════════════════════════════
# RESORT INFO — Glass
# ══════════════════════════════════════════
$html = $html.Replace(".resort-info-card{background:var(--champagne2);border:1px solid var(--sand2);padding:18px 20px}", ".resort-info-card{background:rgba(255,255,255,.05);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);padding:18px 20px}")
$html = $html.Replace(".resort-map-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:700;color:var(--dusk);", ".resort-map-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:700;color:#FFFFFF;")
$html = $html.Replace(".resort-map-note{font-size:.8rem;color:var(--muted);", ".resort-map-note{font-size:.8rem;color:rgba(255,255,255,.45);")
$html = $html.Replace(".rlb-primary{background:var(--ember);color:var(--warm-white)}", ".rlb-primary{background:linear-gradient(135deg,#FF851B,#E06A10);color:#FFF;transition:all .3s ease}")
$html = $html.Replace(".rlb-primary:hover{background:#a84a12}", ".rlb-primary:hover{background:linear-gradient(135deg,#FFA040,#FF851B);transform:scale(1.05);box-shadow:0 4px 20px rgba(255,133,27,.3)}")
$html = $html.Replace(".rlb-secondary{background:var(--champagne2);color:var(--dusk2);border:1px solid var(--sand2)}", ".rlb-secondary{background:rgba(255,255,255,.06);color:rgba(255,255,255,.7);border:1px solid rgba(255,255,255,.15);transition:all .25s ease}")
$html = $html.Replace(".rlb-secondary:hover{background:var(--sand2)}", ".rlb-secondary:hover{background:rgba(255,255,255,.12);transform:scale(1.03)}")

# ══════════════════════════════════════════
# FACTS — Already dark, tweak colors
# ══════════════════════════════════════════
$html = $html.Replace("color:rgba(245,230,200,.03)", "color:rgba(255,255,255,.03)")
$html = $html.Replace("background:rgba(245,230,200,.05);border:1px solid rgba(245,230,200,.1);color:rgba(245,230,200,.35)", "background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.35)")

# ══════════════════════════════════════════
# BULK COLOR SWAPS
# ══════════════════════════════════════════
$html = $html.Replace("rgba(26,14,8,", "rgba(15,29,17,")
$html = $html.Replace("rgba(245,230,200,", "rgba(255,255,255,")
$html = $html.Replace("rgba(74,30,10,", "rgba(30,70,35,")
$html = $html.Replace("rgba(58,122,154,.2)", "rgba(108,170,211,.15)")
$html = $html.Replace("rgba(58,122,154,.3)", "rgba(108,170,211,.25)")
$html = $html.Replace("rgba(58,122,154,.25)", "rgba(108,170,211,.2)")

# ══════════════════════════════════════════
# MAP DOTS — Poster palette
# ══════════════════════════════════════════
$html = $html.Replace('style="background:#c45a1a"', 'style="background:#FF851B"')
$html = $html.Replace('style="background:#3a7a9a"', 'style="background:#6CAAD3"')
$html = $html.Replace('style="background:#b8960c"', 'style="background:#FFB347"')
$html = $html.Replace('style="background:#5a8a5a"', 'style="background:#3D7844"')
$html = $html.Replace('style="background:#6a4a8a"', 'style="background:#E05050"')

# JS map markers
$html = $html.Replace("c:'#c45a1a',s:18", "c:'#FF851B',s:18")
$html = $html.Replace("c:'#c45a1a',s:16", "c:'#FF851B',s:16")
$html = $html.Replace("c:'#6a4a8a'", "c:'#E05050'")
$html = $html.Replace("c:'#5a8a5a'", "c:'#3D7844'")
$html = $html.Replace("c:'#3a7a9a'", "c:'#6CAAD3'")
$html = $html.Replace("c:'#b8960c'", "c:'#FFB347'")
$html = $html.Replace("c:'#d4940a'", "c:'#6CAAD3'")
$html = $html.Replace("c:'#c45a1a'", "c:'#FF851B'")

# ══════════════════════════════════════════
# INJECT — SVG overlays + interaction CSS
# ══════════════════════════════════════════
$svgLeaf = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 800' fill='%231E4623'%3E%3Cpath d='M750,800 C680,680 550,600 400,580 C250,560 120,620 50,750 C100,680 200,610 320,590 C330,520 360,450 420,380 C360,390 280,420 220,480 C260,410 320,360 390,320 C340,310 260,330 180,380 C230,320 300,280 380,260 C320,230 240,240 150,280 C220,220 310,190 410,190 C360,150 280,140 180,160 C260,110 360,100 460,120 C420,70 340,50 240,60 C340,10 450,20 540,60 C510,10 440,0 350,0 C460,0 560,30 630,90 C670,130 700,180 720,240 C750,340 760,450 780,560 C790,640 800,720 750,800 Z' opacity='0.8'/%3E%3C/svg%3E"

$svgVolcano = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 400' fill='%233D7844'%3E%3Cpath d='M0,400 L1440,400 L1440,320 C1320,290 1210,250 1100,260 C950,275 880,310 720,180 C610,90 540,80 480,120 C380,180 290,280 150,310 C80,325 30,340 0,350 Z' opacity='0.75'/%3E%3Cpath d='M0,400 L1440,400 L1440,350 C1380,330 1280,310 1190,320 C1020,340 910,260 760,220 C640,188 560,210 490,260 C390,330 210,360 0,385 Z' fill='%231E4623' opacity='0.9'/%3E%3C/svg%3E"

$extraCSS = @"

/* ── VINTAGE POSTER OVERLAYS ── */
body::before{content:'';position:fixed;bottom:0;left:0;width:100%;height:400px;background:url("$svgVolcano") no-repeat bottom center/100% auto;opacity:.07;pointer-events:none;z-index:0}
body::after{content:'';position:fixed;bottom:-60px;right:-80px;width:500px;height:500px;background:url("$svgLeaf") no-repeat center/contain;opacity:.06;pointer-events:none;z-index:0;transform:rotate(15deg)}
/* ── GLASSMORPHISM INTERACTIONS ── */
.tag{transition:all .2s ease}
.tag:hover{transform:translateY(-1px);box-shadow:0 2px 8px rgba(15,29,17,.2)}
.perk-card,.flight-card,.activity-item,.dining-card,.timing-item,.roadmap-item,.rec-card,.info-card,.stat-card{transition:all .3s cubic-bezier(.4,0,.2,1)}
.resort-link-btn{transition:all .25s ease}
.cl-item{transition:background .15s ease}
.cl-item:hover{background:rgba(255,255,255,.03);border-radius:4px}
a{transition:color .2s ease}
/* ── POSTER GRAIN OVERLAY ── */
.app::before{content:'';position:fixed;inset:0;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");pointer-events:none;z-index:9999}
"@

$html = $html.Replace("</style>", "$extraCSS`n</style>")

# ══════════════════════════════════════════
# WRITE
# ══════════════════════════════════════════
[System.IO.File]::WriteAllText($file, $html, [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host "Vintage poster redesign applied!" -ForegroundColor Green
Write-Host "  $original -> $($html.Length) bytes" -ForegroundColor Gray
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  Use GitHub Desktop to commit + push"
Write-Host "  Then: GitHub > Actions > Run workflow"