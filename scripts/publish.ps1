param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Name
)

$modulePath = "modules/$Name"

if (-not (Test-Path $modulePath)) {
    Write-Error "Module '$Name' not found in modules/"
    Write-Host "Available modules:"
    Get-ChildItem -Directory modules/ | ForEach-Object { Write-Host "  - $($_.Name)" }
    exit 1
}

Push-Location $modulePath
try {
    wally publish
} finally {
    Pop-Location
}
