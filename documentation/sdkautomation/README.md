# SDK Automation Customization

This is the specification of the SDK Automation customization configuration.

## SDK Automation workflow

### Spec Pull Request Trigger

SDK Automation is launched in azure pipeline. For each language configured:

1. Clone the spec repo on the merge commit and clone the specified SDK language repo from the main branch.

2. Identify the TypeSpec project or the `readme.md` file based on the PR changed files.

3. Trigger the `spec-gen-sdk` pipelines for five SDK languages.

4. Validate SDK configuration in the `spec-gen-sdk` pipeline:

    1. For `readme.md` file, validate the specified language is configured for in the `swagger-to-sdk` section. Example of `swagger-to-sdk` in SDK Automation:
        ```
        ```yaml $(swagger-to-sdk)
        swagger-to-sdk:
          - repo: azure-sdk-for-python
          - repo: azure-sdk-for-java
          - repo: azure-sdk-for-go
          - repo: azure-sdk-for-js
        ``` <EOL>
        ```
    2. For TypeSpec project, validate if the specified language emitter is configured in the `options` config in the `tspconfig.yaml` file.
    
    If SDK configuration is not configured here, the SDK generation will be skipped.

5. Load `specificationRepositoryConfiguration.json` from the merged PR commit. See [SpecRepoConfig](#specrepoconfig). Get the SDK repo config path.

6. Get `swagger_to_sdk_config.json` from cloned SDK repository. The config file path could be customized by __configFilePath__ in spec config. For the definition of the config see [SwaggerToSdkConfig](#swaggertosdkconfig).

7. Launch __initScript__ defined in [SwaggerToSdkConfig](#swaggertosdkconfig). All the script's working directory is root folder of cloned SDK repository.

8. Launch __generateScript__ defined in [SwaggerToSdkConfig](#swaggertosdkconfig) with [generateInput.json](#generateinput). The script should produce [generateOutput.json](#generateoutput) if __parseGenerateOutput__ is true.

9. Get generated package. If __packageFolderFromFileSearch__ is defined with file search then package folder is detected based on git diff in SDK repository and algorithm described in [SwaggerToSdkConfig Schema](#swaggertosdkconfig-schema). Else package folder is from [generateOutput.json](#generateoutput). For each package ___loop the rest steps___.

10. Launch __buildScript__ to build the package. Collect the artifacts by config __artifactPathFromFileSearch__. This step could be skipped if it's not defined in [SwaggerToSdkConfig](#swaggertosdkconfig) and it's covered by __generateScript__ and the result could be found in [generateOutput.json](#generateoutput).

11. Launch __changelogScript__ to get changelog and detect breaking change. This step could be skipped if changelog and breaking change could be found in [generateOutput.json](#generateoutput). If breaking change is found, the spec PR will be labelled with `BreakingChange-<Lang>-Sdk`.

12. Launch __installInstructionScript__ to get install instruction for that package. This step could be skipped if install instruction could be found in [generateOutput.json](#generateoutput). The lite install instruction will be shown in spec PR comment, the full install instruction will be shown in generated SDK PR.

### Manual Trigger

Almost the same as spec pull request trigger. The difference is users can specify the commitish for both of the spec repo and the SDK repo while triggering the pipeline. In addition, a SDK pull request will be created after the pipeline completes successfully. Refer to https://aka.ms/azsdk/spec-gen-sdk-pipeline-doc for more details.

## Definitions

### SpecRepoConfig
This is type of file `./specificationRepositoryConfiguration.json` in swagger spec repo.

#### SpecRepoConfig Example
```json 
{
  "sdkRepositoryMappings": {
    "azure-sdk-for-go": {
      "configFilePath": "eng/swagger_to_sdk_config.json"
    }
  },
  "overrides": {
    "Azure/azure-rest-api-specs-pr": {
      "sdkRepositoryMappings": {
        "azure-sdk-for-net": {
          "configFilePath": "eng/swagger_to_sdk_config.json"
        }
      }
    }
  }
}
```

#### SpecRepoConfig Schema

See [SpecConfigSchema.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/SpecConfigSchema.json)

### SwaggerToSdkConfig
This is type of file `./swagger_to_sdk_config.json` in sdk repo.
The running environment of these scripts would be expected to be __Ubuntu 22__ on Azure Pipeline. This may change in the future. All the running script should be executable.
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

    "breakingChangesLabel": "BreakingChange-DotNet-Sdk"
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

See [SwaggerToSdkConfigSchema.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/SwaggerToSdkConfigSchema.json)

### GenerateInput

Input file for generate script.

#### GenerateInput Example

```jsonc
{
  "specFolder": "/z/work/azure-rest-api-specs",
  "headSha": "fce3400431eff281bddd04bed9727e63765b8da0",
  "repoHttpsUrl": "https://github.com/Azure/azure-rest-api-specs.git",
  "runMode": "spec-pull-request",
  "changedFiles": [],
  "apiVersion": "",
  "sdkReleaseType": "beta",
  "relatedReadmeMdFiles": [
    "specification/cdn/something/readme.md"
  ],
  "relatedTypeSpecProjectFolder": [
    "specification/contosowidgetmanager/Contoso.Management"
  ],
  "installInstructionInput": {
    "isPublic": false,
    "downloadUrlPrefix": "prefix",
  }
}
```

#### GenerateInput Schema

See [GenerateInputSchema.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/GenerateInputSchema.json)

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

See [GenerateOutputSchema.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/GenerateOutputSchema.json)

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
  "downloadUrlPrefix": "prefix"
}
```

#### InstallInstructionScriptInput Schema

See [InstallInstructionScriptInput.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/InstallInstructionScriptInputSchema.json)

### InstallInstructionScriptOutput

Output of install instruction script.

#### InstallInstructionScriptOutput Example

```jsonc
{
  "full": "To install something...",
}
```

#### InstallInstructionScriptOutput Schema

See [InstallInstructionScriptOutput.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/InstallInstructionScriptOutputSchema.json)

### InitOutput

#### InitOutput Schema

See [InitOutputSchema.json](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/types/InitOutputSchema.json)
