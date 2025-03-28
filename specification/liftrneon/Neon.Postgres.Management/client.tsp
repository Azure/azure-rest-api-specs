import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Neon.Postgres,
  "com.azure.resourcemanager.neonpostgres",
  "java"
);
@@clientNamespace(LiftrBase, "com.azure.resourcemanager.neonpostgres", "java");
@@clientNamespace(LiftrBase.Data,
  "com.azure.resourcemanager.neonpostgres",
  "java"
);
@@clientName(Neon.Postgres, "NeonPostgresMgmtClient", "python");
@@clientName(Neon.Postgres, "NeonPostgresManagementClient", "java");
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
