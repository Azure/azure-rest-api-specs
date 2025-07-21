# AzureComputeRecommenderClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureComputeRecommenderClient.

---

## Getting Started

To build the SDK for AzureComputeRecommenderClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureComputeRecommenderClient API.

``` yaml !$(python) || !$(track2)
title: AzureComputeRecommenderManagementClient
```

``` yaml
description: Azure Compute Recommender Client
openapi-type: arm
tag: package-2025-02-01-preview

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: RecommenderRP.json
  - code: PathForResourceAction
    reason: This is not a valid scenario for the diskInspection and spotPlacementRecommender API as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: RecommenderRP.json
  - code: PathForNestedResource
    reason: This is not a valid scenario for the diskInspection and spotPlacementRecommender API as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: RecommenderRP.json
  - code: XmsPageableForListCalls
    reason: False positive error as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: RecommenderRP.json
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property name contains abbreviations and need to keep it as upper case.
    from: RecommenderRP.json
  - code: BodyTopLevelProperties
    reason: The is the additional property bag to introduce new nonbreaking properties.
    from: RecommenderRP.json

```

### Tag: package-2025-02-01-preview

These settings apply only when `--tag=package-package-2025-02-01-preview` is specified on the command line

``` yaml $(tag) == 'package-2025-02-01-preview'
input-file:
- preview/2025-02-01-preview/RecommenderRP.json
```
