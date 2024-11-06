import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Neon.Postgres, "NeonPostgresMgmtClient", "python");
@@clientName(Neon.Postgres.OrganizationResource, "NeonOrganization", "dotnet");
@@clientName(LiftrBase.CompanyDetails, "NeonCompanyDetails", "dotnet");
@@clientName(LiftrBase.MarketplaceDetails, "NeonMarketplaceDetails", "dotnet");
@@clientName(LiftrBase.OfferDetails, "NeonOfferDetails", "dotnet");
@@clientName(LiftrBase.UserDetails, "NeonUserDetails", "dotnet");
@@clientName(LiftrBase.Data.OrganizationProperties,
  "NeonOrganizationPropertes",
  "dotnet"
);
@@clientName(LiftrBase.BaseResourceProperties.provisioningState,
  "NeonResourceProvisioningState",
  "dotnet"
);
@@clientName(LiftrBase.SingleSignOnProperties,
  "NeonSingleSignOnProperties",
  "dotnet"
);
