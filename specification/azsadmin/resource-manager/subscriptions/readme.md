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
title: SubscriptionsAdminClient
description: Subscriptions Admin Client
openapi-type: arm
tag: package-2015-11-01
```


## Suppression
``` yaml
directive:
  - suppress: XmsResourceInPutResponse
    reason: Subscription and Location are not modelled as ARM resources in azure for legacy reasons. In Azure stack as well, Subscription and Location are not modelled as ARM resource for azure consistency
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{subscription}"].put
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/subscriptions/{targetSubscriptionId}/acquiredPlans/{planAcquisitionId}"].put
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/locations/{location}"].put

  - suppress: SubscriptionIdParameterInOperations
    reason: Subscription is the main resource in the API spec and it should not be masked in global parameters.
    where:
      - $.paths[\"/subscriptions/{subscriptionId}\"].get.parameters[0]
      - $.paths[\"/subscriptions/{subscriptionId}\"].put.parameters[0]
      - $.paths[\"/subscriptions/{subscriptionId}\"].delete.parameters[0]

  - suppress: BodyTopLevelProperties
    reason: Subscription is not modelled as ARM resource in azure for legacy reasons. In Azure stack as well, Subscription is not modelled as ARM resource for azure consistency.
    where:
      - $.definitions.Subscription.properties
      - $.definitions.PlanAcquisition.properties
      - $.definitions.Location.properties

  - suppress: RequiredPropertiesMissingInResourceModel
    reason: Subscription is not modelled as ARM resource in azure for legacy reasons. In Azure stack as well, Subscription is not modelled as ARM resource for azure consistency.
    where:
      - $.definitions.Subscription
      - $.definitions.PlanAcquisition
      - $.definitions.Location

  - suppress: OperationIdNounVerb
    reason: Subscriptions is both the name of the module and the operation action name.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/moveSubscriptions"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscriptions.Admin/validateMoveSubscriptions"].post.operationId
```

### Tag: package-2015-11-01

These settings apply only when `--tag=package-2015-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-01'
input-file:
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Subscriptions.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/AcquiredPlan.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProvider.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProviderOffer.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/DirectoryTenant.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Location.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Offer.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/OfferDelegation.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Plan.json
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Quota.json
```

---
# Code Generation

## C# 

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Subscriptions.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```