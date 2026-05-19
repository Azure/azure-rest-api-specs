import "./Quota/main.tsp";
import "./Reservations/main.tsp";
import "@azure-tools/typespec-client-generator-core";

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
@@clientName(Reservations.PurchaseRequest, "ReservationPurchaseContent", "csharp");
@@clientName(Reservations.Price, "PurchasePrice", "csharp");
@@clientName(Reservations.SavingsPlanPurchaseRequest, "SavingsPlanPurchase", "csharp");
@@clientName(Reservations.OperationStatus, "ReservationOperationStatus", "csharp");
@@clientName(Quota.ResourceName, "ReservationResourceName", "csharp");
@@clientName(Quota.ResourceType, "ResourceTypeName", "csharp");

// Disambiguate properties that would collide when renamed to *On.
@@clientName(Reservations.ReservationOrderProperties.expiryDate, "reservationExpireOn", "csharp");
@@clientName(Reservations.ReservationOrderProperties.expiryDateTime, "expireOn", "csharp");
@@clientName(Reservations.ReservationsProperties.expiryDate, "reservationExpireOn", "csharp");
@@clientName(Reservations.ReservationsProperties.expiryDateTime, "expireOn", "csharp");
@@clientName(Reservations.ReservationsProperties.effectiveDateTime, "effectOn", "csharp");
@@clientName(Reservations.ReservationsProperties.purchaseDate, "reservationPurchaseOn", "csharp");
@@clientName(Reservations.PaymentDetail.paymentDate, "payOn", "csharp");
@@clientName(Reservations.Catalog.resourceType, "appliedResourceType", "csharp");
@@clientName(Reservations.Catalog.name, "skuName", "csharp");
@@clientName(Quota.QuotaProperties.name, "resourceName", "csharp");
@@clientName(Reservations.ReservationOrderResponse.etag, "version", "csharp");
@@clientName(Reservations.ReservationResponse.etag, "version", "csharp");

// Type renames to preserve GA SDK surface.
@@clientName(Reservations.ReservationResponse, "ReservationDetail", "csharp");
@@clientName(Reservations.ReservationOrderResponse, "ReservationOrder", "csharp");
@@clientName(Reservations.Patch, "ReservationDetailPatch", "csharp");
@@clientName(Reservations.ReservationsProperties, "ReservationProperties", "csharp");
@@clientName(Reservations.ReservationsPropertiesUtilization, "ReservationPropertiesUtilization", "csharp");
@@clientName(Reservations.ProvisioningState, "ReservationProvisioningState", "csharp");
@@clientName(Reservations.ErrorResponseCode, "ReservationErrorResponseCode", "csharp");
@@clientName(Reservations.AppliedReservations, "AppliedReservationData", "csharp");
@@clientName(Reservations.AvailableScopeRequest, "AvailableScopesContent", "csharp");
@@clientName(Reservations.AvailableScopeRequestProperties, "AvailableScopesContentProperties", "csharp");
@@clientName(Reservations.AvailableScopeProperties, "AvailableScopesProperties", "csharp");
@@clientName(Reservations.Commitment, "BenefitsCommitment", "csharp");
@@clientName(Reservations.CommitmentGrain, "BenefitsCommitmentGrain", "csharp");
@@clientName(Reservations.CalculateExchangeRequest, "CalculateExchangeContent", "csharp");
@@clientName(Reservations.CalculateExchangeRequestProperties, "CalculateExchangeContentProperties", "csharp");
@@clientName(Reservations.CalculateExchangeOperationResultResponse, "CalculateExchangeResult", "csharp");
@@clientName(Reservations.CalculateExchangeResponseProperties, "CalculateExchangeResultProperties", "csharp");
@@clientName(Reservations.CalculatePriceResponse, "CalculatePriceResult", "csharp");
@@clientName(Reservations.CalculatePriceResponseProperties, "CalculatePriceResultProperties", "csharp");
@@clientName(Reservations.CalculatePriceResponsePropertiesBillingCurrencyTotal, "CalculatePriceResultPropertiesBillingCurrencyTotal", "csharp");
@@clientName(Reservations.CalculatePriceResponsePropertiesPricingCurrencyTotal, "CalculatePriceResultPropertiesPricingCurrencyTotal", "csharp");
@@clientName(Reservations.ChangeDirectoryRequest, "ChangeDirectoryContent", "csharp");
@@clientName(Reservations.ChangeDirectoryResponse, "ChangeDirectoryDetail", "csharp");
@@clientName(Reservations.ExchangeRequest, "ExchangeContent", "csharp");
@@clientName(Reservations.ExchangeOperationResultResponse, "ExchangeResult", "csharp");
@@clientName(Reservations.ExchangeResponseProperties, "ExchangeResultProperties", "csharp");
@@clientName(Reservations.MergeRequest, "MergeContent", "csharp");
@@clientName(Reservations.RenewPropertiesResponse, "RenewProperties", "csharp");
@@clientName(Reservations.RenewPropertiesResponseBillingCurrencyTotal, "RenewPropertiesBillingCurrencyTotal", "csharp");
@@clientName(Reservations.RenewPropertiesResponsePricingCurrencyTotal, "RenewPropertiesPricingCurrencyTotal", "csharp");
@@clientName(Reservations.CalculateRefundRequest, "ReservationCalculateRefundContent", "csharp");
@@clientName(Reservations.CalculateRefundRequestProperties, "ReservationCalculateRefundRequestProperties", "csharp");
@@clientName(Reservations.CalculateRefundResponse, "ReservationCalculateRefundResult", "csharp");
@@clientName(Reservations.Catalog, "ReservationCatalog", "csharp");
@@clientName(Reservations.CatalogMsrp, "ReservationCatalogMsrp", "csharp");
@@clientName(Reservations.RefundBillingInformation, "ReservationRefundBillingInformation", "csharp");
@@clientName(Reservations.RefundRequest, "ReservationRefundContent", "csharp");
@@clientName(Reservations.RefundPolicyError, "ReservationRefundPolicyError", "csharp");
@@clientName(Reservations.RefundPolicyResultProperty, "ReservationRefundPolicyResultProperty", "csharp");
@@clientName(Reservations.RefundRequestProperties, "ReservationRefundRequestProperties", "csharp");
@@clientName(Reservations.RefundResponseProperties, "ReservationRefundResponseProperties", "csharp");
@@clientName(Reservations.RefundResponse, "ReservationRefundResult", "csharp");
@@clientName(Reservations.BillingPlan, "SavingsPlanBillingPlan", "csharp");
@@clientName(Reservations.SplitRequest, "SplitContent", "csharp");
@@clientName(Quota.SubRequest, "SubContent", "csharp");
@@clientName(Quota.CurrentQuotaLimitBase, "ReservationQuota", "csharp");
@@clientName(Quota.QuotaRequestDetails, "QuotaRequestDetail", "csharp");

// Property renames for GA parity.
@@clientName(Reservations.ScopeProperties.valid, "isValid", "csharp");
@@clientName(Reservations.ReservationsProperties.archived, "isArchived", "csharp");
@@clientName(Reservations.ReservationsProperties.renew, "isRenewEnabled", "csharp");
@@clientName(Reservations.PurchaseRequestProperties.renew, "isRenewEnabled", "csharp");
@@clientName(Reservations.PatchProperties.renew, "isRenewEnabled", "csharp");
@@clientName(Reservations.SkuRestriction.type, "skuRestrictionType", "csharp");
@@clientName(Quota.QuotaProperties.resourceType, "resourceTypeName", "csharp");
@@clientName(Quota.QuotaRequestProperties.value, "quotaRequestValue", "csharp");
@@clientName(Reservations.ReservationList.value, "reservations", "csharp");
@@clientName(Reservations.ReservationsListResult.value, "reservations", "csharp");
@@clientName(Reservations.SubscriptionScopeProperties.scopes, "scopes", "csharp");
@@clientName(Reservations.ExchangeRequestProperties.sessionId, "exchangeRequestSessionId", "csharp");

// Flatten envelopes to expose inner fields on parent (matches GA API surface).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Reservations.AvailableScopeRequest.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Reservations.AvailableScopeProperties.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Reservations.CalculateExchangeResponseProperties.policyResult, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Reservations.ExchangeResponseProperties.policyResult, "csharp");

// Strongly-typed AzureLocation for location key on Quota proxy resource and ReservationCatalog location param.
@@alternateType(Quota.LocationProxy.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Reservations.getCatalog::parameters.location, Azure.Core.azureLocation, "csharp");

// Re-establish GA inheritance: AppliedReservationData derives from ResourceData (ProxyResource).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Reservations.AppliedReservations,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// ExchangeRequestSessionId is GA strongly-typed as Guid.
@@alternateType(Reservations.ExchangeRequestProperties.sessionId, Azure.Core.uuid, "csharp");

// Resource keys are GA strongly-typed as Guid.
@@alternateType(Reservations.ReservationOrderResponse.name, Azure.Core.uuid, "csharp");
@@alternateType(Reservations.ReservationResponse.name, Azure.Core.uuid, "csharp");
@@alternateType(Quota.QuotaRequestDetails.name, Azure.Core.uuid, "csharp");

// BillingScopeId / ReservationId are GA strongly-typed as ResourceIdentifier.
@@alternateType(Reservations.PurchaseRequestProperties.billingScopeId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Reservations.SavingsPlanPurchaseRequestProperties.billingScopeId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Reservations.SplitProperties.reservationId, Azure.Core.armResourceIdentifier, "csharp");

// Enum value casing fixes.
@@clientName(Reservations.ReservedResourceType.AVS, "Avs", "csharp");
@@clientName(Reservations.ReservedResourceType.CosmosDb, "CosmosDB", "csharp");
@@clientName(Reservations.ReservedResourceType.MariaDb, "MariaDB", "csharp");

// Operation renames to match GA method names.
@@clientName(Reservations.ReservationResponses.availableScopes, "GetAvailableScopes", "csharp");
@@clientName(Reservations.ReservationResponses.listRevisions, "GetRevisions", "csharp");
@@clientName(Reservations.ReservationOrderResponses.purchase, "CreateOrUpdate", "csharp");
@@clientName(Reservations.ReservationOrderResponses.split, "SplitReservation", "csharp");
@@clientName(Reservations.ReservationOrderResponses.merge, "MergeReservation", "csharp");
@@clientName(Reservations.ReservationOrderResponses.post, "CalculateRefund", "csharp");
@@clientName(Reservations.ReservationOrderResponses.returnPost, "Return", "csharp");
@@clientName(Reservations.ReservationOrderOperationGroup.calculate, "CalculateReservationOrder", "csharp");
@@clientName(Reservations.CalculateExchangeOperationGroup.post, "CalculateReservationExchange", "csharp");
@@clientName(Reservations.ExchangeOperationGroup.post, "Exchange", "csharp");
@@clientName(Reservations.getAppliedReservationList, "GetAppliedReservations", "csharp");
@@clientName(Reservations.getCatalog, "GetCatalog", "csharp");
@@clientName(Reservations.ReservationOperationGroup.listAll, "GetReservationDetails", "csharp");


@@clientName(ReservationTerm.P1Y, "P1_Y", "python");
@@clientName(ReservationTerm.P3Y, "P3_Y", "python");
@@clientName(ReservationTerm.P5Y, "P5_Y", "python");
@@clientName(SavingsPlanTerm.P1Y, "P1_Y", "python");
@@clientName(SavingsPlanTerm.P3Y, "P3_Y", "python");

@@clientLocation(getAppliedReservationList, "AzureReservationAPIClient", "go");
@@clientLocation(getCatalog, "AzureReservationAPIClient", "go");

@@clientLocation(
  Reservations.getAppliedReservationList::parameters.subscriptionId,
  Reservations.getAppliedReservationList
);
@@clientLocation(
  Reservations.getCatalog::parameters.subscriptionId,
  Reservations.getCatalog
);

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
