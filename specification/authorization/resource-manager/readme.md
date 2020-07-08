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
tag: package-2020-04-preview
```

## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: we do have a operations api as "/providers/Microsoft.Authorization/operations"
  - suppress: OperationIdNounConflictingModelNames
    where: '$.paths["/providers/Microsoft.Authorization/providerOperations/{resourceProviderNamespace}"].get.operationId'
    from: authorization-ProviderOperationsCalls.json
    reason: the full operationId value is "ProviderOperationsMetadata_Get" the linter does not seem to be picking what's after the '_'
  - suppress: OperationIdNounConflictingModelNames
    where: '$.paths["/providers/Microsoft.Authorization/providerOperations"].get.operationId'
    from: authorization-ProviderOperationsCalls.json
    reason: the full operationId value is "ProviderOperationsMetadata_List" the linter does not seem to be picking what's after the '_'
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.RoleAssignmentFilter.properties.canDelegate
    from: authorization-RoleAssignmentsCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.RoleAssignmentPropertiesWithScope.properties.canDelegate
    from: authorization-RoleAssignmentsCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.RoleAssignmentProperties.properties.canDelegate
    from: authorization-RoleAssignmentsCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.ProviderOperation.properties.isDataAction
    from: authorization-ProviderOperationsCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DenyAssignmentProperties.properties.doNotApplyToChildScopes
    from: authorization-DenyAssignmentGetCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DenyAssignmentProperties.properties.isSystemProtected
    from: authorization-DenyAssignmentGetCalls.json
    reason: for this case the result of the proposed change would resemble a boolean anyways
```

### Tag: package-2020-04-preview

These settings apply only when `--tag=package-2020-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
- Microsoft.Authorization/preview/2020-04-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2015-07-01

These settings apply only when `--tag=package-2015-07-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-01'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json
```

### Tag: package-2015-06-01-preview

These settings apply only when `--tag=package-2015-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
```

### Tag: package-2017-10-01-preview-only

These settings apply only when `--tag=package-2017-10-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json
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
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2018-01-01-preview

These settings apply only when `--tag=package-2018-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
```

### Tag: package-2018-07-01-preview

These settings apply only when `--tag=package-2018-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
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
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-authorization --default-api-version=2018-09-01-preview
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

See configuration in [readme.java.md](./readme.java.md)

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json

```

If there are files that should not be in the `all-api-versions` set,
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```
