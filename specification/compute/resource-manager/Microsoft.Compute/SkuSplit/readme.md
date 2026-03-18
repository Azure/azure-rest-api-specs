# AzureComputeSkuSplitClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureComputeSkuSplitClient.

---

## Getting Started

To build the SDK for AzureComputeSkuSplitClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureComputeSkuSplitClient API.

``` yaml !$(python) || !$(track2)
title: ComputeSkuSplitResourceProviderClient
```

``` yaml
description: The Compute SkuSplit Resource Provider Client
openapi-type: arm
tag: package-2026-04-01-preview

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: SkuSplitRP.json
  - code: PathForResourceAction
    reason: The mixPlacementScores singleton resource uses a custom path structure matching the Recommender pattern.
    from: SkuSplitRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/mixPlacementScores/skuMixPlacement/generate"]
  - code: PathForNestedResource
    reason: The mixPlacementScores singleton resource uses a custom path structure matching the Recommender pattern.
    from: SkuSplitRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/mixPlacementScores/skuMixPlacement"]
```

### Tag: package-2026-04-01-preview

These settings apply only when `--tag=package-2026-04-01-preview` is specified on the command line

``` yaml $(tag) == 'package-2026-04-01-preview'
input-file:
- preview/2026-04-01-preview/SkuSplitRP.json
```
