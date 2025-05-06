import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

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

@@clientName(Neon.Postgres.Project, "NeonProject", "csharp");
@@clientName(Neon.Postgres.ProjectProperties,
  "NeonProjectProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Branch, "NeonBranch", "csharp");
@@clientName(Neon.Postgres.BranchProperties, "NeonBranchProperties", "csharp");

@@clientName(Neon.Postgres.Endpoint, "NeonEndpoint", "csharp");
@@clientName(Neon.Postgres.EndpointProperties,
  "NeonEndpointProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Compute, "NeonCompute", "csharp");
@@clientName(Neon.Postgres.ComputeProperties,
  "NeonComputeProperties",
  "csharp"
);

@@clientName(Neon.Postgres.ProjectProperties.pgVersion,
  "postgresVersion",
  "csharp"
);

@@clientName(Neon.Postgres.ProjectProperties.attributes, "attribute", "csharp");
