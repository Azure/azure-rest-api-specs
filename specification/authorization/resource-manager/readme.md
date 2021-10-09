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
tag: package-2020-10-01-preview
```

### Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: we do have a operations api as "/providers/Microsoft.Authorization/operations"
  - suppress: TopLevelResourcesListByResourceGroup
    reason: proxy resources don't require list by resource group (Suppression confirmed by API council)
  - suppress: OperationIdNounConflictingModelNames
    where: '$.paths["/providers/Microsoft.Authorization/providerOperations/{resourceProviderNamespace}"].get.operationId'
    from: authorization-ProviderOperationsCalls.json
    reason: the full operationId value is "ProviderOperationsMetadata_Get" the linter does not seem to be picking what's after the '_'
  - suppress: OperationIdNounConflictingModelNames
    where: '$.paths["/providers/Microsoft.Authorization/providerOperations"].get.operationId'
    from: authorization-ProviderOperationsCalls.json
    reason: the full operationId value is "ProviderOperationsMetadata_List" the linter does not seem to be picking what's after the '_'
  - suppress: EnumInsteadOfBoolean
    reason: booleans are only used when the values reduce to true or false
  - suppress: R4024
    reason: Preview versions still in use
  - suppress: RequiredSystemDataInNewApiVersions
    reason: Existing APIs don't have this attribute. Suppressing so that we don't have to make changes to existing APIs
  - suppress: RequiredReadOnlySystemData
    reason: Existing APIs don't have this attribute. Suppressing so that we don't have to make changes to existing APIs
  - suppress: XmsPathsMustOverloadPaths
    from: authorization-RoleDefinitionsCalls.json
    reason: x-ms-paths extension was previously required. Suppressing so that we don't have to make changes to existing APIs.
  - suppress: AddedPropertyInResponse
    from: authorization-AccessReviewCalls.json
    reason: API documentation is not exposed yet. We're making some small changes before publishing documentation.
  - suppress: AddingOptionalProperty
    from: authorization-AccessReviewCalls.json
    reason: API documentation is not exposed yet. We're making some small changes before publishing documentation.
  - suppress: R1003
    from: EligibleChildResources.json
    reason: Fixing warning would create a breaking change
  - suppress: R1006
    from: authorization-AccessReviewCalls.json
    reason: Fixing warning would create a breaking change
  - suppress: R1007
    from: authorization-AccessReviewCalls.json
    reason: Fixing warning would create a breaking change
  - suppress: R2017
    from: authorization-AccessReviewCalls.json
    reason: Request body is a subset of response body. Additional properties in the response are not settable by the user
  - suppress: R2063
    from: authorization-AccessReviewCalls.json
    reason: Disambiguation resolution is acceptable and desired. When generating the models the _Suffix doesn't get included
  - suppress: R2015
    from: common-types.json
    reason: common-types doesn't need to reference api version.
```

### Tag: package-2021-07-01-preview-only

These settings apply only when `--tag=package-2021-07-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2021-07-01-preview/authorization-AccessReviewCalls.json
```

### Tag: package-2021-03-01-preview-only

These settings apply only when `--tag=package-2021-03-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2021-03-01-preview/authorization-AccessReviewCalls.json
```

### Tag: package-2021-01-01-preview-only

These settings apply only when `--tag=package-2021-01-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2021-01-01-preview/authorization-RoleAssignmentApprovalCalls.json
```

### Tag: package-2020-10-01-preview

These settings apply only when `--tag=package-2020-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01-preview'
input-file:
- Microsoft.Authorization/preview/2018-05-01-preview/authorization-AccessReviewCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2020-10-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2019-08-01-preview/authorization-UsageMetricsCalls.json
- Microsoft.Authorization/preview/2020-10-01-preview/common-types.json
- Microsoft.Authorization/preview/2020-10-01-preview/EligibleChildResources.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentSchedule.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentScheduleInstance.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentScheduleRequest.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilitySchedule.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilityScheduleInstance.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilityScheduleRequest.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleManagementPolicy.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleManagementPolicyAssignment.json
```

### Tag: package-2020-10-01-preview-only

These settings apply only when `--tag=package-2020-10-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2020-10-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2020-10-01-preview/common-types.json
- Microsoft.Authorization/preview/2020-10-01-preview/EligibleChildResources.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentSchedule.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentScheduleInstance.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleAssignmentScheduleRequest.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilitySchedule.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilityScheduleInstance.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleEligibilityScheduleRequest.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleManagementPolicy.json
- Microsoft.Authorization/preview/2020-10-01-preview/RoleManagementPolicyAssignment.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2020-08-01-preview

These settings apply only when `--tag=package-2020-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
- Microsoft.Authorization/preview/2019-08-01-preview/authorization-UsageMetricsCalls.json
- Microsoft.Authorization/preview/2020-08-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2020-04-01-preview

These settings apply only when `--tag=package-2020-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
- Microsoft.Authorization/preview/2019-08-01-preview/authorization-UsageMetricsCalls.json
- Microsoft.Authorization/preview/2020-04-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2020-04-01-preview-only

These settings apply only when `--tag=package-2020-04-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2020-04-01-preview/authorization-RoleAssignmentsCalls.json
```

### Tag: package-2020-03-01-preview

These settings apply only when `--tag=package-2020-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview'
input-file:
- Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
- Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
- Microsoft.Authorization/preview/2020-03-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2019-08-01-preview/authorization-UsageMetricsCalls.json
```

### Tag: package-2019-08-01-preview-only

These settings apply only when `--tag=package-2019-08-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-08-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2019-08-01-preview/authorization-UsageMetricsCalls.json
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

### Tag: package-2018-09-01-preview-only

These settings apply only when `--tag=package-2018-09-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json
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

### Tag: package-2018-07-01-preview-only

These settings apply only when `--tag=package-2018-07-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
```

### Tag: package-2018-05-01-preview

These settings apply only when `--tag=package-2018-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-01-preview'
input-file:
- Microsoft.Authorization/preview/2018-05-01-preview/authorization-AccessReviewCalls.json
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

### Tag: package-2018-01-01-preview-only

These settings apply only when `--tag=package-2018-01-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
- Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
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

### Tag: package-2017-10-01-preview-only

These settings apply only when `--tag=package-2017-10-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-01-preview-only'
input-file:
- Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json
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

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_authorization']
  - repo: azure-resource-manager-schemas
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Python

See configuration in [readme.python.md](./readme.python.md)
