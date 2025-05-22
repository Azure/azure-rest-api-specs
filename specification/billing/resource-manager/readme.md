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

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
title: BillingManagementClient
description: Billing Client
input-file:
- Microsoft.Billing/stable/2024-04-01/agreement.json
- Microsoft.Billing/stable/2024-04-01/associatedTenant.json
- Microsoft.Billing/stable/2024-04-01/availableBalance.json
- Microsoft.Billing/stable/2024-04-01/billingAccount.json
- Microsoft.Billing/stable/2024-04-01/billingPermission.json
- Microsoft.Billing/stable/2024-04-01/billingProfile.json
- Microsoft.Billing/stable/2024-04-01/billingProperty.json
- Microsoft.Billing/stable/2024-04-01/billingRequest.json
- Microsoft.Billing/stable/2024-04-01/billingRoleAssignment.json
- Microsoft.Billing/stable/2024-04-01/billingRoleDefinition.json
- Microsoft.Billing/stable/2024-04-01/billingSavingsPlan.json
- Microsoft.Billing/stable/2024-04-01/billingSubscription.json
- Microsoft.Billing/stable/2024-04-01/customer.json
- Microsoft.Billing/stable/2024-04-01/department.json
- Microsoft.Billing/stable/2024-04-01/enrollmentAccount.json
- Microsoft.Billing/stable/2024-04-01/invoice.json
- Microsoft.Billing/stable/2024-04-01/invoiceSection.json
- Microsoft.Billing/stable/2024-04-01/operation.json
- Microsoft.Billing/stable/2024-04-01/payment.json
- Microsoft.Billing/stable/2024-04-01/policy.json
- Microsoft.Billing/stable/2024-04-01/product.json
- Microsoft.Billing/stable/2024-04-01/reservation.json
- Microsoft.Billing/stable/2024-04-01/transaction.json
- Microsoft.Billing/stable/2024-04-01/transfers.json
- Microsoft.Billing/stable/2024-04-01/types.json
suppressions:
- code: AllProxyResourcesShouldHaveDelete
  from: billingRequest.json
  reason: Service design forces behavior
- code: AllProxyResourcesShouldHaveDelete
  from: billingSubscription.json
  reason: Service design forces behavior
- code: AllProxyResourcesShouldHaveDelete
  from: policy.json
  reason: Service design forces behavior
- code: AllProxyResourcesShouldHaveDelete
  from: transfers.json
  reason: Service design forces behavior
- code: AllTrackedResourcesMustHaveDelete
  from: reservation.json
  reason: Breaking change
- code: AvoidAdditionalProperties
  from: billingRequest.json
  reason: Service design forces behavior
- code: AvoidAdditionalProperties
  from: billingSavingsPlan.json
  reason: False positive. Used for "tags"
- code: AvoidAdditionalProperties
  from: billingSubscription.json
  reason: Breaking change
- code: AvoidAdditionalProperties
  from: reservation.json
  reason: False positive. Used for "tags"
- code: AvoidAnonymousTypes
  from: policy.json
  reason: Service design forces behavior
- code: EnumInsteadOfBoolean
  from: associatedTenant.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingAccount.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingProfile.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingProperty.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingRoleAssignment.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingSavingsPlan.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: billingSubscription.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: enrollmentAccount.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: invoice.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: invoiceSection.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: operation.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: product.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: reservation.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: transaction.json
  reason: Breaking Change
- code: EnumInsteadOfBoolean
  from: types.json
  reason: Breaking Change
- code: EvenSegmentedPathForPutOperation
  from: policy.json
  reason: False positive
- code: GetCollectionOnlyHasValueAndNextLink
  from: billingSavingsPlan.json
  reason: Blocked on resolving this issue by wide adoption of partner services
- code: GetCollectionOnlyHasValueAndNextLink
  from: billingSubscription.json
  reason: Breaking change
- code: GetCollectionOnlyHasValueAndNextLink
  from: reservation.json
  reason: Breaking change
- code: GetCollectionOnlyHasValueAndNextLink
  from: transaction.json
  reason: Breaking change
- code: ListInOperationName
  from: billingRoleAssignment.json
  reason: Breaking Change
- code: ListInOperationName
  from: transfers.json
  reason: Breaking Change
- code: LroErrorContent
  reason: Service design that generates API definition. Type defined in local types.json
- code: OperationIdNounConflictingModelNames
  from: billingProperty.json
  reason: Breaking Change
- code: OperationIdNounConflictingModelNames
  from: billingRoleDefinition.json
  reason: Breaking Change
- code: OperationIdNounVerb
  from: billingSavingsPlan.json
  reason: False positive. SavingsPlan is a child resource of SavingsPlanOrder
- code: OperationIdNounVerb
  from: reservation.json
  reason: False positive. Reservations can be a child resource of ReservationOrder.
- code: OperationIdNounVerb
  from: transaction.json
  reason: False positive. TransactionSummary is an aggregation of transactions.
- code: OperationsApiSchemaUsesCommonTypes
  from: operation.json
  reason: Service design that generates API definition. Type defined in local types.json
- code: ParametersInPointGet
  reason: Service design forces this behavior
- code: ParametersInPost
  from: billingAccount.json
  reason: Breaking change
- code: ParametersInPost
  from: billingRoleAssignment.json
  reason: Service design forces this behavior
- code: ParametersInPost
  from: invoice.json
  reason: Breaking Change
- code: ParameterNotDefinedInGlobalParameters
  reason: Referenced in common types.json file
- code: ParameterNotUsingCommonTypes
  reason: Service design forces this behavior
- code: PathForTrackedResourceTypes
  from: reservation.json
  reason: Breaking change
- code: PostOperationIdContainsUrlVerb
  from: billingAccount.json
  reason: Breaking Change
- code: PostOperationIdContainsUrlVerb
  from: billingRoleAssignment.json
  reason: Breaking Change
- code: PutInOperationName
  from: transfers.json
  reason: Breaking Change
- code: PutRequestResponseSchemeArm
  from: transfers.json
  reason: Design ensures only recipients choose products, not initiators, for security and access reasons. 
- code: PutResponseCodes
  from: billingProfile.json
  reason: Breaking change
- code: PutResponseCodes
  from: billingSubscription.json
  reason: Breaking change
- code: PutResponseCodes
  from: invoiceSection.json
  reason: Breaking change
- code: ResourceNameRestriction
  from: billingSubscription.json
  reason: Breaking change
- code: ResourceNameRestriction
  from: payment.json
  reason: Breaking change
- code: TenantLevelAPIsNotAllowed
  reason: Specific validation rules do not apply to this service. Microsoft.Billing is a tenant level RP
- code: TopLevelResourcesListBySubscription
  reason: Specific validation rules do not apply to this service. Microsoft.Billing is a tenant level RP
- code: TrackedResourcesMustHavePut
  from: reservation.json
  reason: Breaking change
- code: XmsPageableForListCalls
  from: availableBalance.json
  reason: Breaking change
- code: XmsPageableForListCalls
  from: billingProperty.json
  reason: Breaking change
- code: XmsPageableForListCalls
  from: policy.json
  reason: Breaking change
- code: XmsPageableForListCalls
  from: transaction.json
  reason: Breaking change
- code: XmsResourceInPutResponse
  from: transfers.json
  reason: Service design forces this behavior
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
title: BillingManagementClient
description: Billing Client
input-file:
  - Microsoft.Billing/stable/2021-10-01/billingSubscription.json
  - Microsoft.Billing/stable/2021-10-01/payment.json
directive:
  - suppress: R4009
    from: Microsoft.Billing/stable/2021-10-01/billingSubscription.json
    reason: systemData is not in this API version
  - suppress: R4009
    from: Microsoft.Billing/stable/2021-10-01/payment.json
    reason: systemData is not in this API version
```

### Tag: package-2020-05

These settings apply only when `--tag=package-2020-05` is specified on the command line.

```yaml $(tag) == 'package-2020-05'
input-file:
  - Microsoft.Billing/stable/2020-05-01/billing.json
  - Microsoft.Billing/preview/2018-03-01-preview/billingV2.json
  - Microsoft.Billing/stable/2020-05-01/billingOperations.json
```

### Tag: package-2020-09-preview

These settings apply only when `--tag=package-2020-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-09-preview'
input-file:
  - Microsoft.Billing/stable/2020-05-01/billing.json
  - Microsoft.Billing/preview/2020-09-01-preview/billingPromotions.json
  - Microsoft.Billing/preview/2020-09-01-preview/billingOperations.json
```

### Tag: package-2020-11-preview

These settings apply only when `--tag=package-2020-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-11-preview'
input-file:
  - Microsoft.Billing/stable/2020-05-01/billing.json
  - Microsoft.Billing/preview/2020-11-01-preview/billingPromotions.json
  - Microsoft.Billing/preview/2020-11-01-preview/billingOperations.json
```

### Tag: package-2019-10-preview

These settings apply only when `--tag=package-2019-10-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-10-preview'
input-file:
  - Microsoft.Billing/preview/2019-10-01-preview/billing.json
```

### Tag: package-2018-11-preview

These settings apply only when `--tag=package-2018-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-11-preview'
input-file:
  - Microsoft.Billing/preview/2018-11-01-preview/billing.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-03-preview'
input-file:
  - Microsoft.Billing/preview/2018-03-01-preview/billing.json
```

### Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2017-04-preview'
input-file:
  - Microsoft.Billing/preview/2017-04-24-preview/billing.json
```

### Tag: package-2017-02-preview

These settings apply only when `--tag=package-2017-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2017-02-preview'
input-file:
  - Microsoft.Billing/preview/2017-02-27-preview/billing.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
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

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Billing
  output-folder: $(csharp-sdks-folder)/billing/Microsoft.Azure.Management.Billing/src/Generated
  clear-output-folder: true
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
