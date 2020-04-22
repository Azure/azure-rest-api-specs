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
```

### Basic Information

These are the global settings for the Security API.

``` yaml
title: SecurityCenter
description: API spec for Microsoft.Security (Azure Security Center) resource provider
openapi-type: arm
tag: package-composite-v3
```

## Composite packages

The following packages may be composed from multiple api-versions.

### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

``` yaml $(tag) == 'package-composite-v1'
input-file:
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

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-composite-v2

These settings apply only when `--tag=package-composite-v2` is specified on the command line.

``` yaml $(tag) == 'package-composite-v2'
input-file:
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
- Microsoft.Security/stable/2019-01-01/alerts.json
- Microsoft.Security/stable/2019-01-01/settings.json
- Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
- Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
- Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
- Microsoft.Security/preview/2015-06-01-preview/locations.json
- Microsoft.Security/preview/2015-06-01-preview/operations.json
- Microsoft.Security/preview/2015-06-01-preview/tasks.json
- Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
- Microsoft.Security/preview/2017-08-01-preview/compliances.json
- Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
- Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
- Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2019-01-01-preview/serverVulnerabilityAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/automations.json
- Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
- Microsoft.Security/stable/2020-01-01/assessments.json
- Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
- Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
- Microsoft.Security/stable/2020-01-01/allowedConnections.json
- Microsoft.Security/stable/2020-01-01/topologies.json
- Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2015-06-preview-only

These settings apply only when `--tag=package-2015-06-preview-only` is specified on the command line.

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

These settings apply only when `--tag=package-2017-08-preview-only` is specified on the command line.

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

These settings apply only when `--tag=package-2019-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-preview-only'
input-file:
- Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
- Microsoft.Security/preview/2019-01-01-preview/serverVulnerabilityAssessments.json
- Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
- Microsoft.Security/preview/2019-01-01-preview/assessments.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2017-08-only

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-only'
input-file:
- Microsoft.Security/stable/2017-08-01/complianceResults.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2018-06-only

These settings apply only when `--tag=package-2018-06-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-only'
input-file:
- Microsoft.Security/stable/2018-06-01/pricings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-01-only

These settings apply only when `--tag=package-2019-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-only'
input-file:
- Microsoft.Security/stable/2019-01-01/alerts.json
- Microsoft.Security/stable/2019-01-01/settings.json

# Needed when there is more than one input file
override-info:
  title: SecurityCenter
```

### Tag: package-2019-08-only

These settings apply only when `--tag=package-2019-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-08-only'
input-file:
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
- Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json

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

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/automations.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/pricings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/compliances.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/settings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/operations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/locations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/tasks.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/alerts.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/topologies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
  - $(this-folder)/Microsoft.Security/stable/2018-06-01/pricings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/alerts.json
  - $(this-folder)/Microsoft.Security/stable/2017-08-01/complianceResults.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/settings.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/serverVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/assessments.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/allowedConnections.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/topologies.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/assessments.json

```

If there are files that should not be in the `all-api-versions` set,
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```