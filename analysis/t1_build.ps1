$ErrorActionPreference = 'Stop'
$root = 'A:\MyProgramming\C++\SpecScout'
$lines = Get-Content "$root\build\Release\driver_list.txt"

$drivers = New-Object System.Collections.Generic.List[object]
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^\d+\.$') {
        $d = @{ Driver=''; Path=''; Company=''; Description=''; Version='' }
        for ($j = $i + 1; $j -lt $lines.Count; $j++) {
            if ($lines[$j] -match '^\d+\.$') { break }
            if ($lines[$j] -match '^(Driver|Base|Size|Path|Description|Company|Version):\s*(.*)$') {
                $d[$matches[1]] = $matches[2].Trim()
            }
        }
        $drivers.Add([pscustomobject]$d)
    }
}

$third = $drivers | Where-Object { $_.Company -notmatch 'Microsoft' } |
    Sort-Object Driver -Unique

$lol = Get-Content "$root\analysis\loldrivers_search.json" -Raw
$knownHashes = [array]([regex]::Matches($lol, '[0-9a-f]{64}') | ForEach-Object { $_.Value } | Sort-Object -Unique)

$results = foreach ($d in $third) {
    $p = $d.Path
    $exists = Test-Path $p
    $sha = $null
    if ($exists) { $sha = (Get-FileHash $p -Algorithm SHA256).Hash.ToLowerInvariant() }
    $known = ($sha -and ($knownHashes -contains $sha))
    [pscustomobject]@{
        Driver   = $d.Driver
        Path     = $p
        Exists   = $exists
        SHA256   = $sha
        InLOL    = $known
        Company  = $d.Company
        SizeMB   = if ($exists) { [math]::Round((Get-Item $p).Length / 1MB, 2) } else { $null }
    }
}

$results | ConvertTo-Json -Depth 3 | Set-Content "$root\analysis\t1_hashes.json" -Encoding utf8
Write-Host ("third-party drivers: " + $results.Count)
Write-Host ("missing on disk: " + (($results | Where-Object { -not $_.Exists }).Count))
Write-Host ("known-vulnerable (LOLDrivers, excluded):")
$results | Where-Object InLOL | ForEach-Object { Write-Host ("  " + $_.Driver + "  " + $_.SHA256) }
Write-Host ("targets remaining:")
$results | Where-Object { -not $_.InLOL } | ForEach-Object { Write-Host ("  " + $_.Driver + "  " + $_.SizeMB + " MB") }
