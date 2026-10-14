import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Kore.AgentPlatform;

@@clientName(Kore.AgentPlatform, "KoreAIArtemisMgmtClient", "python");
// java
@@clientName(Kore.AgentPlatform, "KoreAIArtemisManagementClient", "java");

// csharp
@@clientName(
  Kore.AgentPlatform.OrganizationResource,
  "KoreAIArtemisOrganization",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationProperties,
  "KoreAIArtemisOrganizationProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationPartnerProperties,
  "KoreAIArtemisOrganizationPartnerProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.DefaultWorkspaceProperties,
  "KoreAIArtemisDefaultWorkspaceProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceResource,
  "KoreAIArtemisWorkspace",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceProperties,
  "KoreAIArtemisWorkspaceProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspacePartnerProperties,
  "KoreAIArtemisWorkspacePartnerProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceLifecycleStatus,
  "KoreAIArtemisWorkspaceLifecycleStatus",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.UserDetails,
  "KoreAIArtemisUserDetails",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.CompanyDetails,
  "KoreAIArtemisCompanyDetails",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.SingleSignOnProperties,
  "KoreAIArtemisSingleSignOnProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.ListWorkspacesResponse,
  "ListWorkspacesResult",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "KoreAIArtemisOfferDetails", "csharp");
@@clientName(
  LiftrBase.MarketplaceDetails,
  "KoreAIArtemisMarketplaceDetails",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "KoreAIArtemisResourceProvisioningState",
  "csharp"
);
