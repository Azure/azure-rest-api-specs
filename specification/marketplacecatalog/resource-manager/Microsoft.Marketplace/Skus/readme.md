# Marketplace Catalog Skus

> see https://aka.ms/autorest

This is the AutoRest configuration file for Marketplace Catalog Skus.

## Configuration

### Basic Information

This is a TypeSpec project so we only want the readme to the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation. It isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

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
  - code: RequiredPropertiesMissingInResourceModel
    from: openapi.json
    where: $.definitions.SkuSummaryListResult
    reason: SkuSummaryListResult is a paged collection model, not an ARM resource. It does not need id, name, or type properties.
  - code: RequiredPropertiesMissingInResourceModel
    from: openapi.json
    where: $.definitions.SkuSummary
    reason: SkuSummary is a read-only catalog data model representing marketplace SKU metadata, not a tracked ARM resource.
  - code: BodyTopLevelProperties
    from: openapi.json
    where: $.definitions.SkuSummary
    reason: SkuSummary response is a proxy resource model
  - code: PathForTrackedResourceTypes
    from: openapi.json
    where: $.paths["/providers/Microsoft.Marketplace/skus/{skuId}"]
    reason: Sku is a proxy resource
  - code: PathForTrackedResourceTypes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Marketplace/skus/{skuId}"]
    reason: Sku is a proxy resource
  - code: PathForTrackedResourceTypes
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/skus/{skuId}"]
    reason: Sku is a proxy resource
  - code: PathForTrackedResourceTypes
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/skus/{skuId}"]
    reason: Sku is a proxy resource
  - code: ParametersInPointGet
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/skus/{skuId}"].get.parameters
    reason: Required query parameters for proxy
  - code: ParametersInPointGet
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/skus/{skuId}"].get.parameters
    reason: Required query parameters for proxy
  - code: GetCollectionResponseSchema
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/providers/Microsoft.Marketplace/skus"]
    reason: List returns SkuSummary (lightweight) while individual GET returns SkuDetails (with availabilities). The richer individual response cannot be aggregated in the listing API.
  - code: GetCollectionResponseSchema
    from: openapi.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.Marketplace/skus"]
    reason: List returns SkuSummary (lightweight) while individual GET returns SkuDetails (with availabilities). The richer individual response cannot be aggregated in the listing API.
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Availability
    reason: Using records that generate this automatically
  - code: RequiredPropertiesMissingInResourceModel
    from: openapi.json
    where: $.definitions.SkuDetails
    reason: SkuDetails is a read-only catalog data model representing marketplace SKU metadata, not a tracked ARM resource. It does not need id, name, or type properties.
  - code: BodyTopLevelProperties
    from: openapi.json
    where: $.definitions.SkuDetails
    reason: Existing fields in current APIs
```
