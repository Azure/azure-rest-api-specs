# Authorization

> see https://aka.ms/autorest

This is the AutoRest configuration file for Authorization.



---
## Getting Started
To build the SDK for Authorization, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Authorization API.

``` yaml
openapi-type: arm
tag: package-2018-09-01-preview
```

## Suppression
``` yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: we do have a operations api as "/providers/Microsoft.Authorization/operations"
    #where:
    #  -   $.paths["/providers/Microsoft.Authorization/operations"]

```

### Tag: package-2015-07

These settings apply only when `--tag=package-2015-07` is specified on the command line.

``` yaml $(tag) == 'package-2015-07'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json
```

### Tag: package-2015-07-authorization-only

These settings apply only when `--tag=package-2015-07-authorization-only` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-authorization-only'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization.json
```

### Tag: package-2015-06-01-preview

These settings apply only when `--tag=package-2015-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
```

### Tag: package-2015-07-01-preview

These settings apply only when `--tag=package-2015-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-07-01/authorization.json
```

### Tag: package-2017-10-01-preview-only

These settings apply only when `--tag=package-2017-10-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2017-10-01-preview/authorization-RACalls.json
```

### Tag: package-2018-01-01-preview-only

These settings apply only when `--tag=package-2018-01-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
```

### Tag: package-2018-07-01-preview-only

These settings apply only when `--tag=package-2018-07-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
```

### Tag: package-2018-09-01-preview-only

These settings apply only when `--tag=package-2018-09-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2017-10-01-preview

These settings apply only when `--tag=package-2017-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/preview/2015-07-01/authorization.json
- Microsoft.Authorization/preview/2017-10-01-preview/authorization-RACalls.json
```

### Tag: package-2018-01-01-preview

These settings apply only when `--tag=package-2018-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
```

### Tag: package-2018-07-01-preview

These settings apply only when `--tag=package-2018-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
```

### Tag: package-2018-09-01-preview

These settings apply only when `--tag=package-2018-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-authorization
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_authorization']
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.authorization
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-authorization
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-07
  - tag: package-2018-09-01-preview
```

### Tag: package-2018-09-01-preview and java

These settings apply only when `--tag=package-2018-09-01-preview --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2018_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/authorization/resource-manager/v2018_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-07 and java

These settings apply only when `--tag=package-2015-07 --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2015_07_01
  output-folder: $(azure-libraries-for-java-folder)/authorization/resource-manager/v2015_07_01
regenerate-manager: true
generate-interface: true
```
