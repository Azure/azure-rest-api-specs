# Billing benefits

> see https://aka.ms/autorest

This is the AutoRest configuration file for billingbenefits.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the billingbenefits.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-preview-2024-11-01-preview
```

### Suppression

```yaml
directive:
  - suppress: ProvisioningStateValidation
    from: billingbenefits.json
    where: $.definitions.ProvisioningState
    reason: \'Cancelled\' state is used in the service which should be equivalent to in ARM's \'Canceled\' definition ProvisioningState property.
  - suppress: PathForPutOperation
    from: billingbenefits.json
    reason: Subscription or resource group is passed in request body.
  - suppress: PatchSkuProperty
    from: billingbenefits.json
    reason: \'Sku\' is not a supported property in savings plan patch operation
  - suppress: AllResourcesMustHaveDelete
    from: billingbenefits.json
    reason: This service does not support deleting resources once created.
  - suppress: TopLevelResourcesListBySubscription
    from: billingbenefits.json
    reason: Currently only list by tenant is supported.
  - suppress: CreateOperationAsyncResponseValidation
    from: billingbenefits.json
    reason: According to ARM's guide 200 is returned when PUT call finishes.
  - suppress: TrackedResourcePatchOperation
    from: billingbenefits.json
  - suppress: TenantLevelAPIsNotAllowed
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/savingsPlanOrderAliases/{savingsPlanOrderAliasName}"]
  - suppress: ParametersInPointGet
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}"].get.parameters
  - suppress: ParametersInPointGet
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}"].get.parameters
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
  - suppress: PatchResponseCodes
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}"].patch
  - suppress: NoErrorCodeResponses
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}"].patch.responses["404"]
  - suppress: PathForTrackedResourceTypes
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/reservationOrderAliases/{reservationOrderAliasName}"]
  - suppress:  PutRequestResponseSchemeArm
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.paths["/providers/Microsoft.BillingBenefits/reservationOrderAliases/{reservationOrderAliasName}"].put
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: billingbenefits.json
    reason: False-positive. Tags property exists.
    where: $.paths["/providers/Microsoft.BillingBenefits/reservationOrderAliases/{reservationOrderAliasName}"].put
  - suppress: AvoidAdditionalProperties
    from: billingbenefits.json
    reason: Service design forces this behavior. This API will remain managed by BenefitsRP when onboarded to RPaaS. (Direct type)
    where: $.definitions.SavingsPlanModelListResult.properties
  - suppress: AllTrackedResourcesMustHaveDelete
    from: billingbenefits.json
    reason: False-positive. ReservationOrderAliasResponse is a type defintion that does not require a delete operation.
    where: $.definitions.ReservationOrderAliasResponse
  - suppress: PatchIdentityProperty
    from: billingbenefits.json
    reason: False-positive. Identity property is never defined on the model.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/discounts/{discountName}"].patch.parameters[4]
```

### Tag: package-preview-2024-11-01-preview

These settings apply only when `--tag=package-preview-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01-preview'
input-file:
  - Microsoft.BillingBenefits/preview/2024-11-01-preview/billingbenefits.json
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01'
input-file:
  - Microsoft.BillingBenefits/stable/2022-11-01/billingbenefits.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
