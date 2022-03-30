# Security Insight

> see https://aka.ms/autorest

This is the AutoRest configuration file for SecurityInsights.

---

## Getting Started

To build the SDK for SecurityInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the SecurityInsights API.

``` yaml
openapi-type: arm
tag: package-preview-2022-01
```

---


### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/operations.json
```
### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/operations.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
- Microsoft.SecurityInsights/preview/2021-09-01-preview/AlertRules.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/AutomationRules.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Bookmarks.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Enrichment.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/EntityQueries.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Entities.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Incidents.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Metadata.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/OnboardingStates.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Settings.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/SourceControls.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Watchlists.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/dataConnectors.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/ThreatIntelligence.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/operations.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/OfficeConsents.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/EntityQueryTemplates.json
```

---

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.SecurityInsights/stable/2021-10-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2021-10-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2021-10-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2021-10-01/operations.json
  - Microsoft.SecurityInsights/stable/2021-10-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2021-10-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2021-10-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2021-10-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2021-10-01/AutomationRules.json
```

### Tag: package-2021-04-01-only

These settings apply only when `--tag=package-2021-04-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01-only'
input-file:
- Microsoft.SecurityInsights/stable/2021-04-01/Incidents.json
- Microsoft.SecurityInsights/stable/2021-04-01/operations.json
- Microsoft.SecurityInsights/stable/2021-04-01/Watchlists.json
- Microsoft.SecurityInsights/stable/2021-04-01/ThreatIntelligence.json
```

---

### Tag: package-2020-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01'
input-file:
- Microsoft.SecurityInsights/stable/2020-01-01/AlertRules.json
- Microsoft.SecurityInsights/stable/2020-01-01/Bookmarks.json
- Microsoft.SecurityInsights/stable/2020-01-01/DataConnectors.json
- Microsoft.SecurityInsights/stable/2020-01-01/SecurityInsights.json
```

---

### Tag: package-2021-03-preview-only

These settings apply only when `--tag=package-2021-03-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-preview-only'
input-file:
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Incidents.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Settings.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/OnboardingStates.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/operations.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/SourceControls.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/dataConnectors.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Watchlists.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/AlertRules.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/EntityQueries.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/EntityQueryTemplates.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Metadata.json
```

---

### Tag: package-2019-01-preview

These settings apply only when `--tag=package-2019-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-preview'
input-file:
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Aggregations.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/AutomationRules.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Bookmarks.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Cases.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/DataConnectorsCheckRequirements.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Enrichment.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Entities.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/OfficeConsents.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/SecurityInsights.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/ThreatIntelligence.json
```

---

## Suppression

``` yaml
directive:
  - suppress: R4017
    reason: Our resources do not support list by subscription. They're not top-level resources. To get a SecurityInsights resource, we should have a subscription as well as a resource group and Log Analytics workspace.
  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    reason: 'Caused by a duplicate Resource definition in our common directory that contains systemData. We were instructed to supress this by Swagger reviewr.'
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
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-java
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.SecurityInsights
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/securityinsights/Microsoft.Azure.Management.SecurityInsights/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
