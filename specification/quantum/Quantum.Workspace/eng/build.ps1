# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

try {
    Push-Location (Join-Path $PSScriptRoot "../")

    $logDirectory = "./output/logs/"
    New-Item -ItemType Directory -Force -Path $logDirectory *> $null
    $logDirectory = Resolve-Path $logDirectory

    function RunAndCheck {
        param (
            [string] $name,
            [string] $logFolder,
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
    function GetVersions {
        param (
            [string] $configFile
        )
        # get new/current tag from the Autorest config
        $configContents = Get-Content -Path $configFile
        $tagRegex = '(?<tag>package-(?<version>\d{4}-\d{2}-\d{2}(?<modifier>-preview)?))'    
        $reMatches = ($configContents | Select-String "^tag:\s$tagRegex$").Matches | Select-Object -First 1
        $newTag = $reMatches.Groups["tag"].Value
        $newVersion = $reMatches.Groups["version"].Value

        # get all tags from the Autorest config and determine the previous version
        $reMatches = ($configContents | Select-String "^###\sTag:\s$tagRegex$").Matches
        $previousVersion = ""
        $previousTag = ""
        $allVersions = New-Object System.Collections.Generic.List[string]
        foreach ($match in $reMatches) {
            $tag = $match.Groups["tag"].Value
            $version = $match.Groups["version"].Value           
            $allVersions.Add($version)
            if ($tag -gt $previousTag && $tag -ne $newTag) {
                $previousTag = $tag
                $previousVersion = $version
            }
        }
        return [PSCustomObject]@{
            NewTag = $newTag
            NewVersion = $newVersion
            PreviousTag = $previousTag
            PreviousVersion = $previousVersion
            AllVersions = $allVersions
        }
    }

    $configFile =  Resolve-Path "../data-plane/readme.md"
    $versions = GetVersions $configFile
    Write-Host @"
------------------------------------------------------------------------
Azure Quantum TypeSpec build - BEGIN
------------------------------------------------------------------------
Started at
    $(Get-Date -format "yyyy-MM-dd HH:mm:ss")
Compiling TypeSpec and generating Swagger for version
    $($versions.NewVersion)
Comparisons will be made against previous version
    $($versions.PreviousVersion)
Writing output logs to
    $logDirectory
------------------------------------------------------------------------
"@

    $jsonFile = Join-Path (Resolve-Path .) "../data-plane/Microsoft.Quantum/preview/$($versions.NewVersion)/quantum.json"
    $jsonFilePrevious = Join-Path (Resolve-Path .) "../data-plane/Microsoft.Quantum/preview/$($versions.PreviousVersion)/quantum.json"

    # Copy examples from previous version
    # if they don't exist for the new version.
    $target = ".\examples\$($versions.NewVersion)"
    if (-not (Test-Path -Path $target)) {
        $source = ".\examples\$($versions.PreviousVersion)"
        Write-Host @"
Examples not found for $($versions.NewVersion).
Copying examples from $source to $target
"@
        Copy-Item -Path $source -Destination $target -Recurse
        ForEach($file in Get-ChildItem -Path $target -File){
            $example = Get-Content -Path $file
            $example = $example -replace $versions.PreviousVersion, $versions.NewVersion
            Set-Content $file $example                
        }
    }

    RunAndCheck "tsp-format" \ {
        tsp format **/*.tsp
    }

    RunAndCheck "tsp-compile" \ {
        tsp compile . --pretty --debug
    }

    RunAndCheck "tsp-compile-api-view" \ {
        tsp compile . --pretty --debug --emit=@azure-tools/typespec-apiview --output-dir (Join-Path $logDirectory "../api-view/")
    }
        
    # copy to swagger folder to easy upload to https://apiview.dev/
    New-Item -ItemType Directory -Force -Path (Join-Path $PSScriptRoot "../output/swagger/") *> $null
    Copy-Item $jsonFile (Join-Path $PSScriptRoot "../output/swagger/quantum.swagger") -Force -Recurse

    RunAndCheck "swagger-preview" \ {
        $openApi = Get-Content -Path $jsonFile
        $spec = "let spec = $openApi"
        Set-Content ./eng/swagger-ui/spec.js $spec
    }

    # RunAndCheck "generate-examples" \ {
    #     # Ideally we should use the example generation with the custom payloads, but I didn't
    #     # figured out yet what's wrong with the initial payload I created (Jobs_Cancel/204.json)).
    #     # oav generate-examples $jsonFile -l info -p --payloadDir (Join-Path $PSScriptRoot "../example-payloads/")
    #     oav generate-examples $jsonFile -l info -p
    # }

    # Pipeline validations
    # from https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/ci-fix.md

    RunAndCheck "tsp-validate" \ {
        # To run the TypeSpec Validation we need to go
        # to the root of the azure-rest-api-specs repo
        Push-Location (Join-Path $PSScriptRoot "../../../../")
        try
        {
            npx --no tsv .\specification\quantum\Quantum.Workspace\        
        }
        finally
        {
            Pop-Location
        }     
    }   

    RunAndCheck "lint-swagger" \ {
        npx prettier --write $jsonFile
    }

    RunAndCheck "example-validation" \ {
        oav validate-example $jsonFile
    }

    RunAndCheck "semantic-validation" \ {
        oav validate-spec $jsonFile
    }

    RunAndCheck "model-compare" \ {
        oad compare $jsonFilePrevious $jsonFile --logFilepath (Join-Path $logDirectory "/oad-compare-log.json") > (Join-Path $logDirectory "/model-compare.json")
    }

    RunAndCheck "model-compare-viz" \ {
        $modelCompare = Get-Content -Path (Join-Path $logDirectory "/model-compare.json")
        $modelCompare = "let modelCompare = $modelCompare"
        Set-Content ./eng/model-compare/model-compare.js $modelCompare

        $openApi = Get-Content -Path $jsonFile
        $spec = "let newSpec = $openApi"
        Set-Content ./eng/model-compare/new-spec.js $spec

        $openApi = Get-Content -Path $jsonFilePrevious
        $spec = "let oldSpec = $openApi"
        Set-Content ./eng/model-compare/old-spec.js $spec
    }

    RunAndCheck "lint-diff" \ {
        autorest --v3 --spectral --validation --azure-validator --use=@microsoft.azure/openapi-validator@latest --tag=$newTag $configFile
    }

    RunAndCheck "avocado" \ {
        avocado -f (Join-Path $logDirectory "/avocado-log.txt") -d (Join-Path $logDirectory "../data-plane")
    }

    Write-Host @"
------------------------------------------------------------------------
Azure Quantum TypeSpec build - END
------------------------------------------------------------------------
Completed at
    $(Get-Date -format "yyyy-MM-dd HH:mm:ss")
------------------------------------------------------------------------
"@
}
finally
{
    Pop-Location
}
