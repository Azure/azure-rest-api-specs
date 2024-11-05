function RunAndCheck {
    param (
        [string] $name,
        [string] $logDirectory,
        [Scriptblock] $expression
    )
    Write-Host "Running $name..."
    $global:LASTEXITCODE = 0
    $outputFile = Join-Path $logDirectory "$name.txt"
    &$expression *> $outputFile
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$name completed with success!"
    } else {
        Write-Host "$name completed with error! Exit code: {$LASTEXITCODE}."
        $outputFile = Resolve-Path $outputFile
        Write-Host "Check $outputFile"
    }
    Write-Host ""
}
