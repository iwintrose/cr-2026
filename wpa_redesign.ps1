# WPA Vintage Travel Poster — Complete Style Overhaul
# Replaces the ENTIRE <style> block for reliability
# Run: powershell -ExecutionPolicy Bypass -File .\wpa_redesign.ps1

$file = Join-Path $PSScriptRoot "index.html"
if (-not (Test-Path $file)) { Write-Host "ERROR: index.html not found." -ForegroundColor Red; exit 1 }

$html = Get-Content $file -Raw -Encoding UTF8
Write-Host "Read index.html ($($html.Length) bytes)" -ForegroundColor Cyan

# Extract everything before <style>, after </style>, and replace the middle
$styleStart = $html.IndexOf("<style>")
$styleEnd = $html.IndexOf("</style>") + "</style>".Length

if ($styleStart -lt 0 -or $styleEnd -lt 0) {
  Write-Host "ERROR: Could not find <style> block" -ForegroundColor Red
  exit 1
}

$before = $html.Substring(0, $styleStart)
$after = $html.Substring($styleEnd)

# Also swap the font import in the <head>
$before = $before.Replace(
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Outfit:wght@300;400;500;600;700&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400",
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400"
)
# Fallback for original font string
$before = $before.Replace(
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Tenor+Sans&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=Instrument+Sans:wght@300;400;500;600",
  "family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Cormorant:ital,wght@0,300;0,600;1,300;1,600&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400"
)

# Also fix map legend dot colors in the HTML body
$after = $after -replace 'style="background:#[0-9A-Fa-f]{6}"', 'style="background:#E06A1B"'
# Re-apply specific dot colors
$after = $after.Replace('class="legend-dot" style="background:#E06A1B"></div>Resort', 'class="legend-dot" style="background:#E06A1B"></div>Resort')
$after = $after.Replace('class="legend-dot" style="background:#E06A1B"></div>Dining', 'class="legend-dot" style="background:#275D74"></div>Dining')
$after = $after.Replace('class="legend-dot" style="background:#E06A1B"></div>Excursions', 'class="legend-dot" style="background:#DDA15E"></div>Excursions')
$after = $after.Replace('class="legend-dot" style="background:#E06A1B"></div>Beaches', 'class="legend-dot" style="background:#3D7844"></div>Beaches')
$after = $after.Replace('class="legend-dot" style="background:#E06A1B"></div>Airport', 'class="legend-dot" style="background:#8B4513"></div>Airport')

# Fix JS map marker colors
$after = $after.Replace("c:'#2B5B33',s:18", "c:'#E06A1B',s:18")
$after = $after.Replace("c:'#2B5B33',s:16", "c:'#E06A1B',s:16")
$after = $after.Replace("c:'#E54B4B'", "c:'#8B4513'")
$after = $after.Replace("c:'#3CB371'", "c:'#3D7844'")
$after = $after.Replace("c:'#028090'", "c:'#275D74'")
$after = $after.Replace("c:'#F4B41A'", "c:'#DDA15E'")
$after = $after.Replace("c:'#2B5B33'", "c:'#E06A1B'")
$after = $after.Replace("c:'#FF851B',s:18", "c:'#E06A1B',s:18")
$after = $after.Replace("c:'#FF851B',s:16", "c:'#E06A1B',s:16")
$after = $after.Replace("c:'#E05050'", "c:'#8B4513'")
$after = $after.Replace("c:'#FFB347'", "c:'#DDA15E'")
$after = $after.Replace("c:'#6CAAD3'", "c:'#275D74'")
$after = $after.Replace("c:'#FF851B'", "c:'#E06A1B'")

Write-Host "Injecting WPA vintage poster CSS..." -ForegroundColor Yellow

$newStyle = @'
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --ink:#0F1D11;
  --parchment:#F5EBE0;
  --parchment2:#F2E9E1;
  --cream:#EDE0D0;
  --sky:#6CAAD3;
  --ocean:#275D74;
  --forest:#1E4623;
  --forest2:#3D7844;
  --orange:#E06A1B;
  --ochre:#DDA15E;
  --rust:#A0522D;
  --warmblack:#1A1A0E;
  --mutedgreen:#5A7A5A;
}
html{scroll-behavior:smooth}
body{
  background:linear-gradient(175deg,#6CAAD3 0%,#4A8FB8 15%,#275D74 40%,#1E4623 70%,#0F1D11 100%);
  background-attachment:fixed;
  color:var(--ink);
  font-family:'Libre Baskerville',serif;
  font-weight:400;font-size:15px;
  overflow-x:hidden;
  -webkit-print-color-adjust:exact;print-color-adjust:exact;
}

/* ── PAPER TEXTURE OVERLAY ── */
body::before{content:'';position:fixed;inset:0;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='5' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='400' height='400' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");pointer-events:none;z-index:0}
/* ── VOLCANO SVG ── */
body::after{content:'';position:fixed;bottom:0;left:0;width:100%;height:400px;background:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 400' fill='%233D7844'%3E%3Cpath d='M0,400 L1440,400 L1440,320 C1320,290 1210,250 1100,260 C950,275 880,310 720,180 C610,90 540,80 480,120 C380,180 290,280 150,310 C80,325 30,340 0,350 Z' opacity='0.75'/%3E%3Cpath d='M0,400 L1440,400 L1440,350 C1380,330 1280,310 1190,320 C1020,340 910,260 760,220 C640,188 560,210 490,260 C390,330 210,360 0,385 Z' fill='%231E4623' opacity='0.9'/%3E%3C/svg%3E") no-repeat bottom center/100% auto;opacity:.08;pointer-events:none;z-index:0}

/* ── COVER ── */
.cover{min-height:100vh;background:var(--ink);position:relative;display:grid;grid-template-rows:auto 1fr auto auto;overflow:hidden}
.cover-bg{position:absolute;inset:0;background:radial-gradient(ellipse 120% 60% at 100% 0%,rgba(108,170,211,.3) 0%,transparent 55%),radial-gradient(ellipse 80% 80% at 0% 100%,rgba(30,70,35,.85) 0%,transparent 60%),linear-gradient(160deg,#0A1810 0%,#0F1D11 45%,#1E4623 100%)}
.cover-rays{position:absolute;inset:0;background:repeating-conic-gradient(from 280deg at 110% -10%,rgba(108,170,211,.03) 0deg,transparent 3deg,transparent 10deg,rgba(221,161,94,.02) 13deg,transparent 16deg);animation:rays 25s linear infinite}
@keyframes rays{from{transform:rotate(0)}to{transform:rotate(360deg)}}
.cover-grain{position:absolute;inset:0;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.8' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23n)' opacity='0.06'/%3E%3C/svg%3E");pointer-events:none;z-index:1}
.cover-nav{position:relative;z-index:10;display:flex;justify-content:space-between;align-items:center;padding:28px 44px}
.nav-logo{font-family:'Cormorant',serif;font-style:italic;font-weight:300;font-size:1.1rem;color:rgba(245,235,224,.5);letter-spacing:.12em}
.nav-phase{font-size:.6rem;font-weight:600;letter-spacing:.4em;text-transform:uppercase;color:var(--ochre);opacity:.8}
.cover-body{position:relative;z-index:5;display:flex;flex-direction:column;justify-content:flex-end;padding:0 44px 0}
.cover-overline{font-family:'DM Sans',sans-serif;font-size:.65rem;letter-spacing:.5em;text-transform:uppercase;color:var(--ochre);margin-bottom:20px;opacity:0;animation:fadeUp .7s ease forwards .3s}
.cover-headline{font-family:'Playfair Display',serif;font-weight:900;font-size:clamp(4.5rem,15vw,12rem);line-height:.85;letter-spacing:-.02em;opacity:0;animation:fadeUp 1s ease forwards .5s}
.cover-headline .hl1{display:block;color:var(--parchment)}
.cover-headline .hl2{display:block;color:transparent;-webkit-text-stroke:1.5px var(--ochre);font-style:italic}
.cover-sub{font-family:'Cormorant',serif;font-style:italic;font-weight:300;font-size:clamp(1rem,2.5vw,1.5rem);color:rgba(245,235,224,.45);margin-top:20px;max-width:500px;line-height:1.55;opacity:0;animation:fadeUp .8s ease forwards .8s}

/* ── COUNTDOWN ── */
.countdown-strip{position:relative;z-index:5;display:flex;align-items:stretch;overflow:hidden;margin-top:44px;opacity:0;animation:fadeUp .8s ease forwards 1s}
.cd-label-block{background:rgba(224,106,27,.2);border-right:1px solid rgba(224,106,27,.25);padding:18px 24px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.cd-label-text{font-size:.55rem;font-weight:600;letter-spacing:.3em;text-transform:uppercase;color:var(--ochre);writing-mode:vertical-rl;transform:rotate(180deg)}
.cd-units{display:flex;flex:1;background:rgba(245,235,224,.06)}
.cd-unit{flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:18px 10px;border-right:1px solid rgba(245,235,224,.06)}
.cd-unit:last-child{border-right:none}
.cd-num{font-family:'Playfair Display',serif;font-weight:700;font-size:clamp(1.8rem,5vw,3rem);color:var(--parchment);line-height:1;letter-spacing:.03em}
.cd-lbl{font-size:.52rem;font-weight:600;letter-spacing:.25em;text-transform:uppercase;color:rgba(245,235,224,.3);margin-top:4px}

/* ── META STRIP ── */
.cover-meta{position:relative;z-index:5;display:flex;border-top:1px solid rgba(245,235,224,.08);margin-top:0;opacity:0;animation:fadeIn .8s ease forwards 1.2s}
.cmi{flex:1;padding:22px 28px;border-right:1px solid rgba(245,235,224,.06)}
.cmi:last-child{border-right:none}
.cmi-label{font-size:.55rem;font-weight:600;letter-spacing:.3em;text-transform:uppercase;color:rgba(245,235,224,.25);margin-bottom:6px}
.cmi-value{font-family:'Cormorant',serif;font-size:1rem;font-weight:600;color:rgba(245,235,224,.8)}

/* ── APP ── */
.app{max-width:920px;margin:0 auto;padding:0 0 100px;position:relative;z-index:2}

/* ── TAB NAV — Vintage bar ── */
.tab-nav-wrap{position:sticky;top:0;z-index:100;background:var(--parchment);border-bottom:2px solid var(--ink);box-shadow:0 3px 0 rgba(15,29,17,.1);display:flex;align-items:stretch}
.tab-nav-chevron{flex-shrink:0;width:36px;display:flex;align-items:center;justify-content:center;background:var(--parchment);border:none;cursor:pointer;color:var(--ink);transition:all .15s;z-index:3}
.tab-nav-chevron:hover{color:var(--orange);background:var(--cream)}
.tab-nav-chevron:disabled{opacity:.2;cursor:default}
.tab-nav-chevron.left{border-right:1px solid rgba(15,29,17,.12)}
.tab-nav-chevron.right{border-left:1px solid rgba(15,29,17,.12)}
.tab-nav-inner{flex:1;position:relative;overflow:hidden}
.tab-nav-scroll{display:flex;overflow-x:auto;scrollbar-width:none;padding:0 16px;gap:4px;align-items:center;min-height:52px;cursor:grab;user-select:none}
.tab-nav-scroll::-webkit-scrollbar{display:none}
.tab-nav-scroll.dragging{cursor:grabbing}
.tab-nav-fade-right{position:absolute;right:0;top:0;bottom:0;width:32px;background:linear-gradient(to right,transparent,var(--parchment) 80%);pointer-events:none;z-index:2;transition:opacity .2s}
.tab-nav-fade-left{position:absolute;left:0;top:0;bottom:0;width:32px;background:linear-gradient(to left,transparent,var(--parchment) 80%);pointer-events:none;z-index:2;opacity:0;transition:opacity .2s}
.tab-btn{padding:7px 14px;font-size:.6rem;font-weight:700;letter-spacing:.15em;text-transform:uppercase;color:var(--ink);background:none;border:1.5px solid transparent;border-radius:0;cursor:pointer;white-space:nowrap;transition:all .15s;flex-shrink:0;line-height:1;font-family:'DM Sans',sans-serif}
.tab-btn:hover{color:var(--orange);border-bottom:1.5px solid var(--orange)}
.tab-btn.active{color:var(--parchment);background:var(--ink);border-color:var(--ink)}

/* ── PANELS ── */
.panel{display:none;padding:52px 36px 0}
.panel.active{display:block}

/* ── SECTION HEADERS ── */
.sec-label{font-size:.58rem;font-weight:700;letter-spacing:.4em;text-transform:uppercase;color:var(--ochre);margin-bottom:10px;font-family:'DM Sans',sans-serif}
.sec-headline{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,4vw,2.6rem);font-weight:700;color:var(--parchment);line-height:1.1;margin-bottom:8px;letter-spacing:-.01em}
.sec-headline em{font-style:italic;font-weight:400;color:var(--ochre)}
.sec-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(245,235,224,.5);line-height:1.7;margin-bottom:36px;padding-left:16px;border-left:2px solid var(--ochre)}

/* ── VINTAGE CARD BASE ── */
.stat-card,.perk-card,.rec-card,.resort-info-card,.info-card,.requests-card{background:var(--parchment);border:2px solid var(--ink);box-shadow:4px 4px 0px var(--ink);color:var(--ink);transition:all .2s ease-in-out}
.stat-card:hover,.perk-card:hover,.rec-card:hover,.info-card:hover{transform:translate(-3px,-3px);box-shadow:7px 7px 0px var(--ink)}

/* ── OVERVIEW ── */
.overview-hero{background:var(--forest);padding:44px;margin-bottom:6px;position:relative;overflow:hidden;border:2px solid var(--ink);box-shadow:4px 4px 0 var(--ink)}
.overview-hero::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 80% 60% at 100% 0%,rgba(108,170,211,.2) 0%,transparent 60%)}
.oh-eyebrow{font-size:.58rem;font-weight:700;letter-spacing:.4em;text-transform:uppercase;color:var(--ochre);margin-bottom:16px;position:relative;z-index:2;font-family:'DM Sans',sans-serif}
.oh-resort{font-family:'Playfair Display',serif;font-size:clamp(1.4rem,3.5vw,2.2rem);font-weight:700;color:var(--parchment);margin-bottom:8px;line-height:1.2;position:relative;z-index:2}
.oh-room{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(245,235,224,.5);margin-bottom:28px;position:relative;z-index:2}
.oh-tags{display:flex;gap:8px;flex-wrap:wrap;position:relative;z-index:2}
.tag{font-size:.6rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;padding:5px 12px;font-family:'DM Sans',sans-serif;transition:all .15s}
.tag-ember{background:var(--orange);color:var(--parchment);border:1.5px solid var(--ink)}
.tag-amber{background:var(--ochre);color:var(--ink);border:1.5px solid var(--ink)}
.tag-ocean{background:var(--ocean);color:var(--parchment);border:1.5px solid var(--ink)}
.tag:hover{transform:translate(-2px,-2px);box-shadow:3px 3px 0 var(--ink)}

.stats-row{display:grid;grid-template-columns:repeat(4,1fr);gap:6px;margin-bottom:6px}
.stat-card{padding:22px 20px}
.stat-label{font-size:.55rem;font-weight:700;letter-spacing:.3em;text-transform:uppercase;color:var(--mutedgreen);margin-bottom:8px;font-family:'DM Sans',sans-serif}
.stat-value{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--ink);line-height:1.2}
.stat-sub{font-size:.7rem;color:var(--mutedgreen);margin-top:4px}
.requests-card{padding:22px 24px}
.req-pills{display:flex;gap:6px;flex-wrap:wrap;margin-top:10px}

/* ── STAR CLASS PERKS ── */
.perks-intro-card{background:var(--forest);padding:40px 44px;margin-bottom:6px;position:relative;overflow:hidden;border:2px solid var(--ink);box-shadow:4px 4px 0 var(--ink)}
.perks-intro-card::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 70% 50% at 100% 50%,rgba(221,161,94,.15) 0%,transparent 60%)}
.pic-label{font-size:.58rem;font-weight:700;letter-spacing:.4em;text-transform:uppercase;color:var(--ochre);margin-bottom:16px;position:relative;z-index:2;font-family:'DM Sans',sans-serif}
.pic-title{font-family:'Playfair Display',serif;font-size:clamp(1.6rem,4vw,2.4rem);font-weight:700;color:var(--parchment);line-height:1.2;margin-bottom:12px;position:relative;z-index:2}
.pic-title em{font-style:italic;font-weight:400;color:var(--ochre)}
.pic-desc{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(245,235,224,.55);line-height:1.65;max-width:560px;position:relative;z-index:2}
.perks-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-bottom:6px}
.perk-card{padding:28px}
.perk-card.full{grid-column:1/-1}
.perk-icon{font-size:1.8rem;margin-bottom:14px;display:block}
.perk-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:var(--ink);margin-bottom:8px}
.perk-desc{font-size:.83rem;color:var(--mutedgreen);line-height:1.7}
.perk-highlight{margin-top:12px;padding:10px 14px;background:rgba(224,106,27,.08);border-left:3px solid var(--orange);font-size:.78rem;color:var(--ink);line-height:1.6;font-style:italic}

/* ── BUTLER ── */
.butler-card{background:var(--forest);padding:44px;margin-bottom:6px;display:grid;grid-template-columns:1fr 1fr;gap:40px;align-items:center;position:relative;overflow:hidden;border:2px solid var(--ink);box-shadow:4px 4px 0 var(--ink)}
.butler-card::after{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 60% 80% at 0% 50%,rgba(108,170,211,.1) 0%,transparent 60%)}
.bc-label{font-size:.58rem;font-weight:700;letter-spacing:.4em;text-transform:uppercase;color:var(--ochre);margin-bottom:14px;position:relative;z-index:2;font-family:'DM Sans',sans-serif}
.bc-title{font-family:'Playfair Display',serif;font-size:clamp(1.4rem,3vw,2rem);font-weight:700;color:var(--parchment);line-height:1.2;margin-bottom:16px;position:relative;z-index:2}
.bc-desc{font-size:.85rem;color:rgba(245,235,224,.55);line-height:1.75;position:relative;z-index:2}
.bc-tips{display:flex;flex-direction:column;gap:4px;position:relative;z-index:2}
.bc-tip{background:rgba(245,235,224,.06);border:1px solid rgba(245,235,224,.1);padding:16px 20px}
.bc-tip-title{font-size:.7rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--ochre);margin-bottom:6px;font-family:'DM Sans',sans-serif}
.bc-tip-text{font-size:.8rem;color:rgba(245,235,224,.55);line-height:1.6}

/* ═══ FLIGHTS — Vintage Airline Ticket ═══ */
.flight-card{background:var(--parchment);border:2px dashed var(--ink);padding:32px 36px;margin-bottom:8px;position:relative;overflow:hidden;transition:all .2s ease-in-out}
.flight-card::before{content:'✈';position:absolute;top:16px;left:16px;font-size:4rem;color:rgba(15,29,17,.04);font-family:serif}
.flight-card:hover{transform:translate(-3px,-3px);box-shadow:6px 6px 0px var(--ink)}
.flight-dir-badge{display:inline-flex;align-items:center;gap:8px;font-size:.6rem;font-weight:700;letter-spacing:.25em;text-transform:uppercase;color:var(--orange);margin-bottom:24px;font-family:'DM Sans',sans-serif}
.flight-dir-badge::before{content:'';width:20px;height:2px;background:var(--orange)}
.fc-num{position:absolute;top:32px;right:36px;font-family:'Playfair Display',serif;font-size:2rem;font-weight:700;color:rgba(15,29,17,.08);letter-spacing:.05em}
.flight-route{display:flex;align-items:center;gap:24px}
.airport-code{font-family:'Playfair Display',serif;font-size:clamp(2.5rem,7vw,4.5rem);font-weight:900;color:var(--ink);line-height:1;letter-spacing:.02em}
.airport-city{font-size:.7rem;color:var(--mutedgreen);margin-top:4px;font-weight:500}
.route-mid{flex:1;display:flex;flex-direction:column;align-items:center;gap:6px}
.route-line-wrap{width:100%;display:flex;align-items:center;gap:8px}
.rline{flex:1;height:2px;border-top:2px dashed var(--ink)}
.rplane{color:var(--orange);font-size:1.2rem}
.route-dur{font-size:.62rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;color:var(--mutedgreen);font-family:'DM Sans',sans-serif}
.flight-footer{display:flex;justify-content:space-between;margin-top:20px;padding-top:18px;border-top:2px dashed rgba(15,29,17,.15)}
.ft-label{font-size:.58rem;color:var(--mutedgreen);font-weight:700;letter-spacing:.1em;text-transform:uppercase;margin-bottom:3px;font-family:'DM Sans',sans-serif}
.ft-time{font-size:.9rem;font-weight:700;color:var(--ink)}

/* ── ACTIVITIES — Retro cards ── */
.activity-item{display:grid;grid-template-columns:72px 1fr;gap:0;margin-bottom:6px;background:var(--parchment);border:2px solid var(--ink);box-shadow:4px 4px 0px var(--ink);overflow:hidden;transition:all .2s ease-in-out}
.activity-item:hover{transform:translate(-3px,-3px);box-shadow:7px 7px 0px var(--ink)}
.ai-number{background:var(--forest);display:flex;align-items:center;justify-content:center;font-family:'Playfair Display',serif;font-size:2rem;font-weight:700;color:rgba(245,235,224,.15);flex-shrink:0}
.ai-body{padding:26px 30px}
.ai-category{font-size:.55rem;font-weight:700;letter-spacing:.35em;text-transform:uppercase;color:var(--orange);margin-bottom:8px;font-family:'DM Sans',sans-serif}
.ai-title{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--ink);margin-bottom:8px;line-height:1.2}
.ai-desc{font-size:.83rem;color:var(--mutedgreen);line-height:1.75;margin-bottom:12px}
.ai-tip{display:flex;gap:10px;align-items:flex-start;background:rgba(224,106,27,.06);border-left:3px solid var(--orange);padding:10px 14px;font-size:.77rem;color:var(--ink);line-height:1.6}

/* ── DINING ── */
.dining-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px}
.dining-card{background:var(--parchment);border:2px solid var(--ink);box-shadow:4px 4px 0px var(--ink);overflow:hidden;transition:all .2s ease-in-out}
.dining-card:hover{transform:translate(-3px,-3px);box-shadow:7px 7px 0px var(--ink)}
.dining-card.featured{grid-column:1/-1}
.dc-header{padding:26px 26px 0}
.dc-tags{display:flex;gap:6px;margin-bottom:10px}
.dc-name{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--ink);line-height:1.2;margin-bottom:5px}
.dc-location{font-size:.65rem;color:var(--mutedgreen);font-weight:700;letter-spacing:.1em;text-transform:uppercase;margin-bottom:14px;display:flex;align-items:center;gap:8px;font-family:'DM Sans',sans-serif}
.dc-location::before{content:'→';color:var(--orange)}
.dc-divider{height:2px;background:var(--ink);margin:0 26px;opacity:.1}
.dc-body{padding:18px 26px 26px}
.dc-desc{font-size:.82rem;color:var(--mutedgreen);line-height:1.7;margin-bottom:10px}
.dc-pro{font-size:.77rem;color:var(--ocean);font-style:italic;padding-top:10px;border-top:1px solid rgba(15,29,17,.08)}

/* ── BEST TIMES ── */
.timing-list{display:flex;flex-direction:column;gap:6px}
.timing-item{display:grid;grid-template-columns:180px 1fr;background:var(--parchment);border:2px solid var(--ink);box-shadow:4px 4px 0px var(--ink);overflow:hidden;transition:all .2s ease-in-out}
.timing-item:hover{transform:translate(-3px,-3px);box-shadow:7px 7px 0px var(--ink)}
.ti-left{background:var(--cream);padding:22px;border-right:2px solid var(--ink);display:flex;flex-direction:column;justify-content:center}
.ti-place{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:var(--ink);margin-bottom:5px}
.ti-time{font-size:.8rem;font-weight:700;color:var(--orange);letter-spacing:.05em;line-height:1.3;font-family:'DM Sans',sans-serif}
.ti-right{padding:22px 26px}
.ti-desc{font-size:.82rem;color:var(--mutedgreen);line-height:1.7}

/* ── MAP ── */
.map-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(245,235,224,.5);line-height:1.7;margin-bottom:28px;padding-left:16px;border-left:2px solid var(--ochre)}
.map-legend{display:flex;gap:16px;flex-wrap:wrap;margin-bottom:20px}
.legend-item{display:flex;align-items:center;gap:8px;font-size:.7rem;font-weight:700;color:rgba(245,235,224,.6);font-family:'DM Sans',sans-serif}
.legend-dot{width:12px;height:12px;border-radius:50%;flex-shrink:0;border:1.5px solid rgba(245,235,224,.3)}
#explore-map{height:480px;border:2px solid var(--ink);margin-bottom:32px}
.resort-map-section{margin-top:44px}
.resort-map-label{font-size:.58rem;font-weight:700;letter-spacing:.35em;text-transform:uppercase;color:var(--ochre);margin-bottom:10px;font-family:'DM Sans',sans-serif}
.resort-map-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:700;color:var(--parchment);margin-bottom:8px}
.resort-map-note{font-size:.8rem;color:rgba(245,235,224,.45);margin-bottom:16px;line-height:1.6}
#resort-map{height:400px;border:2px solid var(--ink);margin-bottom:20px}
.resort-info-row{display:grid;grid-template-columns:1fr 1fr 1fr;gap:6px;margin-bottom:20px}
.resort-info-card{padding:18px 20px}
.ric-label{font-size:.55rem;font-weight:700;letter-spacing:.3em;text-transform:uppercase;color:var(--mutedgreen);margin-bottom:6px;font-family:'DM Sans',sans-serif}
.ric-value{font-size:.82rem;color:var(--ink);line-height:1.5}
.ric-value a{color:var(--ocean);text-decoration:none;border-bottom:1px solid rgba(39,93,116,.3)}
.resort-links-row{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:32px}
.resort-link-btn{display:inline-flex;align-items:center;gap:8px;padding:11px 18px;font-size:.68rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;cursor:pointer;border:2px solid var(--ink);transition:all .15s;font-family:'DM Sans',sans-serif}
.rlb-primary{background:var(--orange);color:var(--parchment);box-shadow:3px 3px 0 var(--ink)}
.rlb-primary:hover{background:var(--ink);color:var(--parchment);transform:translate(-2px,-2px);box-shadow:5px 5px 0 var(--ink)}
.rlb-secondary{background:var(--parchment);color:var(--ink);box-shadow:3px 3px 0 var(--ink)}
.rlb-secondary:hover{background:var(--cream);transform:translate(-2px,-2px);box-shadow:5px 5px 0 var(--ink)}
.pdf-embed-wrap{border:2px solid var(--ink);overflow:hidden}
.pdf-embed-wrap iframe{width:100%;height:580px;border:none;display:block}
.map-popup-name{font-family:'Playfair Display',serif;font-size:.95rem;font-weight:700;color:var(--ink);margin-bottom:4px}
.map-popup-cat{font-size:.62rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;margin-bottom:5px}
.map-popup-desc{font-size:.77rem;color:var(--mutedgreen);line-height:1.5}

/* ═══ PACKING — Vintage Stamp Checkboxes ═══ */
.progress-bar-wrap{background:var(--cream);height:4px;margin-bottom:32px;overflow:hidden;border:1px solid rgba(15,29,17,.1)}
.progress-bar{height:100%;background:var(--orange);transition:width .4s ease;width:0%}
.cl-group{margin-bottom:28px}
.cl-group-label{font-size:.58rem;font-weight:700;letter-spacing:.35em;text-transform:uppercase;color:rgba(245,235,224,.4);margin-bottom:8px;padding-bottom:8px;border-bottom:1px solid rgba(245,235,224,.1);font-family:'DM Sans',sans-serif}
.cl-item{display:flex;align-items:center;gap:16px;padding:13px 8px;border-bottom:1px solid rgba(245,235,224,.06);cursor:pointer;transition:all .15s;user-select:none}
.cl-item:last-child{border-bottom:none}
.cl-item:hover{background:rgba(245,235,224,.04);border-radius:0}
.cl-item:hover .cl-box{border-color:var(--orange)}
.cl-box{width:22px;height:22px;flex-shrink:0;border:2px solid rgba(245,235,224,.25);border-radius:50%;display:flex;align-items:center;justify-content:center;transition:all .2s;font-size:.7rem;color:transparent;background:transparent}
.cl-item.done .cl-box{background:var(--orange);border-color:var(--orange);color:var(--parchment);box-shadow:0 0 0 2px rgba(224,106,27,.2)}
.cl-text{font-size:.88rem;color:rgba(245,235,224,.8);flex:1;line-height:1.4}
.cl-item.done .cl-text{color:rgba(245,235,224,.3);text-decoration:line-through;text-decoration-color:var(--orange);text-decoration-thickness:2px}
.cl-badge{font-size:.58rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;padding:3px 10px;flex-shrink:0;font-family:'DM Sans',sans-serif}
.pack-recs{margin-top:48px}
.pack-recs-title{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:700;color:var(--parchment);margin-bottom:8px}
.pack-recs-sub{font-size:.82rem;color:rgba(245,235,224,.45);margin-bottom:32px;line-height:1.6}
.rec-category{margin-bottom:36px}
.rec-cat-label{font-size:.58rem;font-weight:700;letter-spacing:.35em;text-transform:uppercase;color:var(--ochre);margin-bottom:16px;padding-bottom:10px;border-bottom:1px solid rgba(245,235,224,.1);font-family:'DM Sans',sans-serif}
.rec-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px}
.rec-card{padding:22px 24px}
.rec-card.full{grid-column:1/-1}
.rc-essential{display:inline-block;font-size:.56rem;font-weight:700;letter-spacing:.15em;text-transform:uppercase;color:var(--parchment);background:var(--orange);border:1.5px solid var(--ink);padding:3px 10px;margin-bottom:8px;font-family:'DM Sans',sans-serif}
.rc-name{font-family:'Playfair Display',serif;font-size:1.05rem;font-weight:700;color:var(--ink);margin-bottom:6px}
.rc-why{font-size:.8rem;color:var(--mutedgreen);line-height:1.65;margin-bottom:8px}
.rc-tip{font-size:.75rem;color:var(--ocean);font-style:italic}

/* ── INFO ── */
.info-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px}
.info-card{padding:26px}
.info-card.full{grid-column:1/-1}
.info-card.emergency{background:var(--forest);border-color:var(--ink);color:var(--parchment)}
.ic-label{font-size:.56rem;font-weight:700;letter-spacing:.35em;text-transform:uppercase;color:var(--mutedgreen);margin-bottom:10px;font-family:'DM Sans',sans-serif}
.info-card.emergency .ic-label{color:rgba(245,235,224,.3)}
.ic-value{font-size:.88rem;color:var(--ink);line-height:1.7}
.info-card.emergency .ic-value{color:rgba(245,235,224,.7)}
.ic-value a{color:var(--ocean);text-decoration:none;border-bottom:1px solid rgba(39,93,116,.3)}
.emergency-num{font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:700;color:var(--orange);margin-top:8px;letter-spacing:.03em}
.emergency-label{font-size:.62rem;color:rgba(245,235,224,.3);font-weight:700;letter-spacing:.1em;text-transform:uppercase;margin-top:4px;font-family:'DM Sans',sans-serif}

/* ── FACTS ── */
.fact-feature{background:var(--forest);padding:48px 44px;position:relative;overflow:hidden;margin-bottom:6px;border:2px solid var(--ink);box-shadow:4px 4px 0 var(--ink)}
.fact-feature::before{content:'"';font-family:'Playfair Display',serif;font-size:18rem;color:rgba(245,235,224,.04);position:absolute;top:-40px;left:20px;line-height:1}
.fact-nav{display:flex;gap:4px;margin-bottom:28px}
.fact-nav-btn{padding:7px 14px;font-size:.6rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;background:transparent;border:1.5px solid rgba(245,235,224,.15);color:rgba(245,235,224,.35);cursor:pointer;transition:all .15s;font-family:'DM Sans',sans-serif}
.fact-nav-btn.active,.fact-nav-btn:hover{background:var(--orange);border-color:var(--orange);color:var(--parchment)}
.fact-text{font-family:'Cormorant',serif;font-style:italic;font-size:clamp(1.2rem,3vw,1.75rem);font-weight:300;color:var(--parchment);line-height:1.65;max-width:640px;transition:opacity .4s ease,transform .4s ease;position:relative;z-index:2}
.fact-attr{margin-top:22px;font-size:.6rem;font-weight:700;letter-spacing:.3em;text-transform:uppercase;color:rgba(245,235,224,.2);position:relative;z-index:2;font-family:'DM Sans',sans-serif}

/* ── ROADMAP ── */
.roadmap-intro{font-family:'Cormorant',serif;font-style:italic;font-size:1.1rem;font-weight:300;color:rgba(245,235,224,.5);line-height:1.7;margin-bottom:40px;padding-left:16px;border-left:2px solid var(--ochre)}
.roadmap-list{display:flex;flex-direction:column;gap:6px}
.roadmap-item{display:grid;grid-template-columns:160px 1fr;background:var(--parchment);border:2px solid var(--ink);box-shadow:4px 4px 0px var(--ink);overflow:hidden;transition:all .2s ease-in-out;break-inside:avoid}
.roadmap-item:hover{transform:translate(-3px,-3px);box-shadow:7px 7px 0px var(--ink)}
.roadmap-item.active-phase{border-color:var(--orange);box-shadow:4px 4px 0 var(--orange)}
.roadmap-item.completed{opacity:.45}
.ri-left{padding:22px;display:flex;flex-direction:column;justify-content:center;border-right:2px solid var(--ink);background:var(--cream)}
.ri-left.active-bg{background:rgba(224,106,27,.08)}
.ri-date{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:var(--orange);line-height:1.1;margin-bottom:4px}
.ri-days{font-size:.62rem;font-weight:700;color:var(--mutedgreen);letter-spacing:.08em;font-family:'DM Sans',sans-serif}
.ri-status{display:inline-block;margin-top:8px;font-size:.52rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;padding:3px 8px;font-family:'DM Sans',sans-serif}
.status-now{background:var(--orange);color:var(--parchment)}
.status-upcoming{background:var(--ocean);color:var(--parchment)}
.status-done{background:rgba(15,29,17,.08);color:var(--mutedgreen)}
.ri-right{padding:22px 26px}
.ri-phase{font-size:.56rem;font-weight:700;letter-spacing:.3em;text-transform:uppercase;color:var(--orange);margin-bottom:5px;font-family:'DM Sans',sans-serif}
.ri-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:var(--ink);margin-bottom:7px;line-height:1.2}
.ri-desc{font-size:.8rem;color:var(--mutedgreen);line-height:1.65;margin-bottom:10px}
.ri-updates{display:flex;flex-direction:column;gap:4px}
.ri-update{display:flex;align-items:flex-start;gap:10px;font-size:.76rem;color:var(--ink);line-height:1.5}
.ri-update-icon{color:var(--orange);flex-shrink:0;margin-top:1px}
.roadmap-now-banner{background:var(--orange);color:var(--parchment);padding:20px 28px;margin-bottom:6px;display:flex;align-items:center;gap:16px;border:2px solid var(--ink);box-shadow:4px 4px 0 var(--ink)}
.rnb-icon{font-size:1.6rem;flex-shrink:0}
.rnb-title{font-family:'Playfair Display',serif;font-size:1.15rem;font-weight:700;margin-bottom:4px}
.rnb-desc{font-size:.8rem;opacity:.85;line-height:1.5}

/* ── REVEAL ── */
.reveal{opacity:0;transform:translateY(16px);transition:opacity .6s ease,transform .6s ease}
.reveal.in{opacity:1;transform:none}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
@keyframes fadeIn{from{opacity:0}to{opacity:1}}

/* ── LEAFLET ── */
.leaflet-popup-content-wrapper{border-radius:0;border:2px solid var(--ink);box-shadow:3px 3px 0 var(--ink)}
.leaflet-popup-content{margin:14px 16px;min-width:180px}

/* ── PRINT ── */
@media print{@page{size:auto;margin:10mm}body{background:#fff!important}.tab-nav-wrap{display:none}.panel{display:block!important}.reveal{opacity:1!important;transform:none!important}}

/* ── MOBILE ── */
@media(max-width:640px){
  .cover-nav{padding:18px 22px}.cover-body{padding:0 22px}
  .cd-label-block{display:none}
  .cover-meta{flex-wrap:wrap}.cmi{min-width:50%}
  .stats-row{grid-template-columns:1fr 1fr}
  .perks-grid{grid-template-columns:1fr}
  .dining-grid{grid-template-columns:1fr}.dining-card.featured{grid-column:1}
  .timing-item{grid-template-columns:1fr}.ti-left{border-right:none;border-bottom:2px solid var(--ink)}
  .info-grid{grid-template-columns:1fr}.info-card.full{grid-column:1}
  .activity-item{grid-template-columns:56px 1fr}
  .butler-card{grid-template-columns:1fr}
  .resort-info-row{grid-template-columns:1fr}
  .rec-grid{grid-template-columns:1fr}.rec-card.full{grid-column:1}
  .roadmap-item{grid-template-columns:1fr}
  .ri-left{border-right:none;border-bottom:2px solid var(--ink)}
  .panel{padding:36px 20px 0}
  #explore-map{height:300px}#resort-map{height:260px}
  .tab-nav-chevron{width:28px}
}
'@

$newHtml = $before + $newStyle + "`n</style>" + $after
[System.IO.File]::WriteAllText($file, $newHtml, (New-Object System.Text.UTF8Encoding $false))

Write-Host ""
Write-Host "WPA Vintage Poster redesign applied!" -ForegroundColor Green
Write-Host "  $($html.Length) -> $($newHtml.Length) bytes" -ForegroundColor Gray
Write-Host ""
Write-Host "Features:" -ForegroundColor Cyan
Write-Host "  - Parchment cards with solid offset shadows"
Write-Host "  - Dashed-border vintage airline tickets"
Write-Host "  - Circular stamp checkboxes with ink-bleed strikethrough"
Write-Host "  - Mechanical lift hover (translate + solid shadow)"
Write-Host "  - Volcano silhouette + paper grain overlays"
Write-Host "  - Libre Baskerville body font"
Write-Host ""
Write-Host "Next: git add -A && git commit -m 'WPA vintage poster' && git push" -ForegroundColor Yellow