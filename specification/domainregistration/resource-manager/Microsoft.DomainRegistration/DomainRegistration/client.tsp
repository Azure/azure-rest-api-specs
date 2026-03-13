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
  "IsReadyForDnsRecordManagement",
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
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
