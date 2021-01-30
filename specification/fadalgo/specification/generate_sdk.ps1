param ([switch]$ps = $false, $version = "2021-01-01-alpha", [switch]$validate = $false)

$tag = "v$version"
$nsversion = $tag.Replace("-","_")

if ($ps) {
    autorest devtestcenter/resource-manager/Microsoft.DevTestCenter/readme.md `
        --tag=$tag `
        --nsversion=$nsversion `
        --powershell

    # Remove-Item -Force "..\PowerShell\$tag\.gitignore"
} else {
    autorest devtestcenter/resource-manager/Microsoft.DevTestCenter/readme.md `
        --tag=$tag `
        --nsversion=$nsversion `
        --verbose `
        --csharp `
        --csharp-sdks-folder=../CSharp/ `
        --azure-validator=$validate
}
