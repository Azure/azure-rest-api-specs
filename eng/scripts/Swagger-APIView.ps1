. "$PSScriptRoot/ChangedFiles-Functions.ps1"

# Get Changed Swagger Files
$changedFiles = Get-ChangedFiles -baseCommitish "d69e0e4005427ac68c21618afe1e856790b956b3" -targetCommitish "e6094e6653921fca7b0b61fbc3e6e7c351e58093"
$changedSwaggerFiles = Get-ChangedSwaggerFiles -changedFiles $changedFiles

$changedSwaggerFiles | ForEach-Object { Write-Output $_ }

# Get Tags from Changed Swagger files