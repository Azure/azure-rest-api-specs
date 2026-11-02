import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Kore.AgentPlatform;

@@clientName(Kore.AgentPlatform, "KoreAIArtemisMgmtClient", "python");
@@clientName(Kore.AgentPlatform.SaaSOperationGroup, "Saas", "python");
@@clientName(Kore.AgentPlatform.Workspaces.linkSaaS, "link_saas", "python");
@@clientName(
  Kore.AgentPlatform.Workspaces.listLinkedSaaS,
  "list_linked_saas",
  "python"
);
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
  Kore.AgentPlatform.ActivateSaaSParameterRequest,
  "ActivateSaasContent",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationPartnerPropertiesUpdate,
  "KoreAIArtemisOrganizationPartnerPropertiesPatch",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.OrganizationPropertiesUpdate,
  "KoreAIArtemisOrganizationPropertiesPatch",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.Product,
  "KoreAIArtemisWorkspaceProduct",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceSaaSData,
  "WorkspaceSaasContent",
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.WorkspaceDetailPartnerProperties.default,
  "IsDefault",
  "csharp"
);
@@alternateType(
  Kore.AgentPlatform.ActivateSaaSParameterRequest.saasGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Kore.AgentPlatform.SaaSResourceDetailsResponse.saasId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Kore.AgentPlatform.WorkspaceMarketplaceDetails.resourceId,
  Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaS/resources",
    }
  ]>,
  "csharp"
);
@@clientName(
  Kore.AgentPlatform.ListWorkspacesResponse,
  "ListWorkspacesResult",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "KoreAIArtemisOfferDetails", "csharp");
@@clientName(
  LiftrBase.MarketplaceSubscriptionStatus,
  "KoreAIArtemisMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(
  LiftrBase.MarketplaceDetails,
  "KoreAIArtemisMarketplaceDetails",
  "csharp"
);
@@clientName(
  LiftrBase.SingleSignOnStates,
  "KoreAIArtemisSingleSignOnState",
  "csharp"
);
@@clientName(
  LiftrBase.SingleSignOnType,
  "KoreAIArtemisSingleSignOnType",
  "csharp"
);
@@alternateType(
  LiftrBase.MarketplaceDetails.subscriptionId,
  Azure.Core.uuid,
  "csharp"
);

@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "KoreAIArtemisResourceProvisioningState",
  "csharp"
);
