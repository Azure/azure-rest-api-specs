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
  [string] $SpecRepoRootDirectory,
  [Parameter(Position = 2)]
  [bool] $NeedConvert = $true
)

$RPList = @()
$SuccessConvertRPlist = @()
$FailConvertRPlist = @()
$SuccessCompileRPlist = @()
$FailCompileRPlist = @()
$MultiVersionlist = @()
$IllegalRPList = @()

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

            # Tag analyze
            $configContent = Get-Content -Path $readmeFilePath -Raw
            $tagPattern = 'tag:\s*([^\r\n]+)'
            $matchesResult = [regex]::Matches($configContent, $tagPattern)
            $defaultTag = $matchesResult[0].Groups[1].Value.Trim()
            $inputPattern = "yaml \$\(tag\) == '$defaultTag'\s*input-file:\s*([^``]+)``````"
            $matchesResult = [regex]::Matches($configContent, $inputPattern)
            $tagContent = $matchesResult[0].Groups[1].Value
            $apiPattern = "/(stable|preview)/([a-z0-9-]+)/(.*).json"
            $matchesResult = [regex]::Matches($tagContent, $apiPattern)
            $inputFiles = @()
            $stableFlag = $false
            $previewFlag = $false
            foreach ($match in $matchesResult) {
                if ($match.value.Contains("stable")) {
                    $stableFlag = $true
                }elseif ($match.value.Contains("preview")) {
                    $previewFlag = $true
                }
                $inputFiles += $match
            }
            if ($stableFlag -and $previewFlag) {
                Write-Output "Both stable and preview versions found in $readmeFilePath"
                $MultiVersionlist += $_
            }
            else {
                $versionPattern = "\d{4}-\d{2}-\d{2}"
                $versions = @()
                foreach ($file in $inputFiles) {
                    $matchesResult = [regex]::Matches($file, $versionPattern)
                    if ($matchesResult[0].Value -notin $versions) {
                        $versions += $matchesResult[0].Value
                    }
                }
                if ($versions.Count -gt 1) {
                    $MultiVersionlist += $_
                }
            }

            if ($NeedConvert){
                $output = Invoke-Expression "tsp-client convert --swagger-readme $readmeFilePath --arm --fully-compatible" 2>&1 | Out-String
                if ($output.Contains("Resource schema not the same as defined in common-type")){
                    $IllegalRPList += $_
                    Write-Output "Illegal RP: $_"
                }
                # Write-Output "Command Output:"
                # Write-Output $output
            if ($LASTEXITCODE) {
                Write-Output "Failed to run convertion tool on $_."
                $FailConvertRPlist += $_
                Pop-Location
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
            
    }

$currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$testResultsFolder = Join-Path $SpecRepoRootDirectory "eng" "scripts" "TSPConvert" $currentDateTime
New-Item -Path $testResultsFolder -ItemType Directory
Push-Location $testResultsFolder
$SuccessConvertRPlistPath = Join-Path $testResultsFolder  "SuccessConvertRPlist.txt"
New-Item -Path $SuccessConvertRPlistPath -ItemType File
$FailConvertRPlistPath = Join-Path $testResultsFolder  "FailConvertRPlist.txt"
New-Item -Path $FailConvertRPlistPath -ItemType File
$SuccessCompileRPlistPath = Join-Path $testResultsFolder  "SuccessCompileRPlist.txt"
New-Item -Path $SuccessCompileRPlistPath -ItemType File
$FailCompileRPlistPath = Join-Path $testResultsFolder  "FailCompileRPlist.txt"
New-Item -Path $FailCompileRPlistPath -ItemType File
$MultiVersionlistPath = Join-Path $testResultsFolder  "MultiVersionlist.txt"
New-Item -Path $MultiVersionlistPath -ItemType File
$IllegalRPListPath = Join-Path $testResultsFolder  "IllegalRPList.txt"
New-Item -Path $IllegalRPListPath -ItemType File

$SuccessConvertRPlist | Out-File -FilePath $SuccessConvertRPlistPath
$FailConvertRPlist | Out-File -FilePath $FailConvertRPlistPath
$SuccessCompileRPlist | Out-File -FilePath $SuccessCompileRPlistPath
$FailCompileRPlist | Out-File -FilePath $FailCompileRPlistPath
$MultiVersionlist | Out-File -FilePath $MultiVersionlistPath
$IllegalRPList | Out-File -FilePath $IllegalRPListPath

Pop-Location

exit 0