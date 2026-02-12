## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
  generate-readme-md: true

directive: 
  - where-operation: ManagedHsms_PurgeDeleted
    transform: >
      $.parameters = 
        [
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/SubscriptionIdParameter"
          },
          {
            "name": "name",
            "in": "path",
            "description": "The name of the deleted managed HSM.",
            "required": true,
            "type": "string"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter"
          }
        ]
  - where-operation: ManagedHsms_GetDeleted
    transform: >
      $.parameters = 
        [
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/SubscriptionIdParameter"
          },
          {
            "name": "name",
            "in": "path",
            "description": "The name of the deleted managed HSM.",
            "required": true,
            "type": "string"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter"
          }
        ]
  - where-operation: Vaults_PurgeDeleted
    transform: >
      $.parameters = 
        [
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/SubscriptionIdParameter"
          },
          {
            "name": "vaultName",
            "in": "path",
            "description": "The name of the vault.",
            "required": true,
            "type": "string"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter"
          },
        ]
  - where-operation: Vaults_GetDeleted
    transform: >
      $.parameters = 
        [
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/SubscriptionIdParameter"
          },
          {
            "name": "vaultName",
            "in": "path",
            "description": "The name of the vault.",
            "required": true,
            "type": "string"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter"
          }
        ]
```

``` yaml $(typescript) && !$(profile-content)
typescript:
  package-name: "@azure/arm-keyvault"
  output-folder: "$(typescript-sdks-folder)/sdk/keyvault/arm-keyvault"
  auto-publish: true
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile-content=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-keyvault-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/keyvault/arm-keyvault-profile-2019-03-01-hybrid"
  batch:
    - tag: profile-hybrid-2019-03-01
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile-content=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-keyvault-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/keyvault/arm-keyvault-profile-2020-09-01-hybrid"
  azure-arm: true
  generate-metadata: true
  batch:
    - tag: profile-hybrid-2020-09-01
```
