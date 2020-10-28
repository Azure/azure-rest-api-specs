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

8. Calculate __PR diff__ and related `readme.md`. If __generationCallMode__ is __one-for-all-configs__ then run ___one pass for the rest steps___, else (__one-per-configs__) ___loop the rest steps___ with each `readme.md`.

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
``` jsonc
{
  "type": "object",
  "properties": {
    "sdkRepositoryMappings": {
      // A mapping of SDK repository names to the names of the SDK repositories
      // that all interaction should go to instead.
      "type": "object",
      "additionalProperties": {
        "oneOf": [
          {
            "$ref": "#/definitions/SdkRepositoryConfig"
          },
          {
            "type": "string"
          }
        ]
      },
      "propertyNames": {
        // The property name is the sdk name identifier.
        "type": "string"
      }
    },
    "overrides": {
      // Override config for specific repository.
      "type": "object",
      "additionalProperties": {
        "$ref": "#/"
      },
      "propertyNames": {
        // The property name is the sdk repo ref.
        "$ref": "#/definitions/RepositoryName"
      }
    }
  },
  "required": ["sdkRepositoryMappings"],
  "definitions": {
    "RepositoryName": {
      // Reference to a repository on github. Could be <repo> or <owner>/<repo>.
      // By default the <owner> is the same as the owner of the spec repo.
      "type": "string"
    },
    "SdkRepositoryConfig": {
      "type": "object",
      "properties": {
        "mainRepository": {
          // The repository that the final release PR will targeting.
          "$ref": "#/definitions/RepositoryName"
        },
        "mainBranch": {
          // Base branch of codegen branches
          "default": "master",
          "type": "string"
        },
        "integrationRepository": {
          // The repository that hold generation branch, generation PR and integration branch.
          // By default it's the same as mainRepository
          "$ref": "#/definitions/RepositoryName"
        },
        "secondaryRepository": {
          // Codegen runs on this repository.
          // By default it's the same as 'mainRepository' but it could be different.
          "$ref": "#/definitions/RepositoryName"
        },
        "secondaryBranch": {
          // Codegen runs on this branch on secondaryRepository.
          // By default it's the same as 'mainBranch' but it could be different.
          "type": "string"
        },
        "integrationBranchPrefix": {
          // The prefix that will be applied to the beginning of integration branches
          "type": "string",
          "default": "sdkAutomation"
        },
        "configFilePath": {
          // Path to swagger-to-sdk config in sdk repo
          "default": "swagger_to_sdk_config.json"
        }
      },
      "required": ["mainRepository"]
    }
  }
}
```

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
    }
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
``` jsonc
{
  "type": "object",
  "properties": {
    "advancedOptions": {
      // To keep backward compatibility, but will not list schema for old config options.
      "properties": {
        "createSdkPullRequests": {
          // Should SDK Automation create PR or not.
          "type": "boolean",
          "default": true
        },
        "closeIntegrationPR": {
          // Should SDK Automation close integrationPR to reduce noise.
          "type": "boolean",
          "default": true
        },
        "generationCallMode": {
          // If we have multiple related readme.md, should we call generation once with
          // all the readme.md or should we call generation multiple times and one per readme.md.
          "type": "string",
          "enum": ["one-per-config", "one-for-all-configs"],
          "default": "one-for-all-configs"
        },
        "clondDir": {
          // SDK clone directory. By default it's name of sdk repo
          "type": "string"
        }
      },
      "default": {
        "createSdkPullRequests": true,
        "closeIntegrationPR": true
      }
    },
    "initOptions": {
      // Init the environment. Install dependencies.
      "type": "object",
      "properties": {
        "initScript": {
          // Script to init.
          "$ref": "#/definitions/RunOptions"
        }
      },
      "default": {}
    },
    "generateOptions": {
      // Generate the SDK code.
      "type": "object",
      "properties": {
        "generateScript": {
          // Script to generate the SDK code.
          // Param: <path_to_generateInput.json> <path_to_generateOutput.json>
          // generateInput.json: See #GenerateInput
          // generateOutput.json: See #GenerateOutput
          "$ref": "#/definitions/RunOptions"
        },
        "preprocessDryRunGetPackageName": {
          // If this options is set to true, generateScript will first run with
          // "dryRun": true to get package name and related readme.md,
          // then for each package, checkout the expected branch and launch generateScript.
          "type": "boolean",
          "default": false
        },
        "parseGenerateOutput": {
          // Will this script output to generateOutput.json.
          // If not, default behavior will be applied that outcome will be
          // detected automatically based on filename regex search.
          "type": "boolean",
          "default": true
        }
      },
      "default": {
        "preprocessDryRunGetPackageName": false,
        "parseGenerateOutput": false
      }
    },
    "packageOptions": {
      // Get package folder and build / get changelog
      "type": "object",
      "properties": {
        "packageFolderFromFileSearch": {
          "oneOf": [
            {
              // If this option is set to object, then package folder will be detected automatically.
              //   based on filename regex search.
              // This options must be set to object if parseGenerateOutput is false.
              "type": "object",
              "properties": {
                "searchRegex": {
                  // Search algorithm:
                  //  For each changed file detected after generation
                  //    PotentialPackageFolder = folder of changed file
                  //    While PotentialPackageFolder is not root folder of sdk repo:
                  //      If PotentialPackageFolder contains a file that matches the searchRegex:
                  //        PackageFolder found, break
                  //      Else:
                  //        PotentialPackageFolder = parent folder of PotentialPackageFolder
                  "type": "string",
                  "format": "regex"
                },
                "packageNamePrefix": {
                  // Prefix to be appended to packageName.
                  // By default packageName will be the folder name of packageFolder
                  "type": "string"
                }
              },
              "required": ["searchRegex"]
            },
            {
              // If this option is set to false, then package folder will be from generateOutput.json.
              "const": false
            }
          ]
        },
        "buildScript": {
          // Build the generated sdk.
          // Param: <path_to_package_folder>
          // Package folder could be a list separated by space if it's from generateOutput.json.
          "$ref": "#/definitions/RunOptions"
        },
        "changelogScript": {
          // Changelog generation and breaking-change detection.
          // Param: <path_to_package_folder>
          // Package folder could be a list separated by space if it's from generateOutput.json.
          // Expected output from stdout/stderr: Changelog in markdown
          "allOf": [
            {
              "$ref": "#/definitions/RunOptions"
            }
          ],
          "properties": {
            "breakingChangeDetect": {
              // If stdout or stderr matches this in output of changelog tool
              // then we assume this SDK has breaking change.
              "$ref": "#/definitions/RunLogFilterOptions"
            },
            "breakingChangeLabel": {
              "type": "string"
            }
          }
        }
      },
      "default": {}
    },
    "artifactOptions": {
      "properties": {
        "artifactPathFromFileSearch": {
          "oneOf": [
            {
              // If this option is set to object, then artifacts will be detected automatically
              //   based on filename regex search.
              // This options must be set to object if parseGenerateOutput is false.
              "type": "object",
              "properties": {
                "searchRegex": {
                  // Any file under package folder matching the searchRegex is package artifact.
                  "type": "string",
                  "format": "regex"
                }
              },
              "required": ["searchRegex"]
            },
            {
              // If this option is set to false, then package folder will be from generateOutput.json
              "const": false
            }
          ]
        },
        "installInstructionScript": {
          // Generate install instruction that could be shown in spec PR comment (lite version)
          //  or in generated SDK PR (full version).
          // If generateOutput.json contains installInstruction then this could be skipped.
          // Param: <path_to_installInstructionInput.json> <path_to_installInstructionOutput.json>
          // installInstructionInput.json: See #InstallInstructionScriptInput .
          // installInstructionOutput.json: See #InstallInstructionScriptInput .
          "$ref": "#/definitions/RunOptions"
        }
      },
      "default": {}
    }
  },
  "definitions": {
    "RunOptions": {
      // Options to run a script and collect log.
      "type": "object",
      "properties": {
        "path": {
          // Script path related to repo root
          "type": "string"
        },
        "logPrefix": {
          // Prefix to be added to SDK Automation log. By default it would be filename of the script.
          "type": "string"
        },
        "stdout": {
          // How should SDK Automation handle the script stdout stream
          "allOf": [
            {
              "$ref": "#/definitions/RunLogOptions"
            }
          ]
        },
        "stderr": {
          // How should SDK Automation handle the script stderr stream
          "allOf": [
            {
              "$ref": "#/definitions/RunLogOptions"
            }
          ],
          "default": {
            "scriptWarning": true
          }
        },
        "exitCode": {
          "properties": {
            // How should SDK Automation handle non-zero exitCode.
            "showInComment": {
              // Should we show this error in comment.
              "type": "boolean",
              "default": true
            },
            "result": {
              // If script has non-error exitCode how should we mark the script's result.
              "type": "string",
              "enum": ["error", "warning", "ignore"],
              "default": "error"
            }
          },
          "default": {
            "showInComment": true,
            "result": "error"
          }
        }
      },
      "required": ["path"]
    },
    "RunLogOptions": {
      // How should SDK Automation handle the log stream.
      "showInComment": {
        // Should we show this stream in comment.
        "$ref": "#/definitions/RunLogFilterOptions"
      },
      "scriptError": {
        // If any line match, assume the script fails.
        "$ref": "#/definitions/RunLogFilterOptions"
      },
      "scriptWarning": {
        // If any line match, assume the script warns.
        "$ref": "#/definitions/RunLogFilterOptions"
      }
    },
    "RunLogFilterOptions": {
      "oneOf": [
        {
          // If line of log match this regex then hit
          "type": "string",
          "format": "regex"
        },
        {
          // If set to true, any line of log will hit
          "type": "boolean"
        }
      ],
      "default": false
    }
  }
}
```

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
  ]
}
```

#### GenerateInput Schema

```jsonc
{
  "type": "object",
  "properties": {
    "dryRun": {
      // If dryRun is true, generateScript is expected to parse readme.md
      // and output the package list with package name and related readme.md.
      // Should not run codegen at this time.
      // ** Not supported yet **
      "type": "boolean"
    },
    "specFolder": {
      // Path to local spec folder.
      "type": "string"
    },
    "headSha": {
      // Git head sha.
      "type": "string"
    },
    "headRef": {
      // Git head ref.
      // Format will be "refs/pull/<number>/merge" or "refs/heads/<branch>".
      "type": "string"
    },
    "repoHttpsUrl": {
      // Spec repo url in https without auth.
      "type": "string"
    },
    "trigger": {
      "$ref": "TriggerType#"
    },
    "changedFiles": {
      // Changed file list in spec PR.
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "relatedReadmeMdFiles": {
      // Related readme.md files that pending generation.
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "installInstructionInput": {
      // See #InstallInstructionScriptInput
      "$ref": "InstallInstructionScriptInput#"
    }
  },
  "required": ["specFolder", "headSha", "headRef", "repoHttpsUrl", "trigger", "changedFiles", "relatedReadmeMdFiles"]
}
```

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
      "result": "success"
    }
  ]
}
```

#### GenerateOutput Schema

```jsonc
{
  "type": "object",
  "properties": {
    "packages": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/PackageResult"
      }
    }
  },
  "required": ["packages"],
  "definitions": {
    "PackageResult": {
      "properties": {
        "packageName": {
          // Name of package. Will be used in branch name and PR title.
          // By default it's folder name of first entry in path.
          "type": "string"
        },
        "path": {
          // List of package content paths.
          // If the path points to a folder then
          //   all the content under the folder will be included.
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "readmeMd": {
          // List of related readmeMd of this package.
          // Must provide this field if dryRun is true.
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "changelog": {
          "type": "object",
          "properties": {
            "content": {
              // Content of changelog in markdown
              "type": "string"
            },
            "hasBreakingChange": {
              // Does the new package has breaking change
              "type": "boolean"
            }
          },
          "required": ["content"]
        },
        "artifacts": {
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "installInstructions": {
          // See #InstallInstructionScriptOutput
          "$ref": "InstallInstructionScriptOutput"
        }
      },
      "required": ["path"]
    }
  }
}
```

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

```jsonc
{
  "$id": "InstallInstructionScriptInput",
  "type": "object",
  "properties": {
    "packageName": {
      // The package name. May be skipped if sdk automation don't know the info yet.
      "type": "string"
    },
    "artifacts": {
      // List of artifact's path. May be skipped if sdk automation don't know the info yet.
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "isPublic": {
      // Is the download url public accessible.
      // If it's false, the download command template will be
      //  az rest --resource <client-id> -u "{URL}" --output-file {FILENAME}
      "type": "boolean"
    },
    "downloadUrlPrefix": {
      // All the artifacts will be uploaded and user could access the artifact via
      // a link composed by this prefix and artifact filename.
      "type": "string"
    },
    "downloadCommandTemplate": {
      // Download command template. Replace {URL} and {FILENAME} to get the real command.
      "type": "string"
    },
    "trigger": {
      "$ref": "TriggerType#"
    }
  }
}
```

### InstallInstructionScriptOutput

Output of install instruction script.

#### InstallInstructionScriptOutput Example

```jsonc
{
  "full": "To install something...",
}
```

#### InstallInstructionScriptOutput Schema

```jsonc
{
  "$id": "InstallInstructionScriptOutput",
  "type": "object",
  "properties": {
    "full": {
      // Full version of install instruction will be shown in generated SDK PR.
      // Should be in markdown format.
      "type": "string"
    },
    "lite": {
      // Lite version of install instruction will be shown in generated SDK PR.
      // Should be in markdown format.
      "type": "string"
    }
  },
  "required": ["full"]
}
```

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