import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Neon.Postgres, "NeonPostgresMgmtClient", "python");
@@clientName(Neon.Postgres.OrganizationResource, "NeonOrganization", "csharp");
@@clientName(LiftrBase.CompanyDetails, "NeonCompanyDetails", "csharp");
@@clientName(LiftrBase.MarketplaceDetails, "NeonMarketplaceDetails", "csharp");
@@clientName(LiftrBase.OfferDetails, "NeonOfferDetails", "csharp");
@@clientName(LiftrBase.UserDetails, "NeonUserDetails", "csharp");
@@clientName(LiftrBase.Data.OrganizationProperties,
  "NeonOrganizationProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "NeonResourceProvisioningState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnProperties,
  "NeonSingleSignOnProperties",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnStates, "NeonSingleSignOnState", "csharp");
