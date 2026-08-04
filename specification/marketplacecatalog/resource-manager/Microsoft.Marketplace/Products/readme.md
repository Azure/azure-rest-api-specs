# Marketplace Discovery Authenticated Products

> see https://aka.ms/autorest
This is the AutoRest configuration file for marketplaceproducts.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the marketplacecatalog.

```yaml
openapi-type: arm
tag: package-2025-05-01
```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - stable/2025-05-01/openapi.json

suppressions:
- code: BodyTopLevelProperties
  from: openapi.json
  where: $.definitions.ProductDetails
  reason: Existing fields in current APIs
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/products/{productId}"].get.parameters
  reason: Required query parameters for proxy 
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/products/{productId}"].get.parameters
  reason: Required query parameters for proxy 
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Marketplace/products/{productId}"].get.parameters
  reason: Required query parameters for proxy 
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/products/{productId}"].get.parameters
  reason: Required query parameters for proxy 
- code: GetCollectionResponseSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/products"]
  reason: We returned a more detailed response that can't be aggregated in the listing API
- code: GetCollectionResponseSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/products"]
  reason: We returned a more detailed response that can't be aggregated in the listing API
- code: GetCollectionResponseSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Marketplace/products"]
  reason: We returned a more detailed response that can't be aggregated in the listing API
- code: GetCollectionResponseSchema
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/products"]
  reason: We returned a more detailed response that can't be aggregated in the listing API
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.BillingComponent.properties.customMeterIds
  reason: Using records that generate this automatically
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.ProductDetails.properties.additionalProductProperties
  reason: Using records that generate this automatically
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.ProductSummary.properties.linkedAddInsTypes
  reason: Using records that generate this automatically
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.ProductSummaryListResult
  reason: false positive on paging
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.ProductDetails
  reason: The detailed response already returning existing API does not have these fields populated
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/products"].get
  reason: Doesn't generate in TypeSpec compiler version 1.3 - issue with nested Pageables
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/products"].get
  reason: Doesn't generate in TypeSpec compiler version 1.3 - issue with nested Pageables  
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/providers/Microsoft.Marketplace/products"].get
  reason: Doesn't generate in TypeSpec compiler version 1.3 - issue with nested Pageables  
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/products"].get
  reason: Doesn't generate in TypeSpec compiler version 1.3 - issue with nested Pageables  
```