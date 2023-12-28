import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.SecurityDevOps;

interface Operations extends Azure.ResourceManager.Operations {}

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

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
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

For Ignite, we will be supporting a single default branch configuration in the UX.
""")
  names?: string[];
}

model AzureDevOpsConnectorStatsListResponse {
  @doc("Gets or sets list of resources.")
  value?: AzureDevOpsConnectorStats[];

  @doc("Gets or sets next link to scroll over the results.")
  nextLink?: string;
}

model AzureDevOpsConnectorStats extends ProxyResource {
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

@doc("AzureDevOps Org properties.")
model AzureDevOpsOrgProperties {
  provisioningState?: ProvisioningState;
  autoDiscovery?: AutoDiscovery;
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

@doc("Properties of the ARM resource for /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.")
model GitHubConnectorProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets one-time OAuth code to exchange for refresh and access tokens.")
  code?: string;
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

model GitHubConnectorStats extends ProxyResource {
  properties?: GitHubConnectorStatsProperties;
}

model GitHubConnectorStatsProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets owners count.")
  ownersCount?: int32;

  @doc("Gets or sets repos count.")
  reposCount?: int32;
}

@doc("GitHub Repo Owner properties.")
model GitHubOwnerProperties {
  provisioningState?: ProvisioningState;

  @doc("Gets or sets gitHub owner url.")
  ownerUrl?: string;
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
