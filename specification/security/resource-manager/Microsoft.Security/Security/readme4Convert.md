# Security Center

> see https://aka.ms/autorest

This is the AutoRest configuration file for Security.

---

## Getting Started

To build the SDK for Security, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration



``` yaml
directive:
  - suppress: ValidFormats
    from: securityContacts.json
    where: $.definitions.SecurityContactProperties.properties.email.format
    reason: email format is allowed
  - suppress: ValidFormats
    from: automations.json
    where: $.definitions.AutomationActionLogicApp.properties.uri.format
    reason: uri format is allowed
  - suppress: PageableOperation
    from: iotSecuritySolutionAnalytics.json
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels"].get'
    reason: The list returns limited number of items
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: settings.json
    reason: Operations API has nothing to do with current additions.
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: assignments.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: standards.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: governanceRules.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: governanceAssignments.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: applications.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.Pricing
    from: pricings.json
    reason: It does have a LIST API, but it is wrapped with PricingList object.
```

``` yaml
suppressions:
  - code: ResourceNameRestriction
    from: Microsoft.Security\stable\2024-01-01\pricings.json
    reason: Old versions do not have pattern as well, and if I add a pattern to this version, I get another error about breaking the last version's pattern.
  - code: PutRequestResponseSchemeArm
    from: Microsoft.Security\stable\2024-01-01\pricings.json
    reason: The models are the same, but one is a parameter and the other is a definition! old versions of this API have the same configurations.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: Microsoft.Security\stable\2024-01-01\pricings.json
    reason: The collections is limited to 13 items maximum. No need for paging. Also old versions did not have these fields as well.
  - code: ResourceNameRestriction
    from: Microsoft.Security\preview\2024-03-01\securityConnectors.json
    reason: Old versions do not have pattern as well, and if I add a pattern to this version, I get another error about breaking the last version's pattern.
  - code: PatchBodyParametersSchema
    from: Microsoft.Security\preview\2024-03-01\securityConnectors.json
    reason: Patch uses a complex composable object model which cannot be easily split. it will be addressed in a future PR, as this occurs in previous API versions as well.
  - code: UnSupportedPatchProperties
    from: Microsoft.Security\preview\2024-03-01\securityConnectors.json
    reason: Patch uses a complex composable object model which cannot be easily split. it will be addressed in a future PR, as this occurs in previous API versions as well.
  - code: AvoidAdditionalProperties
    from: Microsoft.Security\preview\2024-03-01\securityConnectors.json
    reason: This is a property used across all API versions. changing it would be a breaking change, and is required for 
```

### Basic Information

These are the global settings for the Security API.

``` yaml
title: SecurityCenter
description: API spec for Microsoft.Security (Azure Security Center) resource provider
openapi-type: arm
tag: MdeOnboarding.Management
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: MdeOnboarding.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'MdeOnboarding.Management'
input-file:
  - preview/2021-10-01-preview/mdeOnboardings.json
```

### Tag: SubAssessments.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SubAssessments.Management'
input-file:
  - preview/2019-01-01-preview/subAssessments.json
```

### Tag: Locations.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Locations.Management'
input-file:
  - preview/2015-06-01-preview/locations.json
```

### Tag: Tasks.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Tasks.Management'
input-file:
  - preview/2015-06-01-preview/tasks.json
```

### Tag: Settings.management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Settings.management'
input-file:
  - preview/2017-08-01-preview/autoProvisioningSettings.json
  - preview/2017-08-01-preview/compliances.json
  - preview/2017-08-01-preview/informationProtectionPolicies.json
  - preview/2017-08-01-preview/workspaceSettings.json
```

### Tag: AlertsSuppressionRules.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'AlertsSuppressionRules.Management'
input-file:
  - preview/2019-01-01-preview/alertsSuppressionRules.json
```

### Tag: RegulatoryCompliance.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'RegulatoryCompliance.Management'
input-file:
  - preview/2019-01-01-preview/regulatoryCompliance.json
```