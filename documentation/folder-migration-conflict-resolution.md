# Resolving Folder Migration Conflicts: A Guide for PR Authors

## Overview

When folder structure migration PRs (like [#36764](https://github.com/Azure/azure-rest-api-specs/pull/36764)) are merged, they may conflict with ongoing PRs that modify files within the refactored folders. This guide helps PR authors resolve these conflicts more efficiently.

> **Important Note**: If you create a new PR **after** a folder migration is already merged into main, you should not encounter merge conflicts but need to work based on the new folder structure.

## Understanding Folder Migration

Here's the brief summary of the file changes of folder structure migration PR. we will take the Container Apps as an example.

### Folder Structure Change  

**Before Migration Structure**:
```
specification/app/
├── Microsoft.App.DynamicSessions/
│   ├── *.tsp
│   ├── examples/*/*.json
│   └── tspconfig.yaml
├── resource-manager/
|   ├── readme.md
|   └── Microsoft.App/
|       ├── preview/*/*.json
|       └── stable/*/*.json
└── data-plane/
    ├── readme.md
    └── Microsoft.App.DynamicSessions/
        └── preview/*/*.json
```

**After Migration Structure**:
```
specification/app/
├── resource-manager/Microsoft.App/ContainerApps/
│   ├── preview/*/*.json
│   ├── stable/*/*.json
│   └── readme.md
└── data-plane/DynamicSessions/
    ├── examples/*/*.json
    ├── preview/*/*.json
    ├── *.tsp
    ├── tspconfig.yaml
    └── readme.md
```

**Key Changes Made**:
- TypeSpec files moved with their respective services
- Each service now has its own isolated directory structure

For example:
- Create a new serviceName folder ContainerApps: Moved from `resource-manager/Microsoft.App/` to `resource-manager/Microsoft.App/ContainerApps/`
- The resource-manager readme.md updated paths from `resource-manager/` to `resource-manager/Microsoft.App/ContainerApps`
- DynamicSessions TypeSpec: Moved from `Microsoft.App.DynamicSessions/` to `data-plane/DynamicSessions/`
- DynamicSessions OpenAPI json files: Moved from `data-plane/Microsoft.App.DynamicSessions/preview/<version>/` to `data-plane/DynamicSessions/preview/<version>/`
- The data-plane readme.md updated paths from `Microsoft.App.DynamicSessions/preview/<version>/` to `preview/<version>/`


### File Reference Updates Needed

1. **Readme.md files** - Update input-file paths:
   
   **For ContainerApps (Resource Manager)**:
   ```yaml
   # Before
   input-file:
     - Microsoft.App/stable/2024-03-01/ContainerApps.json
   
   # After  
   input-file:
     - stable/2024-03-01/ContainerApps.json
   ```
   
   **For DynamicSessions (Data Plane)**:
   ```yaml
   # Before migration - in data-plane/readme.md
   input-file:
     - Microsoft.App.DynamicSessions/preview/2025-02-02-preview/DynamicSessions.json
   
   # After migration - in data-plane/DynamicSessions/readme.md  
   input-file:
     - preview/2025-02-02-preview/DynamicSessions.json
   ```

2. **tspconfig.yaml files** - Update emitter output directory:
   
   **DynamicSessions tspconfig.yaml changes**:
   ```yaml
   # Before migration - in Microsoft.App.DynamicSessions/tspconfig.yaml
   options:
     "@azure-tools/typespec-autorest":
       emitter-output-dir: "{project-root}/.."
       output-file: "{azure-resource-provider-folder}/{service-name}/{version-status}/{version}/DynamicSessions.json"
   
   # After migration - in data-plane/DynamicSessions/tspconfig.yaml
   options:
     "@azure-tools/typespec-autorest":
       emitter-output-dir: "{project-root}"
       output-file: "{version-status}/{version}/DynamicSessions.json"
   ```

3. **Common-types references** - Update relative paths in JSON files:
   ```json
   // Before (in ContainerApps.json)
   "$ref": "../../../../../common-types/resource-management/v3/types.json#/parameters/SubscriptionIdParameter"
   
   // After  
   "$ref": "../../../../../../common-types/resource-management/v3/types.json#/parameters/SubscriptionIdParameter"
   ```

   Fpr mgmt plane TypeSpec, we also need to specify the `arm-common-types` in tspconfig options of `@azure-tools/typespec-autorest`.
   ```yaml 
   options:
     "@azure-tools/typespec-autorest":
       arm-types-dir: "{project-root}/../../../../common-types/resource-management"
   ```

4. **Suppressions.yaml** - Update paths in suppressions:
As GitHub recognize this refactor change as to add new API versions in the OpenAPI folder, in order to make sure the TypeSpec requirement check pass. we need to have a suppressions.yaml under serviceName folder 
and add suppression one by one like this 
```
- tool: TypeSpecRequirement
  path: ./preview/2022-01-01-preview/*.json
  reason: Brownfield service not ready to migrate
- tool: TypeSpecRequirement
  path: ./stable/2025-01-01/*.json
  reason: Brownfield service not ready to migrate
```


## The impact to ongoing PRs

1. If the ongoing PRs are targeting to a release-* or dev-* branch which are not created or syncing from the latest main, we recommend to merge these PRs first.
1. If the ongoing PRs are targeting to public main branch, Here's the suggestion to resolve the conflict. 

      1. Merge latest main 
          ```
          git checkout main
          git pull origin main // origin points to Azure rest api specs repo.
          git merge main <your-pr-branch>
          ```
      2. Resolve conflicts  
        - For most of the conflicts, accept the incoming changes.  
        - If it's unclear, please accept both and then update based on your judgement with the folder structure changes above.  

      3. Make sure the new change is aligned with folder structure v2  

        There are some cases where the PR is adding a new version in the original location, but the file diff doesn't show as conflict. we should move them into the correct place so that it doesn't break the folder structure v2 as instructions in **Understanding Folder Migration sections** 

      4. clean up the previous folder if exists.

  

**Important**: It's strongly recommended to understand what's really changed in the folder refactor. Always ensure the new PR doesn't include any things that breaks the folder structure.


### After Resolution

Make sure to compile the TypeSpec project so that the TypeSpec Validation could pass.

1. **Comprehensive validation**:
   ```bash
   # Run full validation suite
   npm ci
   npm run lint
   npm run validate
   
   # Test TypeSpec compilation for your service
   cd specification/app/data-plane/DynamicSessions/
   npx tsp compile .
   npx tsp compile . --emit @azure-tools/typespec-autorest
   
   # Verify generated files match expectations by checking if there's any diff with the OpenAPI json files.
   ```

## Getting Help

### Resources
- [Azure Service Version Guidelines](https://github.com/Azure/azure-rest-api-specs/wiki/Azure-Service-Versioning-Guideline)
- [Container Apps Migration PR #36764](https://github.com/Azure/azure-rest-api-specs/pull/36764)

### Support Channels

If you encounter complex conflicts that can't be resolved using this guide, please email to azversioning@service.microsoft.com

