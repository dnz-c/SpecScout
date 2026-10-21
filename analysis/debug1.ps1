$an = 'A:\MyProgramming\C++\SpecScout\analysis'
$t = Get-Content "$an\t1_hashes.json" -Raw | ConvertFrom-Json
Write-Host "raw: $(@($t).Count)"
$a = $t | Where-Object { $_.Exists -and -not $_.InLOL }
Write-Host "a: $(@($a).Count)"
$b = $a | Where-Object { $_.Driver -notmatch '^dump_' -and $_.Driver -notin @('amdkmdag.sys','igdkmdn64.sys') }
Write-Host "b: $(@($b).Count)"
$c = $t | Where-Object { $_.Exists -and -not $_.InLOL } | Where-Object { $_.Driver -notmatch '^dump_' -and $_.Driver -notin @('amdkmdag.sys','igdkmdn64.sys') }
Write-Host "c chained: $(@($c).Count)"
foreach ($x in $c) { Write-Host "item: $($x.Driver)" }
