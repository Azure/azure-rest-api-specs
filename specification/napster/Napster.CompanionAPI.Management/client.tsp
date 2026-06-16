import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Napster.CompanionAPI;

@@clientName(Napster.CompanionAPI, "NapsterOmniAgentApiMgmtClient", "python");

// Resource trio: add Napster prefix to avoid generic "Organization" name collision
// and drop "Resource" infix from Data/Collection types (RESNAME001, RESINFIX001)
@@clientName(OrganizationResource, "NapsterOrganizationResource", "csharp");
@@clientName(OrganizationProperties, "NapsterOrganizationProperties", "csharp");
@@clientName(PartnerProperties, "NapsterPartnerProperties", "csharp");

// SUFFIX004: Request → Content for request body types
@@clientName(
  ActivateSaaSParameterRequest,
  "ActivateSaaSParameterContent",
  "csharp"
);

// SUFFIX005: Response suffix → Data (derives from ResourceData)
@@clientName(SaaSResourceDetailsResponse, "SaaSResourceDetailsData", "csharp");

// SUFFIX005: Response → Result for non-ResourceData response types
@@clientName(LatestLinkedSaaSResponse, "LatestLinkedSaaSResult", "csharp");

// SUFFIX003: Data suffix reserved for ResourceData types
@@clientName(SaaSData, "SaaSInfo", "csharp");

// Plural → singular for non-flags extensible enum
@@clientName(
  LiftrBase.SingleSignOnStates,
  "NapsterSingleSignOnState",
  "csharp"
);

// TYPE001: Rename *ResourceId properties to avoid implying ARM resource IDs
// These are SaaS marketplace IDs, not ARM resource paths
@@clientName(SaaSData.saaSResourceId, "SaaSId", "csharp");
@@clientName(LatestLinkedSaaSResponse.saaSResourceId, "SaaSId", "csharp");
@@clientName(LiftrBase.MarketplaceDetails.saasResourceId, "SaaSId", "csharp");

// LiftrBase types: add Napster domain prefix to avoid generic name collisions
@@clientName(
  LiftrBase.MarketplaceDetails,
  "NapsterMarketplaceDetails",
  "csharp"
);
@@clientName(
  LiftrBase.MarketplaceSubscriptionStatus,
  "NapsterMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails, "NapsterOfferDetails", "csharp");
@@clientName(LiftrBase.UserDetails, "NapsterUserDetails", "csharp");
@@clientName(
  LiftrBase.SingleSignOnPropertiesV2,
  "NapsterSingleSignOnPropertiesV2",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnType, "NapsterSingleSignOnType", "csharp");
@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "NapsterProvisioningState",
  "csharp"
);

// Fix SaasGuid property type: should be Guid, not string
@@alternateType(ActivateSaaSParameterRequest.saasGuid, uuid, "csharp");

// Fix organizationname parameter casing
@@clientName(OrganizationResource.name, "organizationName", "csharp");
