# Billing

> see https://aka.ms/autorest

This is the AutoRest configuration file for Billing.

---

## Getting Started

To build the SDK for Billing, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Billing API.

```yaml
openapi-type: arm
tag: package-2024-04
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
title: BillingManagementClient
description: Billing Client
input-file:
- stable/2024-04-01/openapi.json
suppressions:
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}"].patch.responses.200
  reason: Brownfield service already in production + Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}"].patch.responses.200
  reason: Brownfield service already in production + Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ProvisioningStateSpecifiedForLROPut
  from: openapi.json
  reason: Brownfield service already in production + Billing Resources are tenant resources that are not provisioned under a subscription.
- code: LroExtension
  from: openapi.json
  reason: Brownfield service already in production + Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ParametersInPointGet
  from: openapi.json
  reason: Brownfield service that already shipped expand on GETs.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.BillingProperty
  reason: BillingProperty is singleton with resource id default.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.SubscriptionPolicy
  reason: SubscriptionPolicy is singleton with resource id default.
- code: TenantLevelAPIsNotAllowed
  from: openapi.json
  reason: This entire RP is a tenant level resource provider.
- code: ParameterNotUsingCommonTypes
  from: openapi.json
  reason: subscriptionId param cannot use common parameter types because the segment name must be billingSubscriptions, not subscriptions.
- code: ParameterNotDefinedInGlobalParameters
  from: openapi.json
  reason: subscriptionId param cannot use common parameter types because the segment name must be billingSubscriptions, not subscriptions.
- code: PatchBodyParametersSchema
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. When updating an address, the full address object, not just a few properties of it, are expected to be present.
- code: ParametersSchemaAsTypeObject
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/addPaymentTerms"].post.parameters[2].schema.type
  reason: Previously ARM approved before TypeSpec. The request body is an array of payment terms.
- code: ParametersSchemaAsTypeObject
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/cancelPaymentTerms"].post.parameters[2].schema.type
  reason: Previously ARM approved before TypeSpec. The request body is a date-time value.
- code: ParametersSchemaAsTypeObject
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/downloadDocuments"].post.parameters[2].schema.type
  reason: Previously ARM approved before TypeSpec. The request body is an array of document download requests.
- code: ParametersSchemaAsTypeObject
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/validatePaymentTerms"].post.parameters[2].schema.type
  reason: Previously ARM approved before TypeSpec. The request body is an array of payment terms.
- code: ParametersSchemaAsTypeObject
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/default/billingSubscriptions/{subscriptionId}/downloadDocuments"].post.parameters[2].schema.type
  reason: Previously ARM approved before TypeSpec. The request body is an array of document download requests.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: SummaryAndDescriptionMustNotBeSame
  from: openapi.json
  reason: Previously ARM approved before TypeSpec.
- code: OperationIdNounConflictingModelNames
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. Do not want this kind of breaking change.
- code: PostOperationIdContainsUrlVerb
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. Verbs are more specific to the hierarchy of the billing role assignment being added. Address_Validate feels more natural than Address_ValidateAddress.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}"].put
  reason: Previously ARM approved before TypeSpec. Is returning 200, 201, and 202 for LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}"].put
  reason: Previously ARM approved before TypeSpec. Is returning 200, 201, and 202 for LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptionAliases/{aliasName}"].put
  reason: Previously ARM approved before TypeSpec. Is returning 200, 201, and 202 for LRO.
- code: ListInOperationName
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. Most are resolveBillingRoleAssignments which can find multiple role assignments. ValidateTransfer can find multiple validation results.
- code: ParametersInPost
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. Most are resolveBillingRoleAssignments, so filter parameters are necessary. DownloadInvoice, the documentName parameter is literally the invoice to download.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, PartnerTransferDetails.
- code: PutInOperationName
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/transfers/{transferName}"].put.operationId
  reason: Previously ARM approved before TypeSpec. Do not want to take breaking change.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, TransferDetails.
- code: PutInOperationName
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/transfers/{transferName}"].put.operationId
  reason: Previously ARM approved before TypeSpec. Do not want to take breaking change.
- code: PostResponseCodes
  from: openapi.json
  reason: Previously ARM approved before TypeSpec.
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/transactionSummary"].get
  reason: Previously ARM approved before TypeSpec. This isn't a list response.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/transactionSummary"].get.operationId
  reason: Previously ARM approved before TypeSpec. Operation name Transactions_GetTransactionSummaryByInvoice makes sense for a Get.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/transactionsDownload"].post.operationId
  reason: Previously ARM approved before TypeSpec. Operation Transactions_TransactionsDownloadByInvoice name makes sense for an action.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}/reservations"].get.operationId
  reason: Previously ARM approved before TypeSpec. Operation Reservations_ListByReservationOrder name makes sense for a list get.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}/reservations/{reservationId}"].get.operationId
  reason: Previously ARM approved before TypeSpec. Operation Reservations_GetByReservationOrder name makes sense for a list get.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans"].get.operationId
  reason: Previously ARM approved before TypeSpec. Operation SavingsPlans_ListBySavingsPlanOrder name makes sense for a list get.
- code: PathForTrackedResourceTypes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}/reservations/{reservationId}"]
  reason: Previously ARM approved before TypeSpec. Not a tracked resource.
- code: TrackedResourcesMustHavePut
  from: openapi.json
  where: $.definitions.Reservation
  reason: Previously ARM approved before TypeSpec. Not a tracked resource.
- code: AllTrackedResourcesMustHaveDelete
  from: openapi.json
  where: $.definitions.Reservation
  reason: Previously ARM approved before TypeSpec. Not a tracked resource.
- code: SubscriptionIdParameterInOperations
  from: openapi.json
  reason: Previously ARM approved before TypeSpec. The subscriptionId parameter used is for a billing subscription, not an Azure subscription.
- code: ArmResourcePropertiesBag
  from: openapi.json
  where: $.definitions.Department
  reason: Previously ARM approved before TypeSpec. Do not want to take a breaking change.
- code: ArmResourcePropertiesBag
  from: openapi.json
  where: $.definitions.PaymentMethod
  reason: Previously ARM approved before TypeSpec. Do not want to take a breaking change.
- code: ArmResourcePropertiesBag
  from: openapi.json
  where: $.definitions.BillingRequest
  reason: Previously ARM approved before TypeSpec. Do not want to take a breaking change.
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.BillingSubscriptionAliasProperties.properties.billingPolicies
  reason: Previously ARM approved before TypeSpec. billingPolicies property is already in production as a dictionary by design.
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.BillingSubscriptionProperties.properties.billingPolicies
  reason: Previously ARM approved before TypeSpec. billingPolicies property is already in production as a dictionary by design.
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.BillingRequestProperties.properties.additionalInformation
  reason: Previously ARM approved before TypeSpec. Billing Request additionalInformation property is already in production as a dictionary by design.
- code: XmsIdentifierValidation
  from: openapi.json
  where: $.definitions.BillingPermissionListResult.properties.value
  reason: Previously ARM approved before TypeSpec. Array items in the response are not objects, just string arrays.
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.BillingPermissionListResult
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.TransactionSummary
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.PartnerTransferDetails
  reason: Previously ARM approved before TypeSpec. A transfer is not a living resource, so it does not support delete operation.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.TransferDetails
  reason: Previously ARM approved before TypeSpec. A transfer is not a living resource, so it does not support delete operation.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.BillingProfilePolicy
  reason: Previously ARM approved before TypeSpec. Policies by design cannot be deleted, are system policies that can be toggled or read.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.BillingSubscriptionAlias
  reason: Previously ARM approved before TypeSpec. A Billing Subscription Alias is not a distinct resource, just another means to reference a billing subscription.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.BillingAccountPolicy
  reason: Previously ARM approved before TypeSpec. Policies by design cannot be deleted, are system policies that can be toggled or read.
- code: AllProxyResourcesShouldHaveDelete
  from: openapi.json
  where: $.definitions.BillingRequest
  reason: Previously ARM approved before TypeSpec. Billing requests do not get deleted. They still exist but expire over time.
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
title: BillingManagementClient
description: Billing Client
input-file:
  - stable/2021-10-01/billingSubscription.json
  - stable/2021-10-01/payment.json
directive:
  - suppress: R4009
    from: stable/2021-10-01/billingSubscription.json
    reason: systemData is not in this API version
  - suppress: R4009
    from: stable/2021-10-01/payment.json
    reason: systemData is not in this API version
```

### Tag: package-2020-05

These settings apply only when `--tag=package-2020-05` is specified on the command line.

```yaml $(tag) == 'package-2020-05'
input-file:
  - stable/2020-05-01/billing.json
  - preview/2018-03-01-preview/billingV2.json
  - stable/2020-05-01/billingOperations.json
```

### Tag: package-2020-09-preview

These settings apply only when `--tag=package-2020-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-09-preview'
input-file:
  - stable/2020-05-01/billing.json
  - preview/2020-09-01-preview/billingPromotions.json
  - preview/2020-09-01-preview/billingOperations.json
```

### Tag: package-2024-08-preview

These settings apply only when `--tag=package-2024-08-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-preview'
input-file:
  - preview/2024-08-01-preview/migration.json
  - preview/2024-08-01-preview/operation.json
  - preview/2024-08-01-preview/types.json
suppressions:
  - code: PutResponseCodes
    from: migration.json
    reason: 201 is returned as a part of response
  - code: PutRequestResponseSchemeArm
    from: migration.json
    reason: PATCH operation is not needed
  - code: OperationsApiSchemaUsesCommonTypes
    from: operation.json
    reason: Service design that generates API definition. Type defined in local types.json
  - code: TenantLevelAPIsNotAllowed
    reason: Specific validation rules do not apply to this service. Microsoft.Billing is a tenant level RP
```

### Tag: package-2020-11-preview

These settings apply only when `--tag=package-2020-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-11-preview'
input-file:
  - stable/2020-05-01/billing.json
  - preview/2020-11-01-preview/billingPromotions.json
  - preview/2020-11-01-preview/billingOperations.json
```

### Tag: package-2019-10-preview

These settings apply only when `--tag=package-2019-10-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-10-preview'
input-file:
  - preview/2019-10-01-preview/billing.json
```

### Tag: package-2018-11-preview

These settings apply only when `--tag=package-2018-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-11-preview'
input-file:
  - preview/2018-11-01-preview/billing.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-03-preview'
input-file:
  - preview/2018-03-01-preview/billing.json
```

### Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2017-04-preview'
input-file:
  - preview/2017-04-24-preview/billing.json
```

### Tag: package-2017-02-preview

These settings apply only when `--tag=package-2017-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2017-02-preview'
input-file:
  - preview/2017-02-27-preview/billing.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_billing']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.billing
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-billing
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-10
  - tag: package-2020-05
  - tag: package-2019-10-preview
  - tag: package-2018-11-preview
  - tag: package-2018-03-preview
  - tag: package-2017-04-preview
  - tag: package-2017-02-preview
```

### Tag: package-2021-10 and java

These settings apply only when `--tag=package-2021-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2021-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2021_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-05 and java

These settings apply only when `--tag=package-2020-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2020-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-10-preview and java

These settings apply only when `--tag=package-2019-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2019-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2019_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2019_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-11-preview and java

These settings apply only when `--tag=package-2018-11-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2018-11-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2018_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2018_11_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-preview and java

These settings apply only when `--tag=package-2018-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2018-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2018_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2018_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-04-preview and java

These settings apply only when `--tag=package-2017-04-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2017-04-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2017_04_24_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2017_04_24_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-02-preview and java

These settings apply only when `--tag=package-2017-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2017-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.billing.v2017_02_27_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/billing/mgmt-v2017_02_27_preview
regenerate-manager: true
generate-interface: true
```
