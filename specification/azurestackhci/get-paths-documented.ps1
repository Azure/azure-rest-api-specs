$paths = @(
    "C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\preview",
    "C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\stable"
)

$outputFile = "all-paths-unmoved.txt"

# Clear the file if it already exists
if (Test-Path $outputFile) {
    Clear-Content -Path $outputFile
}

foreach ($path in $paths) {
    Get-ChildItem -Path $path -Recurse -File | ForEach-Object {
        $_.FullName | Out-File -FilePath $outputFile -Append
    }
}
