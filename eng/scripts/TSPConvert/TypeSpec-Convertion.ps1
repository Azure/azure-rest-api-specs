###
# Conventient usage: 
# D:\Azure\azure-rest-api-specs\eng\scripts\TSPConvert\TypeSpec-Convertion.ps1 
#   D:\Azure\azure-rest-api-specs\eng\scripts\TSPConvert\BrownFieldRPs.txt 
#   D:\Azure\azure-rest-api-specs
###

[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string] $ServiceListFilePath,
  [Parameter(Position = 1)]
  [string] $SpecRepoRootDirectory
)

$RPList = @()
$SuccessConvertRPlist = @()
$FailConvertRPlist = @()
$SuccessCompileRPlist = @()
$FailCompileRPlist = @()

if (Test-Path $ServiceListFilePath) {
    Get-Content $ServiceListFilePath | ForEach-Object {
    $RPList += $_
    }
}
else {
    Write-Output "Error: File not found at path $ServiceListFilePath"
    exit 1
}

$count = $RPList.Count
if ($count -eq 0) {
    Write-Output "Error: No service found in the file $ServiceListFilePath"
    exit 1
}

Write-Output "Processing $count RPs"

$RPList | ForEach-Object {
        $serviceFolder = Join-Path $SpecRepoRootDirectory "specification" $_
        Write-Output "Processing service folder: $serviceFolder"

        $upperCaseName = $_.Substring(0,1).ToUpper() + $_.Substring(1) + ".Management"
        $TSPFolderPath = Join-Path $serviceFolder $upperCaseName
        if (Test-Path $TSPFolderPath) {
            Write-Output "TypeSpec convert already exists under $TSPFolderPath"
        }
        else {
            New-Item -Path $TSPFolderPath -ItemType Directory
        }
            Push-Location $TSPFolderPath
            $readmeFilePath = Join-Path $serviceFolder "resource-manager" "readme.md"
            $output = Invoke-Expression "tsp-client convert --swagger-readme $readmeFilePath --arm --fully-compatible" 2>&1 | Out-String
            # Write-Output "Command Output:"
            # Write-Output $output
            if ($LASTEXITCODE) {
                Write-Output "Failed to run convertion tool on $_."
                $FailConvertRPlist += $_
                Remove-Item -Path $TSPFolderPath -Recurse -Force
            }
            else {
                Write-Output "Successfully run convertion tool on $_."
                $SuccessConvertRPlist += $_
                if (Test-Path -Path (Join-Path $TSPFolderPath "client.tsp")){
                    $output = Invoke-Expression "tsp compile client.tsp" 2>&1 | Out-String
                    # Write-Output "Command Output:"
                    # Write-Output $output
                }
                else {
                    $output = Invoke-Expression "tsp compile ." 2>&1 | Out-String
                    # Write-Output "Command Output:"
                    # Write-Output $output
                }
                if ($LASTEXITCODE) {
                    Write-Output "Failed to compile TSP files on $_."
                    $FailCompileRPlist += $_
                }
                else {
                    Write-Output "Successfully complie TSP files on $_."
                    $SuccessCompileRPlist += $_
                }
            }
            Pop-Location
    }

$currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$testResultsFolder = Join-Path $SpecRepoRootDirectory "eng" "scripts" "TSPConvert" $currentDateTime
New-Item -Path $testResultsFolder -ItemType Directory
Push-Location $testResultsFolder
$SuccessConvertRPlistPath = Join-Path $testResultsFolder  "SuccessConvertRPlist.txt"
New-Item -Path $SuccessConvertRPlistPath -ItemType File
$FailConvertRPlist = Join-Path $testResultsFolder  "FailConvertRPlist.txt"
New-Item -Path $FailConvertRPlist -ItemType File
$SuccessCompileRPlist = Join-Path $testResultsFolder  "SuccessCompileRPlist.txt"
New-Item -Path $SuccessCompileRPlist -ItemType File
$FailCompileRPlist = Join-Path $testResultsFolder  "FailCompileRPlist.txt"
New-Item -Path $FailCompileRPlist -ItemType File

$SuccessConvertRPlist | Out-File -FilePath $SuccessConvertRPlistPath
$FailConvertRPlist | Out-File -FilePath $FailConvertRPlist
$SuccessCompileRPlist | Out-File -FilePath $SuccessCompileRPlist
$FailCompileRPlist | Out-File -FilePath $FailCompileRPlist

exit 0