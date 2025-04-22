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

@@clientName(Neon.Postgres.Models.Project, "NeonProject", "csharp");
@@clientName(Neon.Postgres.Models.ProjectProperties,
  "NeonProjectProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Models.Branch, "NeonBranch", "csharp");
@@clientName(Neon.Postgres.Models.BranchProperties,
  "NeonBranchProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Models.Endpoint, "NeonEndpoint", "csharp");
@@clientName(Neon.Postgres.Models.EndpointProperties,
  "NeonEndpointProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Models.Compute, "NeonCompute", "csharp");
@@clientName(Neon.Postgres.Models.ComputeProperties,
  "NeonComputeProperties",
  "csharp"
);

@@clientName(Neon.Postgres.Models.ProjectProperties.pgVersion,
  "postgresVersion",
  "csharp"
);

@@clientName(Neon.Postgres.Models.ProjectProperties.attributes,
  "attribute",
  "csharp"
);
