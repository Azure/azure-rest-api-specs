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
        $errorFile = Join-Path $logDirectory "$name-error.txt"
        $outputFile = Join-Path $logDirectory "$name.txt"
        &$expression 2> $errorFile *> $outputFile
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$name completed with success!"
        } else {
            Write-Host "$name completed with error! Exit code: {$LASTEXITCODE}."
            $errorFile = Resolve-Path $errorFile
            $outputFile = Resolve-Path $outputFile
            Write-Host "Check $outputFile"
            Write-Host "Check $errorFile"
        }
        Write-Host ""
    }

    $configFile =  Resolve-Path "../data-plane/readme.md"

    # get new/current tag and previous tag from the Autorest config
    $configContents = Get-Content -Path $configFile
    $tagRegex = '(?<tag>package-(?<version>\d{4}-\d{2}-\d{2}(?<modifier>-preview)?))'    
    $reMatches = ($configContents | Select-String "^tag:\s$tagRegex$").Matches | Select-Object -First 1
    $newTag = $reMatches.Groups["tag"].Value
    $newVersion = $reMatches.Groups["version"].Value
    $reMatches = ($configContents | Select-String "^###\sTag:\s$tagRegex$").Matches
    $previousVersion = ""
    $previousTag = ""
    foreach ($match in $reMatches) {
        $tag = $match.Groups["tag"].Value
        if ($tag -gt $previousTag && $tag -ne $newTag) {
            $previousTag = $tag
            $previousVersion = $match.Groups["version"].Value
        }
    }
    Write-Output ""
    Write-Output "New Tag: $newTag"
    Write-Output "Previous Tag: $previousTag"
    Write-Output ""

    $jsonFile = Resolve-Path "../data-plane/Microsoft.Quantum/preview/$newVersion/quantum.json"
    $jsonFilePrevious = Resolve-Path "../data-plane/Microsoft.Quantum/preview/$previousVersion/quantum.json"

    RunAndCheck "tsp-format" \ {
        tsp format **/*.tsp
    }

    RunAndCheck "tsp-compile" \ {
        tsp compile . --pretty --debug
    }

    RunAndCheck "tsp-compile-api-view" \ {
        tsp compile . --pretty --debug --emit=@azure-tools/typespec-apiview --output-dir (Join-Path $logDirectory "../api-view/")
    }

    # Rename common parameters to match previous Swagger.
    RunAndCheck "replace-param-names" \ {
        $spec = Get-Content -Path $jsonFile
        $spec = $spec -replace '(?:CommonParams\.)([^"]*)','$1Parameter'
        Set-Content $jsonFile $spec
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
}
finally
{
    Pop-Location
}
