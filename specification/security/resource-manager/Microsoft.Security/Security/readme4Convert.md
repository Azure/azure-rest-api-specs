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
tag: PrivateLinks.Management
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Assessment.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Assessment.Management'
input-file:
  - stable/2025-05-04/assessmentMetadata.json
  - stable/2025-05-04/assessments.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Governance.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Governance.Management'
input-file:
  - preview/2022-01-01-preview/governanceAssignments.json
  - preview/2022-01-01-preview/governanceRules.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Settings.management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Settings.management'
input-file:
  - stable/2022-05-01/settings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecuritySolutions.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecuritySolutions.Management'
input-file:
  - stable/2020-01-01/allowedConnections.json
  - stable/2020-01-01/discoveredSecuritySolutions.json
  - stable/2020-01-01/externalSecuritySolutions.json
  - stable/2020-01-01/jitNetworkAccessPolicies.json
  - stable/2020-01-01/SecuritySolutions.json
  - stable/2020-01-01/securitySolutionsReferenceData.json
  - stable/2020-01-01/serverVulnerabilityAssessments.json
  - stable/2020-01-01/topologies.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecureScore.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecureScore.Management'
input-file:
  - stable/2020-01-01/secureScore.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: PrivateLinks.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'PrivateLinks.Management'
input-file:
  - stable/2026-01-01/privateLinks.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: DefenderForStorage.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'DefenderForStorage.Management'
input-file:
  - preview/2025-09-01-preview/defenderForStorageSettings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Standards.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Standards.Management'
input-file:
  - preview/2021-08-01-preview/standards.json
  - preview/2021-08-01-preview/assignments.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecurityStandards.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecurityStandards.Management'
input-file:
  - stable/2024-08-01/securityStandards.json
  - stable/2024-08-01/standardAssignments.json
  - stable/2024-08-01/customRecommedations.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Pricings.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Pricings.Management'
input-file:
  - stable/2024-01-01/pricings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: ApiCollections.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'ApiCollections.Management'
input-file:
  - stable/2023-11-15/apiCollections.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: ServerVulnerabilityAssessmentsSettings.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'ServerVulnerabilityAssessmentsSettings.Management'
input-file:
  - stable/2023-05-01/ServerVulnerabilityAssessmentsSettings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Alerts.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Alerts.Management'
input-file:
  - stable/2022-01-01/alerts.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: IoTSecurity.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'IoTSecurity.Management'
input-file:
  - stable/2019-08-01/deviceSecurityGroups.json
  - stable/2019-08-01/iotSecuritySolutionAnalytics.json
  - stable/2019-08-01/iotSecuritySolutions.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: ATPSettings.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'ATPSettings.Management'
input-file:
  - stable/2019-01-01/advancedThreatProtectionSettings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: ComplianceResults.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'ComplianceResults.Management'
input-file:
  - stable/2017-08-01/complianceResults.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Operations.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Operations.Management'
input-file:
  - preview/2025-10-01-preview/operations.json
  - preview/2025-10-01-preview/operationResults.json
  - preview/2025-10-01-preview/operationStatuses.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecurityConnectorsDevOps.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecurityConnectorsDevOps.Management'
input-file:
  - preview/2025-11-01-preview/securityConnectorsDevOps.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecurityConnectors.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecurityConnectors.Management'
input-file:
  - preview/2024-08-01-preview/securityConnectors.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Automations.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Automations.Management'
input-file:
  - preview/2023-12-01-preview/automations.json
  - preview/2023-12-01-preview/securityContacts.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: HealthReports.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'HealthReports.Management'
input-file:
  - preview/2023-05-01-preview/healthReports.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SensitivitySettings.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SensitivitySettings.Management'
input-file:
  - preview/2023-02-15-preview/sensitivitySettings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SensitivitySettings.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SensitivitySettings.Management'
input-file:
  - preview/2023-02-15-preview/sensitivitySettings.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SqlVulnerabilityAssessments.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SqlVulnerabilityAssessments.Management'
input-file:
  - preview/2026-04-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
  - preview/2026-04-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
  - preview/2026-04-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
  - preview/2026-04-01-preview/sqlVulnerabilityAssessmentsSettingsOperations.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: SecurityOperators.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'SecurityOperators.Management'
input-file:
  - preview/2023-01-01-preview/securityOperators.json
```

### Composite packages

The following packages may be composed from multiple api-versions.


### Tag: Applications.Management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'Applications.Management'
input-file:
  - preview/2022-07-01-preview/applications.json
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

### Tag: LegacySettings.management

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'LegacySettings.management'
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
