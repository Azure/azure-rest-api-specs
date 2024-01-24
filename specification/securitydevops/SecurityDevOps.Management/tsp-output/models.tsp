import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SecurityDevOps;

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

model AzureDevOpsConnectorProperties {
  provisioningState?: ProvisioningState;
  authorization?: AuthorizationInfo;

  /**
   * Gets or sets org onboarding information.
   */
  orgs?: AzureDevOpsOrgMetadata[];
}

model AuthorizationInfo {
  /**
   * Gets or sets one-time OAuth code to exchange for refresh and access tokens.
   */
  code?: string;
}

/**
 * Org onboarding info.
 */
model AzureDevOpsOrgMetadata {
  /**
   * Gets or sets name of the AzureDevOps Org.
   */
  name?: string;

  autoDiscovery?: AutoDiscovery;
  projects?: AzureDevOpsProjectMetadata[];
}

/**
 * Project onboarding info.
 */
model AzureDevOpsProjectMetadata {
  /**
   * Gets or sets name of the AzureDevOps Project.
   */
  name?: string;

  autoDiscovery?: AutoDiscovery;

  /**
   * Gets or sets repositories.
   */
  repos?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * AzureDevOps Repo properties.
 */
model AzureDevOpsRepoProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets Azure DevOps repo id.
   */
  repoId?: string;

  /**
   * Gets or sets AzureDevOps repo url.
   */
  repoUrl?: string;

  /**
   * Gets or sets AzureDevOps Org Name.
   */
  orgName?: string;

  /**
   * Gets or sets AzureDevOps Project Name.
   */
  projectName?: string;

  /**
   * Gets or sets AzureDevOps repo visibility, whether it is public or private etc.
   */
  visibility?: string;

  actionableRemediation?: ActionableRemediation;
}

model ActionableRemediation {
  state?: ActionableRemediationState;
  severityLevels?: string[];
  categories?: RuleCategory[];

  /**
   * Branch onboarding info.
   */
  branchConfiguration?: TargetBranchConfiguration;
}

/**
 * Branch onboarding info.
 */
model TargetBranchConfiguration {
  /**
   * Gets or sets branches that should have annotations.
   *
   * For Ignite, we will be supporting a single default branch configuration in the UX.
   */
  names?: string[];
}

model AzureDevOpsConnectorStatsListResponse {
  /**
   * Gets or sets list of resources.
   */
  value?: AzureDevOpsConnectorStats[];

  /**
   * Gets or sets next link to scroll over the results.
   */
  nextLink?: string;
}

model AzureDevOpsConnectorStats extends ProxyResource {
  properties?: AzureDevOpsConnectorStatsProperties;
}

model AzureDevOpsConnectorStatsProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets orgs count.
   */
  orgsCount?: int64;

  /**
   * Gets or sets projects count.
   */
  projectsCount?: int64;

  /**
   * Gets or sets repos count.
   */
  reposCount?: int64;
}

/**
 * AzureDevOps Org properties.
 */
model AzureDevOpsOrgProperties {
  provisioningState?: ProvisioningState;
  autoDiscovery?: AutoDiscovery;
}

/**
 * AzureDevOps Project properties.
 */
model AzureDevOpsProjectProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets AzureDevOps Project Id.
   */
  projectId?: string;

  /**
   * Gets or sets AzureDevOps Org Name.
   */
  orgName?: string;

  autoDiscovery?: AutoDiscovery;
}

/**
 * Properties of the ARM resource for /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
 */
model GitHubConnectorProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets one-time OAuth code to exchange for refresh and access tokens.
   */
  code?: string;
}

/**
 * GitHub Repo properties.
 */
model GitHubRepoProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets gitHub repo account id.
   */
  accountId?: int64;

  /**
   * Gets or sets gitHub repo url.
   */
  repoUrl?: string;

  /**
   * Gets or sets GitHub Owner Name.
   */
  ownerName?: string;
}

model GitHubConnectorStatsListResponse {
  /**
   * Gets or sets list of resources.
   */
  value?: GitHubConnectorStats[];

  /**
   * Gets or sets next link to scroll over the results.
   */
  nextLink?: string;
}

model GitHubConnectorStats extends ProxyResource {
  properties?: GitHubConnectorStatsProperties;
}

model GitHubConnectorStatsProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets owners count.
   */
  ownersCount?: int64;

  /**
   * Gets or sets repos count.
   */
  reposCount?: int64;
}

/**
 * GitHub Repo Owner properties.
 */
model GitHubOwnerProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets gitHub owner url.
   */
  ownerUrl?: string;
}

model GitHubReposProperties {
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets gitHub repo account id.
   */
  accountId?: int64;

  /**
   * Gets or sets gitHub repo name.
   */
  repoName?: string;

  /**
   * Gets or sets gitHub repo url.
   */
  repoUrl?: string;
}
