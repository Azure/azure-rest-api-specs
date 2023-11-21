import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.SecurityDevOps;

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum AutoDiscovery {
  Disabled,
  Enabled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ActionableRemediationState {
  None,
  Disabled,
  Enabled,
}

enum RuleCategory {
  Code,
  Artifacts,
  Dependencies,
  Secrets,
  IaC,
  Containers,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

model AzureDevOpsConnectorListResponse is Azure.Core.Page<AzureDevOpsConnector>;

model AzureDevOpsConnector {
  ...TrackedResource;
  properties?: AzureDevOpsConnectorProperties;
}

model AzureDevOpsConnectorProperties {
  provisioningState?: ProvisioningState;
  authorization?: AuthorizationInfo;

  @doc("Gets or sets org onboarding information.")
  orgs?: AzureDevOpsOrgMetadata[];
}

model AuthorizationInfo {
  @doc("Gets or sets one-time OAuth code to exchange for refresh and access tokens.")
  code?: string;
}

@doc("Org onboarding info.")
model AzureDevOpsOrgMetadata {
  @doc("Gets or sets name of the AzureDevOps Org.")
  name?: string;

  autoDiscovery?: AutoDiscovery;
  projects?: AzureDevOpsProjectMetadata[];
}

@doc("Project onboarding info.")
model AzureDevOpsProjectMetadata {
  @doc("Gets or sets name of the AzureDevOps Project.")
  name?: string;

  autoDiscovery?: AutoDiscovery;

  @doc("Gets or sets repositories.")
  repos?: string[];
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

model AzureDevOpsRepoListResponse is Azure.Core.Page<AzureDevOpsRepo>;

@doc("Azure DevOps Repo Proxy Resource.")
model AzureDevOpsRepo {
  ...ProxyResource;

  @doc("AzureDevOps Repo properties.")
  properties?: AzureDevOpsRepoProperties;
}

@doc("AzureDevOps Repo properties.")
model AzureDevOpsRepoProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets Azure DevOps repo id.")
  repoId?: string;

  @doc("Gets or sets AzureDevOps repo url.")
  repoUrl?: string;

  @doc("Gets or sets AzureDevOps Org Name.")
  orgName?: string;

  @doc("Gets or sets AzureDevOps Project Name.")
  projectName?: string;

  @doc("Gets or sets AzureDevOps repo visibility, whether it is public or private etc.")
  visibility?: string;

  actionableRemediation?: ActionableRemediation;
}

model ActionableRemediation {
  state?: ActionableRemediationState;
  severityLevels?: string[];
  categories?: RuleCategory[];

  @doc("Branch onboarding info.")
  branchConfiguration?: TargetBranchConfiguration;
}

@doc("Branch onboarding info.")
model TargetBranchConfiguration {
  @doc("""
Gets or sets branches that should have annotations.

For Ignite, we will be
supporting a single default branch configuration in the UX.
""")
  names?: string[];
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

model AzureDevOpsConnectorStatsListResponse {
  @doc("Gets or sets list of resources.")
  value?: AzureDevOpsConnectorStats[];

  @doc("Gets or sets next link to scroll over the results.")
  nextLink?: string;
}

model AzureDevOpsConnectorStats {
  ...ProxyResource;
  properties?: AzureDevOpsConnectorStatsProperties;
}

model AzureDevOpsConnectorStatsProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets orgs count.")
  orgsCount?: int32;

  @doc("Gets or sets projects count.")
  projectsCount?: int32;

  @doc("Gets or sets repos count.")
  reposCount?: int32;
}

model AzureDevOpsOrgListResponse is Azure.Core.Page<AzureDevOpsOrg>;

@doc("Azure DevOps Org Proxy Resource.")
model AzureDevOpsOrg {
  ...ProxyResource;

  @doc("AzureDevOps Org properties.")
  properties?: AzureDevOpsOrgProperties;
}

@doc("AzureDevOps Org properties.")
model AzureDevOpsOrgProperties {
  provisioningState?: ProvisioningState;
  autoDiscovery?: AutoDiscovery;
}

model AzureDevOpsProjectListResponse is Azure.Core.Page<AzureDevOpsProject>;

@doc("Azure DevOps Project Proxy Resource.")
model AzureDevOpsProject {
  ...ProxyResource;

  @doc("AzureDevOps Project properties.")
  properties?: AzureDevOpsProjectProperties;
}

@doc("AzureDevOps Project properties.")
model AzureDevOpsProjectProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets AzureDevOps Project Id.")
  projectId?: string;

  @doc("Gets or sets AzureDevOps Org Name.")
  orgName?: string;

  autoDiscovery?: AutoDiscovery;
}

model GitHubConnectorListResponse is Azure.Core.Page<GitHubConnector>;

@doc("""
Represents an ARM resource for
/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
""")
model GitHubConnector {
  ...TrackedResource;

  @doc("""
Properties of the ARM resource for
/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
""")
  properties?: GitHubConnectorProperties;
}

@doc("""
Properties of the ARM resource for
/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
""")
model GitHubConnectorProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets one-time OAuth code to exchange for refresh and access tokens.")
  code?: string;
}

model GitHubRepoListResponse is Azure.Core.Page<GitHubRepo>;

@doc("GitHub repo Proxy Resource.")
model GitHubRepo {
  ...ProxyResource;

  @doc("GitHub Repo properties.")
  properties?: GitHubRepoProperties;
}

@doc("GitHub Repo properties.")
model GitHubRepoProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets gitHub repo account id.")
  accountId?: int32;

  @doc("Gets or sets gitHub repo url.")
  repoUrl?: string;

  @doc("Gets or sets GitHub Owner Name.")
  ownerName?: string;
}

model GitHubConnectorStatsListResponse {
  @doc("Gets or sets list of resources.")
  value?: GitHubConnectorStats[];

  @doc("Gets or sets next link to scroll over the results.")
  nextLink?: string;
}

model GitHubConnectorStats {
  ...ProxyResource;
  properties?: GitHubConnectorStatsProperties;
}

model GitHubConnectorStatsProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets owners count.")
  ownersCount?: int32;

  @doc("Gets or sets repos count.")
  reposCount?: int32;
}

model GitHubOwnerListResponse is Azure.Core.Page<GitHubOwner>;

@doc("GitHub repo owner Proxy Resource.")
model GitHubOwner {
  ...ProxyResource;

  @doc("GitHub Repo Owner properties.")
  properties?: GitHubOwnerProperties;
}

@doc("GitHub Repo Owner properties.")
model GitHubOwnerProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets gitHub owner url.")
  ownerUrl?: string;
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

model GitHubReposProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets gitHub repo account id.")
  accountId?: int32;

  @doc("Gets or sets gitHub repo name.")
  repoName?: string;

  @doc("Gets or sets gitHub repo url.")
  repoUrl?: string;
}
