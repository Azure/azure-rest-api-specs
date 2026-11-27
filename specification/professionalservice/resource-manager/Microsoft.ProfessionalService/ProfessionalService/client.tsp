import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ProfessionalService;

@@clientName(ProfessionalServiceResource, "ProfessionalService", "csharp");
@@clientName(
  ProfessionalServiceResourceProperties.autoRenew,
  "IsAutoRenew",
  "csharp"
);

@@clientName(
  UnsubscribeOptions,
  "ProfessionalServiceUnsubscribeContent",
  "csharp"
);
@@clientName(
  UnsubscribeOptions.unsubscribeOnly,
  "IsUnsubscribeOnly",
  "csharp"
);

@@clientName(
  ProfessionalServicePurchaseValidationRequest,
  "ProfessionalServicePurchaseValidationContent",
  "csharp"
);
@@clientName(
  ResourceValidationResult,
  "ProfessionalServiceValidationResult",
  "csharp"
);
@@clientName(
  ResourceValidationError,
  "ProfessionalServiceValidationError",
  "csharp"
);

@@clientName(
  DeletionSource,
  "ProfessionalServiceDeletionSource",
  "csharp"
);
@@clientName(
  SubscriptionStatusReason,
  "ProfessionalServiceSubscriptionStatusReason",
  "csharp"
);
@@clientName(
  ProfessionalServiceResourceStatus,
  "ProfessionalServiceSubscriptionStatus",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "ProfessionalServiceNameAvailabilityContent",
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
  "ProfessionalServiceNameAvailabilityResult",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "ProfessionalServiceNameUnavailableReason",
  "csharp"
);
@@clientName(
  ProfessionalServiceSubscriptionLevelGlobal.checkNameAvailability,
  "CheckProfessionalServiceNameAvailability",
  "csharp"
);
