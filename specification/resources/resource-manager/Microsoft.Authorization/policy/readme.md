# Policy

> see https://aka.ms/autorest

This is the AutoRest configuration file.

## Getting Started

To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Resource API.

``` yaml
title: PolicyClient
description: Policy Client
openapi-type: arm
tag: package-policy-2025-03-stable
```

### Tag: package-policy-2025-03-stable

These settings apply only when `--tag=package-policy-2025-03-stable` is specified on the command line.

```yaml $(tag) == 'package-policy-2025-03-stable'
input-file:
  - stable/2025-03-01/openapi.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2025-01

These settings apply only when `--tag=package-policy-2025-01` is specified on the command line.

```yaml $(tag) == 'package-policy-2025-01'
input-file:
- stable/2025-01-01/policyDefinitions.json
- stable/2025-01-01/policyDefinitionVersions.json
- stable/2025-01-01/policySetDefinitions.json
- stable/2025-01-01/policySetDefinitionVersions.json
- stable/2025-01-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2024-12-preview

These settings apply only when `--tag=package-policy-2024-12-preview` is specified on the command line.

```yaml $(tag) == 'package-policy-2024-12-preview'
input-file:
- preview/2024-12-01-preview/policyExemptions.json
- preview/2024-12-01-preview/policyVariables.json
- preview/2024-12-01-preview/policyVariableValues.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2024-05

These settings apply only when `--tag=package-policy-2024-05` is specified on the command line.

```yaml $(tag) == 'package-policy-2024-05'
input-file:
- stable/2024-05-01/policyDefinitions.json
- stable/2024-05-01/policyDefinitionVersions.json
- stable/2024-05-01/policySetDefinitions.json
- stable/2024-05-01/policySetDefinitionVersions.json
- stable/2024-05-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2024-04

These settings apply only when `--tag=package-policy-2024-04` is specified on the command line.

```yaml $(tag) == 'package-policy-2024-04'
input-file:
  - stable/2024-04-01/policyAssignments.json
```


### Tag: package-policy-2023-04

These settings apply only when `--tag=package-policy-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-policy-2023-04'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2023-04-01/policyDefinitions.json
- stable/2023-04-01/policyDefinitionVersions.json
- stable/2023-04-01/policySetDefinitions.json
- stable/2023-04-01/policySetDefinitionVersions.json
- stable/2023-04-01/policyAssignments.json
- preview/2022-07-01-preview/policyExemptions.json
- preview/2022-08-01-preview/policyVariables.json
- preview/2022-08-01-preview/policyVariableValues.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2023-04-only

These settings apply only when `--tag=package-policy-2023-04-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2023-04-only'
input-file:
  - stable/2023-04-01/policyDefinitions.json
  - stable/2023-04-01/policyDefinitionVersions.json
  - stable/2023-04-01/policySetDefinitions.json
  - stable/2023-04-01/policySetDefinitionVersions.json
  - stable/2023-04-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2022-08-preview-only

These settings apply only when `--tag=package-policy-2022-08-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2022-08-preview-only'
input-file:
- preview/2022-08-01-preview/policyVariables.json
- preview/2022-08-01-preview/policyVariableValues.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2022-07-preview-only

These settings apply only when `--tag=package-policy-2022-07-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2022-07-preview-only'
input-file:
- preview/2022-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2022-06-only

These settings apply only when `--tag=package-policy-2022-06-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2022-06-only'
input-file:
- stable/2022-06-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2022-06

These settings apply only when `--tag=package-policy-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2022-06'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2021-06-01/policyDefinitions.json
- stable/2021-06-01/policySetDefinitions.json
- stable/2022-06-01/policyAssignments.json
- preview/2022-07-01-preview/policyExemptions.json
- preview/2022-08-01-preview/policyVariables.json
- preview/2022-08-01-preview/policyVariableValues.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2021-06

These settings apply only when `--tag=package-policy-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2021-06'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2021-06-01/policyAssignments.json
- stable/2021-06-01/policyDefinitions.json
- stable/2021-06-01/policySetDefinitions.json
- preview/2020-07-01-preview/policyExemptions.json
- preview/2022-08-01-preview/policyVariables.json
- preview/2022-08-01-preview/policyVariableValues.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2021-06-only

These settings apply only when `--tag=package-policy-2021-06-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2021-06-only'
input-file:
- stable/2021-06-01/policyAssignments.json
- stable/2021-06-01/policyDefinitions.json
- stable/2021-06-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2020-09

These settings apply only when `--tag=package-policy-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-09'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2020-09-01/policyAssignments.json
- stable/2020-09-01/policyDefinitions.json
- stable/2020-09-01/policySetDefinitions.json
- preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2020-09-only

These settings apply only when `--tag=package-policy-2020-09-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-09-only'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2020-09-01/policyAssignments.json
- stable/2020-09-01/policyDefinitions.json
- stable/2020-09-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2020-03

These settings apply only when `--tag=package-policy-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-03'
input-file:
- stable/2020-03-01/policyAssignments.json
- stable/2020-03-01/policyDefinitions.json
- stable/2020-03-01/policySetDefinitions.json
- preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2020-07-preview-only

These settings apply only when `--tag=package-policy-2020-07-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-07-preview-only'
input-file:
- preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2019-09

These settings apply only when `--tag=package-policy-2019-09` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-09'
input-file:
- stable/2019-09-01/policyAssignments.json
- stable/2019-09-01/policyDefinitions.json
- stable/2019-09-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2019-06

These settings apply only when `--tag=package-policy-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-06'
input-file:
- stable/2019-06-01/policyAssignments.json
- stable/2019-06-01/policyDefinitions.json
- stable/2019-06-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2019-01

These settings apply only when `--tag=package-policy-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-01'
input-file:
- stable/2019-01-01/policyAssignments.json
- stable/2019-01-01/policyDefinitions.json
- stable/2019-01-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2018-05

These settings apply only when `--tag=package-policy-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-policy-2018-05'
input-file:
- stable/2018-05-01/policyAssignments.json
- stable/2018-05-01/policyDefinitions.json
- stable/2018-05-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2018-03

These settings apply only when `--tag=package-policy-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-policy-2018-03'
input-file:
- stable/2018-03-01/policyAssignments.json
- stable/2018-03-01/policyDefinitions.json
- stable/2018-03-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2017-06

These settings apply only when `--tag=package-policy-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2017-06'
input-file:
- preview/2017-06-01-preview/policyAssignments.json
- preview/2017-06-01-preview/policySetDefinitions.json
- stable/2016-12-01/policyDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-pure-policy-2017-06

These settings apply only when `--tag=package-pure-policy-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-pure-policy-2017-06'
input-file:
- preview/2017-06-01-preview/policyAssignments.json
- preview/2017-06-01-preview/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2017-06-preview-only

These settings apply only when `--tag=package-policy-2017-06-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-policy-2017-06-preview-only'
input-file:
- preview/2017-06-01-preview/policyAssignments.json
- preview/2017-06-01-preview/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-12

These settings apply only when `--tag=package-policy-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-12'
input-file:
- stable/2016-12-01/policyDefinitions.json
- stable/2016-12-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-04

These settings apply only when `--tag=package-policy-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-04'
input-file:
- stable/2016-04-01/policy.json
```

### Tag: package-policy-2015-10

These settings apply only when `--tag=package-policy-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-policy-2015-10'
input-file:
- preview/2015-10-01-preview/policy.json
```

## Suppression

``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: policySetDefinitions.json
    reason: policy set definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: openapi.json
    reason: policy set definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyDefinitions.json
    reason: policy definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: openapi.json
    reason: policy definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyAssignments.json
    reason: policy assignment under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: openapi.json
    reason: policy assignment under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyExemptions.json
    where: $.paths
    reason: policy exemption under an extension resource with Microsoft.Management
  - suppress: OperationsAPIImplementation
    from: policyAssignments.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyDefinitions.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyDefinitionVersions.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policySetDefinitions.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policySetDefinitionVersions.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyExemptions.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyVariables.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyVariableValues.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: openapi.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: BodyTopLevelProperties
    from: policyAssignments.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: openapi.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: policyDefinitions.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: openapi.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: policyDefinitionVersions.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: openapi.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: policySetDefinitions.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: openapi.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: policySetDefinitionVersions.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: openapi.json
    reason: Currently systemData is not allowed. Lint bug - collection GET result contains value and nextLink properties.
  - suppress: BodyTopLevelProperties
    from: policyExemptions.json
    where: $.definitions.PolicyExemption.properties
    reason: Currently systemData is not allowed
  - suppress: BodyTopLevelProperties
    from: openapi.json
    where: $.definitions.PolicyExemption.properties
    reason: Currently systemData is not allowed
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: dataPolicyManifests.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DataManifestCustomResourceFunctionDefinition.properties.allowCustomProperties
    from: dataPolicyManifests.json
    reason: 'This property can only have two values. '
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DataPolicyManifestProperties.properties.isBuiltInOnly
    from: dataPolicyManifests.json
    reason: 'This property can only have two values. '
  - suppress: PageableOperation
    where: '$.paths["/providers/Microsoft.Authorization/dataPolicyManifests"].get'
    from: dataPolicyManifests.json
    reason: Pagination not supported. The size of the result list is pretty limited
  - suppress: TopLevelResourcesListByResourceGroup
    from: policyDefinitions.json
    reason: Policy definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: openapi.json
    reason: Policy definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: policyVariables.json
    reason: Policy variables are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: openapi.json
    reason: Policy variables are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: policyVariableValues.json
    reason: Policy variable values are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: openapi.json
    reason: Policy variable values are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: policySetDefinitions.json
    reason: Policy set definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: openapi.json
    reason: Policy set definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: PathForTrackedResourceTypes
    from: policyAssignments.json
    reason: Not a tracked resource type. The API has never been changed since inception. Would be a breaking change.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyDefinitions.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyDefinitionVersions.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policySetDefinitions.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policySetDefinitionVersions.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyAssignments.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyExemptions.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyVariables.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: TenantLevelAPIsNotAllowed
    from: policyVariableValues.json
    reason: Linter rule limitation. The API has always supported management group scope.
  - suppress: EvenSegmentedPathForPutOperation
    from: policyAssignments.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: PutResponseCodes
    from: policyDefinitions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: PutResponseCodes
    from: policySetDefinitions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: PutResponseCodes
    from: policyAssignments.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: AvoidAdditionalProperties
    from: policyDefinitions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: AvoidAdditionalProperties
    from: policyDefinitionVersions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: AvoidAdditionalProperties
    from: policySetDefinitions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: AvoidAdditionalProperties
    from: policySetDefinitionVersions.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: AvoidAdditionalProperties
    from: policyAssignments.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: PathForPutOperation
    from: policyDefinitions.json
    reason: Policy definitions can be created at management group or subscriptions
  - suppress: PathForPutOperation
    from: policySetDefinitions.json
    reason: Policy sets can be created at management group or subscriptions
  - suppress: PathForPutOperation
    from: policyAssignments.json
    reason: Policy assignments can be created at management group or subscriptions
  - suppress: PathForPutOperation
    from: policyDefinitionVersions.json
    reason: Policy definition versions can be created at management group or subscriptions
  - suppress: PathForPutOperation
    from: policySetDefinitionVersions.json
    reason: Policy set versions can be created at management group or subscriptions
  - suppress: DeleteResponseBodyEmpty
    from: policyAssignments.json
    reason: Policy assignment body is returned on delete and this must match API
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: policyAssignments.json
    reason: Policy assignments are not tracked resources
  - suppress: RepeatedPathInfo
    from: policyAssignments.json
    reason: Service requires the scope to be in the body
  - suppress: PutResponseSchemaDescription
    from: policyAssignments.json
    reason: Service only returns 201 on all successful PUTs
  - suppress: PutResponseSchemaDescription
    from: policyDefinitions.json
    reason: Service only returns 201 on all successful PUTs
  - suppress: PutResponseSchemaDescription
    from: policySetDefinitions.json
    reason: Service only returns 201 on all successful PUTs
  - suppress: UnSupportedPatchProperties
    from: policyAssignments.json
    reason: The location property represents the user-assigned identity location and is changeable for policy assignments
  - suppress: PathContainsResourceType
    from: policyAssignments.json
    reason: The policy assignment id does contain the resource type
  - suppress: ResourceNameRestriction
    from: policyDefinitionVersions.json
    reason: Using common types for management group name
  - suppress: ResourceNameRestriction
    from: policySetDefinitionVersions.json
    reason: Using common types for management group name
  - suppress: ResourceNameRestriction
    from: policyExemptions.json
    reason: Using common types for management group name
  - suppress: ResourceNameRestriction
    from: policyVariables.json
    reason: Using common types for management group name
  - suppress: ResourceNameRestriction
    from: policyVariableValues.json
    reason: Using common types for management group name
  - suppress: ParametersInPointGet
    from: policyAssignments.json
    reason: "This is for specific properties that require extra processing to produce so only want to return on demand."
  - suppress: ParametersInPointGet
    from: policySetDefinitions.json
    reason: "This is for specific properties that require extra processing to produce so only want to return on demand."
  - suppress: ParametersInPointGet
    from: policySetDefinitionVersions.json
    reason: "This is for specific properties that require extra processing to produce so only want to return on demand."
  - suppress: TrackedExtensionResourcesAreNotAllowed
    from: policyAssignments.json
    reason: "Policy assignments can have a manged identity associated with them. This requires a location."
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
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
