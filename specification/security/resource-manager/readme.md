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

## Suppression

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
  - suppress: PageableOperation
    from: alertTypes.json
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/iotSecuritySolutions/{solutionName}/alertTypes"].get'
    reason: The list returns limited number of items
  - suppress: PageableOperation
    from: recommendationTypes.json
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/iotSecuritySolutions/{solutionName}/recommendationTypes"].get'
    reason: The list returns limited number of items
  - suppress: PageableOperation
    from: iotDefenderSettings.json
    where: '$.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Security/iotDefenderSettings"].get'
    reason: The list returns limited number of items
  - suppress: PageableOperation
    from: iotSensors.json
    where: '$.paths["/{scope}/providers/Microsoft.Security/iotSensors/{iotSensorName}"].get'
    reason: The list returns limited number of items
  - suppress: PageableOperation
    from: onPremiseIotSensors.json
    where: '$.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Security/onPremiseIotSensors"].get'
    reason: The list returns limited number of items
  - suppress: TopLevelResourcesListByResourceGroup
    from: onPremiseIotSensors.json
    where: $.definitions.OnPremiseIotSensor
    reason: The resource is managed in a subscription level (instead of inside a resource group)
```

### Basic Information

These are the global settings for the Security API.

``` yaml
title: SecurityCenter
description: API spec for Microsoft.Security (Azure Security Center) resource provider
openapi-type: arm
tag: package-composite-v4
```

## Composite packages

The following packages may be composed from multiple api-versions.


### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

``` yaml $(tag) == 'package-composite-v1'
input-file:
- Microsoft.Security/preview/2020-01-01-preview/secureScore.json
- Microsoft.Security/preview/2020-01-01-preview/connectors.json
- Microsoft.Security/preview/2019-01-01-preview/automations.json
- Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2017-08-01-preview/pricings.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
- Microsoft.Security/preview/2017-08-01-preview/settings.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/preview/2015-06-01-preview/alerts.json
- Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
- Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/topologies.json
- Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
- Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
- Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v2

These settings apply only when `--tag=package-composite-v2` is specified on the command line.

``` yaml $(tag) == 'package-composite-v2'
input-file:
- Microsoft.Security/preview/2020-01-01-preview/secureScore.json
- Microsoft.Security/preview/2020-01-01-preview/connectors.json
- Microsoft.Security/preview/2019-01-01-preview/automations.json
- Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/stable/2018-06-01/pricings.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
- Microsoft.Security/preview/2017-08-01-preview/settings.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
- Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/stable/2019-01-01/alerts.json
- Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
- Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/topologies.json
- Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
- Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
- Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v3

These settings apply only when `--tag=package-composite-v3` is specified on the command line.

``` yaml $(tag) == 'package-composite-v3'
input-file:
- Microsoft.Security/stable/2017-08-01/complianceResults.json
- Microsoft.Security/stable/2018-06-01/pricings.json
- Microsoft.Security/stable/2019-01-01/settings.json
- Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
- Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
- Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
- Microsoft.Security/stable/2019-08-01/iotAlerts.json
- Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
- Microsoft.Security/stable/2019-08-01/iotRecommendations.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/automations.json
- Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
- Microsoft.Security/stable/2019-01-01/alerts.json
- Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json
- Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
- Microsoft.Security/stable/2020-01-01/assessments.json
- Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
- Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
- Microsoft.Security/stable/2020-01-01/allowedConnections.json
- Microsoft.Security/stable/2020-01-01/topologies.json
- Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
- Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
- Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/secureScore.json
- Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
- Microsoft.Security/preview/2020-01-01-preview/connectors.json
- Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
- Microsoft.Security/preview/2020-08-06-preview/iotSensors.json
- Microsoft.Security/preview/2020-08-06-preview/devices.json
- Microsoft.Security/preview/2020-08-06-preview/onPremiseIotSensors.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v4

These settings apply only when `--tag=package-composite-v4` is specified on the command line.

``` yaml $(tag) == 'package-composite-v4'
input-file:
- Microsoft.Security/stable/2017-08-01/complianceResults.json
- Microsoft.Security/stable/2018-06-01/pricings.json
- Microsoft.Security/stable/2019-01-01/settings.json
- Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
- Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
- Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
- Microsoft.Security/stable/2019-08-01/iotAlerts.json
- Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
- Microsoft.Security/stable/2019-08-01/iotRecommendations.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/automations.json
- Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
- Microsoft.Security/stable/2020-01-01/alerts.json
- Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json
- Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
- Microsoft.Security/stable/2020-01-01/assessments.json
- Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
- Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
- Microsoft.Security/stable/2020-01-01/allowedConnections.json
- Microsoft.Security/stable/2020-01-01/topologies.json
- Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
- Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
- Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/secureScore.json
- Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
- Microsoft.Security/preview/2020-01-01-preview/connectors.json
- Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
- Microsoft.Security/preview/2020-08-06-preview/iotSensors.json
- Microsoft.Security/preview/2020-08-06-preview/devices.json
- Microsoft.Security/preview/2020-08-06-preview/onPremiseIotSensors.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2015-06-preview-only

These settings apply only when `--tag=package-2015-06-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2015-06-preview-only'
input-file:
- Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
- Microsoft.Security/preview/2015-06-01-preview/alerts.json
- Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
- Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
- Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/preview/2015-06-01-preview/topologies.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-preview-only

These settings apply only when `--tag=package-2017-08-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2017-08-preview-only'
input-file:
- Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
- Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
- Microsoft.Security/preview/2017-08-01-preview/pricings.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/settings.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-preview-only

These settings apply only when `--tag=package-2019-01-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-preview-only'
input-file:
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
- Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
- Microsoft.Security/preview/2019-01-01-preview/assessments.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-preview-only

These settings apply only when `--tag=package-2020-01-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-preview-only'
input-file:
- Microsoft.Security/preview/2020-01-01-preview/secureScore.json
- Microsoft.Security/preview/2020-01-01-preview/connectors.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-only

These settings apply only when `--tag=package-2017-08-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2017-08-only'
input-file:
- Microsoft.Security/stable/2017-08-01/complianceResults.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2018-06-only

These settings apply only when `--tag=package-2018-06-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2018-06-only'
input-file:
- Microsoft.Security/stable/2018-06-01/pricings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-only

These settings apply only when `--tag=package-2019-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-01-only'
input-file:
- Microsoft.Security/stable/2019-01-01/alerts.json
- Microsoft.Security/stable/2019-01-01/settings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-08-only

These settings apply only when `--tag=package-2019-08-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2019-08-only'
input-file:
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
- Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
- Microsoft.Security/stable/2019-08-01/iotAlerts.json
- Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
- Microsoft.Security/stable/2019-08-01/iotRecommendations.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-preview-only

These settings apply only when `--tag=package-2020-01-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-package-2020-01-preview-only'
input-file:
- Microsoft.Security/preview/2020-01-01-preview/secureScore.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-01-only

These settings apply only when `--tag=package-2020-01-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-01-only'
input-file:
- Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
- Microsoft.Security/stable/2020-01-01/allowedConnections.json
- Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
- Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
- Microsoft.Security/stable/2020-01-01/assessments.json
- Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
- Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json
- Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
- Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json	
- Microsoft.Security/stable/2020-01-01/topologies.json
- Microsoft.Security/stable/2020-01-01/secureScore.json
- Microsoft.Security/stable/2020-01-01/alerts.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2020-08-preview-only

These settings apply only when `--tag=package-2020-08-preview-only` is specified on the command line. This tag is used for Ruby SDK.

``` yaml $(tag) == 'package-2020-08-preview-only'
input-file:
- Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
- Microsoft.Security/preview/2020-08-06-preview/iotSensors.json
- Microsoft.Security/preview/2020-08-06-preview/devices.json
- Microsoft.Security/preview/2020-08-06-preview/onPremiseIotSensors.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
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
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js security/resource-manager
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

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

