import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The provisioning state of the resource.
 *
 * Pending - Provisioning pending.
 * Failed - Provisioning failed.
 * Succeeded - Successful provisioning.
 * Canceled - Provisioning canceled.
 * PendingDeletion - Deletion pending.
 * DeletionSuccess - Deletion successful.
 * DeletionFailure - Deletion failure.
 */
union DevOpsProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * PendingDeletion
   */
  PendingDeletion: "PendingDeletion",

  /**
   * DeletionSuccess
   */
  DeletionSuccess: "DeletionSuccess",

  /**
   * DeletionFailure
   */
  DeletionFailure: "DeletionFailure",
}

/**
 * Details about resource onboarding status across all connectors.
 *
 * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
 * Onboarded - this resource has already been onboarded by the specified connector.
 * NotOnboarded - this resource has not been onboarded to any connector.
 * NotApplicable - the onboarding state is not applicable to the current endpoint.
 */
union OnboardingState {
  string,

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",

  /**
   * OnboardedByOtherConnector
   */
  OnboardedByOtherConnector: "OnboardedByOtherConnector",

  /**
   * Onboarded
   */
  Onboarded: "Onboarded",

  /**
   * NotOnboarded
   */
  NotOnboarded: "NotOnboarded",
}

/**
 * ActionableRemediation Setting.
 * None - the setting was never set.
 * Enabled - ActionableRemediation is enabled.
 * Disabled - ActionableRemediation is disabled.
 */
union ActionableRemediationState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Rule categories.
 * Code - code scanning results.
 * Artifact scanning results.
 * Dependencies scanning results.
 * IaC results.
 * Secrets scanning results.
 * Container scanning results.
 */
union RuleCategory {
  string,

  /**
   * Code
   */
  Code: "Code",

  /**
   * Artifacts
   */
  Artifacts: "Artifacts",

  /**
   * Dependencies
   */
  Dependencies: "Dependencies",

  /**
   * Secrets
   */
  Secrets: "Secrets",

  /**
   * IaC
   */
  IaC: "IaC",

  /**
   * Containers
   */
  Containers: "Containers",
}

/**
 * Configuration of PR Annotations on default branch.
 *
 * Enabled - PR Annotations are enabled on the resource's default branch.
 * Disabled - PR Annotations are disabled on the resource's default branch.
 */
union AnnotateDefaultBranchState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Update Settings.
 *
 * Enabled - Resource should inherit configurations from parent.
 * Disabled - Resource should not inherit configurations from parent.
 */
union InheritFromParentState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * AutoDiscovery states.
 */
union AutoDiscovery {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",
}

/**
 * Agentless Enablement states.
 */
union AgentlessEnablement {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",
}

/**
 * Types for inventory list.
 */
union InventoryListKind {
  string,

  /**
   * Inclusion
   */
  Inclusion: "Inclusion",

  /**
   * Exclusion
   */
  Exclusion: "Exclusion",
}

/**
 * Types for inventory kind.
 */
union InventoryKind {
  string,

  /**
   * AzureDevOpsOrganization
   */
  AzureDevOpsOrganization: "AzureDevOpsOrganization",

  /**
   * AzureDevOpsProject
   */
  AzureDevOpsProject: "AzureDevOpsProject",

  /**
   * AzureDevOpsRepository
   */
  AzureDevOpsRepository: "AzureDevOpsRepository",

  /**
   * GitHubOwner
   */
  GitHubOwner: "GitHubOwner",

  /**
   * GitHubRepository
   */
  GitHubRepository: "GitHubRepository",
}

/**
 * Onboarding states.
 */
union DesiredOnboardingState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * List of RP resources which supports pagination.
 */
model AzureDevOpsOrgListResponse {
  /**
   * The AzureDevOpsOrg items on this page.
   */
  @pageItems
  value?: AzureDevOpsOrg[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Azure DevOps Organization properties.
 */
model AzureDevOpsOrgProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;

  /**
   * Configuration payload for PR Annotations.
   */
  actionableRemediation?: ActionableRemediation;
}

/**
 * Configuration payload for PR Annotations.
 */
model ActionableRemediation {
  /**
   * ActionableRemediation Setting.
   * None - the setting was never set.
   * Enabled - ActionableRemediation is enabled.
   * Disabled - ActionableRemediation is disabled.
   */
  state?: ActionableRemediationState;

  /**
   * Gets or sets list of categories and severity levels.
   */
  @identifiers(#[])
  categoryConfigurations?: CategoryConfiguration[];

  /**
   * Repository branch configuration for PR Annotations.
   */
  branchConfiguration?: TargetBranchConfiguration;

  /**
   * Update Settings.
   *
   * Enabled - Resource should inherit configurations from parent.
   * Disabled - Resource should not inherit configurations from parent.
   */
  inheritFromParentState?: InheritFromParentState;
}

/**
 * Severity level per category configuration for PR Annotations.
 */
model CategoryConfiguration {
  /**
   * Gets or sets minimum severity level for a given category.
   */
  minimumSeverityLevel?: string;

  /**
   * Rule categories.
   * Code - code scanning results.
   * Artifact scanning results.
   * Dependencies scanning results.
   * IaC results.
   * Secrets scanning results.
   * Container scanning results.
   */
  category?: RuleCategory;
}

/**
 * Repository branch configuration for PR Annotations.
 */
model TargetBranchConfiguration {
  /**
   * Gets or sets branches that should have annotations.
   */
  branchNames?: string[];

  /**
   * Configuration of PR Annotations on default branch.
   *
   * Enabled - PR Annotations are enabled on the resource's default branch.
   * Disabled - PR Annotations are disabled on the resource's default branch.
   */
  annotateDefaultBranch?: AnnotateDefaultBranchState;
}

/**
 * List of RP resources which supports pagination.
 */
model AzureDevOpsProjectListResponse {
  /**
   * The AzureDevOpsProject items on this page.
   */
  @pageItems
  value?: AzureDevOpsProject[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Azure DevOps Project properties.
 */
model AzureDevOpsProjectProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets parent Azure DevOps Organization name.
   */
  parentOrgName?: string;

  /**
   * Gets or sets Azure DevOps Project id.
   */
  @visibility(Lifecycle.Read)
  projectId?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;

  /**
   * Configuration payload for PR Annotations.
   */
  actionableRemediation?: ActionableRemediation;
}

/**
 * List of RP resources which supports pagination.
 */
model AzureDevOpsRepositoryListResponse {
  /**
   * The AzureDevOpsRepository items on this page.
   */
  @pageItems
  value?: AzureDevOpsRepository[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Azure DevOps Repository properties.
 */
model AzureDevOpsRepositoryProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets parent Azure DevOps Organization name.
   */
  parentOrgName?: string;

  /**
   * Gets or sets parent Azure DevOps Project name.
   */
  parentProjectName?: string;

  /**
   * Gets or sets Azure DevOps Repository id.
   */
  @visibility(Lifecycle.Read)
  repoId?: string;

  /**
   * Gets or sets Azure DevOps Repository url.
   */
  @visibility(Lifecycle.Read)
  repoUrl?: string;

  /**
   * Gets or sets Azure DevOps repository visibility, whether it is public or private etc.
   */
  @visibility(Lifecycle.Read)
  visibility?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;

  /**
   * Configuration payload for PR Annotations.
   */
  actionableRemediation?: ActionableRemediation;
}

/**
 * List of RP resources which supports pagination.
 */
model DevOpsConfigurationListResponse {
  /**
   * The DevOpsConfiguration items on this page.
   */
  @pageItems
  value?: DevOpsConfiguration[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * DevOps Configuration properties.
 */
model DevOpsConfigurationProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Authorization payload.
   */
  authorization?: Authorization;

  /**
   * AutoDiscovery states.
   */
  autoDiscovery?: AutoDiscovery;

  /**
   * List of top-level inventory to select when AutoDiscovery is disabled.
   * This field is ignored when AutoDiscovery is enabled.
   */
  topLevelInventoryList?: string[];

  /**
   * List of capabilities assigned to the DevOps configuration during the discovery process.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  capabilities?: DevOpsCapability[];

  /**
   * Details about Agentless configuration.
   */
  agentlessConfiguration?: AgentlessConfiguration;
}

/**
 * Authorization payload.
 */
model Authorization {
  /**
   * Gets or sets one-time OAuth code to exchange for refresh and access tokens.
   *
   * Only used during PUT/PATCH operations. The secret is cleared during GET.
   */
  @secret
  code?: string;
}

/**
 * Details about DevOps capability.
 */
model DevOpsCapability {
  /**
   * Gets the name of the DevOps capability.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the value of the DevOps capability.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Details about Agentless configuration.
 */
model AgentlessConfiguration {
  /**
   * Agentless Enablement states.
   */
  agentlessEnabled?: AgentlessEnablement;

  /**
   * AutoDiscovery states.
   */
  agentlessAutoDiscovery?: AutoDiscovery;

  /**
   * Gets or sets the scanners for the connector.
   */
  scanners?: string[];

  /**
   * Types for inventory list.
   */
  inventoryListType?: InventoryListKind;

  /**
   * Gets or sets the inventory list for inclusion or exclusion from Agentless.
   * Will be ignored if agentless auto-discovery is enabled.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  inventoryList?: InventoryList[];
}

/**
 * Model for inventory to be included or excluded from Agentless.
 */
model InventoryList {
  /**
   * Types for inventory kind.
   */
  inventoryKind?: InventoryKind;

  /**
   * Gets or sets the value for inventory type.
   */
  value?: string;
}

/**
 * List of RP resources which supports pagination.
 */
model GitHubOwnerListResponse {
  /**
   * The GitHubOwner items on this page.
   */
  @pageItems
  value?: GitHubOwner[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * GitHub Owner properties.
 */
model GitHubOwnerProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets GitHub Owner url.
   */
  @visibility(Lifecycle.Read)
  ownerUrl?: string;

  /**
   * Gets or sets internal GitHub id.
   */
  @visibility(Lifecycle.Read)
  gitHubInternalId?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;
}

/**
 * List of RP resources which supports pagination.
 */
model GitHubRepositoryListResponse {
  /**
   * The GitHubRepository items on this page.
   */
  @pageItems
  value?: GitHubRepository[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * GitHub Repository properties.
 */
model GitHubRepositoryProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets GitHub Repository id.
   *
   * This is a numeric id defined by Github.
   * Eg: "123456".
   */
  @visibility(Lifecycle.Read)
  repoId?: string;

  /**
   * Gets or sets GitHub Repository name.
   * Eg: "new-repo-1".
   */
  @visibility(Lifecycle.Read)
  repoName?: string;

  /**
   * Gets or sets GitHub Full Name.
   * Repository name, prefixed with Owner name.
   * Eg: "my-org/new-repo-1".
   */
  @visibility(Lifecycle.Read)
  repoFullName?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;

  /**
   * Gets or sets GitHub Repository url.
   */
  @visibility(Lifecycle.Read)
  repoUrl?: string;

  /**
   * Gets or sets parent GitHub Owner name.
   */
  parentOwnerName?: string;
}

/**
 * The issue creation request model
 */
model IssueCreationRequest {
  /**
   * The security assessment resource id that the issue will be opened based on.
   */
  securityAssessmentResourceId?: string;
}

/**
 * List of RP resources which supports pagination.
 */
model GitLabGroupListResponse {
  /**
   * The GitLabGroup items on this page.
   */
  @pageItems
  value?: GitLabGroup[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * GitLab Group properties.
 */
model GitLabGroupProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets the fully-qualified name of the Group object.
   *
   * This contains the entire namespace hierarchy where namespaces are separated by the '$' character.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedName?: string;

  /**
   * Gets or sets the human readable fully-qualified name of the Group object.
   *
   * This contains the entire namespace hierarchy as seen on GitLab UI where namespaces are separated by the '/' character.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedFriendlyName?: string;

  /**
   * Gets or sets the url of the GitLab Group.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;
}

/**
 * List of RP resources which supports pagination.
 */
model GitLabProjectListResponse {
  /**
   * The GitLabProject items on this page.
   */
  @pageItems
  value?: GitLabProject[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * GitLab Project properties.
 */
model GitLabProjectProperties {
  /**
   * Gets the resource status message.
   */
  @visibility(Lifecycle.Read)
  provisioningStatusMessage?: string;

  /**
   * Gets the time when resource was last checked.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStatusUpdateTimeUtc?: utcDateTime;

  /**
   * The provisioning state of the resource.
   *
   * Pending - Provisioning pending.
   * Failed - Provisioning failed.
   * Succeeded - Successful provisioning.
   * Canceled - Provisioning canceled.
   * PendingDeletion - Deletion pending.
   * DeletionSuccess - Deletion successful.
   * DeletionFailure - Deletion failure.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevOpsProvisioningState;

  /**
   * Gets or sets the fully-qualified name of the project object.
   *
   * This contains the entire hierarchy where entities are separated by the '$' character.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedName?: string;

  /**
   * Gets or sets the human readable fully-qualified name of the Project object.
   *
   * This contains the entire namespace hierarchy as seen on GitLab UI where entities are separated by the '/' character.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedFriendlyName?: string;

  /**
   * Gets or sets the fully-qualified name of the project's parent group object.
   *
   * This contains the entire hierarchy where namespaces are separated by the '$' character.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedParentGroupName?: string;

  /**
   * Gets or sets the url of the GitLab Project.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Details about resource onboarding status across all connectors.
   *
   * OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
   * Onboarded - this resource has already been onboarded by the specified connector.
   * NotOnboarded - this resource has not been onboarded to any connector.
   * NotApplicable - the onboarding state is not applicable to the current endpoint.
   */
  onboardingState?: OnboardingState;
}

/**
 * AzureDevOps Org Inventory Configuration.
 */
model AzureDevOpsOrganizationConfiguration {
  /**
   * AutoDiscovery states.
   */
  autoDiscovery?: AutoDiscovery;

  /**
   * AzureDevOps Project Inventory Configuration.
   * Dictionary of AzureDevOps project name to desired project configuration.
   * If AutoDiscovery is Enabled, this field should be empty or null.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectConfigs?: Record<AzureDevOpsProjectConfiguration>;
}

/**
 * AzureDevOps Project Inventory Configuration.
 */
model AzureDevOpsProjectConfiguration {
  /**
   * AutoDiscovery states.
   */
  autoDiscovery?: AutoDiscovery;

  /**
   * AzureDevOps Repository Inventory Configuration.
   * Dictionary of AzureDevOps repository name to desired repository configuration.
   * If AutoDiscovery is Enabled, this field should be null or empty.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repositoryConfigs?: Record<BaseResourceConfiguration>;
}

/**
 * Base Resource Inventory configuration changes.
 */
model BaseResourceConfiguration {
  /**
   * Onboarding states.
   */
  desiredOnboardingState?: DesiredOnboardingState;
}

/**
 * GitHub Owner Inventory Configuration.
 */
model GitHubOwnerConfiguration {
  /**
   * AutoDiscovery states.
   */
  autoDiscovery?: AutoDiscovery;

  /**
   * GitHub Repository Inventory Configuration.
   * Dictionary of GitHub repository name to desired repository configuration.
   * If AutoDiscovery is Enabled, this field should be null or empty.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repositoryConfigs?: Record<BaseResourceConfiguration>;
}

/**
 * GitLab Group Inventory Configuration.
 */
model GitLabGroupConfiguration {
  /**
   * AutoDiscovery states.
   */
  autoDiscovery?: AutoDiscovery;

  /**
   * GitLab Project Inventory Configuration.
   * Dictionary of GitLab fully-qualified project name to desired project configuration.
   * If AutoDiscovery is Enabled, this field should be null or empty.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectConfigs?: Record<BaseResourceConfiguration>;
}
