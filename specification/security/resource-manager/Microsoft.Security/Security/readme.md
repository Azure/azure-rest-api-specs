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

### Suppression

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
tag: package-composite-v3
```

### Composite packages

The following packages may be composed from multiple api-versions.

### Tag: package-2026-01

These settings apply only when `--tag=package-2026-01` is specified on the command line.

```yaml $(tag) == 'package-2026-01'
input-file:
  - stable/2026-01-01/privateLinks.json
```

### Tag: package-preview-2025-11-01-preview

These settings apply only when `--tag=package-preview-2025-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-11-01-preview'
input-file:
  - preview/2025-11-01-preview/securityConnectorsDevOps.json
```

### Tag: package-preview-2025-10-01-preview

These settings apply only when `--tag=package-preview-2025-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-10-01-preview'
input-file:
  - preview/2025-10-01-preview/operations.json
  - preview/2025-10-01-preview/operationResults.json
  - preview/2025-10-01-preview/operationStatuses.json
```

### Tag: package-preview-2025-09-01-preview

These settings apply only when `--tag=package-preview-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09-01-preview'
input-file:
  - preview/2025-09-01-preview/defenderForStorageSettings.json
  - preview/2025-09-01-preview/operations.json
  - preview/2025-09-01-preview/privateLinks.json
```

### Tag: package-preview-2025-05-04-preview

These settings apply only when `--tag=package-preview-2025-05-04-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-04-preview'
input-file:
  - preview/2025-05-04-preview/operations.json
  - preview/2025-05-04-preview/assessmentMetadata.json
  - preview/2025-05-04-preview/assessments.json
suppressions:
  - code: GetResponseCodes
    from: operationResults.json
    where:
          - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{location}/operationResults/{operationId}"].get.responses["204"]
    reason: According to the [Azure Resource Manager async API reference spec](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/async-api-reference.md), the 204 No Content response status code
      is required for polling operations when the operation has completed successfully with no content to return.
```

### Tag: package-2025-03

These settings apply only when `--tag=package-2025-03` is specified on the command line.

```yaml $(tag) == 'package-2025-03'
input-file:
  - stable/2025-03-01/securityConnectorsDevOps.json
suppressions:
  - code: LroLocationHeader
    from: securityConnectorsDevOps.json
    reason: False positive. Per ResourceProvider specification SecurityConnectors DevOps uses Azure-AsyncOperation header instead of Location header
  - code: ResourceNameRestriction
    from: securityConnectorsDevOps.json
    reason: SecurityConnectors DevOps collects data from thirdparty providers which do not always specify name patterns
  - code: GetCollectionOnlyHasValueAndNextLink
    from: securityConnectorsDevOps.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/devops/default"].get.responses["200"].schema.properties
    reason: False positive. This check flags the the API which doesn't actually return collection but a singleton.
```

### Tag: package-preview-2025-07

These settings apply only when `--tag=package-preview-2025-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07'
input-file:
  - preview/2025-07-01-preview/defenderForStorageSettings.json
  - preview/2025-07-01-preview/operations.json
```

### Tag: package-2025-06
These settings apply only when `--tag=package-2025-06` is specified on the command line.

```yaml $(tag) == 'package-2025-06'
input-file:
  - stable/2025-06-01/defenderForStorageSettings.json
  - stable/2025-06-01/operations.json
```

### Tag: package-preview-2025-02
These settings apply only when `--tag=package-preview-2025-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-02'
input-file:
  - preview/2025-02-01-preview/defenderForStorageSettings.json
```

### Tag: package-2025-01

These settings apply only when `--tag=package-2025-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01'
input-file:
  - stable/2025-01-01/defenderForStorageSettings.json
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - preview/2024-10-01-preview/defenderForStorageSettings.json
  - preview/2024-10-01-preview/operations.json
```

### Tag: package-preview-2024-08-01-preview

These settings apply only when `--tag=package-preview-2024-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-08-01-preview'
input-file:
  - preview/2024-08-01-preview/securityConnectors.json
  - preview/2024-08-01-preview/defenderForStorageSettings.json
```

### Tag: package-2024-08

These settings apply only when `--tag=package-2024-08` is specified on the command line.

``` yaml $(tag) == 'package-2024-08'
input-file:
  - stable/2024-08-01/securityStandards.json
  - stable/2024-08-01/standardAssignments.json
  - stable/2024-08-01/customRecommedations.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - preview/2024-05-15-preview/securityConnectorsDevOps.json
suppressions:
  - code: LroLocationHeader
    from: securityConnectorsDevOps.json
    reason: False positive. Per ResourceProvider specification SecurityConnectors DevOps uses Azure-AsyncOperation header instead of Location header
  - code: ResourceNameRestriction
    from: securityConnectorsDevOps.json
    reason: SecurityConnectors DevOps collects data from thirdparty providers which do not always specify name patterns
  - code: OperationsAPIImplementation
    from: securityConnectorsDevOps.json
    reason: Suppression of OperationsAPI as it doesn't apply to this specific file.
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

``` yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-01/securityConnectorsDevOps.json
suppressions:
  - code: LroLocationHeader
    from: securityConnectorsDevOps.json
    reason: False positive. Per ResourceProvider specification SecurityConnectors DevOps uses Azure-AsyncOperation header instead of Location header
  - code: ResourceNameRestriction
    from: securityConnectorsDevOps.json
    reason: SecurityConnectors DevOps collects data from thirdparty providers which do not always specify name patterns
  - code: GetCollectionOnlyHasValueAndNextLink
    from: securityConnectorsDevOps.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/devops/default"].get.responses["200"].schema.properties
    reason: False positive. This check flags the the API which doesn't actually return collection but a singleton.
```

### Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - preview/2024-07-01-preview/securityConnectors.json
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2024-03-01-preview/securityConnectors.json
```

### Tag: package-preview-2023-12

These settings apply only when `--tag=package-preview-2023-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-12'
input-file:
  - preview/2023-12-01-preview/securityContacts.json
  - preview/2023-12-01-preview/automations.json
```

### Tag: package-2023-11-15

These settings apply only when `--tag=package-2023-11-15` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-15'
input-file:
  - stable/2023-11-15/apiCollections.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-01-preview/securityConnectors.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-01-preview/securityConnectorsDevOps.json
suppressions:
  - code: LroLocationHeader
    from: securityConnectorsDevOps.json
    reason: False positive. Per ResourceProvider specification SecurityConnectors DevOps uses Azure-AsyncOperation header instead of Location header
  - code: ResourceNameRestriction
    from: securityConnectorsDevOps.json
    reason: SecurityConnectors DevOps collects data from thirdparty providers which do not always specify name patterns
  - code: GetCollectionOnlyHasValueAndNextLink
    from: securityConnectorsDevOps.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/devops/default"].get.responses["200"].schema.properties
    reason: False positive. This check flags the the API which doesn't actually return collection but a singleton.
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-01/pricings.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - preview/2023-05-01-preview/healthReports.json
```

### Tag: package-preview-2023-03-only

These settings apply only when `--tag=package-preview-2023-03-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03-only'
input-file:
  - preview/2023-03-01-preview/securityConnectors.json
```

### Tag: package-preview-2023-01-only

These settings apply only when `--tag=package-preview-2023-01-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01-only'
input-file:
  - preview/2023-01-01-preview/securityOperators.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - preview/2023-01-01-preview/securityOperators.json
  - preview/2023-03-01-preview/securityConnectors.json
```

### Tag: package-preview-2023-02-15-only

These settings apply only when `--tag=package-preview-2023-02-15-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02-15-only'
input-file:
  - preview/2023-02-15-preview/sensitivitySettings.json
```

### Tag: package-preview-2023-02-only

These settings apply only when `--tag=package-preview-2023-02-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02-only'
input-file:
  - preview/2023-02-01-preview/healthReports.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - preview/2023-02-01-preview/healthReports.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
  - preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
  - preview/2023-02-15-preview/sensitivitySettings.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - preview/2022-12-01-preview/defenderForStorageSettings.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - preview/2022-11-20-preview/apiCollections.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - preview/2022-08-01-preview/securityConnectors.json
```

### Tag: package-preview-2022-07

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-07'
input-file:
  - preview/2022-07-01-preview/applications.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - stable/2022-05-01/settings.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - preview/2022-05-01-preview/securityConnectors.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
  - stable/2021-11-01/alerts.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - stable/2022-03-01/pricings.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
  - stable/2023-01-01/pricings.json
```

### Tag: package-preview-2021-12

These settings apply only when `--tag=package-preview-2021-12-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-12'
input-file:
  - preview/2015-06-01-preview/operations.json
  - preview/2021-12-01-preview/securityConnectors.json
```

### Tag: package-preview-2021-08

These settings apply only when `--tag=package-preview-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-08'
input-file:
  - preview/2021-08-01-preview/assignments.json
  - preview/2021-08-01-preview/standards.json

override-info:
  title: SecurityCenter
```

### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

``` yaml $(tag) == 'package-composite-v1'
input-file:
- preview/2015-06-01-preview/alerts.json
- preview/2015-06-01-preview/allowedConnections.json
- preview/2015-06-01-preview/discoveredSecuritySolutions.json
- preview/2015-06-01-preview/externalSecuritySolutions.json
- preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/operations.json
- preview/2015-06-01-preview/tasks.json
- preview/2015-06-01-preview/topologies.json
- preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/deviceSecurityGroups.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/settings.json
- preview/2017-08-01-preview/workspaceSettings.json
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/automations.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json
- preview/2020-01-01-preview/secureScore.json
- preview/2020-01-01-preview/securityContacts.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
- preview/2021-05-01-preview/softwareInventories.json
- preview/2021-07-01-preview/customAssessmentAutomation.json
- preview/2021-10-01-preview/mdeOnboardings.json
- preview/2022-08-01-preview/securityConnectors.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v2

These settings apply only when `--tag=package-composite-v2` is specified on the command line.

``` yaml $(tag) == 'package-composite-v2'
input-file:
- preview/2015-06-01-preview/allowedConnections.json
- preview/2015-06-01-preview/discoveredSecuritySolutions.json
- preview/2015-06-01-preview/externalSecuritySolutions.json
- preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/operations.json
- preview/2015-06-01-preview/tasks.json
- preview/2015-06-01-preview/topologies.json
- preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/deviceSecurityGroups.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
- preview/2017-08-01-preview/iotSecuritySolutions.json
- preview/2017-08-01-preview/settings.json
- preview/2017-08-01-preview/workspaceSettings.json
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/automations.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json
- preview/2020-01-01-preview/secureScore.json
- preview/2020-01-01-preview/securityContacts.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
- preview/2021-05-01-preview/softwareInventories.json
- preview/2021-07-01-preview/customAssessmentAutomation.json
- preview/2021-10-01-preview/mdeOnboardings.json
- preview/2022-08-01-preview/securityConnectors.json
- stable/2018-06-01/pricings.json
- stable/2019-01-01/alerts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v3

These settings apply only when `--tag=package-composite-v3` is specified on the command line.

``` yaml $(tag) == 'package-composite-v3'
input-file:
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/tasks.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/workspaceSettings.json
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json
- preview/2021-05-01-preview/softwareInventories.json
- preview/2021-07-01-preview/customAssessmentAutomation.json
- preview/2021-10-01-preview/mdeOnboardings.json
- preview/2022-01-01-preview/governanceAssignments.json
- preview/2022-01-01-preview/governanceRules.json
- preview/2022-07-01-preview/applications.json
- preview/2023-01-01-preview/securityOperators.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
- preview/2023-02-15-preview/sensitivitySettings.json
- preview/2023-05-01-preview/healthReports.json
- preview/2023-12-01-preview/automations.json
- preview/2023-12-01-preview/securityContacts.json
- preview/2024-08-01-preview/securityConnectors.json
- preview/2025-05-04-preview/assessmentMetadata.json
- preview/2025-05-04-preview/assessments.json
- preview/2025-09-01-preview/defenderForStorageSettings.json
- preview/2025-11-01-preview/securityConnectorsDevOps.json
- preview/2025-10-01-preview/operations.json
- preview/2025-10-01-preview/operationResults.json
- preview/2025-10-01-preview/operationStatuses.json
- stable/2017-08-01/complianceResults.json
- stable/2019-01-01/advancedThreatProtectionSettings.json
- stable/2019-08-01/deviceSecurityGroups.json
- stable/2019-08-01/iotSecuritySolutionAnalytics.json
- stable/2019-08-01/iotSecuritySolutions.json
- stable/2020-01-01/allowedConnections.json
- stable/2020-01-01/discoveredSecuritySolutions.json
- stable/2020-01-01/externalSecuritySolutions.json
- stable/2020-01-01/jitNetworkAccessPolicies.json
- stable/2020-01-01/secureScore.json
- stable/2020-01-01/SecuritySolutions.json
- stable/2020-01-01/securitySolutionsReferenceData.json
- stable/2020-01-01/serverVulnerabilityAssessments.json
- stable/2020-01-01/topologies.json
- stable/2022-01-01/alerts.json
- stable/2022-05-01/settings.json
- stable/2023-05-01/ServerVulnerabilityAssessmentsSettings.json
- stable/2023-11-15/apiCollections.json
- stable/2024-01-01/pricings.json
- stable/2024-08-01/securityStandards.json
- stable/2024-08-01/standardAssignments.json
- stable/2024-08-01/customRecommedations.json
- stable/2026-01-01/privateLinks.json

# Autorest suppressions
suppressions:
  - code: LroLocationHeader
    from: securityConnectorsDevOps.json
    reason: False positive. Per ResourceProvider specification SecurityConnectors DevOps uses Azure-AsyncOperation header instead of Location header
  - code: ResourceNameRestriction
    from: securityConnectorsDevOps.json
    reason: SecurityConnectors DevOps collects data from thirdparty providers which do not always specify name patterns
  - code: GetCollectionOnlyHasValueAndNextLink
    from: securityConnectorsDevOps.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/devops/default"].get.responses["200"].schema.properties
    reason: False positive. This check flags the the API which doesn't actually return collection but a singleton.

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-dotnet-sdk

These settings apply only when `--tag=package-dotnet-sdk` is specified on the command line.

``` yaml $(tag) == 'package-dotnet-sdk'
input-file:
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/operations.json
- preview/2015-06-01-preview/tasks.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/workspaceSettings.json
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/automations.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json
- preview/2020-01-01-preview/securityContacts.json
- preview/2021-05-01-preview/softwareInventories.json
- preview/2021-07-01-preview/customAssessmentAutomation.json
- preview/2021-10-01-preview/mdeOnboardings.json
- preview/2022-01-01-preview/governanceAssignments.json
- preview/2022-01-01-preview/governanceRules.json
- preview/2022-07-01-preview/applications.json
- preview/2022-12-01-preview/defenderForStorageSettings.json
- preview/2023-01-01-preview/securityOperators.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2023-02-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
- preview/2023-02-15-preview/sensitivitySettings.json
- preview/2023-05-01-preview/healthReports.json
- preview/2023-10-01-preview/securityConnectors.json
- stable/2017-08-01/complianceResults.json
- stable/2019-01-01/advancedThreatProtectionSettings.json
- stable/2019-08-01/deviceSecurityGroups.json
- stable/2019-08-01/iotSecuritySolutionAnalytics.json
- stable/2019-08-01/iotSecuritySolutions.json
- stable/2020-01-01/allowedConnections.json
- stable/2020-01-01/discoveredSecuritySolutions.json
- stable/2020-01-01/externalSecuritySolutions.json
- stable/2020-01-01/jitNetworkAccessPolicies.json
- stable/2020-01-01/secureScore.json
- stable/2020-01-01/SecuritySolutions.json
- stable/2020-01-01/securitySolutionsReferenceData.json
- stable/2020-01-01/serverVulnerabilityAssessments.json
- stable/2020-01-01/topologies.json
- stable/2021-06-01/assessmentMetadata.json
- stable/2021-06-01/assessments.json
- stable/2022-01-01/alerts.json
- stable/2022-05-01/settings.json
- stable/2023-01-01/pricings.json
- stable/2023-05-01/ServerVulnerabilityAssessmentsSettings.json
- stable/2023-11-15/apiCollections.json
- stable/2024-08-01/standardAssignments.json
- stable/2024-08-01/securityStandards.json
- stable/2024-08-01/customRecommedations.json
- stable/2025-03-01/securityConnectorsDevOps.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2015-06-preview-python-only

These settings apply only when `--tag=package-2015-06-preview-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2015-06-preview-python-only'
input-file:
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/operations.json
- preview/2015-06-01-preview/tasks.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2015-06-preview-only

These settings apply only when `--tag=package-2015-06-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2015-06-preview-only'
input-file:
- preview/2015-06-01-preview/alerts.json
- preview/2015-06-01-preview/allowedConnections.json
- preview/2015-06-01-preview/discoveredSecuritySolutions.json
- preview/2015-06-01-preview/externalSecuritySolutions.json
- preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/operations.json
- preview/2015-06-01-preview/tasks.json
- preview/2015-06-01-preview/topologies.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-preview-python-only

These settings apply only when `--tag=package-2017-08-preview-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2017-08-preview-python-only'
input-file:
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/securityContacts.json
- preview/2017-08-01-preview/workspaceSettings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-preview-only

These settings apply only when `--tag=package-2017-08-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2017-08-preview-only'
input-file:
- preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/deviceSecurityGroups.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
- preview/2017-08-01-preview/iotSecuritySolutions.json
- preview/2017-08-01-preview/securityContacts.json
- preview/2017-08-01-preview/settings.json
- preview/2017-08-01-preview/workspaceSettings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-preview-python-only

These settings apply only when `--tag=package-2019-01-preview-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-preview-python-only'
input-file:
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/automations.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-preview-only

These settings apply only when `--tag=package-2019-01-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-preview-only'
input-file:
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/assessmentMetadata.json
- preview/2019-01-01-preview/assessments.json
- preview/2019-01-01-preview/regulatoryCompliance.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-preview-python-only

These settings apply only when `--tag=package-2020-01-preview-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-preview-python-only'
input-file:
- preview/2020-01-01-preview/securityContacts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-only

These settings apply only when `--tag=package-2017-08-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2017-08-only'
input-file:
- stable/2017-08-01/complianceResults.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2018-06-only

These settings apply only when `--tag=package-2018-06-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2018-06-only'
input-file:
- stable/2018-06-01/pricings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-python-only

These settings apply only when `--tag=package-2019-01-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-python-only'
input-file:
- stable/2019-01-01/advancedThreatProtectionSettings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-only

These settings apply only when `--tag=package-2019-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-only'
input-file:
- stable/2019-01-01/alerts.json
- stable/2019-01-01/settings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-08-python-only

These settings apply only when `--tag=package-2019-08-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-08-python-only'
input-file:
- stable/2019-08-01/deviceSecurityGroups.json
- stable/2019-08-01/iotSecuritySolutionAnalytics.json
- stable/2019-08-01/iotSecuritySolutions.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-08-only

These settings apply only when `--tag=package-2019-08-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-08-only'
input-file:
- stable/2019-08-01/iotAlerts.json
- stable/2019-08-01/iotAlertTypes.json
- stable/2019-08-01/iotRecommendations.json
- stable/2019-08-01/iotRecommendationTypes.json
- stable/2019-08-01/iotSecuritySolutionAnalytics.json
- stable/2019-08-01/iotSecuritySolutions.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-preview-only

These settings apply only when `--tag=package-2020-01-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-preview-only'
input-file:
- preview/2020-01-01-preview/secureScore.json
- preview/2020-01-01-preview/securityContacts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-python-only

These settings apply only when `--tag=package-2020-01-python-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-python-only'
input-file:
- stable/2020-01-01/allowedConnections.json
- stable/2020-01-01/assessmentMetadata.json
- stable/2020-01-01/assessments.json
- stable/2020-01-01/discoveredSecuritySolutions.json
- stable/2020-01-01/externalSecuritySolutions.json
- stable/2020-01-01/jitNetworkAccessPolicies.json
- stable/2020-01-01/secureScore.json
- stable/2020-01-01/SecuritySolutions.json
- stable/2020-01-01/securitySolutionsReferenceData.json
- stable/2020-01-01/serverVulnerabilityAssessments.json
- stable/2020-01-01/topologies.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-only

These settings apply only when `--tag=package-2020-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-only'
input-file:
- stable/2020-01-01/alerts.json
- stable/2020-01-01/allowedConnections.json
- stable/2020-01-01/assessmentMetadata.json
- stable/2020-01-01/assessments.json
- stable/2020-01-01/discoveredSecuritySolutions.json
- stable/2020-01-01/externalSecuritySolutions.json
- stable/2020-01-01/jitNetworkAccessPolicies.json
- stable/2020-01-01/secureScore.json
- stable/2020-01-01/SecuritySolutions.json
- stable/2020-01-01/securitySolutionsReferenceData.json
- stable/2020-01-01/serverVulnerabilityAssessments.json
- stable/2020-01-01/topologies.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-07-preview-only

These settings apply only when `--tag=package-2020-07-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-07-preview-only'
input-file:
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2020-07-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2021-01-only

These settings apply only when `--tag=package-2021-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2021-01-only'
input-file:
- stable/2021-01-01/alerts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2021-05-preview-only

These settings apply only when `--tag=package-2021-05-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2021-05-preview-only'
input-file:
- preview/2021-05-01-preview/softwareInventories.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-preview-2021-07

These settings apply only when `--tag=package-2021-07-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-preview-only'
input-file:
  - preview/2021-07-01-preview/customAssessmentAutomation.json
  - preview/2021-07-01-preview/securityConnectors.json
override-info:
  title: SecurityCenter
```

### Tag: package-preview-2021-10

These settings apply only when `--tag=package-2021-10-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-10-preview-only'
input-file:
  - preview/2021-10-01-preview/mdeOnboardings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2021-06-only

These settings apply only when `--tag=package-2021-06-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2021-06-only'
input-file:
- stable/2021-06-01/assessmentMetadata.json
- stable/2021-06-01/assessments.json
- stable/2021-06-01/settings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2021-07-only

These settings apply only when `--tag=package-2021-07-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2021-07-only'
input-file:
- stable/2021-07-01/settings.json
# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-2022-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-preview-only'
input-file:
  - preview/2022-01-01-preview/governanceAssignments.json
  - preview/2022-01-01-preview/governanceRules.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2022-01-only

These settings apply only when `--tag=package-2022-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2022-01-only'
input-file:
- stable/2022-01-01/alerts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/ServerVulnerabilityAssessmentsSettings.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-java
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
