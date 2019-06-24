# Subscriptions Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Subscriptions Admin.

---
## Getting Started
To build the SDK for Subscriptions Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Subscriptions API.

``` yaml
title: SubscriptionClient
description: Subscription Management Client
openapi-type: arm
tag: package-2015-11-01
```

## Suppression
``` yaml
directive:
  - suppress: XmsResourceInPutResponse
    reason: Subscription is not modelled as ARM resource in azure for legacy reasons. In Azure stack as well, Subscription is not modelled as ARM resource for azure consistency
    where:
      - $.paths["/subscriptions/{subscriptionId}"].put

  - suppress: R3023
    reason: No operations endpoint as not ARM resource provider.

  - suppress: SubscriptionIdParameterInOperations
    reason: Subscription is the main resource in the API spec and it should not be masked in global parameters.
    where:
      - $.paths["/subscriptions/{subscriptionId}"].get.parameters[0]
      - $.paths["/subscriptions/{subscriptionId}"].put.parameters[0]
      - $.paths["/subscriptions/{subscriptionId}"].delete.parameters[0]

  - suppress: BodyTopLevelProperties
    reason: Subscription is not modelled as ARM resource in azure for legacy reasons. In Azure stack as well, Subscription is not modelled as ARM resource for azure consistency.
    where:
      - $.definitions.Subscription.properties

  - suppress: RequiredPropertiesMissingInResourceModel
    reason: Subscription is not modelled as ARM resource in azure for legacy reasons. In Azure stack as well, Subscription is not modelled as ARM resource for azure consistency.
    where:
      - $.definitions.Subscription

```

### Tag: package-2015-11-01

These settings apply only when `--tag=package-2015-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-01'
input-file:
    - Microsoft.Subscriptions/preview/2015-11-01/Subscriptions.json
    - Microsoft.Subscriptions/preview/2015-11-01/Offer.json
```

---
# Code Generation

## C#

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Subscription
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
```

### Tag: package-2015-11-01 and python

These settings apply only when `--tag=package-2015-11-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-01' && $(python)
namespace: azure.mgmt.subscriptions.v2015_06_01_preview
```
