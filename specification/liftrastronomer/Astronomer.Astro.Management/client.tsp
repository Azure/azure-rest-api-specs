import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Astronomer.Astro;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

@@clientName(Astronomer.Astro, "AstroMgmtClient", "python");

@@clientName(Data.OrganizationProperties,
  "AstroOrganizationProperties",
  "csharp"
);
@@clientName(Data.PartnerOrganizationProperties,
  "AstroPartnerOrganizationProperties",
  "csharp"
);
@@clientName(MarketplaceDetails, "AstroMarketplaceDetails", "csharp");
@@clientName(OfferDetails, "AstroOfferDetails", "csharp");
@@clientName(SingleSignOnProperties, "AstroSingleSignOnProperties", "csharp");
@@alternateType(SingleSignOnProperties.singleSignOnUrl, url, "csharp");
@@clientName(UserDetails, "AstroUserDetails", "csharp");
@@clientName(RenewalMode, "AstroRenewalMode", "csharp");
@@clientName(OrganizationResource, "AstroOrganization", "csharp");
@@clientName(SingleSignOnStates, "AstroSingleSignOnState", "csharp");
@@clientName(ResourceProvisioningState,
  "AstroResourceProvisioningState",
  "csharp"
);
@@alternateType(CommonTypes.Resource.id, armResourceIdentifier, "csharp");
