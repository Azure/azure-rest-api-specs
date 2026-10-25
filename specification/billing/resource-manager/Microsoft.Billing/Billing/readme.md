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

### Tag: package-2024-08-preview

These settings apply only when `--tag=package-2024-08-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-preview'
title: BillingManagementClient
description: Billing Client
input-file:
- preview/2024-08-01-preview/openapi.json
suppressions:
- code: TenantLevelAPIsNotAllowed
  from: openapi.json
  reason: Applies to every operation in this RP because this entire RP is a tenant level resource provider.
- code: ProvisioningStateSpecifiedForLROPut
  from: openapi.json
  reason: Applies to every operation in this RP because Billing Resources are tenant resources that are not provisioned under a subscription.
- code: SubscriptionIdParameterInOperations
  from: openapi.json
  reason: Applies to every operation in this RP because subscription Id in Billing's case means Billing Subscription, not Azure Subscription.
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}"].patch.responses.200
  reason: Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}"].patch.responses.200
  reason: Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/billingSubscriptions/{billingSubscriptionName}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get billing subscription is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get billing subscription is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get reservation order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}/reservations/{reservationId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get reservation order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlanOrders/{savingsPlanOrderId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get savings plan order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get savings plan is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingProperty/default"].get.parameters
  reason: Previously ARM approved before TypeSpec. Billing Property details aren't always needed and add cost to retreive.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.BillingProperty
  reason: BillingProperty is singleton with resource id default.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.SubscriptionPolicy
  reason: SubscriptionPolicy is singleton with resource id default.
- code: PatchBodyParametersSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}"].patch.parameters.2.schema.properties.properties
  reason: Previously ARM approved before TypeSpec. When updating an address, the full address object, not just a few properties of it, are expected to be present.
- code: PatchBodyParametersSchema
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingProperty/default"].patch.parameters.2.schema.properties.properties
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
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/reservations"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. ReservationSummary provides the total counts of various types in the list.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/customers/{customerName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/enrollmentAccounts/{enrollmentAccountName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/transactionSummary"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. Not a list API, gets a single resource.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/download"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. This is not a list API.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservations"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. ReservationSummary provides the total counts of various types in the list.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlans"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. SavingsPlanSummaryCount provides the total counts of various types in the list.
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
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/download"].post.parameters
  reason: Previously ARM approved before TypeSpec. The documentName parameter is the document under the invoice to download.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/default/billingSubscriptions/{subscriptionId}/invoices/{invoiceName}/download"].post.parameters
  reason: Previously ARM approved before TypeSpec. The documentName parameter is the document under the invoice to download.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}/fetchHistory"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: OperationIdNounVerb
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}/fetchHistory"].post.operationId
  reason: Previously ARM approved before TypeSpec. Preserving existing operation Id.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/listInvoiceSectionsWithCreateSubscriptionPermission"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, PartnerTransferDetails.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, TransferDetails.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/amend"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/licenseReservations/{licenseReservationName}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This doesn't appear to be an operation that can be polled and just gives you the cancellation response details.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/transferEnrollmentToMCA"].post
  reason: Previously ARM approved before TypeSpec. Synchronous operation returning 200.
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
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.BillingPermissionListResult
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.TransactionSummary
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
# New to 2024-08-01-preview
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoicingPreferences/default"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/purchaseOrderMappings/{purchaseOrderMappingName}"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/purchaseOrders/{poNumber}"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingRoleAssignments/{billingRoleAssignmentName}"].put
  reason: Previously ARM approved before TypeSpec. Is returning 200, 201, and 202 for LRO.
- code: DeleteResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingRoleAssignments/{billingRoleAssignmentName}"].delete
  reason: Previously ARM approved before TypeSpec. Is returning 200, 201, and 202 for LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoicingPreferences/default"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/migrations/default"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}"].put
  reason: Previously ARM approved before TypeSpec. Isn't actually LRO, but returns 202 and a response body for the operation.
- code: LroExtension
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}"].put
  reason: Previously ARM approved before TypeSpec. Isn't actually LRO, but returns 202 and a response body for the operation.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/purchaseOrderMappings/{purchaseOrderMappingName}"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/purchaseOrders/{poNumber}"].put
  reason: Previously ARM approved before TypeSpec. Existing design is to only return 200, not LRO.
- code: PutGetPatchResponseSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}"]
  reason: Previously ARM approved before TypeSpec. The two response bodies are different by design.
- code: LroLocationHeader
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}"].put.responses.202
  reason: Previously ARM approved before TypeSpec. Returns a body instead of a location header by design.
- code: LroLocationHeader
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/cancel"].post.responses.202
  reason: Previously ARM approved before TypeSpec. Returns a body instead of a location header by design.
- code: LroExtension
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/cancel"].post
  reason: Previously ARM approved before TypeSpec. Returns synchronously instead of a location header by design.
- code: XmsPageableForListCalls
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/download"].get
  reason: Previously ARM approved before TypeSpec. Not a list call, should be a post action if we can break in next GA.
- code: AvoidAdditionalProperties
  from: openapi.json
  where: $.definitions.AlertProperties.properties.egressConfig
  reason: Previously ARM approved before TypeSpec. Free form by design to support different kinds of alerts to display to the customer. Entirely system generated values, the service guarantees no secret material is ever placed in this map.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/addresses/{addressId}"].put
  reason: Previously ARM approved before TypeSpec. Addresses API became fully fleshed out in 2026-03-01-preview.
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
title: BillingManagementClient
description: Billing Client
input-file:
- stable/2024-04-01/openapi.json
suppressions:
- code: TenantLevelAPIsNotAllowed
  from: openapi.json
  reason: Applies to every operation in this RP because this entire RP is a tenant level resource provider.
- code: ProvisioningStateSpecifiedForLROPut
  from: openapi.json
  reason: Applies to every operation in this RP because Billing Resources are tenant resources that are not provisioned under a subscription.
- code: SubscriptionIdParameterInOperations
  from: openapi.json
  reason: Applies to every operation in this RP because subscription Id in Billing's case means Billing Subscription, not Azure Subscription.
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}"].patch.responses.200
  reason: Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ProvisioningStateSpecifiedForLROPatch
  from: openapi.json
  where: $.paths.["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}"].patch.responses.200
  reason: Billing Resources are tenant resources that are not provisioned under a subscription.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/billingSubscriptions/{billingSubscriptionName}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get billing subscription is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get billing subscription is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get reservation order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservationOrders/{reservationOrderId}/reservations/{reservationId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get reservation order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlanOrders/{savingsPlanOrderId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get savings plan order is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlanOrders/{savingsPlanOrderId}/savingsPlans/{savingsPlanId}"].get.parameters
  reason: Previously ARM approved before TypeSpec. Expand on get savings plan is by design.
- code: ParametersInPointGet
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingProperty/default"].get.parameters
  reason: Previously ARM approved before TypeSpec. Billing Property details aren't always needed and add cost to retreive.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.BillingProperty
  reason: BillingProperty is singleton with resource id default.
- code: TopLevelResourcesListBySubscription
  from: openapi.json
  where: $.definitions.SubscriptionPolicy
  reason: SubscriptionPolicy is singleton with resource id default.
- code: PatchBodyParametersSchema
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}"].patch.parameters.2.schema.properties.properties
  reason: Previously ARM approved before TypeSpec. When updating an address, the full address object, not just a few properties of it, are expected to be present.
- code: PatchBodyParametersSchema
  from: openapi.json
  where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingProperty/default"].patch.parameters.2.schema.properties.properties
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
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/reservations"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. ReservationSummary provides the total counts of various types in the list.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/customers/{customerName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/enrollmentAccounts/{enrollmentAccountName}/billingSubscriptions"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. TotalCount property also being present is desired.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/transactionSummary"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. Not a list API, gets a single resource.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/download"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. This is not a list API.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/reservations"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. ReservationSummary provides the total counts of various types in the list.
- code: GetCollectionOnlyHasValueAndNextLink
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/savingsPlans"].get.responses.200.schema.properties
  reason: Previously ARM approved before TypeSpec. SavingsPlanSummaryCount provides the total counts of various types in the list.
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
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/download"].post.parameters
  reason: Previously ARM approved before TypeSpec. The documentName parameter is the document under the invoice to download.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/default/billingSubscriptions/{subscriptionId}/invoices/{invoiceName}/download"].post.parameters
  reason: Previously ARM approved before TypeSpec. The documentName parameter is the document under the invoice to download.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/listInvoiceSectionsWithCreateSubscriptionPermission"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: ParametersInPost
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/resolveBillingRoleAssignments"].post.parameters
  reason: Previously ARM approved before TypeSpec. Filtering parameters are needed for this post action which returns a list.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/customers/{customerName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, PartnerTransferDetails.
- code: PutRequestResponseSchemeArm
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/transfers/{transferName}"].put
  reason: Previously ARM approved before TypeSpec. From what I can tell, the Get and the Put are both using the same model, TransferDetails.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/invoices/{invoiceName}/amend"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/licenseReservations/{licenseReservationName}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This is using a 202 response code.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/partnerChangeRequests/{partnerChangeRequestGuid}/cancel"].post
  reason: Previously ARM approved before TypeSpec. This doesn't appear to be an operation that can be polled and just gives you the cancellation response details.
- code: PostResponseCodes
  from: openapi.json
  where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/transferEnrollmentToMCA"].post
  reason: Previously ARM approved before TypeSpec. Synchronous operation returning 200.
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
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.BillingPermissionListResult
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
- code: RequiredPropertiesMissingInResourceModel
  from: openapi.json
  where: $.definitions.TransactionSummary
  reason: Previously ARM approved before TypeSpec. Response isn't an ARM resource.
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
