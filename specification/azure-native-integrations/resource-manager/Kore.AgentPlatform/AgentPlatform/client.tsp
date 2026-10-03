import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Kore.AgentPlatform;

@@clientName(Kore.AgentPlatform, "KoreAgentPlatformMgmtClient", "python");
// java
@@clientName(Kore.AgentPlatform, "KoreAgentPlatformManagementClient", "java");

// csharp
@@clientName(
  Kore.AgentPlatform.OrganizationResource,
  "KoreAgentPlatformOrganization",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationProperties,
  "KoreAgentPlatformOrganizationProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationPartnerProperties,
  "KoreAgentPlatformOrganizationPartnerProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.DefaultWorkspaceProperties,
  "KoreAgentPlatformDefaultWorkspaceProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceResource,
  "KoreAgentPlatformWorkspace",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceProperties,
  "KoreAgentPlatformWorkspaceProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspacePartnerProperties,
  "KoreAgentPlatformWorkspacePartnerProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceLifecycleStatus,
  "KoreAgentPlatformWorkspaceLifecycleStatus",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.UserDetails,
  "KoreAgentPlatformUserDetails",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.CompanyDetails,
  "KoreAgentPlatformCompanyDetails",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.SingleSignOnProperties,
  "KoreAgentPlatformSingleSignOnProperties",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.ListWorkspacesResponse,
  "ListWorkspacesResult",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "KoreAgentPlatformOfferDetails", "csharp");
@@clientName(
  LiftrBase.MarketplaceDetails,
  "KoreAgentPlatformMarketplaceDetails",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "KoreAgentPlatformResourceProvisioningState",
  "csharp"
);
