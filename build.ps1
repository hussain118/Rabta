# Rebuilds index.html from the fragment files.
# Uses explicit UTF8 (no BOM) reads/writes throughout -- Windows PowerShell 5.1's
# Get-Content/Set-Content default to the system codepage without -Encoding, which
# corrupts UTF-8 multibyte characters (Urdu text, rupee sign, middle dots, etc).

$root = "D:\RABTA"
$out = Join-Path $root "index.html"

$parts = @(
  "head1.txt",
  "style.txt",
  "head2.txt",
  "screens1.txt",
  "screens2.txt",
  "screens3.txt",
  "screens4.txt",
  "tail1.txt",
  "script.txt",
  "tail2.txt"
)

$sb = New-Object System.Text.StringBuilder
foreach ($p in $parts) {
  $full = Join-Path $root $p
  $sb.Append([System.IO.File]::ReadAllText($full, [System.Text.Encoding]::UTF8)) | Out-Null
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($out, $sb.ToString(), $utf8NoBom)

Write-Host "Done! File size:" (Get-Item $out).Length
