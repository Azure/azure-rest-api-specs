# SDK Automation Customization

This is the specification of the new SDK Automation customization configuration.
Old customization that hardcoded in sdk automation will still work but this new
approach is preferred.

## SDK Automation workflow

### Opened PR Validation Trigger

SDK Automation is launched with matrix in azure pipeline. For each language configured:

1. Get the PR merge commit and clone the spec repo on the merge commit.

2. Get the PR changed file list. For each changed file, find the nearest readme.md in parent folder. Get list of related readme.md.

3. Filter the list of readme.md with: find the `swagger-to-sdk` section in the readme.md, and see if the specified language is configured for that readme.md. Example of `swagger-to-sdk` in SDK Automation:
```
```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
``` <EOL>
```
If the configured language is not found here, generation for this readme.md will be skipped.

4. Get `specificationRepositoryConfiguration.json` from spec repo default branch. See [SpecRepoConfig](#specrepoconfig). Get the repo and branch config in the file.

5. Clone __mainRepository__ and checkout __mainBranch__. If __secondaryRepository__ is specified then checkout __secondaryRepository__ and __secondaryBranch__ instead.

6. Get `swagger_to_sdk_config.json` from cloned SDK repository. The config file path could be customized by __configFilePath__ in spec config. For the definition of the config see [SwaggerToSdkConfig](#swaggertosdkconfig).

7. Launch __initScript__ defined in [SwaggerToSdkConfig](#swaggertosdkconfig). All the script's working directory is root folder of cloned SDK repository.

8. Calculate __PR diff__ and related `readme.md`. If __generationCallMode__ is __one-for-all-configs__ then run ___one pass for the rest steps___, else (__one-per-config__) ___loop the rest steps___ with each `readme.md`.

9. Launch __generateScript__ defined in [SwaggerToSdkConfig](#swaggertosdkconfig) with [generateInput.json](#generateinput). The script should produce [generateOutput.json](#generateoutput) if __parseGenerateOutput__ is true. If dryRun is set to true then first run of __generateScript__ will be used to collect package information , then loop each package info and checkout package related branch and launch __generateScript__ with package related readmeMd and dryRun set to false.

10. Get generated package. If __packageFolderFromFileSearch__ is defined with file search then package folder is detected based on git diff in SDK repository and algorithm described in [SwaggerToSdkConfig Schema](#swaggertosdkconfig-schema). Else package folder is from [generateOutput.json](#generateoutput). For each package ___loop the rest steps___.

11. Launch __buildScript__ to build the package. Collect the artifacts by config __artifactPathFromFileSearch__. This step could be skipped if it's not defined in [SwaggerToSdkConfig](#swaggertosdkconfig) and it's covered by __generateScript__ and the result could be found in [generateOutput.json](#generateoutput).

12. Upload all the package related artifacts to Azure Storage Blob Container. All the artifact for one package is uploaded in one folder. These file could be downloaded on URL prefixed by __downloadUrlPrefix__ defined in [InstallInstructionScriptInput](#installinstructionscriptinput). It's redirected by openapiHub by design, and for SDK Automation on public repo the redirect don't need auth, but for SDK Automation in private repo it requires microsoft AAD auth. User could authenticate and download via web page oauth in browser or bearer token auth with `az rest --resource` in command line.

13. Launch __changelogScript__ to get changelog and detect breaking change. This step could be skipped if changelog and breaking change could be found in [generateOutput.json](#generateoutput). If breaking change is found, the spec PR will be labelled with `CI-BreakingChange-<Lang>`.

14. Launch __installInstructionScript__ to get install instruction for that package. This step could be skipped if install instruction could be found in [generateOutput.json](#generateoutput). The lite install instruction will be shown in spec PR comment, the full install instruction will be shown in generated SDK PR.

15. Commit the package related code in SDK repository. Force push to [GenerationBranch](#generationbranch) in __integrationRepository__. Create or update [GenerationPR](#generationpr) from [GenerationBranch](#generationbranch) to [MainBranch](#mainbranch) in __integrationRepository__. If __integrationRepository__ is a fork of __mainRepository__, its [MainBranch](#mainbranch) should be synced once a day.

### Continuous Integration (PR Merged) Trigger

Almost the same as opened PR trigger, with different on step 15:

15. Commit the package related code in SDK repository. Close [GenerationPR](#generationpr) and delete [GenerationBranch](#generationbranch). Force push to [IntegrationBranch](#integrationbranch) in __integrationRepository__. Create or update [IntegrationPR](#integrationpr) from [IntegrationBranch](#integrationbranch) to [MainBranch](#mainbranch) in __mainRepository__. Close the [integrationPR](#integrationPR) if __closeIntegrationPR__ in [SwaggerToSdkConfig](#swaggertosdkconfig) is set to true.


## Definitions

### SpecRepoConfig
This is type of file `./specificationRepositoryConfiguration.json` in swagger spec repo.

#### SpecRepoConfig Example
```json 
{
  "sdkRepositoryMappings": {
    "azure-sdk-for-js": {
      "integrationRepository": "AzureSDKAutomation/azure-sdk-for-js",
      "mainRepository": "Azure/azure-sdk-for-js"
    },
    "azure-sdk-for-python": {
      "integrationRepository": "AzureSDKAutomation/azure-sdk-for-python",
      "mainRepository": "Azure/azure-sdk-for-python",
      "mainBranch": "release/v3"
    },
    "azure-sdk-for-python-track2": {
      "integrationRepository": "AzureSDKAutomation/azure-sdk-for-python",
      "mainRepository": "Azure/azure-sdk-for-python"
    },
    "azure-sdk-for-trenton": {
      "integrationRepository": "Azure/azure-sdk-for-trenton",
      "mainRepository": "Azure/azure-sdk-for-trenton",
      "secondaryRepository": "Azure/azure-sdk-for-trenton",
      "secondaryBranch": "secondary"
    }
  },
  "overrides": {
    "Azure/azure-rest-api-specs-pr": {
      "sdkRepositoryMappings": {
        "azure-sdk-for-js": {
          "integrationRepository": "azure-sdk/azure-sdk-for-js-pr",
          "mainRepository": "Azure/azure-sdk-for-js-pr"
        },
        "azure-sdk-for-python": {
          "integrationRepository": "azure-sdk/azure-sdk-for-python-pr",
          "mainRepository": "Azure/azure-sdk-for-python-pr",
          "mainBranch": "release/v3"
        },
        "azure-sdk-for-python-track2": {
          "integrationRepository": "azure-sdk/azure-sdk-for-python-pr",
          "mainRepository": "Azure/azure-sdk-for-python-pr"
        }
      }
    }
  }
}
```

#### SpecRepoConfig Schema

See [./SpecConfigSchema.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/SpecConfigSchema.json)

### SwaggerToSdkConfig
This is type of file `./swagger_to_sdk_config.json` in sdk repo.
The running environment of these scripts would be expected to be __Ubuntu 18.04__ on Azure Pipeline. This may change in the future. All the running script should be executable.
The working folder of all the scripts is the __root folder of sdk repo__.

#### SwaggerToSdkConfig Example
``` jsonc
{
  "advancedOptions": {
    "createSdkPullRequests": true,
    "generationCallMode": "one-for-all-configs"
  },
  "initOptions": {
    "initScript": {
      // Script to init dependencies.
      // Param: <path_to_initInput.json> <path_to_initOutput.json>
      // initInput.json: Not implemented. Placeholder for input arguments.
      // initOutput.json: See #initOutput.
      "path": "./eng/tools/sdk_init"
    }
  },
  "generateOptions": {
    // Param: <path_to_generateInput.json> <path_to_generateOutput.json>
    // generateInput.json: See #GenerateInput .
    // generateOutput.json: See #GenerateOutput .
    "generateScript": {
      "path": "./eng/tools/sdk_generate",
      "stderr": {
        "showInComment": true
      },
      "stdout": {
        // Show logs start with "[Autorest]" in PR comment.
        "showInComment": "^\\[Autorest\\]"
      }
    },

    "parseGenerateOutput": true
  },
  "packageOptions": {
    // Param: <path_to_package_folder>
    "buildScript": {
      "path": "./eng/tools/sdk_package",
      "stderr": {
        // Everything in stderr will show in comment and mark package with warning.
        "showInComment": true,
        "scriptWarning": true
      },
      "exitCode": {
        // If exit code is not zero, mark package with warning instead of error.
        "result": "warning"
      }
    },
    
    // Param: <path_to_package_folder>
    "changelogScript": {
      "path": "./eng/tools/sdk_breaking_change",
      "breakingChangeDetect": "Breaking Change"
    },

    "breakingChangeLabel": "CI-BreakingChange-DotNet"
  },
  "artifactOptions": {
    // Param: <path_to_installInstructionInput.json> <path_to_installInstructionOutput.json>
    // installInstructionInput.json: See #InstallInstructionScriptInput .
    // installInstructionOutput.json: See #InstallInstructionScriptOutput .
    "installInstructionScript": {
      "path": "./eng/tools/sdk_install_instruction"
    }
  }
}
```

#### SwaggerToSdkConfig Schema

See [./SwaggerToSdkConfigSchema.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/SwaggerToSdkConfigSchema.json)

### GenerateInput

Input file for generate script.

#### GenerateInput Example

```jsonc
{
  "dryRun": false,
  "specFolder": "/z/work/azure-rest-api-specs",
  "headSha": "fce3400431eff281bddd04bed9727e63765b8da0",
  "headRef": "refs/pull/1234/merge",
  "repoHttpsUrl": "https://github.com/Azure/azure-rest-api-specs.git",
  "trigger": "pull_request",
  "changedFiles": [
    "specification/cdn/something/cdn.json"
  ],
  "relatedReadmeMdFiles": [
    "specification/cdn/something/readme.md"
  ],
  "installInstructionInput": {
    "isPublic": false,
    "downloadUrlPrefix": "https://openapihub.test.azure-devex-tools.com/api/sdk-dl-pub?p=Azure/1234/azure-sdk-for-net/",
    "downloadCommandTemplate": "curl -L \"{URL}\" -o {FILENAME}",
    "trigger": "pullRequest"
  }
}
```

#### GenerateInput Schema

See [./GenerateInputSchema.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/GenerateInputSchema.json)

### GenerateOutput

Output file for generate script.

#### GenerateOutput Example

```jsonc
{
  "packages": [
    {
      "packageName": "Microsoft.Cdn",
      "path": [
        "sdk/cdn"
      ],
      "readmeMd": [
        "specification/cdn/something/readme.md"
      ],
      "changelog": {
        "content": "Feature: something \n Breaking Changes: something\n",
        "hasBreakingChange": true
      },
      "artifacts": [
        "sdk/cdn/cdn.nuget",
        "sdk/cdn/cdn.snuget"
      ],
      "installInstructions": {
        "full": "To install something...",
        "lite": "dotnet something"
      },
      "result": "succeeded"
    }
  ]
}
```

#### GenerateOutput Schema

See [./GenerateOutputSchema.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/GenerateOutputSchema.json)

### InstallInstructionScriptInput

Input of install instruction script.

#### InstallInstructionScriptInput Example

```jsonc
{
  "packageName": "Microsoft.Cdn",
  "artifacts": [
    "sdk/cdn/cdn.nuget",
    "sdk/cdn/cdn.snuget"
  ],
  "isPublic": true,
  "downloadUrlPrefix": "https://portal.azure-devex-tools.com/api/sdk-dl-pub?p=Azure/azure-rest-api-specs/1234/azure-sdk-for-net/",
  "downloadCommandTemplate": "curl -L \"{URL}\" -o {FILENAME}",
  "trigger": "pullRequest",
}
```

#### InstallInstructionScriptInput Schema

See [./InstallInstructionScriptInput.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/InstallInstructionScriptInput.json)

### InstallInstructionScriptOutput

Output of install instruction script.

#### InstallInstructionScriptOutput Example

```jsonc
{
  "full": "To install something...",
}
```

#### InstallInstructionScriptOutput Schema

See [./InstallInstructionScriptOutput.json](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/sdkautomation/InstallInstructionScriptOutput.json)

### TriggerType

#### TriggerType Schema

```jsonc
{
  // How this generation is triggered.
  "$id": "TriggerType",
  "type": "string",
  "enum": ["pullRequest", "continuousIntegration"]
}
```

### InitOutput

#### InitOutput Schema

```jsonc
{
  "type": "object",
  "properties": {
    "envs": {
      // Environment variable to be set in following scripts.
      "additionalProperties": {
        "type": "string"
      }
    }
  }
}
```
