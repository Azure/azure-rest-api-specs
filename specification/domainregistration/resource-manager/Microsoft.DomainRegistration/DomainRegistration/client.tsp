import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DomainRegistration;

@@clientName(Microsoft.DomainRegistration,
  "DomainRegistrationManagementClient",
  "javascript"
);

@@clientName(Domain, "AppServiceDomain", "csharp");
@@clientName(DomainProperties.autoRenew, "IsAutoRenew", "csharp");
@@clientName(DomainProperties.expirationTime, "ExpireOn", "csharp");
@@clientName(DomainProperties.privacy, "IsDomainPrivacyEnabled", "csharp");
@@clientName(DomainProperties.readyForDnsRecordManagement,
  "IsDnsRecordManagementReady",
  "csharp"
);
@@clientName(DomainCollection, "AppServiceDomainListResult", "csharp");
@@clientName(DomainControlCenterSsoRequest,
  "DomainControlCenterSsoRequestInfo",
  "csharp"
);
@@clientName(DomainOwnershipIdentifierCollection,
  "DomainOwnershipIdentifierListResult",
  "csharp"
);
@@clientName(DomainPatchResourceProperties.autoRenew, "IsAutoRenew", "csharp");
@@clientName(DomainPatchResourceProperties.privacy,
  "IsDomainPrivacyEnabled",
  "csharp"
);
@@clientName(DomainPatchResourceProperties.readyForDnsRecordManagement,
  "IsDnsRecordManagementReady",
  "csharp"
);
@@clientName(TopLevelDomainProperties.privacy,
  "IsDomainPrivacySupported",
  "csharp"
);
@@clientName(TopLevelDomainAgreementOption.forTransfer,
  "IsForTransfer",
  "csharp"
);
@@clientName(TopLevelDomainCollection, "TopLevelDomainListResult", "csharp");
@@clientName(Address, "RegistrationAddressInfo", "csharp");
@@clientName(AzureResourceType, "AppServiceResourceType", "csharp");
@@clientName(Contact, "RegistrationContactInfo", "csharp");
@@clientName(DnsType, "AppServiceDnsType", "csharp");
@@clientName(DomainStatus, "AppServiceDomainStatus", "csharp");
@@clientName(DomainType, "AppServiceDomainType", "csharp");
@@clientName(HostName, "AppServiceHostName", "csharp");
@@clientName(HostNameType, "AppServiceHostNameType", "csharp");
@@clientName(DomainAvailabilityCheckResult.available, "IsAvailable", "csharp");
@@clientName(DomainRecommendationSearchParameters,
  "DomainRecommendationSearchContent",
  "csharp"
);
@@clientName(NameIdentifier, "AppServiceDomainNameIdentifier", "csharp");
@@clientName(NameIdentifierCollection,
  "AppServiceDomainNameIdentifierListResult",
  "csharp"
);
@@clientName(ProvisioningState, "AppServiceDomainProvisioningState", "csharp");
@@clientName(ResourceNotRenewableReason, "DomainNotRenewableReason", "csharp");
@@clientName(TopLevelDomainAgreementOption.forTransfer,
  "IsForTransfer",
  "csharp"
);
@@clientName(TopLevelDomainAgreementOption.includePrivacy,
  "IsPrivacyIncluded",
  "csharp"
);
@@clientName(TopLevelDomainAgreementOption,
  "TopLevelDomainAgreementContent",
  "csharp"
);
@@clientName(TldLegalAgreement, "TopLevelDomainLegalAgreement", "csharp");
@@alternateType(TldLegalAgreement.url, url, "csharp");
@@clientName(DomainsOperationGroup.checkAvailability,
  "CheckAppServiceDomainRegistrationAvailability",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);

// Below is the workaround for C# code generation to produce the correct class inheritance hierarchy for DomainPatchResource.
/**
 * ARM resource for a domain patch operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition is used here to reuse common resource model."
model DomainPatch extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<DomainPatchResource, "id" | "name" | "type">;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The tags property is intentionally included because the domain is TrackedResource, which supports updating tags."
  tags?: Record<string>;
}
@@alternateType(DomainPatchResource, DomainPatch, "csharp");
@@clientName(DomainPatch, "AppServiceDomainPatch", "csharp");
