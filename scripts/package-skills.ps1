# package-skills.ps1
# Rebuilds dist/<skill>.zip from each folder under skills/.
# Each ZIP contains the skill folder with SKILL.md inside (folder at the ZIP root),
# which is the structure claude.ai requires for a custom-skill upload.
# Entry names use forward slashes ("/") per the ZIP spec, so the folder is
# recognized correctly across platforms (Compress-Archive can emit backslashes).

$ErrorActionPreference = "Stop"
$root      = Split-Path -Parent $PSScriptRoot
$skillsDir = Join-Path $root "skills"
$distDir   = Join-Path $root "dist"

New-Item -ItemType Directory -Force -Path $distDir | Out-Null
Add-Type -AssemblyName System.IO.Compression | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null

Get-ChildItem -Path $skillsDir -Directory | ForEach-Object {
  $skill = $_
  if (-not (Test-Path (Join-Path $skill.FullName "SKILL.md"))) {
    Write-Warning ("skip " + $skill.Name + " (no SKILL.md)"); return
  }
  $zipPath = Join-Path $distDir ($skill.Name + ".zip")
  if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

  $fs  = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
  $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
  try {
    Get-ChildItem -Path $skill.FullName -Recurse -File | ForEach-Object {
      $rel = $_.FullName.Substring($skill.FullName.Length).TrimStart('\','/').Replace('\','/')
      $entryName = $skill.Name + '/' + $rel
      $entry = $zip.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
      $es = $entry.Open()
      $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
      $es.Write($bytes, 0, $bytes.Length)
      $es.Dispose()
    }
  } finally {
    $zip.Dispose(); $fs.Dispose()
  }
  Write-Output ("packaged " + $skill.Name + " -> dist/" + $skill.Name + ".zip")
}
