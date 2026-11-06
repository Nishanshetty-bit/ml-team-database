param(
    [string]$SourceHost = "localhost",
    [int]$SourcePort = 5432,
    [string]$SourceDatabase = "team_database",
    [string]$SourceUser = "postgres"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$outFile = Join-Path $repoRoot "init\01_database.sql"

if (-not (Get-Command pg_dump -ErrorAction SilentlyContinue)) {
    throw "pg_dump was not found. Install PostgreSQL command-line tools or add its bin folder to PATH."
}

Write-Host "Exporting '$SourceDatabase' from $SourceHost`:$SourcePort ..."
$env:PGPASSWORD = Read-Host "Enter source PostgreSQL password"
try {
    & pg_dump --host=$SourceHost --port=$SourcePort --username=$SourceUser `
        --dbname=$SourceDatabase --no-owner --no-privileges --format=plain `
        --file=$outFile
    if ($LASTEXITCODE -ne 0) { throw "pg_dump failed with exit code $LASTEXITCODE" }
}
finally {
    Remove-Item Env:PGPASSWORD -ErrorAction SilentlyContinue
}

Write-Host "Export complete: $outFile"
Write-Host "Review the SQL dump, then commit init/01_database.sql to the private team repository."
