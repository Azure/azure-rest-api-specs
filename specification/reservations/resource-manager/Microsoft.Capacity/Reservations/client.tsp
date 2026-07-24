import "./Quota/main.tsp";
import "./Reservations/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Reservations;

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "ReservationsClient",
  service: [Quota, Reservations],
  autoMergeService: true,
})
namespace ReservationsClient;

@@clientName(ReservationsClient, "ReservationsMgmtClient", "python");
@@clientName(BillingPlan.P1M, "P1_M", "python");

// C# customizations for backward compatibility with the GA SDK.
@@clientName(PurchaseRequest, "ReservationPurchaseContent", "csharp");
@@clientName(Price, "PurchasePrice", "csharp");
@@clientName(SavingsPlanPurchaseRequest, "SavingsPlanPurchase", "csharp");
@@clientName(OperationStatus, "ReservationOperationStatus", "csharp");
@@clientName(Quota.ResourceName, "ReservationResourceName", "csharp");
@@clientName(Quota.ResourceType, "ResourceTypeName", "csharp");

// Disambiguate properties that would collide when renamed to *On.
@@clientName(
  ReservationOrderProperties.expiryDate,
  "reservationExpireOn",
  "csharp"
);
@@clientName(ReservationOrderProperties.expiryDateTime, "expireOn", "csharp");
@@clientName(
  ReservationsProperties.expiryDate,
  "reservationExpireOn",
  "csharp"
);
@@clientName(ReservationsProperties.expiryDateTime, "expireOn", "csharp");
@@clientName(ReservationsProperties.effectiveDateTime, "effectOn", "csharp");
@@clientName(
  ReservationsProperties.purchaseDate,
  "reservationPurchaseOn",
  "csharp"
);
@@clientName(PaymentDetail.paymentDate, "payOn", "csharp");
@@clientName(Catalog.resourceType, "appliedResourceType", "csharp");
@@clientName(Catalog.name, "skuName", "csharp");
@@clientName(Quota.QuotaProperties.name, "resourceName", "csharp");
@@clientName(ReservationOrderResponse.etag, "version", "csharp");
@@clientName(ReservationResponse.etag, "version", "csharp");

// Type renames to preserve GA SDK surface.
@@clientName(ReservationResponse, "ReservationDetail", "csharp");
@@alternateType(ReservationResponse.location, azureLocation, "csharp");
@@clientName(ReservationOrderResponse, "ReservationOrder", "csharp");
@@clientName(Patch, "ReservationDetailPatch", "csharp");
@@clientName(ReservationsProperties, "ReservationProperties", "csharp");
@@clientName(
  ReservationsPropertiesUtilization,
  "ReservationPropertiesUtilization",
  "csharp"
);
@@clientName(ProvisioningState, "ReservationProvisioningState", "csharp");
@@clientName(ErrorResponseCode, "ReservationErrorResponseCode", "csharp");
@@clientName(AppliedReservations, "AppliedReservationData", "csharp");
@@clientName(AvailableScopeRequest, "AvailableScopesContent", "csharp");
@@clientName(
  AvailableScopeRequestProperties,
  "AvailableScopesContentProperties",
  "csharp"
);
@@clientName(AvailableScopeProperties, "AvailableScopesProperties", "csharp");
@@clientName(Commitment, "BenefitsCommitment", "csharp");
@@clientName(CommitmentGrain, "BenefitsCommitmentGrain", "csharp");
@@clientName(CalculateExchangeRequest, "CalculateExchangeContent", "csharp");
@@clientName(
  CalculateExchangeRequestProperties,
  "CalculateExchangeContentProperties",
  "csharp"
);
@@clientName(
  CalculateExchangeOperationResultResponse,
  "CalculateExchangeResult",
  "csharp"
);
@@clientName(
  CalculateExchangeResponseProperties,
  "CalculateExchangeResultProperties",
  "csharp"
);
@@clientName(CalculatePriceResponse, "CalculatePriceResult", "csharp");
@@clientName(
  CalculatePriceResponseProperties,
  "CalculatePriceResultProperties",
  "csharp"
);
@@clientName(
  CalculatePriceResponsePropertiesBillingCurrencyTotal,
  "CalculatePriceResultPropertiesBillingCurrencyTotal",
  "csharp"
);
@@clientName(
  CalculatePriceResponsePropertiesPricingCurrencyTotal,
  "CalculatePriceResultPropertiesPricingCurrencyTotal",
  "csharp"
);
@@clientName(ChangeDirectoryRequest, "ChangeDirectoryContent", "csharp");
@@clientName(ChangeDirectoryResponse, "ChangeDirectoryDetail", "csharp");
@@clientName(ExchangeRequest, "ExchangeContent", "csharp");
@@clientName(ExchangeOperationResultResponse, "ExchangeResult", "csharp");
@@clientName(ExchangeResponseProperties, "ExchangeResultProperties", "csharp");
@@clientName(MergeRequest, "MergeContent", "csharp");
@@clientName(RenewPropertiesResponse, "RenewProperties", "csharp");
@@clientName(
  RenewPropertiesResponseBillingCurrencyTotal,
  "RenewPropertiesBillingCurrencyTotal",
  "csharp"
);
@@clientName(
  RenewPropertiesResponsePricingCurrencyTotal,
  "RenewPropertiesPricingCurrencyTotal",
  "csharp"
);
@@clientName(
  CalculateRefundRequest,
  "ReservationCalculateRefundContent",
  "csharp"
);
@@clientName(
  CalculateRefundRequestProperties,
  "ReservationCalculateRefundRequestProperties",
  "csharp"
);
@@clientName(
  CalculateRefundResponse,
  "ReservationCalculateRefundResult",
  "csharp"
);
@@clientName(Catalog, "ReservationCatalog", "csharp");
@@clientName(CatalogMsrp, "ReservationCatalogMsrp", "csharp");
@@clientName(
  RefundBillingInformation,
  "ReservationRefundBillingInformation",
  "csharp"
);
@@clientName(RefundRequest, "ReservationRefundContent", "csharp");
@@clientName(RefundPolicyError, "ReservationRefundPolicyError", "csharp");
@@clientName(
  RefundPolicyResultProperty,
  "ReservationRefundPolicyResultProperty",
  "csharp"
);
@@clientName(
  RefundRequestProperties,
  "ReservationRefundRequestProperties",
  "csharp"
);
@@clientName(
  RefundResponseProperties,
  "ReservationRefundResponseProperties",
  "csharp"
);
@@clientName(RefundResponse, "ReservationRefundResult", "csharp");
@@clientName(BillingPlan, "SavingsPlanBillingPlan", "csharp");
@@clientName(SplitRequest, "SplitContent", "csharp");
@@clientName(Quota.SubRequest, "SubContent", "csharp");
@@clientName(Quota.CurrentQuotaLimitBase, "ReservationQuota", "csharp");
@@clientName(Quota.QuotaRequestDetails, "QuotaRequestDetail", "csharp");

// Property renames for GA parity.
@@clientName(ScopeProperties.valid, "isValid", "csharp");
@@clientName(ReservationsProperties.archived, "isArchived", "csharp");
@@clientName(ReservationsProperties.renew, "isRenewEnabled", "csharp");
@@clientName(PurchaseRequestProperties.renew, "isRenewEnabled", "csharp");
@@clientName(PatchProperties.renew, "isRenewEnabled", "csharp");
@@clientName(SkuRestriction.type, "skuRestrictionType", "csharp");
@@clientName(Quota.QuotaProperties.resourceType, "resourceTypeName", "csharp");
@@clientName(Quota.QuotaRequestProperties.value, "quotaRequestValue", "csharp");
@@clientName(ReservationList.value, "reservations", "csharp");
@@clientName(ReservationsListResult.value, "reservations", "csharp");
@@clientName(
  ExchangeRequestProperties.sessionId,
  "exchangeRequestSessionId",
  "csharp"
);

// Flatten envelopes to expose inner fields on parent (matches GA API surface).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvailableScopeRequest.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvailableScopeProperties.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  CalculateExchangeResponseProperties.policyResult,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ExchangeResponseProperties.policyResult,
  "csharp"
);

// Strongly-typed AzureLocation for location key on Quota proxy resource and ReservationCatalog location param.
@@alternateType(Quota.LocationProxy.location, azureLocation, "csharp");
@@alternateType(getCatalog::parameters.location, azureLocation, "csharp");

// Re-establish GA inheritance: AppliedReservationData derives from ResourceData (ProxyResource).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AppliedReservations,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// ExchangeRequestSessionId is GA strongly-typed as Guid.
@@alternateType(ExchangeRequestProperties.sessionId, uuid, "csharp");

// Resource keys are GA strongly-typed as Guid.
@@alternateType(ReservationOrderResponse.name, uuid, "csharp");
@@alternateType(ReservationResponse.name, uuid, "csharp");
@@alternateType(Quota.QuotaRequestDetails.name, uuid, "csharp");

// BillingScopeId / ReservationId are GA strongly-typed as ResourceIdentifier.
@@alternateType(
  PurchaseRequestProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanPurchaseRequestProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SplitProperties.reservationId, armResourceIdentifier, "csharp");

// Enum value casing fixes.
@@clientName(ReservedResourceType.AVS, "Avs", "csharp");
@@clientName(ReservedResourceType.CosmosDb, "CosmosDB", "csharp");
@@clientName(ReservedResourceType.MariaDb, "MariaDB", "csharp");

// Operation renames to match GA method names.
@@clientName(
  ReservationResponses.availableScopes,
  "GetAvailableScopes",
  "csharp"
);
@@clientName(ReservationResponses.listRevisions, "GetRevisions", "csharp");
@@clientName(ReservationOrderResponses.purchase, "CreateOrUpdate", "csharp");
@@clientName(ReservationOrderResponses.split, "SplitReservation", "csharp");
@@clientName(ReservationOrderResponses.merge, "MergeReservation", "csharp");
@@clientName(ReservationOrderResponses.post, "CalculateRefund", "csharp");
@@clientName(ReservationOrderResponses.returnPost, "Return", "csharp");
@@clientName(
  ReservationOrderOperationGroup.calculate,
  "CalculateReservationOrder",
  "csharp"
);
@@clientName(
  CalculateExchangeOperationGroup.post,
  "CalculateReservationExchange",
  "csharp"
);
@@clientName(ExchangeOperationGroup.post, "Exchange", "csharp");
@@clientName(getAppliedReservationList, "GetAppliedReservations", "csharp");
@@clientName(getCatalog, "GetCatalog", "csharp");
@@clientName(
  ReservationOperationGroup.listAll,
  "GetReservationDetails",
  "csharp"
);

@@clientName(ReservationTerm.P1Y, "P1_Y", "python");
@@clientName(ReservationTerm.P3Y, "P3_Y", "python");
@@clientName(ReservationTerm.P5Y, "P5_Y", "python");
@@clientName(SavingsPlanTerm.P1Y, "P1_Y", "python");
@@clientName(SavingsPlanTerm.P3Y, "P3_Y", "python");

@@clientLocation(getAppliedReservationList, "AzureReservationAPIClient", "go");
@@clientLocation(getCatalog, "AzureReservationAPIClient", "go");

@@clientLocation(
  getAppliedReservationList::parameters.subscriptionId,
  getAppliedReservationList
);
@@clientLocation(getCatalog::parameters.subscriptionId, getCatalog);

@@clientLocation(
  Quota.QuotaPutBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.createOrUpdate
);
@@clientLocation(
  Quota.QuotaPatchBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.update
);
@@clientLocation(
  Quota.QuotaGetBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.get
);
@@clientLocation(
  Quota.QuotaListBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.list
);
@@clientLocation(
  Quota.QuotaRequestGetBaseParam.subscriptionId,
  Quota.QuotaRequestStatus.get
);
@@clientLocation(
  Quota.QuotaRequestListBaseParam.subscriptionId,
  Quota.QuotaRequestStatus.list
);
@@scope(Operation.list, "!csharp");
/**
 * Resource Provider type to be reserved.
 */
union ReservationKind {
  string,

  /**
   * Microsoft.Compute.
   */
  MicrosoftCompute: "Microsoft.Compute",
}
@@alternateType(ReservationResponse.kind, ReservationKind, "csharp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Mark collection action placement"
@@clientOption(
  ReservationResponses.listRevisions,
  "resource-operation-kind",
  "CollectionAction",
  "csharp"
);
