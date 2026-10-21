$ErrorActionPreference = 'Continue'
Write-Host "script started"
$root   = 'A:\MyProgramming\C++\SpecScout'
$an     = "$root\analysis"
$spec   = "$root\build\Release\specscout.exe"
$kuna   = 'kuna'
$_t = Get-Content "$an\t1_hashes.json" -Raw | ConvertFrom-Json
Write-Host "dbg raw: $(@($_t).Count)"
Write-Host "dbg step1: $(@($_t | Where-Object { $_.Exists -and -not $_.InLOL }).Count)"
Write-Host "dbg step2: $(@($_t | Where-Object { $_.Driver -notmatch '^dump_' }).Count)"
Write-Host "dbg step3: $(@($_t | Where-Object { $_.Driver -notin @('amdkmdag.sys','igdkmdn64.sys') }).Count)"
$_t | Select-Object -First 1 | ConvertTo-Json | Write-Host
$targets = Get-Content "$an\t1_hashes.json" -Raw | ConvertFrom-Json
$targets = @($targets) | Where-Object { $_.Exists -and -not $_.InLOL }
$targets = @($targets) | Where-Object { $_.Driver -notmatch '^dump_' -and $_.Driver -notin @('amdkmdag.sys','igdkmdn64.sys') }
Write-Host "targets in script: $(@($targets).Count)"

$blockRe = [regex]'(?s)// Function: (\S+) @ 0x([0-9a-f]+)\r?\n(.*?)(?=\r?\n// Function: |\z)'
$storeRe = [regex]'\+ 0x([0-9a-fA-F]+)\) = (\w+)\s*;'

function Find-Handlers([string]$cFile) {
    $text = [IO.File]::ReadAllText($cFile)
    $found = New-Object System.Collections.Generic.List[object]
    foreach ($m in $blockRe.Matches($text)) {
        $disps  = New-Object System.Collections.Generic.List[object]
        foreach ($s in $storeRe.Matches($m.Groups[3].Value)) {
            $disp = [Convert]::ToInt32($s.Groups[1].Value, 16)
            if ($disp -ge 0x60 -and $disp -le 0x158) {
                $disps += [pscustomobject]@{ disp = ('0x{0:x}' -f $disp); target = $s.Groups[2].Value }
            }
        }
        if ($disps.Count -ge 2) {
            $h = $disps | Where-Object { $_.disp -eq '0xe0' }
            $found.Add([pscustomobject]@{
                entryFunc   = $m.Groups[1].Value
                entryVA     = '0x' + $m.Groups[2].Value
                ioctlHandler = if ($h) { $h[0].target } else { '' }
                stores      = (($disps | ForEach-Object { "$($_.disp)=$($_.target)" }) -join ',')
            })
        }
    }
    return $found
}

$report = foreach ($t in $targets) {
    $name  = $t.Driver
    $kdir  = "$an\kuna\$name"
    $r = [ordered]@{ driver=$name; path=$t.Path; kuna_ok=$false; device=''; entry=''; handler=''; disps=''; specscout_count=$null; specscout_hits=@(); note='' }

    if (Test-Path $kdir) { Remove-Item $kdir -Recurse -Force }
    $out = & $kuna decompile-project $t.Path -o $kdir --jobs auto --max-fn-seconds 120 2>&1
    if (-not (Test-Path "$kdir\$name.c")) { $r.note = ('kuna fail: ' + (($out | Select-Object -Last 2) -join ' | ')); [pscustomobject]$r; continue }
    $r.kuna_ok = $true

    $handlers = Find-Handlers "$kdir\$name.c"
    if ($handlers.Count -eq 0) {
        $r.note = 'no DriverEntry MajorFunction stores found'
    } else {
        $r.entry = ($handlers | ForEach-Object { $_.entryFunc }) -join ','
        # prefer block with explicit 0xE0 store; else the block with most stores
        $pick = $handlers | Where-Object { $_.ioctlHandler } | Select-Object -First 1
        if (-not $pick) { $pick = $handlers | Sort-Object { -($_.stores -split ',').Count } | Select-Object -First 1 }
        $r.handler = if ($pick.ioctlHandler) { $pick.ioctlHandler } else { '' }
        $r.disps   = ($pick.stores)
    }

    # device names from strings
    $sout = & $kuna strings $t.Path --encoding all --filter '(?i)\\(device|dosdevices|\?\?)\\' --json 2>$null
    try { $sjson = $sout | ConvertFrom-Json; $r.device = (($sjson.strings | ForEach-Object { $_.text }) -join ' ; ') } catch {}

    # specscout: named handler when found, else auto-discovery
    $jout = "$an\specscout\$name.json"
    New-Item -ItemType Directory -Force -Path "$an\specscout" | Out-Null
    if ($r.handler -match '^sub_([0-9a-f]+)$') {
        $sres = & $spec $t.Path --driver --function ("0x" + $matches[1]) --json $jout 2>&1
    } else {
        $sres = & $spec $t.Path --driver --json $jout 2>&1
    }
    if (Test-Path $jout) {
        try {
            $j = Get-Content $jout -Raw | ConvertFrom-Json
            $finds = $j.findings
            $r.specscout_count = @($finds).Count
            $r.specscout_hits  = @($finds | ForEach-Object { "{0} guard={1} sink={2} fn={3}" -f $_.kind, $_.guard, $_.sink, $_.function })
        } catch { $r.note += ' specscout-json parse fail' }
    } else { $r.note += ' specscout fail: ' + (($sres | Select-Object -Last 2) -join ' | ') }

    [pscustomobject]$r
}

$report | ConvertTo-Json -Depth 4 | Set-Content "$an\sweep_results.json" -Encoding utf8
$lines = $report | ForEach-Object {
    "=== $($_.driver) ==="
    if ($_.handler)      { "  ioctl handler : $($_.handler)" }
    if ($_.device)       { "  devices       : $($_.device)" }
    if ($_.note)         { "  note          : $($_.note)" }
    if ($_.specscout_count -gt 0) { "  SPECSCOUT: $($_.specscout_count) residual gadget(s)" }
    elseif ($_.specscout_count -eq 0) { "  specscout: clean" }
    $_.specscout_hits | ForEach-Object { "    $_" }
}
$lines | Out-File "$an\sweep_report.txt" -Encoding utf8
Write-Host "done: $($report.Count) drivers"
