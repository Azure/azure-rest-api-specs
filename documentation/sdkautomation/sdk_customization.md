# SDK Automation Customization

This is the specification of the new SDK Automation customization configuration.
Old customization that hardcoded in sdk automation will still work but this new
approach is preferred.

## SDK Automation workflow

### Opened PR Validation Trigger

SDK Automation is launched with matrix in azure pipeline. For each language configured:

1. Get the PR merge commit and clone the spec repo on the merge commit.

2. Get the PR changed file list. For each changed file, find the nearest readme.md in parent folder. Get list of related readme.md.

3. Filter the list of readme.md with: find the `swagger-to-sdk` section in the readme.md, and see if the specified language is configured for that readme.md. Example of `swagger-to-sdk` in sdk automation:
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

4. Get `specificationRepositoryConfiguration.json` from spec repo default branch. See [#definitions/SpecRepoConfig](#specrepoconfig). Get the repo and branch config in the file.

5. Clone __mainRepository__ and checkout __mainBranch__. If __secondaryRepository__ is specified then checkout __secondaryRepository__ and __secondaryBranch__ instead.

6. Get `swagger_to_sdk_config.json` from cloned sdk repository. The config file path could be customized by __configFilePath__ in spec config. For the definition of the config see [#definitions/SwaggerToSdkConfig](#swaggertosdkconfig).

7. 

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
        },
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
      // The property name is the sdk name.
      "type": "object",
      "additionalProperties": {
        "$ref": "#/definitions/SdkRepositoryConfig"
      }
    },
    "overrides": {
      // Override config for specific repository.
      // The property name is #/definitions/RepositoryName.
      "type": "object",
      "additionalProperties": {
        "$ref": "#/"
      }
    },
    "required": [
      "sdkRepositoryMappings"
    ]
  },
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
      "required": [
        "mainRepository"
      ]
    }
  }
}
```

### SwaggerToSdkConfig
This is type of file `./swagger_to_sdk_config.json` in sdk repo.
The running environment of these scripts would be expected to be __Ubuntu 18.04__ on Azure Pipeline. All the running script should be executable.
The working folder of all the scripts is the __root folder of sdk repo__.

#### SwaggerToSdkConfig Example
``` jsonc
{
  "advanced_options": {
    "create_sdk_pull_requests": true,
    "generation_call_mode": "one-for-all-configs"
  },
  "init_options": {
    "init_script": {
      "path": "./eng/tools/sdk_init"
    }
  },
  "generate_options": {
    // Param: <path_to_generate_input.json> <path_to_generate_output.json>
    // generate_input.json: See #GenerateInput .
    // generate_output.json: See #GenerateOutput .
    "generate_script": {
      "path": "./eng/tools/sdk_generate",
      "stderr": {
        "show_in_comment": true
      },
      "stdout": {
        // Show logs start with "[Autorest]" in PR comment.
        "show_in_comment": "^\\[Autorest\\]"
      }
    },

    "parse_generate_output": true
  },
  "package_options": {
    // Param: <path_to_package_folder>
    "build_script": {
      "path": "./eng/tools/sdk_package",
      "stderr": {
        // Everything in stderr will show in comment and mark package with warning.
        "show_in_comment": true,
        "script_warning": true
      },
      "exitCode": {
        // If exit code is not zero, mark package with warning instead of error.
        "result": "warning"
      }
    },
    
    // Param: <path_to_package_folder>
    "changelog_script": {
      "path": "./eng/tools/sdk_breaking_change",
      "breaking_change_detect": "Breaking Change"
    }
  },
  "artifact_options": {
    // Param: <path_to_install_instruction_input.json> <path_to_install_instruction_output.md> <lite|full>
    // install_instruction_input.json: See #InstallInstructionScriptInput .
    // install_instruction_output.md: Install instruction in markdown.
    "install_instruction_script": {
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
    "advanced_options": {
      // To keep backward compatibility, but will not list schema for old config options.
      "properties": {
        "create_sdk_pull_requests": {
          // Should SDK Automation create PR or not.
          "type": boolean,
          "default": false
        },
        "generation_call_mode": {
          // If we have multiple related readme.md, should we call generation once with
          // all the readme.md or should we call generation multiple times and one per readme.md.
          "type": "string",
          "enum": [
            "one-per-config",
            "one-for-all-configs"
          ],
          "default": "one-for-all-configs"
        }
      }
    },
    "init_options": {
      // Init the environment. Install dependencies.
      "type": "object",
      "properties": {
        "init_script": {
          // Script to init.
          "$ref": "#/definitions/RunOptions"
        }
      },
      "required": [
        "init_script"
      ]
    },
    "generate_options": {
      // Generate the SDK code.
      "type": "object",
      "properties": {
        "generate_script": {
          // Script to generate the SDK code.
          // Param: <path_to_generate_input.json> <path_to_generate_output.json>
          // generate_input.json: See #GenerateInput
          // generate_output.json: See #GenerateOutput
          "$ref": "#/definitions/RunOptions"
        },
        "parse_generate_output": {
          // Will this script output to generate_output.json.
          // If not, default behavior will be applied that outcome will be
          // detected automatically based on filename regex search.
          "type": "boolean",
          "default": true
        }
      },
      "required": [
        "generate_script"
      ]
    },
    "package_options": {
      // Get package folder and build / get changelog
      "type": "object",
      "properties": {
        "package_folder_from_file_search": {
          "oneOf": [
            {
              // If this option is set to object, then package folder will be detected automatically.
              //   based on filename regex search.
              // This options must be set to object if parse_generate_output is false.
              "type": "object",
              "properties": {
                "search_regex": {
                  // Search algorithm:
                  //  For each changed file detected after generation
                  //    PotentialPackageFolder = folder of changed file
                  //    While PotentialPackageFolder is not root folder of sdk repo:
                  //      If PotentialPackageFolder contains a file that matches the search_regex:
                  //        PackageFolder found, break
                  //      Else:
                  //        PotentialPackageFolder = parent folder of PotentialPackageFolder
                  "type": "string",
                  "format": "regex"
                },
                "pageNamePrefix": {
                  // Prefix to be appended to packageName. By default packageName will be the folder name of packageFolder
                  "type": "string"
                }
              },
              "required": [
                "search_regex"
              ]
            },
            {
              // If this option is set to false, then package folder will be from generate_output.json.
              "const": false
            }
          ],
          "default": false,
        },
        "build_script": {
          // Build the generated sdk.
          // Param: <path_to_package_folder>
          // Package folder could be a list separated by space if it's from generate_output.json.
          "$ref": "#/definitions/RunOptions"
        },
        "changelog_script": {
          // Changelog generation and breaking-change detection.
          // Param: <path_to_package_folder>
          // Package folder could be a list separated by space if it's from generate_output.json.
          // Expected output from stdout/stderr: Changelog in markdown
          "allOf": {
            "$ref": "#/definitions/RunOptions"
          },
          "properties": {
            "breaking_change_detect": {
              // If stdout or stderr matches this in output of changelog tool
              // then we assume this SDK has breaking change.
              "$ref": "#/definitions/RunLogFilterOptions"
            }
          }
        }
      }
    },
    "artifact_options": {
      "artifact_path_from_file_search": {
        "oneOf": [
          {
            // If this option is set to object, then artifacts will be detected automatically
            //   based on filename regex search.
            // This options must be set to object if parse_generate_output is false.
            "type": "object",
            "properties": {
              "search_regex": {
                // Any file under package folder matching the search_regex is package artifact.
                "type": "string",
                "format": "regex",
              }
            }
          },
          {
            // If this option is set to false, then package folder will be from generate_output.json
            "const": false
          }
        ],
        "default": false
      },
      "install_instruction_script": {
        // Generate install instruction that could be shown in spec PR comment (lite version)
        //  or in generated SDK PR (full version).
        // If generate_output.json contains install_instruction then this could be skipped.
        // Param: <path_to_install_instruction_input.json> <path_to_install_instruction_output.md> <lite|full>
        // install_instruction_input.json: See #InstallInstructionScriptInput .
        // install_instruction_output.md: Install instruction in markdown.
        "allOf": {
          "$ref": "#/definitions/RunOptions"
        },
        "properties": {
          "enable_lite_install_instruction": {
            "type": "boolean",
            "default": false
          }
        }
      }
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
        },
        "stdout": {
          // How should SDK Automation handle the script stdout stream
          "$ref": "#/definitions/RunLogOptions"
        },
        "stderr": {
          // How should SDK Automation handle the script stderr stream
          "$ref": "#/definitions/RunLogOptions"
        },
        "exitCode": {
          // How should SDK Automation handle non-zero exitCode.
          "show_in_comment": {
            // Should we show this error in comment.
            "type": "boolean",
            "default": true
          },
          "result": {
            // If script has non-error exitCode how should we mark the script's result.
            "type": "string",
            "enum": [
              "error", "warning", "ignore"
            ],
            "default": "error"
          }
        },
        "required": [
          "path"
        ]
      }
    },
    "RunLogOptions": {
      // How should SDK Automation handle the log stream.
      "show_in_comment": {
        // Should we show this stream in comment.
        "$ref": "#/definitions/RunLogFilterOptions"
      },
      "script_error": {
        // If any line match, assume the script fails.
        "$ref": "#/definitions/RunLogFilterOptions"
      },
      "script_warning": {
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
  "spec_folder": "/z/work/azure-rest-api-specs",
  "head_sha": "fce3400431eff281bddd04bed9727e63765b8da0",
  "head_ref": "refs/pull/1234/merge",
  "repo_git": "git@github.com:Azure/azure-rest-api-specs.git",
  "repo_https": "https://github.com/Azure/azure-rest-api-specs.git",
  "trigger": "pull_request",
  "changed_files": [
    "specification/cdn/something/cdn.json"
  ],
  "related_readme_md_files": [
    "specification/cdn/something/readme.md"
  ]
}
```

#### GenerateInput Schema

```jsonc
{
  "type": "object",
  "properties": {
    "spec_folder": {
      // Path to local spec folder.
      "type": "string"
    },
    "head_sha": {
      // Git head sha.
      "type": "string"
    },
    "head_ref": {
      // Git head ref.
      // Format will be "refs/pull/<number>/merge" or "refs/heads/<branch>".
      "type": "string"
    },
    "repo_git": {
      // Spec repo url in git without auth.
      "type": "string"
    },
    "repo_https": {
      // Spec repo url in https without auth.
      "type": "string"
    },
    "trigger": {
      // How this generation is triggered.
      "type": "string",
      "enum": [
        "pull_request",
        "continuous_integration"
      ]
    },
    "changed_files": {
      // Changed file list in spec PR.
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "related_readme_md_files": {
      // Related readme.md files that pending generation.
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "install_instruction_input": {
      // See #InstallInstructionScriptInput
      "$ref": "#/definitions/InstallInstructionScriptInput"
    }
  },
  "required": [
    "spec_folder", "head_sha", "head_ref", "repo_git", "repo_https",
    "trigger", "changed_files", "related_readme_md_files"
  ]
}
```

### GenerateOutput

Output file for generate script.

#### GenerateOutput Example

```jsonc
{
  "packages": [
    {
      "path": [
        "sdk/cdn"
      ],
      "changelog": {
        "content": "Feature: something \n Breaking Changes: something\n",
        "hasBreakingChange": true
      },
      "artifacts": [
        "sdk/cdn/cdn.nuget",
        "sdk/cdn/cdn.snuget"
      ],
      "install_instructions": {
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
  "required": [
    "packages"
  ],
  "definitions": {
    "PackageResult": {
      "properties": {
        "path": {
          // List of package content paths.
          // If the path points to a folder then
          //   all the content under the folder will be included.
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
          "required": [
            "content"
          ]
        },
        "artifacts": {
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "install_instructions": {
          "type": "object",
          "properties": {
            "full": {
              "type": "string"
            },
            "lite": {
              "type": "string"
            }
          },
          "required": [
            "full"
          ]
        },
      },
      "required": [
        "path"
      ]
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
  "trigger": "pull_request",
}
```

#### InstallInstructionScriptInput Schema

```jsonc
{
  "type": "object",
  "properties": {
    "packageName": {
      // The package name
      "type": "string"
    },
    "artifacts": {
      // List of artifact's path
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "isPublic": {
      // Is the download url public accessible.
      // If it's false, the download command template will be
      //  az rest --resource <client-id> -u "{URL}" --output-file {FILENAME}
      "type": "boolean",
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
      "type": "string",
      "enum": [
        "pull_request",
        "continuous_integration"
      ]
    }
  }
}
```
