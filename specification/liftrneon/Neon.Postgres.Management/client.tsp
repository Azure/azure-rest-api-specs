import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Neon.Postgres;

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
@@clientName(Project, "NeonProject", "csharp");
@@clientName(ProjectProperties, "NeonProjectProperties", "csharp");
@@clientName(Branch, "NeonBranch", "csharp");
@@clientName(BranchProperties, "NeonBranchProperties", "csharp");
@@clientName(Endpoint, "NeonEndpoint", "csharp");
@@clientName(EndpointProperties, "NeonEndpointProperties", "csharp");
@@clientName(Compute, "NeonCompute", "csharp");
@@clientName(ComputeProperties, "NeonComputeProperties", "csharp");
@@clientName(ProjectProperties.pgVersion, "postgresVersion", "csharp");
@@clientName(ProjectProperties.attributes, "attribute", "csharp");
@@clientName(ProjectProperties.pgVersion, "postgresVersion", "csharp");
@@clientName(AutoscalingSize, "NeonComputeAutoscalingSize", "csharp");
@@clientName(EndpointStatus, "NeonComputeEndpointStatus", "csharp");
@@clientName(EntityType, "PreflightCheckEntityType", "csharp");
@@clientName(BranchProperties.protected, "IsProtected", "csharp");
@@clientName(NeonDatabaseProperties.lastUpdated, "lastUpdatedOn", "csharp");
@@alternateType(NeonDatabaseProperties.lastUpdated, utcDateTime, "csharp");
@@clientName(EndpointProperties.lastActive, "lastActiveOn", "csharp");
@@alternateType(EndpointProperties.lastActive, utcDateTime, "csharp");
@@clientName(NeonRoleProperties.lastUpdated, "lastUpdatedOn", "csharp");
@@alternateType(NeonRoleProperties.lastUpdated, utcDateTime, "csharp");

@@clientName(Versions.v1_preview, "V20241222Preview", "javascript");
@@clientName(Versions.v2_preview, "V20250301Preview", "javascript");
@@clientName(Versions.v3_preview, "V20250623Preview", "javascript");
@@clientName(PreflightCheckParameters, "PreflightCheckContent", "csharp");
@@clientName(Computes.list, "GetComputes", "csharp");
@@clientName(NeonRoles.delete, "DeleteNeonRole", "csharp");
@@clientName(NeonRoles.list, "GetNeonRoles", "csharp");
@@clientName(Endpoints.delete, "DeleteNeonEndpoint", "csharp");
@@clientName(Endpoints.list, "GetEndpoints", "csharp");
@@clientName(NeonDatabases.list, "GetNeonDatabases", "csharp");
@@clientName(Organizations.getPostgresVersions,
  "GetPostgresVersionsOrganization",
  "csharp"
);
