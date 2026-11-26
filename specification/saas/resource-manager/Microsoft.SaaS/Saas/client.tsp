import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.SaaS;

// Name availability
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "SaasNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  armResourceType,
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "SaasNameAvailabilityResult",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "SaasNameUnavailableReason",
  "csharp"
);
@@clientName(
  SaasSubscriptionLevelGlobal.checkNameAvailability,
  "CheckSaasNameAvailability",
  "csharp"
);

// Access token
@@clientName(AccessTokenResult, "SaasAccessTokenResult", "csharp");
@@alternateType(AccessTokenResult.publisherOfferBaseUri, url, "csharp");
@@alternateType(AccessTokenResult.offerUriWithToken, url, "csharp");

// Validation
@@clientName(
  SaasPurchaseValidationRequest,
  "SaasPurchaseValidationContent",
  "csharp"
);
@@clientName(
  ResourceValidationResult,
  "SaasResourceValidationResult",
  "csharp"
);
@@clientName(ResourceValidationError, "SaasResourceValidationError", "csharp");

// Enums / unions
@@clientName(
  SubscriptionStatusReason,
  "SaasSubscriptionStatusReason",
  "csharp"
);
@@clientName(DeletionSource, "SaasDeletionSource", "csharp");
@@clientName(PatchIntent, "SaasPatchIntent", "csharp");

// Unsubscribe
@@clientName(UnsubscribeOptions, "SaasUnsubscribeConfig", "csharp");
@@clientName(
  UnsubscribeOptions.unsubscribeOnly,
  "IsUnsubscribeOnly",
  "csharp"
);

// Properties
@@clientName(SaasResourceProperties.autoRenew, "IsAutoRenew", "csharp");

// Resources (remove Resource infix from Data/Collection)
@@clientName(SaasResource, "Saas", "csharp");
@@clientName(SaasTenantResource, "SaasTenant", "csharp");
