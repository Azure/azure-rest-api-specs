# Subscriptions Admin
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Subscriptions Admin. We do not ship any language SDKs for AzureStack Administrator APIs and these APIs do not exist in azure.


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
    - Microsoft.Subscriptions.Admin/preview/2015-11-01/Manifest.json
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

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Subscriptions.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/AcquiredPlan.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProvider.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProviderOffer.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DirectoryTenant.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Location.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Manifest.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Offer.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/OfferDelegation.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Plan.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Quota.json
```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file:
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```
