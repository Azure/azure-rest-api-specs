# DeploymentScripts

> see https://aka.ms/autorest
This is the AutoRest configuration file.

## Getting Started

To build the SDKs, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings.

``` yaml
title: DeploymentScriptsClient
description: DeploymentScripts Client
openapi-type: arm
tag: package-2023-08
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
  - preview/2019-10-01-preview/deploymentScripts.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
  - stable/2020-10-01/deploymentScripts.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - stable/2023-08-01/deploymentScripts.json
```

## Suppression

``` yaml
directive:
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - suppress: IntegerTypeMustHaveFormat
    from: deploymentScripts.json
    reason: Tooling issue, default is int32, explicitly mentioning the format as per doc, it still flags breaking change.
  - suppress: ResourceNameRestriction
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PropertiesTypeObjectNoDefinition
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SubscriptionsAndResourceGroupCasing
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ParametersInPointGet
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PatchIdentityProperty
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroErrorContent
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPut
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - from: deploymentScripts.json
    suppress: R3006
    where:
      - $.definitions.DeploymentScript.properties
      - $.definitions.AzureCliScript.properties
      - $.definitions.AzurePowerShellScript.properties
    reason: Currently systemData is not allowed
  - suppress: OperationsAPIImplementation
    from: deploymentScripts.json
    reason: Operations API is implemented as a separate service.
  - suppress: XmsPageableForListCalls
    from: deploymentScripts.json
    reason: Pre-existing lint error.
  - suppress: AvoidAdditionalProperties
    from: deploymentScripts.json
    reason: Pre-existing lint error.
  - suppress: MissingTypeObject
    from: deploymentScripts.json
    reason: Pre-existing lint error.
```