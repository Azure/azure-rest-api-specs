import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CognitiveServices;

/**
 * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Free pricing tier"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Basic pricing tier"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Standard pricing tier"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Premium pricing tier"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Enterprise pricing tier"
  Enterprise: "Enterprise",
}

/**
 * Gets the status of the cognitive services account at the time the operation was called.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Request has been accepted for processing"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource is being created"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: account is being moved between regions"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Provisioning has failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Provisioning completed successfully"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Provisioning was canceled by the user"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: DNS records are being resolved during account creation"
  ResolvingDNS: "ResolvingDNS",
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union NetworkRuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "All networks are allowed access"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Only selected networks are allowed access"
  Deny: "Deny",
}

/**
 * Setting for trusted services.
 */
union ByPassSelection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No bypass - all traffic subject to network rules"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Allow trusted Azure services to bypass network rules"
  AzureServices: "AzureServices",
}

/**
 * Enumerates the possible value of keySource for Encryption
 */
union KeySource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption key managed by Microsoft Cognitive Services"
  `Microsoft.CognitiveServices`: "Microsoft.CognitiveServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption key managed by customer's Azure Key Vault"
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource was created by a user"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource was created by an application"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource was created by a managed identity"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Resource was created by a key"
  Key: "Key",
}

/**
 * Whether or not public endpoint access is allowed for this account.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Public endpoint access is enabled for the account"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Public endpoint access is disabled for the account"
  Disabled: "Disabled",
}

/**
 * Multiregion routing methods.
 */
union RoutingMethods {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Route traffic based on endpoint priority"
  Priority: "Priority",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Route traffic based on assigned weights"
  Weighted: "Weighted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Route traffic to the nearest endpoint by latency"
  Performance: "Performance",
}

/**
 * The action of AbusePenalty.
 */
union AbusePenaltyAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Throttle the request rate as a penalty action"
  Throttle: "Throttle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Block requests entirely as a penalty action"
  Block: "Block",
}

/**
 * Specifies what features in AI Foundry network injection applies to. Currently only supports 'agent' for agent scenarios. 'none' means no network injection.
 */
union ScenarioType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No network injection scenario"
  none: "none",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Agent-based network injection scenario"
  agent: "agent",
}

/**
 * The reason for restriction.
 */
union ResourceSkuRestrictionsReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Restricted due to quota limits"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SKU not available for this subscription"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The unit of the metric.
 */
union UnitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Count unit of measurement"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Bytes unit of measurement"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Seconds unit of measurement"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Percentage unit of measurement"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Count per second unit of measurement"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Bytes per second unit of measurement"
  BytesPerSecond: "BytesPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Milliseconds unit of measurement"
  Milliseconds: "Milliseconds",
}

/**
 * Cognitive Services account quota usage status.
 */
union QuotaUsageStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Usage is within the included quota"
  Included: "Included",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Usage is blocked"
  Blocked: "Blocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Usage has exceeded the quota limit"
  InOverage: "InOverage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Usage status is unknown"
  Unknown: "Unknown",
}

/**
 * The quota scope that determines the level at which the quota is applied.
 */
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
union QuotaScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Regional quota scope"
  Regional: "Regional",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Global quota scope"
  Global: "Global",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "DataZone quota scope"
  DataZone: "DataZone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Classic quota scope"
  Classic: "Classic",
}

/**
 * Indicates whether the deprecation date is a confirmed planned end-of-life date or an estimated deprecation date. When 'Planned', the deprecation date represents a confirmed and communicated model end-of-life date. When 'Tentative', the deprecation date is an estimated timeline that may be subject to change.
 */
union DeprecationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deprecation is planned with a confirmed date"
  Planned: "Planned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deprecation is tentative and may change"
  Tentative: "Tentative",
}

/**
 * Model lifecycle status.
 */
union ModelLifecycleStatus {
  string,

  /**
   * Legacy state. Replaced with GenerallyAvailable going forward.
   */
  Stable: "Stable",

  /**
   * Model is in preview and may be subject to changes.
   */
  Preview: "Preview",

  /**
   * Model is generally available for production use.
   */
  GenerallyAvailable: "GenerallyAvailable",

  /**
   * Model is being deprecated and will be removed in the future. Only customers with existing deployments can create new deployments with this model.
   */
  Deprecating: "Deprecating",

  /**
   * Model has been deprecated, also known as retired, and is no longer supported. Inference calls to deployments of models in this lifecycle state will return 410 errors.
   */
  Deprecated: "Deprecated",

  /**
   * Model is a legacy version that is no longer recommended for use. Customers should migrate to newer models. Check replacementConfig for upgrade information.
   */
  Legacy: "Legacy",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Operation initiated by a user"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Operation initiated by the system"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Operation initiated by user or system"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Action type for internal-only APIs"
  Internal: "Internal",
}

/**
 * Account hosting model.
 */
union HostingModel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Web-hosted deployment model"
  Web: "Web",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Connected container deployment model"
  ConnectedContainer: "ConnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Disconnected container deployment model"
  DisconnectedContainer: "DisconnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Provisioned web deployment model"
  ProvisionedWeb: "ProvisionedWeb",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union DeploymentProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment request has been accepted for processing"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment is being created"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: deployment is being moved"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment provisioning has failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment provisioning completed successfully"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: deployment has been disabled"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deployment provisioning was canceled"
  Canceled: "Canceled",
}

/**
 * Deployment scale type.
 */
union DeploymentScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Standard auto-scaling deployment type"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Manually scaled deployment type"
  Manual: "Manual",
}

/**
 * Deployment model version upgrade option.
 */
union DeploymentModelVersionUpgradeOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-upgrade when a new default model version is available. If no new version exists and current expires, model becomes unusable."
  OnceNewDefaultVersionAvailable: "OnceNewDefaultVersionAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-upgrade after the current version expires. Data plane continues working during upgrade; failures trigger DRI notification."
  OnceCurrentVersionExpired: "OnceCurrentVersionExpired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No automatic upgrade. If version expires, deployment is disabled and data plane stops immediately."
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * The service tier for the deployment. Determines the pricing and performance level for request processing. Use 'Default' for standard pricing or 'Priority' for higher-priority processing with premium pricing. Note: Pause operations are only supported on Standard, DataZoneStandard, and GlobalStandard SKUs.
 */
union ServiceTier {
  string,

  /**
   * Default service tier meaning the request will be processed with the standard pricing and performance for the selected model.
   */
  Default: "Default",

  /**
   * Priority service tier meaning the request will be processed with higher pricing and performance for the selected model.
   */
  Priority: "Priority",
}

/**
 * The state of the deployment. Controls whether the deployment is accepting inference requests. Use 'Running' for active deployments that process requests, or 'Paused' to temporarily stop inference while preserving the deployment configuration.
 */
union DeploymentState {
  string,

  /**
   * The deployment is running and accepting inference requests.
   */
  Running: "Running",

  /**
   * The deployment is paused and not accepting inference requests.
   */
  Paused: "Paused",
}

/**
 * The routing mode that determines how requests are distributed across models.
 */
union RoutingMode {
  string,

  /**
   * Route requests to minimize cost while meeting performance requirements.
   */
  Cost: "cost",

  /**
   * Balance cost and accuracy when routing requests across models.
   */
  Balanced: "balanced",

  /**
   * Route requests to maximize accuracy regardless of cost.
   */
  Accuracy: "accuracy",
}

/**
 * Routing configuration for the deployment. Specifies how requests are routed across multiple models.
 */
model DeploymentRouting {
  /**
   * The routing mode that determines how requests are distributed across models.
   */
  mode?: RoutingMode = RoutingMode.Balanced;

  /**
   * Optional. The list of models that the model router can use to route requests across. If not specified, the model router will route to all available models specified in the model-router version.
   */
  @identifiers(#["name", "version"])
  models?: DeploymentModel[];
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union CommitmentPlanProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan request has been accepted for processing"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan is being created"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: commitment plan is being moved"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan provisioning has failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan provisioning completed successfully"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Commitment plan provisioning was canceled"
  Canceled: "Canceled",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union EncryptionScopeProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope request has been accepted for processing"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope is being created"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "CognitiveServices-specific: encryption scope is being moved"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope provisioning has failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope provisioning completed successfully"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope provisioning was canceled"
  Canceled: "Canceled",
}

/**
 * The encryptionScope state.
 */
union EncryptionScopeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope is disabled"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Encryption scope is enabled"
  Enabled: "Enabled",
}

/**
 * Content Filters policy type.
 */
union RaiPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "User-managed RAI policy that can be customized"
  UserManaged: "UserManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "System-managed RAI policy maintained by the service"
  SystemManaged: "SystemManaged",
}

/**
 * Rai policy mode. The enum value mapping is as below: Default = 0, Deferred=1, Blocking=2, Asynchronous_filter =3. Please use 'Asynchronous_filter' after 2025-06-01. It is the same as 'Deferred' in previous version.
 */
union RaiPolicyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Default synchronous annotation mode"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deferred asynchronous annotation mode"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Blocking mode that prevents content from being returned"
  Blocking: "Blocking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Asynchronous filtering mode"
  Asynchronous_filter: "Asynchronous_filter",
}

/**
 * Level at which content is filtered.
 */
union ContentLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Low sensitivity content filtering level"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Medium sensitivity content filtering level"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "High sensitivity content filtering level"
  High: "High",
}

/**
 * Content source to apply the Content Filters.
 */
union RaiPolicyContentSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content from the user prompt input"
  Prompt: "Prompt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content from the model completion output"
  Completion: "Completion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content evaluated before a tool call is made"
  PreToolCall: "PreToolCall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content evaluated after a tool call returns"
  PostToolCall: "PostToolCall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content evaluated before a run execution"
  PreRun: "PreRun",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Content evaluated after a run execution"
  PostRun: "PostRun",
}

/**
 * The action types to apply to the content filters
 */
union RaiActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No action taken on the content"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Block the content from being processed or returned"
  BLOCKING: "BLOCKING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Annotate the content with safety classifications"
  ANNOTATING: "ANNOTATING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Human-in-the-loop review required for the content"
  HITL: "HITL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Retry content generation with modified parameters"
  RETRY: "RETRY",
}

/**
 * Direction of Access Rule
 */
union NspAccessRuleDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Inbound network access rule direction"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound network access rule direction"
  Outbound: "Outbound",
}

/**
 * Defender for AI state on the AI resource.
 */
union DefenderForAISettingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Defender for AI protection is disabled on this resource"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Defender for AI protection is enabled on this resource"
  Enabled: "Enabled",
}

/**
 * Authentication type of the connection target
 */
union ConnectionAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Personal Access Token authentication"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Managed Identity authentication"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Username and password (basic) authentication"
  UsernamePassword: "UsernamePassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No authentication required"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Shared Access Signature authentication"
  SAS: "SAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Storage account key authentication"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Service principal (app registration) authentication"
  ServicePrincipal: "ServicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Access key authentication"
  AccessKey: "AccessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "API key authentication"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom key-value pair authentication"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "OAuth 2.0 authentication flow"
  OAuth2: "OAuth2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Active Directory authentication"
  AAD: "AAD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Delegated Shared Access Signature authentication"
  DelegatedSAS: "DelegatedSAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Project-scoped managed identity authentication"
  ProjectManagedIdentity: "ProjectManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Account-scoped managed identity authentication"
  AccountManagedIdentity: "AccountManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "User Entra (Azure AD) token authentication"
  UserEntraToken: "UserEntraToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Agent user impersonation authentication"
  AgentUserImpersonation: "AgentUserImpersonation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Agentic identity token authentication"
  AgenticIdentityToken: "AgenticIdentityToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Agentic user authentication"
  AgenticUser: "AgenticUser",
}

/**
 * Category of the connection
 */
union ConnectionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Python package feed connection"
  PythonFeed: "PythonFeed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Container registry connection"
  ContainerRegistry: "ContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Git repository connection"
  Git: "Git",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon S3 storage connection"
  S3: "S3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Snowflake data warehouse connection"
  Snowflake: "Snowflake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Key Vault connection"
  AzureKeyVault: "AzureKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure SQL Database connection"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Synapse Analytics connection"
  AzureSynapseAnalytics: "AzureSynapseAnalytics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Database for MySQL connection"
  AzureMySqlDb: "AzureMySqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Database for PostgreSQL connection"
  AzurePostgresDb: "AzurePostgresDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Data Lake Storage Gen2 connection"
  ADLSGen2: "ADLSGen2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Container App Environment connection"
  AzureContainerAppEnvironment: "AzureContainerAppEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Redis cache connection"
  Redis: "Redis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "API key-based service connection"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure OpenAI service connection"
  AzureOpenAI: "AzureOpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure AI Services connection"
  AIServices: "AIServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Cognitive Search (AI Search) connection"
  CognitiveSearch: "CognitiveSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Cognitive Service connection"
  CognitiveService: "CognitiveService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection using custom key-value pairs"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Blob Storage connection"
  AzureBlob: "AzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Storage Account connection"
  AzureStorageAccount: "AzureStorageAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft OneLake connection"
  AzureOneLake: "AzureOneLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Cosmos DB (SQL API) connection"
  CosmosDb: "CosmosDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Cosmos DB (MongoDB API) connection"
  CosmosDbMongoDbApi: "CosmosDbMongoDbApi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Data Explorer (Kusto) connection"
  AzureDataExplorer: "AzureDataExplorer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Database for MariaDB connection"
  AzureMariaDb: "AzureMariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Databricks Delta Lake connection"
  AzureDatabricksDeltaLake: "AzureDatabricksDeltaLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure SQL Managed Instance connection"
  AzureSqlMi: "AzureSqlMi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure Table Storage connection"
  AzureTableStorage: "AzureTableStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon RDS for Oracle connection"
  AmazonRdsForOracle: "AmazonRdsForOracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon RDS for SQL Server connection"
  AmazonRdsForSqlServer: "AmazonRdsForSqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon Redshift connection"
  AmazonRedshift: "AmazonRedshift",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "IBM Db2 database connection"
  Db2: "Db2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Drill connection"
  Drill: "Drill",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Google BigQuery connection"
  GoogleBigQuery: "GoogleBigQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Greenplum database connection"
  Greenplum: "Greenplum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache HBase connection"
  Hbase: "Hbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Hive connection"
  Hive: "Hive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Impala connection"
  Impala: "Impala",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "IBM Informix database connection"
  Informix: "Informix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "MariaDB database connection"
  MariaDb: "MariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft Access database connection"
  MicrosoftAccess: "MicrosoftAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "MySQL database connection"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "IBM Netezza connection"
  Netezza: "Netezza",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Oracle database connection"
  Oracle: "Oracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Phoenix connection"
  Phoenix: "Phoenix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "PostgreSQL database connection"
  PostgreSql: "PostgreSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Presto distributed SQL connection"
  Presto: "Presto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP Open Hub connection"
  SapOpenHub: "SapOpenHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP Business Warehouse connection"
  SapBw: "SapBw",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP HANA database connection"
  SapHana: "SapHana",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP Table connection"
  SapTable: "SapTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Spark connection"
  Spark: "Spark",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SQL Server database connection"
  SqlServer: "SqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP Sybase database connection"
  Sybase: "Sybase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Teradata database connection"
  Teradata: "Teradata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Vertica database connection"
  Vertica: "Vertica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Pinecone vector database connection"
  Pinecone: "Pinecone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Databricks workspace connection"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Apache Cassandra database connection"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Couchbase database connection"
  Couchbase: "Couchbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "MongoDB v2 connection"
  MongoDbV2: "MongoDbV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "MongoDB Atlas connection"
  MongoDbAtlas: "MongoDbAtlas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon S3-compatible storage connection"
  AmazonS3Compatible: "AmazonS3Compatible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "File server connection"
  FileServer: "FileServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FTP server connection"
  FtpServer: "FtpServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Google Cloud Storage connection"
  GoogleCloudStorage: "GoogleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Hadoop Distributed File System connection"
  Hdfs: "Hdfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Oracle Cloud Storage connection"
  OracleCloudStorage: "OracleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SFTP server connection"
  Sftp: "Sftp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Generic HTTP endpoint connection"
  GenericHttp: "GenericHttp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "OData REST API connection"
  ODataRest: "ODataRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "ODBC data source connection"
  Odbc: "Odbc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Generic REST API connection"
  GenericRest: "GenericRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Remote tool connection"
  RemoteTool: "RemoteTool",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Amazon Marketplace Web Service connection"
  AmazonMws: "AmazonMws",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Concur service connection"
  Concur: "Concur",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft Dynamics connection"
  Dynamics: "Dynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft Dynamics AX connection"
  DynamicsAx: "DynamicsAx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft Dynamics CRM connection"
  DynamicsCrm: "DynamicsCrm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Google AdWords connection"
  GoogleAdWords: "GoogleAdWords",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "HubSpot connection"
  Hubspot: "Hubspot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Jira connection"
  Jira: "Jira",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Magento connection"
  Magento: "Magento",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Marketo connection"
  Marketo: "Marketo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Office 365 connection"
  Office365: "Office365",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Oracle Eloqua connection"
  Eloqua: "Eloqua",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Oracle Responsys connection"
  Responsys: "Responsys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Oracle Service Cloud connection"
  OracleServiceCloud: "OracleServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "PayPal connection"
  PayPal: "PayPal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "QuickBooks connection"
  QuickBooks: "QuickBooks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Salesforce connection"
  Salesforce: "Salesforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Salesforce Service Cloud connection"
  SalesforceServiceCloud: "SalesforceServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Salesforce Marketing Cloud connection"
  SalesforceMarketingCloud: "SalesforceMarketingCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP Cloud for Customer connection"
  SapCloudForCustomer: "SapCloudForCustomer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAP ECC connection"
  SapEcc: "SapEcc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "ServiceNow connection"
  ServiceNow: "ServiceNow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SharePoint Online List connection"
  SharePointOnlineList: "SharePointOnlineList",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Shopify connection"
  Shopify: "Shopify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Square connection"
  Square: "Square",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Web Table connection"
  WebTable: "WebTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Xero connection"
  Xero: "Xero",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Zoho connection"
  Zoho: "Zoho",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Generic container registry connection"
  GenericContainerRegistry: "GenericContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Elasticsearch connection"
  Elasticsearch: "Elasticsearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Application Insights connection"
  AppInsights: "AppInsights",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure App Configuration connection"
  AppConfig: "AppConfig",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "OpenAI service connection"
  OpenAI: "OpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Search engine results page API connection"
  Serp: "Serp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Bing LLM Search connection"
  BingLLMSearch: "BingLLMSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Serverless endpoint connection"
  Serverless: "Serverless",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed online endpoint connection"
  ManagedOnlineEndpoint: "ManagedOnlineEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure API Management connection"
  ApiManagement: "ApiManagement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Model gateway connection"
  ModelGateway: "ModelGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Grounding with Bing Search connection"
  GroundingWithBingSearch: "GroundingWithBingSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Grounding with custom search connection"
  GroundingWithCustomSearch: "GroundingWithCustomSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SharePoint connection"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Microsoft Fabric connection"
  MicrosoftFabric: "MicrosoftFabric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Power Platform environment connection"
  PowerPlatformEnvironment: "PowerPlatformEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Remote agent-to-agent protocol connection"
  RemoteA2A: "RemoteA2A",
}

/**
 * Group based on connection category
 */
union ConnectionGroup {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure platform service connections"
  Azure: "Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Azure AI service connections"
  AzureAI: "AzureAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Database connections"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "NoSQL database connections"
  NoSQL: "NoSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "File storage connections"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Generic protocol connections"
  GenericProtocol: "GenericProtocol",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Third-party services and application connections"
  ServicesAndApps: "ServicesAndApps",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint requirement state from AML RP WorkspaceConnectionDtoV2"
union ManagedPERequirement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint is required for this connection"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint is not required for this connection"
  NotRequired: "NotRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint requirement is not applicable"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint status from AML RP WorkspaceConnectionDtoV2"
union ManagedPEStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint is inactive"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint is active"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed private endpoint status is not applicable"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Kind of capability host from AML RP Contracts"
union CapabilityHostKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Agent-based capability host"
  Agents: "Agents",
}

/**
 * Provisioning state of capability host.
 */
union CapabilityHostProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host provisioning succeeded"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host provisioning failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host provisioning was canceled"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host is being created"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host is being updated"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Capability host is being deleted"
  Deleting: "Deleting",
}

/**
 * Gets the tier upgrade policy for the subscription.
 */
union TierUpgradePolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Automatically upgrade to the next tier once available"
  OnceUpgradeIsAvailable: "OnceUpgradeIsAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Do not automatically upgrade to the next tier"
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * Specifies whether an upgrade to the next quota tier is available.
 */
union UpgradeAvailabilityStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "A tier upgrade is available"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "No tier upgrade is currently available"
  NotAvailable: "NotAvailable",
}

/**
 * Category of a managed network Outbound Rule of a cognitive services account.
 */
union RuleCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Rule is required and cannot be removed"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Rule is recommended by the system"
  Recommended: "Recommended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Rule is user-defined and customizable"
  UserDefined: "UserDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Rule is a dependency of another rule"
  Dependency: "Dependency",
}

/**
 * Type of a managed network Outbound Rule of a cognitive services account.
 */
union RuleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound rule is inactive"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound rule is active"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound rule is being provisioned"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound rule is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Outbound rule provisioning failed"
  Failed: "Failed",
}

/**
 * Type of a managed network Outbound Rule of a cognitive services account.
 */
union RuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Fully qualified domain name outbound rule"
  FQDN: "FQDN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Private endpoint outbound rule"
  PrivateEndpoint: "PrivateEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Service tag outbound rule"
  ServiceTag: "ServiceTag",
}

/**
 * The action enum for a managed network outbound rule.
 */
union RuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Allow outbound traffic"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Deny outbound traffic"
  Deny: "Deny",
}

/**
 * Isolation mode for the managed network of a cognitive services account.
 */
union IsolationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network isolation is disabled"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Allow internet outbound traffic from the managed network"
  AllowInternetOutbound: "AllowInternetOutbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Only allow approved outbound traffic from the managed network"
  AllowOnlyApprovedOutbound: "AllowOnlyApprovedOutbound",
}

/**
 * Status for the managed network of a cognitive services account.
 */
union ManagedNetworkStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network is inactive"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network is active"
  Active: "Active",
}

/**
 * Firewall Sku used for FQDN Rules
 */
union FirewallSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Standard firewall SKU for FQDN rules"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Basic firewall SKU for FQDN rules"
  Basic: "Basic",
}

/**
 * The Kind of the managed network. Users can switch from V1 to V2 for granular access controls, but cannot switch back to V1 once V2 is enabled.
 */
union ManagedNetworkKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "V1 managed network with basic access controls"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "V2 managed network with granular access controls"
  V2: "V2",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Provisioning state of managed network from AML RP ManagedNetworkSettingsProperties"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'ManagedNetworkProvisioningState' includes custom states beyond ARM standard values"
union ManagedNetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network provisioning is deferred until first use"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network is being updated"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network provisioning succeeded"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network provisioning failed"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network is being deleted"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network has been deleted"
  Deleted: "Deleted",
}

/**
 * Specifies the kind of Entra identity described by this object.
 */
union IdentityKind {
  string,

  /**
   * Represents a class identity, used for agentic applications.
   */
  AgentBlueprint: "AgentBlueprint",

  /**
   * Represents an instance identity.
   */
  AgentInstance: "AgentInstance",

  /**
   * Represents an agentic instance identity with user-like traits.
   */
  AgenticUser: "AgenticUser",

  /**
   * Represents a classic managed identity.
   */
  Managed: "Managed",

  /**
   * No identity.
   */
  None: "None",
}

/**
 * Enumeration of identity types, from the perspective of management.
 */
union IdentityManagementType {
  string,

  /**
   * Platform-managed identity.
   */
  System: "System",

  /**
   * User-managed identity.
   */
  User: "User",

  /**
   * No identity.
   */
  None: "None",
}

/**
 * Represents the provisioning state of an identity resource.
 */
union IdentityProvisioningState {
  string,

  /**
   * Identity is being created.
   */
  Creating: "Creating",

  /**
   * Identity is being updated.
   */
  Updating: "Updating",

  /**
   * Identity has been successfully provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * Identity provisioning has failed.
   */
  Failed: "Failed",

  /**
   * Identity provisioning has been canceled.
   */
  Canceled: "Canceled",

  /**
   * Identity is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * Authorization scheme type.
 */
union BuiltInAuthorizationScheme {
  string,

  /**
   * Standard AzureML RBAC
   */
  Default: "Default",

  /**
   * Claim-based, requires membership in the tenant
   */
  OrganizationScope: "OrganizationScope",

  /**
   * Channels-specific (AzureBotService) authorization
   */
  Channels: "Channels",

  /**
   * Custom scheme defined by the application author
   */
  Custom: "Custom",
}

/**
 * Traffic routing protocol, used to distribute an application's inbound traffic to its deployments.
 */
union TrafficRoutingProtocol {
  string,

  /**
   * Percentage based routing
   */
  FixedRatio: "FixedRatio",
}

/**
 * Provisioning state of an agentic application.
 */
union AgenticApplicationProvisioningState {
  string,

  /**
   * The application was successfully provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * The application provisioning failed.
   */
  Failed: "Failed",

  /**
   * The application provisioning was canceled.
   */
  Canceled: "Canceled",

  /**
   * The application is being created.
   */
  Creating: "Creating",

  /**
   * The application is being updated.
   */
  Updating: "Updating",

  /**
   * The application is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * Current operational state of the agentic functionality represented by this deployment.
 */
union AgentDeploymentState {
  string,

  /**
   * The deployment is starting.
   */
  Starting: "Starting",

  /**
   * The deployment started/is operational.
   */
  Running: "Running",

  /**
   * The deployment is being stopped.
   */
  Stopping: "Stopping",

  /**
   * The deployment was stopped.
   */
  Stopped: "Stopped",

  /**
   * The deployment failed.
   */
  Failed: "Failed",

  /**
   * The deployment is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The deployment was deleted.
   */
  Deleted: "Deleted",

  /**
   * The deployment is being updated.
   */
  Updating: "Updating",
}

/**
 * Protocol used by the agent/exposed by a deployment.
 */
union AgentProtocol {
  string,

  /**
   * Agent protocol (aka Active)
   */
  Agent: "Agent",

  /**
   * Agent2Agent standard
   */
  A2A: "A2A",

  /**
   * OpenAI-compatible
   */
  Responses: "Responses",
}

/**
 * Specifies the type of deployment for an agent, indicating how the underlying compute and network infrastructure is managed.
 */
union AgentDeploymentType {
  string,

  /**
   * The underlying infra is managed by the platform in the deployer's subscription
   */
  Managed: "Managed",

  /**
   * The underlying infra is owned by the platform
   */
  Hosted: "Hosted",

  /**
   * The underlying infra is provisioned by the deployer (BYO)
   */
  Custom: "Custom",
}

/**
 * Provisioning state of an agentic deployment, as an Azure resource.
 */
union AgentDeploymentProvisioningState {
  string,

  /**
   * The deployment was successfully completed.
   */
  Succeeded: "Succeeded",

  /**
   * The deployment failed.
   */
  Failed: "Failed",

  /**
   * The deployment was canceled.
   */
  Canceled: "Canceled",

  /**
   * The deployment is being created.
   */
  Creating: "Creating",

  /**
   * The deployment is being updated.
   */
  Updating: "Updating",

  /**
   * The deployment is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "'ResourceIdentityType' uses extensible union instead of fixed enum for forward compatibility"
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * key name to generate (Key1|Key2)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "'KeyName' uses extensible union instead of fixed enum for forward compatibility"
enum KeyName {
  Key1,
  Key2,
}

/**
 * The type of restrictions.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "'ResourceSkuRestrictionsType' uses extensible union instead of fixed enum for forward compatibility"
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The list of user assigned identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<userAssignedIdentities> type used for 'Identity' to support extensible key-value pairs matching service behavior"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User-assigned managed identity.
 */
model UserAssignedIdentity {
  /**
   * Azure Active Directory principal ID associated with this Identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client App Id associated with this identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Properties of Cognitive Services account.
 */
model AccountProperties {
  /**
   * Gets the status of the cognitive services account at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Endpoint of the created account.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * The internal identifier (deprecated, do not use this property).
   */
  @visibility(Lifecycle.Read)
  internalId?: string;

  /**
   * Gets the capabilities of the cognitive services account. Each item indicates the capability of a specific feature. The values are read-only and for reference only.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  capabilities?: SkuCapability[];

  /**
   * If the resource is migrated from an existing key.
   */
  @visibility(Lifecycle.Read)
  isMigrated?: boolean;

  /**
   * Resource migration token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "'migrationToken' is correctly marked as secret matching service-side security handling"
  migrationToken?: string;

  /**
   * Sku change info of account.
   */
  @visibility(Lifecycle.Read)
  skuChangeInfo?: SkuChangeInfo;

  /**
   * Optional subdomain name used for token-based authentication.
   */
  customSubDomainName?: string;

  /**
   * A collection of rules governing the accessibility from specific network locations.
   */
  networkAcls?: NetworkRuleSet;

  /**
   * The encryption properties for this resource.
   */
  encryption?: Encryption;

  /**
   * The storage accounts for this resource.
   */
  @identifiers(#["resourceId"])
  userOwnedStorage?: UserOwnedStorage[];

  /**
   * The user owned AML account properties.
   */
  amlWorkspace?: UserOwnedAmlWorkspace;

  /**
   * The private endpoint connection associated with the Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Whether or not public endpoint access is allowed for this account.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The api properties for special APIs.
   */
  apiProperties?: ApiProperties;

  /**
   * Gets the date of cognitive services account creation.
   */
  @visibility(Lifecycle.Read)
  dateCreated?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;

  /**
   * The flag to enable dynamic throttling.
   */
  dynamicThrottlingEnabled?: boolean;

  /**
   * The flag to disable stored completions.
   */
  storedCompletionsDisabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The quota limit for AccountProperties"
  @visibility(Lifecycle.Read)
  quotaLimit?: QuotaLimit;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Whether to restrict outbound network access for this Cognitive Services account"
  restrictOutboundNetworkAccess?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The allowed fqdn list for AccountProperties"
  allowedFqdnList?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The disable local auth for AccountProperties"
  disableLocalAuth?: boolean;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> type used for 'endpoints' in 'AccountProperties' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read)
  endpoints?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The restore for AccountProperties"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  restore?: boolean;

  /**
   * The deletion date, only available for deleted account.
   */
  @visibility(Lifecycle.Read)
  deletionDate?: string;

  /**
   * The scheduled purge date, only available for deleted account.
   */
  @visibility(Lifecycle.Read)
  scheduledPurgeDate?: string;

  /**
   * The multiregion settings of Cognitive Services account.
   */
  locations?: MultiRegionSettings;

  /**
   * The commitment plan associations of Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["commitmentPlanId"])
  commitmentPlanAssociations?: CommitmentPlanAssociation[];

  /**
   * The abuse penalty.
   */
  @visibility(Lifecycle.Read)
  abusePenalty?: AbusePenalty;

  /**
   * Cognitive Services Rai Monitor Config.
   */
  raiMonitorConfig?: RaiMonitorConfig;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Network injection settings for the account"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array of 'networkInjections' omits x-ms-identifiers, matching existing API surface"
  networkInjections?: NetworkInjection[];

  /**
   * Represents the foundry auto-upgrade configuration for a Cognitive Services account.
   */
  @added(Versions.v2026_01_15_preview)
  @removed(Versions.v2026_03_01)
  foundryAutoUpgrade?: FoundryAutoUpgrade;

  /**
   * Specifies whether this resource support project management as child resources, used as containers for access management, data isolation and cost in AI Foundry.
   */
  allowProjectManagement?: boolean;

  /**
   * Specifies the project, by project name, that is targeted when data plane endpoints are called without a project parameter.
   */
  defaultProject?: string;

  /**
   * Specifies the projects, by project name, that are associated with this resource.
   */
  associatedProjects?: string[];
}

/**
 * Represents the mode for foundry auto-upgrade configuration.
 */
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
union FoundryAutoUpgradeMode {
  string,

  /**
   * Auto-upgrade is enabled.
   */
  Enabled: "Enabled",

  /**
   * Auto-upgrade is disabled (opted out).
   */
  Disabled: "Disabled",
}

/**
 * Represents the foundry auto-upgrade configuration for a Cognitive Services account.
 * Customers can opt out of auto-upgrade by setting mode to Disabled.
 */
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
model FoundryAutoUpgrade {
  /**
   * Gets or sets the auto-upgrade mode.
   */
  mode?: FoundryAutoUpgradeMode;

  /**
   * Gets or sets a value indicating whether the auto-upgrade is planned by Microsoft.
   */
  plannedByMicrosoft?: boolean;

  /**
   * Gets or sets the status reason for the auto-upgrade configuration.
   */
  statusReason?: string;

  /**
   * Gets or sets the scheduled time for the auto-upgrade.
   */
  scheduledAt?: utcDateTime;
}

/**
 * SkuCapability indicates the capability of a certain feature.
 */
model SkuCapability {
  /**
   * The name of the SkuCapability.
   */
  name?: string;

  /**
   * The value of the SkuCapability.
   */
  value?: string;
}

/**
 * Sku change info of account.
 */
model SkuChangeInfo {
  /**
   * Gets the count of downgrades.
   */
  countOfDowngrades?: float32;

  /**
   * Gets the count of upgrades after downgrades.
   */
  countOfUpgradesAfterDowngrades?: float32;

  /**
   * Gets the last change date.
   */
  lastChangeDate?: string;
}

/**
 * A set of rules governing the network accessibility.
 */
model NetworkRuleSet {
  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: NetworkRuleAction;

  /**
   * Setting for trusted services.
   */
  bypass?: ByPassSelection;

  /**
   * The list of IP address rules.
   */
  @identifiers(#[])
  ipRules?: IpRule[];

  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/**
 * A rule governing the accessibility from a specific ip address or ip range.
 */
model IpRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).
   */
  value: string;
}

/**
 * A rule governing the accessibility from a specific virtual network.
 */
model VirtualNetworkRule {
  /**
   * Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.
   */
  id: string;

  /**
   * Gets the state of virtual network rule.
   */
  state?: string;

  /**
   * Ignore missing vnet service endpoint or not.
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Properties to configure Encryption
 */
model Encryption {
  /**
   * Properties of KeyVault
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  keySource?: KeySource = KeySource.`Microsoft.KeyVault`;
}

/**
 * Properties to configure keyVault Properties
 */
model KeyVaultProperties {
  /**
   * Name of the Key from KeyVault
   */
  keyName?: string;

  /**
   * Version of the Key from KeyVault
   */
  keyVersion?: string;

  /**
   * Uri of KeyVault
   */
  keyVaultUri?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The identity client id for KeyVaultProperties"
  identityClientId?: string;
}

/**
 * The user owned storage for Cognitive Services account.
 */
model UserOwnedStorage {
  /**
   * Full resource id of a Microsoft.Storage resource.
   */
  resourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The identity client id for UserOwnedStorage"
  identityClientId?: string;
}

/**
 * The user owned AML account for Cognitive Services account.
 */
model UserOwnedAmlWorkspace {
  /**
   * Full resource id of a AML account resource.
   */
  resourceId?: string;

  /**
   * Identity Client id of a AML account resource.
   */
  identityClientId?: string;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: Azure.ResourceManager.CommonTypes.PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: Azure.ResourceManager.CommonTypes.PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'PrivateEndpointConnectionProperties' includes custom states beyond ARM standard values"
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProvisioningState;

  /**
   * The private link resource group ids.
   */
  groupIds?: string[];
}

/**
 * The api properties for special APIs.
 */
model ApiProperties {
  ...Record<unknown>;

  /**
   * (QnAMaker Only) The runtime endpoint of QnAMaker.
   */
  qnaRuntimeEndpoint?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint key of QnAMaker.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "'qnaAzureSearchEndpointKey' is correctly marked as secret matching service-side security handling"
  qnaAzureSearchEndpointKey?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint id of QnAMaker.
   */
  qnaAzureSearchEndpointId?: string;

  /**
   * (Bing Search Only) The flag to enable statistics of Bing Search.
   */
  statisticsEnabled?: boolean;

  /**
   * (Personalization Only) The flag to enable statistics of Bing Search.
   */
  @maxLength(1000)
  @pattern("^( *)Endpoint=sb://(.*);( *)SharedAccessKeyName=(.*);( *)SharedAccessKey=(.*)$")
  eventHubConnectionString?: string;

  /**
   * (Personalization Only) The storage account connection string.
   */
  @maxLength(1000)
  @pattern("^(( *)DefaultEndpointsProtocol=(http|https)( *);( *))?AccountName=(.*)AccountKey=(.*)EndpointSuffix=(.*)$")
  storageAccountConnectionString?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Client Id (Application Id).
   */
  @maxLength(500)
  aadClientId?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Tenant Id.
   */
  @maxLength(500)
  aadTenantId?: string;

  /**
   * (Metrics Advisor Only) The super user of Metrics Advisor.
   */
  @maxLength(500)
  superUser?: string;

  /**
   * (Metrics Advisor Only) The website name of Metrics Advisor.
   */
  @maxLength(500)
  websiteName?: string;
}

/**
 * The call rate limit Cognitive Services account.
 */
model CallRateLimit {
  /**
   * The count value of Call Rate Limit.
   */
  count?: float32;

  /**
   * The renewal period in seconds of Call Rate Limit.
   */
  renewalPeriod?: float32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The rules for CallRateLimit"
  @identifiers(#["key"])
  rules?: ThrottlingRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Throttling rule configuration defining rate limits for API calls"
model ThrottlingRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Key identifying this throttling rule"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "'key' is correctly marked as secret matching service-side security handling"
  key?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Renewal period for the throttle counter"
  renewalPeriod?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Maximum count allowed in the throttle period"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Minimum count threshold for the throttle rule"
  minCount?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Whether dynamic throttling is enabled for this rule"
  dynamicThrottlingEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Patterns to match requests against for this rule"
  @identifiers(#["path", "method"])
  matchPatterns?: RequestMatchPattern[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "URL path and HTTP method pattern for throttling rule matching"
model RequestMatchPattern {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "URL path pattern to match"
  path?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "HTTP method to match"
  method?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Quota limit definition for resource usage caps"
model QuotaLimit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The count for QuotaLimit"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The renewal period for QuotaLimit"
  renewalPeriod?: float32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The rules for QuotaLimit"
  @identifiers(#["key"])
  rules?: ThrottlingRule[];
}

/**
 * The multiregion settings Cognitive Services account.
 */
model MultiRegionSettings {
  /**
   * Multiregion routing methods.
   */
  routingMethod?: RoutingMethods;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The regions for MultiRegionSettings"
  @identifiers(#["name"])
  regions?: RegionSetting[];
}

/**
 * The call rate limit Cognitive Services account.
 */
model RegionSetting {
  /**
   * Name of the region.
   */
  name?: string;

  /**
   * A value for priority or weighted routing methods.
   */
  value?: float32;

  /**
   * Maps the region to the regional custom subdomain.
   */
  customsubdomain?: string;
}

/**
 * The commitment plan association.
 */
model CommitmentPlanAssociation {
  /**
   * The Azure resource id of the commitment plan.
   */
  commitmentPlanId?: string;

  /**
   * The location of of the commitment plan.
   */
  commitmentPlanLocation?: string;
}

/**
 * The abuse penalty.
 */
model AbusePenalty {
  /**
   * The action of AbusePenalty.
   */
  action?: AbusePenaltyAction;

  /**
   * The percentage of rate limit.
   */
  rateLimitPercentage?: float32;

  /**
   * The datetime of expiration of the AbusePenalty.
   */
  expiration?: utcDateTime;
}

/**
 * Cognitive Services Rai Monitor Config.
 */
model RaiMonitorConfig {
  /**
   * The storage resource Id.
   */
  adxStorageResourceId?: string;

  /**
   * The identity client Id to access the storage.
   */
  identityClientId?: string;
}

/**
 * Specifies in AI Foundry where virtual network injection occurs to secure scenarios like Agents entirely within the user's private network, eliminating public internet exposure while maintaining control over network configurations and resources.
 */
model NetworkInjection {
  /**
   * Specifies what features in AI Foundry network injection applies to. Currently only supports 'agent' for agent scenarios. 'none' means no network injection.
   */
  scenario?: ScenarioType;

  /**
   * Specify the subnet for which your Agent Client is injected into.
   */
  subnetArmId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Boolean to enable Microsoft Managed Network for subnet delegation
   */
  useMicrosoftManagedNetwork?: boolean;
}

/**
 * The access keys for the cognitive services account.
 */
model ApiKeys {
  /**
   * Gets the value of key 1.
   */
  key1?: string;

  /**
   * Gets the value of key 2.
   */
  key2?: string;
}

/**
 * Regenerate key parameters.
 */
model RegenerateKeyParameters {
  /**
   * key name to generate (Key1|Key2)
   */
  keyName: KeyName;
}

/**
 * The Get Skus operation response.
 */
model ResourceSkuListResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available Cognitive Services SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  resourceType?: string;

  /**
   * The name of SKU.
   */
  name?: string;

  /**
   * Specifies the tier of Cognitive Services account.
   */
  tier?: string;

  /**
   * The Kind of resources that are supported in this SKU.
   */
  kind?: string;

  /**
   * The set of locations that the SKU is available.
   */
  locations?: string[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  @identifiers(#[])
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * Describes restrictions of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  values?: string[];

  /**
   * The information about the restriction where the SKU cannot be used.
   */
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Information about SKU restriction locations and availability zones"
model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  zones?: string[];
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountSkuListResult {
  /**
   * Gets the list of Cognitive Services accounts and their properties.
   */
  @identifiers(#["sku/name", "resourceType"])
  value?: AccountSku[];
}

/**
 * Cognitive Services resource type and SKU.
 */
model AccountSku {
  /**
   * Resource Namespace and Type
   */
  resourceType?: string;

  /**
   * The SKU of Cognitive Services account.
   */
  sku?: Sku;
}

/**
 * The response to a list usage request.
 */
model UsageListResult {
  /**
   * The link used to get the next page of Usages.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of usages for Cognitive Service account.
   */
  @pageItems
  @identifiers(#["name"])
  value?: Usage[];
}

/**
 * The usage data for a usage request.
 */
model Usage {
  /**
   * The unit of the metric.
   */
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  name?: MetricName;

  /**
   * The quota period used to summarize the usage values.
   */
  quotaPeriod?: string;

  /**
   * Maximum value for this metric.
   */
  limit?: float64;

  /**
   * Current value for this metric.
   */
  currentValue?: float64;

  /**
   * Next reset time for current quota.
   */
  nextResetTime?: string;

  /**
   * Cognitive Services account quota usage status.
   */
  status?: QuotaUsageStatus;

  /**
   * The scope type of the quota usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable for backward compatibility"
  @added(Versions.v2026_01_15_preview)
  @removed(Versions.v2026_03_01)
  scopeType?: QuotaScopeType | null;

  /**
   * The scope identifier of the quota usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable for backward compatibility"
  @added(Versions.v2026_01_15_preview)
  @removed(Versions.v2026_03_01)
  scopeId?: string | null;
}

/**
 * A metric name.
 */
model MetricName {
  /**
   * The name of the metric.
   */
  value?: string;

  /**
   * The friendly name of the metric.
   */
  localizedValue?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountModelListResult {
  /**
   * The link used to get the next page of Model.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts Model and their properties.
   */
  @pageItems
  @identifiers(#["name", "format", "version"])
  value?: AccountModel[];
}

/**
 * Cognitive Services account Model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'AccountModel' extends 'DeploymentModel' using inheritance to match service-side object hierarchy"
model AccountModel extends DeploymentModel {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  baseModel?: DeploymentModel;

  /**
   * If the model is default version.
   */
  isDefaultVersion?: boolean;

  /**
   * The list of Model Sku.
   */
  @identifiers(#["name"])
  skus?: ModelSku[];

  /**
   * The max capacity.
   */
  maxCapacity?: int32;

  /**
   * The capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<capabilities> type used for 'AccountModel' to support extensible key-value pairs matching service behavior"
  capabilities?: Record<string>;

  /**
   * The capabilities for finetune models.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<finetuneCapabilities> type used for 'AccountModel' to support extensible key-value pairs matching service behavior"
  finetuneCapabilities?: Record<string>;

  /**
   * Cognitive Services account ModelDeprecationInfo.
   */
  deprecation?: ModelDeprecationInfo;

  /**
   * Configuration for model replacement.
   */
  replacementConfig?: ReplacementConfig;

  /**
   * Asset identifier for the model in the model catalog.
   */
  modelCatalogAssetId?: string;

  /**
   * Model lifecycle status.
   */
  lifecycleStatus?: ModelLifecycleStatus;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of Cognitive Services account deployment model.
 */
model DeploymentModel {
  /**
   * Deployment model publisher.
   */
  publisher?: string;

  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * Deployment model name.
   */
  name?: string;

  /**
   * Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.
   */
  version?: string;

  /**
   * Optional. Deployment model source ARM resource ID.
   */
  source?: string;

  /**
   * Optional. Source of the model, another Microsoft.CognitiveServices accounts ARM resource ID.
   */
  sourceAccount?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;
}

/**
 * Describes an available Cognitive Services Model SKU.
 */
model ModelSku {
  /**
   * The name of the model SKU.
   */
  name?: string;

  /**
   * The usage name of the model SKU.
   */
  usageName?: string;

  /**
   * The datetime of deprecation of the model SKU.
   */
  deprecationDate?: utcDateTime;

  /**
   * The capacity configuration.
   */
  capacity?: CapacityConfig;

  /**
   * The list of rateLimit.
   */
  @identifiers(#[])
  rateLimits?: CallRateLimit[];

  /**
   * The list of billing meter info.
   */
  @identifiers(#[])
  cost?: BillingMeterInfo[];
}

/**
 * The capacity configuration.
 */
model CapacityConfig {
  /**
   * The minimum capacity.
   */
  minimum?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;

  /**
   * The minimal incremental between allowed values for capacity.
   */
  step?: int32;

  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The array of allowed values for capacity.
   */
  allowedValues?: int32[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Billing meter identifier and pricing information"
model BillingMeterInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The name for BillingMeterInfo"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The meter id for BillingMeterInfo"
  meterId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The unit for BillingMeterInfo"
  unit?: string;
}

/**
 * Cognitive Services account ModelDeprecationInfo.
 */
model ModelDeprecationInfo {
  /**
   * The datetime of deprecation of the fineTune Model.
   */
  fineTune?: string;

  /**
   * The datetime of deprecation of the inference Model.
   */
  inference?: string;

  /**
   * Indicates whether the deprecation date is a confirmed planned end-of-life date or an estimated deprecation date. When 'Planned', the deprecation date represents a confirmed and communicated model end-of-life date. When 'Tentative', the deprecation date is an estimated timeline that may be subject to change.
   */
  deprecationStatus?: DeprecationStatus;
}

/**
 * Configuration for model replacement.
 */
model ReplacementConfig {
  /**
   * The name of the replacement model.
   */
  targetModelName?: string;

  /**
   * The version of the replacement model.
   */
  targetModelVersion?: string;

  /**
   * The date when automatic upgrade should start. This applies to deployments with the OnceNewDefaultVersionAvailable upgrade option.
   */
  autoUpgradeStartDate?: utcDateTime;

  /**
   * The number of days before deprecation date to trigger upgrade. This applies to deployments with the OnceCurrentVersionExpired upgrade option.
   */
  upgradeOnExpiryLeadTimeDays?: int32;
}

/**
 * Check SKU availability parameter.
 */
model CheckSkuAvailabilityParameter {
  /**
   * The SKU of the resource.
   */
  skus: string[];

  /**
   * The kind (type) of cognitive service account.
   */
  kind: string;

  /**
   * The Type of the resource.
   */
  type: string;
}

/**
 * Check SKU availability result list.
 */
model SkuAvailabilityListResult {
  /**
   * Check SKU availability result list.
   */
  @identifiers(#["skuName", "type", "kind"])
  value?: SkuAvailability[];
}

/**
 * SKU availability.
 */
model SkuAvailability {
  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   *The name of SKU.
   */
  skuName?: string;

  /**
   * Indicates the given SKU is available or not.
   */
  skuAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * Additional error message.
   */
  message?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model CommitmentTierListResult {
  /**
   * The link used to get the next page of CommitmentTier.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts CommitmentTier and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["kind", "tier", "skuName", "hostingModel", "planType"])
  value?: CommitmentTier[];
}

/**
 * Cognitive Services account commitment tier.
 */
model CommitmentTier {
  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;

  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  skuName?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment max count.
   */
  maxCount?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  quota?: CommitmentQuota;

  /**
   * Cognitive Services account commitment cost.
   */
  cost?: CommitmentCost;
}

/**
 * Cognitive Services account commitment quota.
 */
model CommitmentQuota {
  /**
   * Commitment quota quantity.
   */
  quantity?: int64;

  /**
   * Commitment quota unit.
   */
  unit?: string;
}

/**
 * Cognitive Services account commitment cost.
 */
model CommitmentCost {
  /**
   * Commitment meter Id.
   */
  commitmentMeterId?: string;

  /**
   * Overage meter Id.
   */
  overageMeterId?: string;
}

/**
 * The list of cognitive services models.
 */
model ModelListResult {
  /**
   * The link used to get the next page of Model.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts Model and their properties.
   */
  @pageItems
  @identifiers(#[
    "kind",
    "skuName",
    "/model/name",
    "/model/format",
    "/model/version"
  ])
  value?: Model[];
}

/**
 * Cognitive Services Model.
 */
model Model {
  /**
   * Cognitive Services account Model.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "'model' name conflict in 'Model' retained for SDK backward compatibility"
  `model`?: AccountModel;

  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;

  /**
   * The name of SKU.
   */
  skuName?: string;

  /**
   * The description of the model.
   */
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'ModelCapacityListResultValueItem' uses base type inheritance matching service-side object hierarchy"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Capacity list result item for a deployment model"
model ModelCapacityListResultValueItem
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The location of the Model Sku Capacity.
   */
  location?: string;

  /**
   * Cognitive Services account ModelSkuCapacity.
   */
  properties?: ModelSkuCapacityProperties;
}

/**
 * Cognitive Services account ModelSkuCapacity.
 */
model ModelSkuCapacityProperties {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The sku name for ModelSkuCapacityProperties"
  skuName?: string;

  /**
   * The available capacity for deployment with this model and sku.
   */
  availableCapacity?: float32;

  /**
   * The available capacity for deployment with a fine-tune version of this model and sku.
   */
  availableFinetuneCapacity?: float32;

  /**
   * The scope identifier for model SKU capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable for backward compatibility"
  @added(Versions.v2026_01_15_preview)
  @removed(Versions.v2026_03_01)
  scopeId?: string | null;

  /**
   * The scope type for model SKU capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Nullable for backward compatibility"
  @added(Versions.v2026_01_15_preview)
  @removed(Versions.v2026_03_01)
  scopeType?: QuotaScopeType | null;
}

/**
 * Check Domain availability parameter.
 */
model CheckDomainAvailabilityParameter {
  /**
   * The subdomain name to use.
   */
  subdomainName: string;

  /**
   * The Type of the resource.
   */
  type: string;

  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;
}

/**
 * Domain availability.
 */
model DomainAvailability {
  /**
   * Indicates the given SKU is available or not.
   */
  isSubdomainAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * The subdomain name to use.
   */
  subdomainName?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The kind (type) of cognitive service account.
   */
  kind?: string;
}

/**
 * Calculate Model Capacity parameter.
 */
model CalculateModelCapacityParameter {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  /**
   * The name of SKU.
   */
  skuName?: string;

  /**
   * List of Model Capacity Calculator Workload.
   */
  @identifiers(#[])
  workloads?: ModelCapacityCalculatorWorkload[];
}

/**
 * Model Capacity Calculator Workload.
 */
model ModelCapacityCalculatorWorkload {
  /**
   * Request per minute.
   */
  requestPerMinute?: int64;

  /**
   * Dictionary, Model Capacity Calculator Workload Parameters.
   */
  requestParameters?: ModelCapacityCalculatorWorkloadRequestParam;
}

/**
 * Dictionary, Model Capacity Calculator Workload Parameters.
 */
model ModelCapacityCalculatorWorkloadRequestParam {
  /**
   * Average prompt tokens.
   */
  avgPromptTokens?: int64;

  /**
   * Average generated tokens.
   */
  avgGeneratedTokens?: int64;
}

/**
 * Calculate Model Capacity result.
 */
model CalculateModelCapacityResult {
  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The sku name for CalculateModelCapacityResult"
  skuName?: string;

  /**
   * Model Estimated Capacity.
   */
  estimatedCapacity?: CalculateModelCapacityResultEstimatedCapacity;
}

/**
 * Model Estimated Capacity.
 */
model CalculateModelCapacityResultEstimatedCapacity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The value for CalculateModelCapacityResultEstimatedCapacity"
  value?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The deployable value for CalculateModelCapacityResultEstimatedCapacity"
  deployableValue?: int32;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'PrivateLinkResource' extends 'Azure.ResourceManager.CommonTypes.Resource' using inheritance to match service-side object hierarchy"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];

  /**
   * The private link resource display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * Properties of Cognitive Services account deployment.
 */
model DeploymentProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  /**
   * Properties of Cognitive Services account deployment model. (Deprecated, please use Deployment.sku instead.)
   */
  scaleSettings?: DeploymentScaleSettings;

  /**
   * The capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<capabilities> type used for 'DeploymentProperties' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * The name of RAI policy.
   */
  raiPolicyName?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility(Lifecycle.Read)
  callRateLimit?: CallRateLimit;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Rate limit rules for the deployment"
  @visibility(Lifecycle.Read)
  @identifiers(#["key"])
  rateLimits?: ThrottlingRule[];

  /**
   * Deployment model version upgrade option.
   */
  versionUpgradeOption?: DeploymentModelVersionUpgradeOption;

  /**
   * If the dynamic throttling is enabled.
   */
  @visibility(Lifecycle.Read)
  dynamicThrottlingEnabled?: boolean;

  /**
   * The current capacity.
   */
  currentCapacity?: int32;

  /**
   * Internal use only.
   */
  capacitySettings?: DeploymentCapacitySettings;

  /**
   * The name of parent deployment.
   */
  parentDeploymentName?: string;

  /**
   * Specifies the deployment name that should serve requests when the request would have otherwise been throttled due to reaching current deployment throughput limit.
   */
  spilloverDeploymentName?: string;

  /**
   * The service tier for the deployment. Determines the pricing and performance level for request processing. Use 'Default' for standard pricing or 'Priority' for higher-priority processing with premium pricing. Note: Pause operations are only supported on Standard, DataZoneStandard, and GlobalStandard SKUs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'serviceTier' is nullable in 'DeploymentProperties' for backward compatibility with existing API behavior"
  serviceTier?: ServiceTier | null;

  /**
   * The state of the deployment. Controls whether the deployment is accepting inference requests. Use 'Running' for active deployments that process requests, or 'Paused' to temporarily stop inference while preserving the deployment configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'deploymentState' is nullable in 'DeploymentProperties' for backward compatibility with existing API behavior"
  deploymentState?: DeploymentState | null;

  /**
   * Routing configuration for the deployment. This property is only applicable when the deployed model is 'model-router' version 2025-11-18 or later. Allows you to select the models subset for routing and the routing mode (balanced, accuracy, cost) for routing across all supported models or the model subset.
   */
  routing?: DeploymentRouting;
}

/**
 * Properties of Cognitive Services account deployment model. (Deprecated, please use Deployment.sku instead.)
 */
model DeploymentScaleSettings {
  /**
   * Deployment scale type.
   */
  scaleType?: DeploymentScaleType;

  /**
   * Deployment capacity.
   */
  capacity?: int32;

  /**
   * Deployment active capacity. This value might be different from `capacity` if customer recently updated `capacity`.
   */
  @visibility(Lifecycle.Read)
  activeCapacity?: int32;
}

/**
 * Internal use only.
 */
model DeploymentCapacitySettings {
  /**
   * The designated capacity.
   */
  @minValue(0)
  designatedCapacity?: int32;

  /**
   * The priority of this capacity setting.
   */
  @minValue(0)
  priority?: int32;
}

/**
 * The object being used to update tags and sku of a resource, in general used for PATCH operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'PatchResourceTagsAndSku' extends 'PatchResourceTags' using inheritance to match service-side object hierarchy"
model PatchResourceTagsAndSku extends PatchResourceTags {
  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;
}

/**
 * The object being used to update tags of a resource, in general used for PATCH operations.
 */
model PatchResourceTags {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type used for 'PatchResourceTags' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * The list of cognitive services accounts operation response.
 */
model DeploymentSkuListResult {
  /**
   * The link used to get the next page of deployment skus.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts deployment skus.
   */
  @pageItems
  @identifiers(#["resourceType"])
  @visibility(Lifecycle.Read)
  value?: SkuResource[];
}

/**
 * Properties of Cognitive Services account resource sku resource properties.
 */
model SkuResource {
  /**
   * The resource type name.
   */
  resourceType?: string;

  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;

  /**
   * The capacity configuration.
   */
  capacity?: CapacityConfig;
}

/**
 * Properties of Cognitive Services account commitment plan.
 */
model CommitmentPlanProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CommitmentPlanProvisioningState;

  /**
   * Commitment plan guid.
   */
  commitmentPlanGuid?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Cognitive Services account commitment period.
   */
  current?: CommitmentPeriod;

  /**
   * AutoRenew commitment plan.
   */
  autoRenew?: boolean;

  /**
   * Cognitive Services account commitment period.
   */
  next?: CommitmentPeriod;

  /**
   * Cognitive Services account commitment period.
   */
  @visibility(Lifecycle.Read)
  last?: CommitmentPeriod;

  /**
   * The list of ProvisioningIssue.
   */
  @visibility(Lifecycle.Read)
  provisioningIssues?: string[];
}

/**
 * Cognitive Services account commitment period.
 */
model CommitmentPeriod {
  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment count.
   */
  count?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  @visibility(Lifecycle.Read)
  quota?: CommitmentQuota;

  /**
   * Commitment period start date.
   */
  @visibility(Lifecycle.Read)
  startDate?: string;

  /**
   * Commitment period end date.
   */
  @visibility(Lifecycle.Read)
  endDate?: string;
}

/**
 * Properties to EncryptionScope
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'EncryptionScopeProperties' extends 'Encryption' using inheritance to match service-side object hierarchy"
model EncryptionScopeProperties extends Encryption {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EncryptionScopeProvisioningState;

  /**
   * The encryptionScope state.
   */
  state?: EncryptionScopeState;
}

/**
 * Azure OpenAI Content Filters properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiPolicyProperties' includes custom states beyond ARM standard values"
model RaiPolicyProperties {
  /**
   * Content Filters policy type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "'type' is intentionally duplicated on 'RaiPolicyProperties' for backward compatibility"
  @visibility(Lifecycle.Read)
  type?: RaiPolicyType;

  /**
   * Rai policy mode. The enum value mapping is as below: Default = 0, Deferred=1, Blocking=2, Asynchronous_filter =3. Please use 'Asynchronous_filter' after 2025-06-01. It is the same as 'Deferred' in previous version.
   */
  mode?: RaiPolicyMode;

  /**
   * Name of Rai policy.
   */
  basePolicyName?: string;

  /**
   * The list of Content Filters.
   */
  @identifiers(#["name"])
  contentFilters?: RaiPolicyContentFilter[];

  /**
   * The list of custom Blocklist.
   */
  @identifiers(#[])
  customBlocklists?: CustomBlocklistConfig[];

  /**
   * The list of custom rai topics.
   */
  @identifiers(#[])
  customTopics?: CustomTopicConfig[];

  /**
   * The list of Safety Providers.
   */
  @identifiers(#[])
  safetyProviders?: SafetyProviderConfig[];
}

/**
 * Azure OpenAI Content Filter.
 */
model RaiPolicyContentFilter {
  /**
   * Name of ContentFilter.
   */
  name?: string;

  /**
   * If the ContentFilter is enabled.
   */
  enabled?: boolean;

  /**
   * Level at which content is filtered.
   */
  severityThreshold?: ContentLevel;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;

  /**
   * The action types to apply to the content filters
   */
  action?: RaiActionType;
}

/**
 * Gets or sets the source to which filter applies.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'CustomBlocklistConfig' extends 'RaiBlocklistConfig' using inheritance to match service-side object hierarchy"
model CustomBlocklistConfig extends RaiBlocklistConfig {
  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Azure OpenAI blocklist config.
 */
model RaiBlocklistConfig {
  /**
   * Name of ContentFilter.
   */
  blocklistName?: string;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;
}

/**
 * Gets or sets the source to which filter applies.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'CustomTopicConfig' extends 'RaiTopicConfig' using inheritance to match service-side object hierarchy"
model CustomTopicConfig extends RaiTopicConfig {
  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Azure OpenAI RAI topic config.
 */
model RaiTopicConfig {
  /**
   * Name of RAI topic.
   */
  topicName?: string;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;
}

/**
 * Gets or sets the source to which safety providers applies.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'SafetyProviderConfig' extends 'RaiSafetyProviderConfig' using inheritance to match service-side object hierarchy"
model SafetyProviderConfig extends RaiSafetyProviderConfig {
  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Azure OpenAI RAI safety provider config.
 */
model RaiSafetyProviderConfig {
  /**
   * Name of RAI Safety Provider.
   */
  safetyProviderName?: string;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;
}

/**
 * RAI Custom Blocklist properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiBlocklistProperties' includes custom states beyond ARM standard values"
model RaiBlocklistProperties {
  /**
   * Description of the block list.
   */
  description?: string;
}

/**
 * The list of cognitive services RAI Blocklist Items.
 */
model RaiBlockListItemsResult {
  /**
   * The link used to get the next page of RaiBlocklistItems.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiBlocklistItems.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiBlocklistItem[];
}

/**
 * RAI Custom Blocklist Item properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiBlocklistItemProperties' includes custom states beyond ARM standard values"
model RaiBlocklistItemProperties {
  /**
   * Pattern to match against.
   */
  pattern?: string;

  /**
   * If the pattern is a regex pattern.
   */
  isRegex?: boolean;
}

/**
 * The Cognitive Services RaiBlocklist Item request body.
 */
model RaiBlocklistItemBulkRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The name for RaiBlocklistItemBulkRequest"
  name?: string;

  /**
   * Properties of Cognitive Services RaiBlocklist Item.
   */
  properties?: RaiBlocklistItemProperties;
}

/**
 * RAI Custom Topic properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiTopicProperties' includes custom states beyond ARM standard values"
model RaiTopicProperties {
  /**
   * The unique identifier of the custom topic.
   */
  topicId?: string;

  /**
   * The name of the custom topic.
   */
  topicName?: string;

  /**
   * Description of the custom topic.
   */
  description?: string;

  /**
   * Sample blob url for the custom topic.
   */
  sampleBlobUrl?: string;

  /**
   * Status of the custom topic.
   */
  status?: string;

  /**
   * Failed reason if the status is Failed.
   */
  failedReason?: string;

  /**
   * Creation time of the custom topic.
   */
  createdAt?: utcDateTime;

  /**
   * Last modified time of the custom topic.
   */
  lastModifiedAt?: utcDateTime;
}

/**
 * The list of cognitive services RAI External Safety Providers.
 */
model RaiExternalSafetyProviderResult {
  /**
   * The link used to get the next page of Rai External Safety Provider.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiExternalSafetyProvider.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiExternalSafetyProviderSchema[];
}

/**
 * RAI External SafetyProvider schema properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiExternalSafetyProviderSchemaProperties' includes custom states beyond ARM standard values"
model RaiExternalSafetyProviderSchemaProperties {
  /**
   * The unique identifier of the safety provider.
   */
  providerId?: string;

  /**
   * Name of the safety provider.
   */
  providerName?: string;

  /**
   * Safety provider mode sync/async.
   */
  mode?: string;

  /**
   * Webhook URL for the safety provider.
   */
  url?: url;

  /**
   * The name of the secret in Key Vault that contains the api key to access the webhook.
   */
  secretName?: string;

  /**
   * The managed identity to access the Key Vault.
   */
  managedIdentity?: string;

  /**
   * The Key Vault URI that contains the api key for safety provider urls.
   */
  keyVaultUri?: url;

  /**
   * Creation time of the safety provider.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * Last modified time of the safety provider.
   */
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

/**
 * Cognitive Services Rai External Safety provider.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'RaiExternalSafetyProvider' uses base type inheritance matching service-side object hierarchy"
model RaiExternalSafetyProvider
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource Etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type used for 'RaiExternalSafetyProvider' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Properties of Cognitive Services Rai External Safety provider.
   */
  properties?: RaiExternalSafetyProviderProperties;
}

/**
 * RAI External SafetyProvider properties.
 */
model RaiExternalSafetyProviderProperties {
  /**
   * The unique identifier of the safety provider.
   */
  providerId?: string;

  /**
   * Name of the safety provider.
   */
  providerName?: string;

  /**
   * Safety provider mode sync/async.
   */
  mode?: string;

  /**
   * Webhook URL for the safety provider.
   */
  url?: url;

  /**
   * Creation time of the safety provider.
   */
  createdAt?: utcDateTime;

  /**
   * Last modified time of the safety provider.
   */
  lastModifiedAt?: utcDateTime;
}

/**
 * The list of cognitive services RAI Topics.
 */
model RaiTopicResult {
  /**
   * The link used to get the next page of RaiTopics.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiTopic.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiTopic[];
}

/**
 * RAI Tool Label properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiToolLabelProperties' includes custom states beyond ARM standard values"
model RaiToolLabelProperties {
  /**
   * The unique tool connection name, e.g., 'Web_Search'.
   */
  toolConnectionName: string;

  /**
   * Account-level tool label definition.
   */
  accountScope?: RaiToolLabelPropertiesAccountScope;

  /**
   * List of project-level tool label definitions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array of 'projectScopes' omits x-ms-identifiers, matching existing API surface"
  projectScopes?: RaiToolLabelPropertiesProjectScopesItem[];
}

/**
 * Account-level tool label definition.
 */
model RaiToolLabelPropertiesAccountScope {
  /**
   * Dictionary of label key-value pairs for the account scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<labelValues> type used for 'RaiToolLabelPropertiesAccountScope' to support extensible key-value pairs matching service behavior"
  labelValues?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Project scope configuration for a RAI tool label"
model RaiToolLabelPropertiesProjectScopesItem {
  /**
   * Project name to which this scope applies.
   */
  project: string;

  /**
   * Dictionary of label key-value pairs for the project scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<labelValues> type used for 'RaiToolLabelPropertiesProjectScopesItem' to support extensible key-value pairs matching service behavior"
  labelValues: Record<string>;
}

/**
 * The list of Cognitive Services RAI Tool Labels.
 */
model RaiToolLabelResult {
  /**
   * The link used to get the next page of RaiToolLabels.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RAI Tool Labels.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiToolLabel[];
}

/**
 * Azure OpenAI Content Filter Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'RaiContentFilterProperties' includes custom states beyond ARM standard values"
model RaiContentFilterProperties {
  /**
   * Name of Content Filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "'name' is intentionally duplicated on 'RaiContentFilterProperties' for backward compatibility"
  name?: string;

  /**
   * If the Content Filter has multi severity levels(Low, Medium, or High).
   */
  isMultiLevelFilter?: boolean;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * The commitment plan account association properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'CommitmentPlanAccountAssociationProperties' includes custom states beyond ARM standard values"
model CommitmentPlanAccountAssociationProperties {
  /**
   * The Azure resource id of the account.
   */
  accountId?: string;
}

/**
 * A list of NSP configurations for an Cognitive Services account.
 */
model NetworkSecurityPerimeterConfigurationList {
  /**
   * Array of NSP configurations List Result for an Cognitive Services account.
   */
  @pageItems
  @identifiers(#["id"])
  value?: NetworkSecurityPerimeterConfiguration[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an NSP Configuration.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Provisioning state of NetworkSecurityPerimeter configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'NetworkSecurityPerimeterConfigurationProperties' includes custom states beyond ARM standard values"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * List of Provisioning Issues
   */
  @identifiers(#["name"])
  provisioningIssues?: ProvisioningIssue[];

  /**
   * Information about a linked Network Security Perimeter
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Network Security Perimeter Configuration Association Information
   */
  resourceAssociation?: NetworkSecurityPerimeterConfigurationAssociationInfo;

  /**
   * Network Security Perimeter Profile Information
   */
  profile?: NetworkSecurityPerimeterProfileInfo;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Details about an issue encountered during resource provisioning"
model ProvisioningIssue {
  /**
   * Name of the NSP provisioning issue
   */
  name?: string;

  /**
   * Properties of Provisioning Issue
   */
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of Provisioning Issue
 */
model ProvisioningIssueProperties {
  /**
   * Type of Issue
   */
  issueType?: string;

  /**
   * Severity of the issue
   */
  severity?: string;

  /**
   * Description of the issue
   */
  description?: string;

  /**
   * IDs of resources that can be associated to the same perimeter to remediate the issue.
   */
  suggestedResourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * Optional array, suggested access rules
   */
  suggestedAccessRules?: NetworkSecurityPerimeterAccessRule[];
}

/**
 * Network Security Perimeter Access Rule
 */
model NetworkSecurityPerimeterAccessRule {
  /**
   * Network Security Perimeter Access Rule Name
   */
  name?: string;

  /**
   * Properties of Network Security Perimeter Access Rule
   */
  properties?: NetworkSecurityPerimeterAccessRuleProperties;
}

/**
 * The Properties of Network Security Perimeter Rule
 */
model NetworkSecurityPerimeterAccessRuleProperties {
  /**
   * Direction of Access Rule
   */
  direction?: NspAccessRuleDirection;

  /**
   * Address prefixes for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: NetworkSecurityPerimeterAccessRulePropertiesSubscriptionsItem[];

  /**
   * NetworkSecurityPerimeters for inbound rules
   */
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  /**
   * Fully qualified domain name for outbound rules
   */
  fullyQualifiedDomainNames?: string[];
}

/**
 * Subscription for inbound rule
 */
model NetworkSecurityPerimeterAccessRulePropertiesSubscriptionsItem {
  /**
   * Fully qualified identifier of subscription
   */
  id?: string;
}

/**
 * Information about a linked Network Security Perimeter
 */
model NetworkSecurityPerimeter {
  /**
   * Fully qualified identifier of the resource
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * Guid of the resource
   */
  perimeterGuid?: string;

  /**
   * Location of the resource
   */
  location?: string;
}

/**
 * Network Security Perimeter Configuration Association Information
 */
model NetworkSecurityPerimeterConfigurationAssociationInfo {
  /**
   * Name of the resource association
   */
  name?: string;

  /**
   * Access Mode of the resource association
   */
  accessMode?: string;
}

/**
 * Network Security Perimeter Profile Information
 */
model NetworkSecurityPerimeterProfileInfo {
  /**
   * Name of the resource profile
   */
  name?: string;

  /**
   * Access rules version of the resource profile
   */
  accessRulesVersion?: int64;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The access rules for NetworkSecurityPerimeterProfileInfo"
  @identifiers(#[])
  accessRules?: NetworkSecurityPerimeterAccessRule[];

  /**
   * Current diagnostic settings version
   */
  diagnosticSettingsVersion?: int64;

  /**
   * List of enabled log categories
   */
  enabledLogCategories?: string[];
}

/**
 * The list of cognitive services Defender for AI Settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model DefenderForAISettingResult {
  /**
   * The link used to get the next page of Defender for AI Settings.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of Defender for AI Settings.
   */
  @pageItems
  @identifiers(#["name"])
  value?: DefenderForAISetting[];
}

/**
 * The Defender for AI resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'DefenderForAISettingProperties' includes custom states beyond ARM standard values"
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model DefenderForAISettingProperties {
  /**
   * Defender for AI state on the AI resource.
   */
  state?: DefenderForAISettingState;
}

/**
 * Properties of Cognitive Services Project'.
 */
model ProjectProperties {
  /**
   * Gets the status of the cognitive services project at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The display name of the Cognitive Services Project.
   */
  displayName?: string;

  /**
   * The description of the Cognitive Services Project.
   */
  description?: string;

  /**
   * The list of endpoint for this Cognitive Services Project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<endpoints> type used for 'ProjectProperties' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read)
  endpoints?: Record<string>;

  /**
   * Indicates whether the project is the default project for the account.
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * Connection property base schema.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'ConnectionPropertiesV2' includes custom states beyond ARM standard values"
@discriminator("authType")
model ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: ConnectionAuthType;

  /**
   * Category of the connection
   */
  category?: ConnectionCategory;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The created by workspace arm id for ConnectionPropertiesV2"
  @visibility(Lifecycle.Read)
  createdByWorkspaceArmId?: Azure.Core.armResourceIdentifier;

  /**
   * Provides the error message if the connection fails
   */
  error?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The expiry time for ConnectionPropertiesV2"
  expiryTime?: utcDateTime;

  /**
   * Group based on connection category
   */
  @visibility(Lifecycle.Read)
  group?: ConnectionGroup;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The is shared to all for ConnectionPropertiesV2"
  isSharedToAll?: boolean;

  /**
   * Store user metadata for this connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<metadata> type used for 'ConnectionPropertiesV2' to support extensible key-value pairs matching service behavior"
  metadata?: Record<string>;

  /**
   * Specifies how private endpoints are used with this connection: 'Required', 'NotRequired', or 'NotApplicable'.
   */
  peRequirement?: ManagedPERequirement;

  /**
   * Specifies the status of private endpoints for this connection: 'Inactive', 'Active', or 'NotApplicable'.
   */
  peStatus?: ManagedPEStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The shared user list for ConnectionPropertiesV2"
  sharedUserList?: string[];

  /**
   * The connection URL to be used.
   */
  target?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The use workspace managed identity for ConnectionPropertiesV2"
  useWorkspaceManagedIdentity?: boolean;
}

/**
 * The properties that the Cognitive services connection will be updated with.
 */
model ConnectionUpdateContent {
  /**
   * The properties that the Cognitive services connection will be updated with.
   */
  properties?: ConnectionPropertiesV2;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Paginated result for connection resources"
model ConnectionPropertiesV2BasicResourceArmPaginatedResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The next link for ConnectionPropertiesV2BasicResourceArmPaginatedResult"
  @nextLink
  nextLink?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The value for ConnectionPropertiesV2BasicResourceArmPaginatedResult"
  @pageItems
  value?: ConnectionPropertiesV2BasicResource[];
}
/**
 * A paginated list of Capability Host entities.
 */
model CapabilityHostResourceArmPaginatedResult {
  /**
   * The link to the next page of Capability Host objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextLink' is nullable in 'CapabilityHostResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Capability Host.
   */
  @pageItems
  value?: CapabilityHost[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'CapabilityHostProperties' extends 'ResourceBase' using inheritance to match service-side object hierarchy"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Configuration properties for a capability host from AML RP"
model CapabilityHostProperties extends ResourceBase {
  /**
   * List of AI services connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'aiServicesConnections' is nullable in 'CapabilityHostProperties' for backward compatibility with existing API behavior"
  aiServicesConnections?: string[] | null;

  /**
   * Kind of this capability host.
   */
  capabilityHostKind?: CapabilityHostKind;

  /**
   * Customer subnet info to help set up this capability host.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'customerSubnet' is nullable in 'CapabilityHostProperties' for backward compatibility with existing API behavior"
  customerSubnet?: string | null;

  /**
   * Provisioning state for the CapabilityHost.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityHostProvisioningState;

  /**
   * List of connection names from those available in the account or project to be used as a storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'storageConnections' is nullable in 'CapabilityHostProperties' for backward compatibility with existing API behavior"
  storageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for Thread storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'threadStorageConnections' is nullable in 'CapabilityHostProperties' for backward compatibility with existing API behavior"
  threadStorageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for vector database (e.g. CosmosDB).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'vectorStoreConnections' is nullable in 'CapabilityHostProperties' for backward compatibility with existing API behavior"
  vectorStoreConnections?: string[] | null;

  /**
   * Whether public hosting environment is enabled for the capability host
   */
  enablePublicHostingEnvironment?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Base properties shared across Azure ML proxied resources (description, tags, identity)"
model ResourceBase {
  /**
   * The asset description text.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'description' is nullable in 'ResourceBase' for backward compatibility with existing API behavior"
  description?: string | null;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type used for 'ResourceBase' to support extensible key-value pairs matching service behavior"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'tags' is nullable in 'ResourceBase' for backward compatibility with existing API behavior"
  tags?: Record<string> | null;
}

/**
 * A paginated list of Project Capability Host entities.
 */
model ProjectCapabilityHostResourceArmPaginatedResult {
  /**
   * The link to the next page of Project Capability Host objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextLink' is nullable in 'ProjectCapabilityHostResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Project Capability Host.
   */
  @pageItems
  value?: ProjectCapabilityHost[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Properties for a project-scoped capability host"
model ProjectCapabilityHostProperties {
  /**
   * List of AI services connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'aiServicesConnections' is nullable in 'ProjectCapabilityHostProperties' for backward compatibility with existing API behavior"
  aiServicesConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for vector database (e.g. CosmosDB).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'vectorStoreConnections' is nullable in 'ProjectCapabilityHostProperties' for backward compatibility with existing API behavior"
  vectorStoreConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used as a storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'storageConnections' is nullable in 'ProjectCapabilityHostProperties' for backward compatibility with existing API behavior"
  storageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for Thread storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'threadStorageConnections' is nullable in 'ProjectCapabilityHostProperties' for backward compatibility with existing API behavior"
  threadStorageConnections?: string[] | null;

  /**
   * Provisioning state for the CapabilityHost.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityHostProvisioningState;
}

/**
 * Properties of Quota Tier resource'.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'QuotaTierProperties' includes custom states beyond ARM standard values"
model QuotaTierProperties {
  /**
   * Name of the current quota tier for the subscription.
   */
  @visibility(Lifecycle.Read)
  currentTierName?: string;

  /**
   * Gets the tier upgrade policy for the subscription.
   */
  tierUpgradePolicy?: TierUpgradePolicy;

  /**
   * The date on which the current tier was assigned to the subscription (UTC).
   */
  @visibility(Lifecycle.Read)
  assignmentDate?: utcDateTime;

  /**
   * Information about the quota tier upgrade eligibility for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'tierUpgradeEligibilityInfo' is nullable in 'QuotaTierProperties' for backward compatibility with existing API behavior"
  @visibility(Lifecycle.Read)
  tierUpgradeEligibilityInfo?: QuotaTierUpgradeEligibilityInfo | null;
}

/**
 * Information about the quota tier upgrade eligibility for the subscription.
 */
model QuotaTierUpgradeEligibilityInfo {
  /**
   * Name of the next quota tier for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextTierName' is nullable in 'QuotaTierUpgradeEligibilityInfo' for backward compatibility with existing API behavior"
  nextTierName?: string | null;

  /**
   * Specifies whether an upgrade to the next quota tier is available.
   */
  upgradeAvailabilityStatus?: UpgradeAvailabilityStatus;

  /**
   * The date after which the current tier will be upgraded to the next tier if the TierUpgradePolicy is "OnceUpgradeIsAvailable" (UTC).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'upgradeApplicableDate' is nullable in 'QuotaTierUpgradeEligibilityInfo' for backward compatibility with existing API behavior"
  upgradeApplicableDate?: utcDateTime | null;

  /**
   * Reason in case the subscription is not eligible for upgrade to the next tier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'upgradeUnavailabilityReason' is nullable in 'QuotaTierUpgradeEligibilityInfo' for backward compatibility with existing API behavior"
  upgradeUnavailabilityReason?: string | null;
}

/**
 * Outbound Rule for the managed network of a cognitive services account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state for 'OutboundRule' includes custom states beyond ARM standard values"
@discriminator("type")
model OutboundRule {
  /**
   * Category of a managed network Outbound Rule of a cognitive services account.
   */
  category?: RuleCategory;

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  status?: RuleStatus;

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "'type' is intentionally duplicated on 'OutboundRule' for backward compatibility"
  type: RuleType;

  /**
   * Error information about an outbound rule of a cognitive services account if RuleStatus is failed.
   */
  @visibility(Lifecycle.Read)
  errorInformation?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The parent rule names for OutboundRule"
  @visibility(Lifecycle.Read)
  parentRuleNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'ManagedNetworkSettingsBasicResource' uses base type inheritance matching service-side object hierarchy"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed network settings resource from AML RP"
model ManagedNetworkSettingsBasicResource
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Managed Network settings for a cognitive services account.
   */
  properties?: ManagedNetworkSettings;
}

/**
 * Managed Network settings for a cognitive services account.
 */
model ManagedNetworkSettings {
  /**
   * Isolation mode for the managed network of a cognitive services account.
   */
  isolationMode?: IsolationMode;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Network ID for the managed network"
  @visibility(Lifecycle.Read)
  networkId?: string;

  /**
   * Dictionary of <OutboundRule>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<outboundRules> type used for 'ManagedNetworkSettings' to support extensible key-value pairs matching service behavior"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'outboundRules' is nullable in 'ManagedNetworkSettings' for backward compatibility with existing API behavior"
  outboundRules?: Record<OutboundRule> | null;

  /**
   * Status of the Provisioning for the managed network of a cognitive services account.
   */
  status?: ManagedNetworkProvisionStatus;

  /**
   * Firewall Sku used for FQDN Rules
   */
  firewallSku?: FirewallSku;

  /**
   * The Kind of the managed network. Users can switch from V1 to V2 for granular access controls, but cannot switch back to V1 once V2 is enabled.
   */
  managedNetworkKind?: ManagedNetworkKind;

  /**
   * Public IP address assigned to the Azure Firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'firewallPublicIpAddress' is nullable in 'ManagedNetworkSettings' for backward compatibility with existing API behavior"
  @visibility(Lifecycle.Read)
  firewallPublicIpAddress?: string | null;

  /**
   * The provisioning state of the managed network settings.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedNetworkProvisioningState;
}

/**
 * Status of the Provisioning for the managed network of a cognitive services account.
 */
model ManagedNetworkProvisionStatus {
  /**
   * Status for the managed network of a cognitive services account.
   */
  status?: ManagedNetworkStatus;
}

/**
 * The properties of the managed network settings of a cognitive services account.
 */
model ManagedNetworkSettingsProperties {
  /**
   * Managed Network settings for a cognitive services account.
   */
  managedNetwork?: ManagedNetworkSettingsEx;

  /**
   * The current deployment state of the managed network resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedNetworkProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'ManagedNetworkSettingsEx' extends 'ManagedNetworkSettings' using inheritance to match service-side object hierarchy"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Extended managed network settings with additional FQDN rules from AML RP"
model ManagedNetworkSettingsEx extends ManagedNetworkSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The changeable isolation modes for ManagedNetworkSettingsEx"
  @visibility(Lifecycle.Read)
  changeableIsolationModes?: IsolationMode[];
}

/**
 * A paginated list of Agent Application entities.
 */
model AgentApplicationResourceArmPaginatedResult {
  /**
   * The link to the next page of Agent Application objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextLink' is nullable in 'AgentApplicationResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Application.
   */
  @pageItems
  value?: AgentApplication[];
}

/**
 * Resource type representing an agentic application as a management construct.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'AgenticApplicationProperties' extends 'ResourceBase' using inheritance to match service-side object hierarchy"
model AgenticApplicationProperties extends ResourceBase {
  /**
   * The display name of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'displayName' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  displayName?: string | null;

  /**
   * The application's dedicated invocation endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'baseUrl' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  baseUrl?: string | null;

  /**
   * The list of agent definitions comprising this application, returned as references to the objects under the parent project; use this to obtain a flat list of all agent-version pairs represented by this application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agents' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  agents?: AgentReferenceProperties[] | null;

  /**
   * The EntraId Agentic Blueprint of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agentIdentityBlueprint' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  agentIdentityBlueprint?: AssignedIdentity | null;

  /**
   * The (default) agent instance identity of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'defaultInstanceIdentity' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  defaultInstanceIdentity?: AssignedIdentity | null;

  /**
   * Gets or sets the authorization policy associated with this agentic application instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'authorizationPolicy' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  authorizationPolicy?: ApplicationAuthorizationPolicy | null;

  /**
   * Gets or sets the traffic routing policy for the application's deployments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'trafficRoutingPolicy' is nullable in 'AgenticApplicationProperties' for backward compatibility with existing API behavior"
  trafficRoutingPolicy?: ApplicationTrafficRoutingPolicy | null;

  /**
   * Provisioning state of the application.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AgenticApplicationProvisioningState;

  /**
   * Enabledstate of the application.
   */
  @visibility(Lifecycle.Read)
  isEnabled?: boolean;
}

/**
 * Type modeling a reference to a version of an agent definition.
 */
model AgentReferenceProperties {
  /**
   * Gets the agent's unique identifier within the organization (subscription).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agentId' is nullable in 'AgentReferenceProperties' for backward compatibility with existing API behavior"
  agentId?: string | null;

  /**
   * Gets the agent's name (unique within the project/app).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agentName' is nullable in 'AgentReferenceProperties' for backward compatibility with existing API behavior"
  agentName?: string | null;
}

/**
 * Type representing an identity assignment
 */
model AssignedIdentity {
  /**
   * Specifies the kind of Entra identity described by this object.
   */
  kind: IdentityKind;

  /**
   * Enumeration of identity types, from the perspective of management.
   */
  type: IdentityManagementType;

  /**
   * The client ID of the identity.
   */
  clientId: string;

  /**
   * The principal ID of the identity.
   */
  principalId: string;

  /**
   * The tenant ID of the identity.
   */
  tenantId: string;

  /**
   * The subject of this identity assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'subject' is nullable in 'AssignedIdentity' for backward compatibility with existing API behavior"
  subject?: string | null;

  /**
   * Represents the provisioning state of an identity resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: IdentityProvisioningState;
}

/**
 * Represents a policy for authorizing applications based on specified authentication and authorization schemes.
 */
@discriminator("type")
model ApplicationAuthorizationPolicy {
  /**
   * Authorization scheme type.
   */
  type: BuiltInAuthorizationScheme;
}

/**
 * Type representing an application traffic policy as a property of an agentic application.
 */
model ApplicationTrafficRoutingPolicy {
  /**
   * Methodology used to route traffic to the application's deployments.
   */
  protocol?: TrafficRoutingProtocol;

  /**
   * Gets or sets the collection of traffic routing rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'rules' is nullable in 'ApplicationTrafficRoutingPolicy' for backward compatibility with existing API behavior"
  rules?: TrafficRoutingRule[] | null;
}

/**
 * Represents a rule for routing traffic to a specific deployment.
 */
model TrafficRoutingRule {
  /**
   * The identifier of this traffic routing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'ruleId' is nullable in 'TrafficRoutingRule' for backward compatibility with existing API behavior"
  ruleId?: string | null;

  /**
   * A user-provided description for this traffic routing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'description' is nullable in 'TrafficRoutingRule' for backward compatibility with existing API behavior"
  description?: string | null;

  /**
   * The unique identifier of the deployment to which traffic is routed by this rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'deploymentId' is nullable in 'TrafficRoutingRule' for backward compatibility with existing API behavior"
  deploymentId?: string | null;

  /**
   * Gets or sets the percentage of traffic allocated to this instance.
   */
  trafficPercentage?: int32;
}

/**
 * A paginated list of Agent Reference entities.
 */
model AgentReferenceResourceArmPaginatedResult {
  /**
   * The link to the next page of Agent Reference objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextLink' is nullable in 'AgentReferenceResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'value' is nullable in 'AgentReferenceResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  value?: AgentReference[] | null;
}

/**
 * Agent Reference resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'AgentReference' extends 'Azure.ResourceManager.CommonTypes.ProxyResource' using inheritance to match service-side object hierarchy"
model AgentReference extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * [Required] Additional attributes of the entity.
   */
  properties: AgentReferenceProperties;
}

/**
 * A paginated list of Agent Deployment entities.
 */
model AgentDeploymentResourceArmPaginatedResult {
  /**
   * The link to the next page of Agent Deployment objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'nextLink' is nullable in 'AgentDeploymentResourceArmPaginatedResult' for backward compatibility with existing API behavior"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Deployment.
   */
  @pageItems
  value?: AgentDeployment[];
}

/**
 * Type representing an agent deployment as a management construct.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'AgentDeploymentProperties' extends 'ResourceBase' using inheritance to match service-side object hierarchy"
@discriminator("deploymentType")
model AgentDeploymentProperties extends ResourceBase {
  /**
   * Gets or sets the display name of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'displayName' is nullable in 'AgentDeploymentProperties' for backward compatibility with existing API behavior"
  displayName?: string | null;

  /**
   * Gets or sets the unique identifier of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'deploymentId' is nullable in 'AgentDeploymentProperties' for backward compatibility with existing API behavior"
  deploymentId?: string | null;

  /**
   * Gets or sets the current operational state of the deployment (and, intrinsically, of the comprising agents).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'state' is nullable in 'AgentDeploymentProperties' for backward compatibility with existing API behavior"
  state?: AgentDeploymentState | null;

  /**
   * Gets or sets the supported protocol types and versions exposed by this deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'protocols' is nullable in 'AgentDeploymentProperties' for backward compatibility with existing API behavior"
  protocols?: AgentProtocolVersion[] | null;

  /**
   * Returns a flat list of agent:version deployed in this deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agents' is nullable in 'AgentDeploymentProperties' for backward compatibility with existing API behavior"
  agents?: VersionedAgentReference[] | null;

  /**
   * Gets or sets the type of deployment for the agent.
   */
  deploymentType: AgentDeploymentType;

  /**
   * Gets or sets the provisioning state of the agent deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentDeploymentProvisioningState;
}

/**
 * Type modeling the protocol and version used by an agent/exposed by a deployment.
 */
model AgentProtocolVersion {
  /**
   * The protocol used by the agent/exposed by a deployment.
   */
  protocol?: AgentProtocol;

  /**
   * The version of the protocol.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'version' is nullable in 'AgentProtocolVersion' for backward compatibility with existing API behavior"
  version?: string | null;
}

/**
 * Type modeling a reference to a version of an agent definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "'VersionedAgentReference' extends 'AgentReferenceProperties' using inheritance to match service-side object hierarchy"
model VersionedAgentReference extends AgentReferenceProperties {
  /**
   * Gets the agent's version (unique for each agent lineage).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'agentVersion' is nullable in 'VersionedAgentReference' for backward compatibility with existing API behavior"
  agentVersion?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for Personal Access Token authentication"
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model PATAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Personal Access Token credentials for the connection"
  credentials?: ConnectionPersonalAccessToken;

  /**
   * Authentication type of the connection target
   */
  authType: "PAT";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing a personal access token value"
model ConnectionPersonalAccessToken {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The pat for ConnectionPersonalAccessToken"
  @secret
  pat?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for Managed Identity authentication"
model ManagedIdentityAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Managed identity credentials for the connection"
  credentials?: ConnectionManagedIdentity;

  /**
   * Authentication type of the connection target
   */
  authType: "ManagedIdentity";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing managed identity client ID and resource ID"
model ConnectionManagedIdentity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The client id for ConnectionManagedIdentity"
  clientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The resource id for ConnectionManagedIdentity"
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for username/password authentication"
model UsernamePasswordAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Username/password credentials for the connection"
  credentials?: ConnectionUsernamePassword;

  /**
   * Authentication type of the connection target
   */
  authType: "UsernamePassword";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing username, password, and security token"
model ConnectionUsernamePassword {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The password for ConnectionUsernamePassword"
  @secret
  password?: string;

  /**
   * Optional, required by connections like SalesForce for extra security in addition to UsernamePassword
   */
  @secret
  securityToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The username for ConnectionUsernamePassword"
  username?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for connections that require no authentication"
model NoneAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "None";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for Shared Access Signature authentication"
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model SASAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "SAS token credentials for the connection"
  credentials?: ConnectionSharedAccessSignature;

  /**
   * Authentication type of the connection target
   */
  authType: "SAS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing a SAS token value"
model ConnectionSharedAccessSignature {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The sas for ConnectionSharedAccessSignature"
  @secret
  sas?: string;
}

/**
 * This connection type covers the account key connection for Azure storage
 */
model AccountKeyAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Account key object for connection credential.
   */
  credentials?: ConnectionAccountKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccountKey";
}

/**
 * Account key object for connection credential.
 */
model ConnectionAccountKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The key for ConnectionAccountKey"
  @secret
  key?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for service principal authentication"
model ServicePrincipalAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Service principal credentials for the connection"
  credentials?: ConnectionServicePrincipal;

  /**
   * Authentication type of the connection target
   */
  authType: "ServicePrincipal";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing service principal client ID, secret, and tenant"
model ConnectionServicePrincipal {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The client id for ConnectionServicePrincipal"
  clientId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The client secret for ConnectionServicePrincipal"
  @secret
  clientSecret?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The tenant id for ConnectionServicePrincipal"
  tenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for access key authentication"
model AccessKeyAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Access key credentials for the connection"
  credentials?: ConnectionAccessKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccessKey";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Credential model containing an access key ID and secret key"
model ConnectionAccessKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The access key id for ConnectionAccessKey"
  accessKeyId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The secret access key for ConnectionAccessKey"
  @secret
  secretAccessKey?: string;
}

/**
 * This connection type covers the generic ApiKey auth connection categories, for examples:
 * AzureOpenAI:
 *     Category:= AzureOpenAI
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {ApiKey} as .ApiKey
 *     Target:= {ApiBase}
 *
 * CognitiveService:
 *     Category:= CognitiveService
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {SubscriptionKey} as ApiKey
 *     Target:= ServiceRegion={serviceRegion}
 *
 * CognitiveSearch:
 *     Category:= CognitiveSearch
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {Key} as ApiKey
 *     Target:= {Endpoint}
 *
 * Use Metadata property bag for ApiType, ApiVersion, Kind and other metadata fields
 */
model ApiKeyAuthConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Api key object for connection credential.
   */
  credentials?: ConnectionApiKey;

  /**
   * Authentication type of the connection target
   */
  authType: "ApiKey";
}

/**
 * Api key object for connection credential.
 */
model ConnectionApiKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The key for ConnectionApiKey"
  @secret
  key?: string;
}

/**
 * Category:= CustomKeys
 * AuthType:= CustomKeys (as type discriminator)
 * Credentials:= {CustomKeys} as CustomKeys
 * Target:= {any value}
 * Use Metadata property bag for ApiVersion and other metadata fields
 */
model CustomKeysConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Custom Keys credential object
   */
  credentials?: CustomKeys;

  /**
   * Authentication type of the connection target
   */
  authType: "CustomKeys";
}

/**
 * Custom Keys credential object
 */
model CustomKeys {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<keys> type used for 'CustomKeys' to support extensible key-value pairs matching service behavior"
  keys?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Connection properties for OAuth 2.0 authentication"
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model OAuth2AuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * ClientId and ClientSecret are required. Other properties are optional
   * depending on each OAuth2 provider's implementation.
   */
  credentials?: ConnectionOAuth2;

  /**
   * Authentication type of the connection target
   */
  authType: "OAuth2";
}

/**
 * ClientId and ClientSecret are required. Other properties are optional
 * depending on each OAuth2 provider's implementation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model ConnectionOAuth2 {
  /**
   * Required by Concur connection category
   */
  authUrl?: url;

  /**
   * Client id in the format of UUID
   */
  clientId?: Azure.Core.uuid;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The client secret for ConnectionOAuth2"
  @secret
  clientSecret?: string;

  /**
   * Required by GoogleAdWords connection category
   */
  @secret
  developerToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The password for ConnectionOAuth2"
  @secret
  password?: string;

  /**
   * Required by GoogleBigQuery, GoogleAdWords, Hubspot, QuickBooks, Square, Xero, Zoho
   * where user needs to get RefreshToken offline
   */
  @secret
  refreshToken?: string;

  /**
   * Required by QuickBooks and Xero connection categories
   */
  tenantId?: string;

  /**
   * Concur, ServiceNow auth server AccessToken grant type is 'Password'
   * which requires UsernamePassword
   */
  username?: string;
}

/**
 * This connection type covers the AAD auth for any applicable Azure service
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "'property' casing matches existing service-side JSON serialization"
model AADAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "AAD";
}

/**
 * FQDN Outbound Rule for the managed network of a cognitive services account.
 */
model FqdnOutboundRule extends OutboundRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The destination for FqdnOutboundRule"
  destination?: string;

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  type: "FQDN";
}

/**
 * Private Endpoint destination for an outbound rule.
 */
model PrivateEndpointOutboundRuleDestination {
  /**
   * The Azure resource ID of the target private endpoint service.
   */
  serviceResourceId?: string;

  /**
   * The subresource of the target service to connect to.
   */
  subresourceTarget?: string;
}

/**
 * Private Endpoint outbound rule for the managed network of a cognitive services account.
 */
model PrivateEndpointOutboundRule extends OutboundRule {
  /**
   * Private Endpoint destination.
   */
  destination?: PrivateEndpointOutboundRuleDestination;

  /**
   * List of FQDNs associated with the private endpoint outbound rule.
   */
  fqdns?: string[];

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  type: "PrivateEndpoint";
}

/**
 * Service Tag destination for an outbound rule.
 */
model ServiceTagOutboundRuleDestination {
  /**
   * Name of the Azure service tag to target.
   */
  serviceTag?: string;

  /**
   * Network protocol used by the service tag rule.
   */
  protocol?: string;

  /**
   * Destination port ranges.
   */
  portRanges?: string;

  /**
   * The action for the service tag outbound rule.
   */
  action?: RuleAction;

  /**
   * Optional address prefixes. If provided, the serviceTag property will be ignored.
   */
  addressPrefixes?: string[];
}

/**
 * Service Tag outbound rule for the managed network of a cognitive services account.
 */
model ServiceTagOutboundRule extends OutboundRule {
  /**
   * Service Tag destination.
   */
  destination?: ServiceTagOutboundRuleDestination;

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  type: "ServiceTag";
}

/**
 * Represents a managed agent deployment where the underlying infrastructure is managed by the platform in the deployer's subscription.
 */
model ManagedAgentDeployment extends AgentDeploymentProperties {
  /**
   * Gets or sets the type of deployment for the agent.
   */
  deploymentType: "Managed";
}

/**
 * Represents a hosted agent deployment where the underlying infrastructure is owned by the platform.
 */
model HostedAgentDeployment extends AgentDeploymentProperties {
  /**
   * Gets or sets the minimum number of replicas for this hosted deployment.
   */
  @minValue(0)
  minReplicas?: int32;

  /**
   * Gets or sets the maximum number of replicas for this hosted deployment.
   */
  @minValue(0)
  maxReplicas?: int32;

  /**
   * Gets or sets the type of deployment for the agent.
   */
  deploymentType: "Hosted";
}

/**
 * Built-in role-based authorization policy.
 */
model RoleBasedBuiltInAuthorizationPolicy
  extends ApplicationAuthorizationPolicy {
  /**
   * Authorization scheme type.
   */
  type: "Default";
}

/**
 * Built-in authorization policy scoped to organization/tenant.
 */
model OrganizationSharedBuiltInAuthorizationPolicy
  extends ApplicationAuthorizationPolicy {
  /**
   * Authorization scheme type.
   */
  type: "OrganizationScope";
}

/**
 * Represents a built-in authorization policy specific to Azure Bot Service/Channels authentication.
 */
model ChannelsBuiltInAuthorizationPolicy
  extends ApplicationAuthorizationPolicy {
  /**
   * Authorization scheme type.
   */
  type: "Channels";
}

/**
 * Represents a detailed description of an agent, including its name, functionality, hosting information, supported interaction modes, and available skills.
 */
model AgentCard {
  /**
   * Human-readable name for the Agent (e.g., 'Recipe Agent').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'name' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  name?: string | null;

  /**
   * Human-readable description of the Agent's function.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'description' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  description?: string | null;

  /**
   * URL address where the Agent is hosted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'url' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  url?: string | null;

  /**
   * Service provider information for the Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'provider' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  provider?: ProviderInfo | null;

  /**
   * Version of the Agent (format defined by provider, e.g., '1.0.0').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'version' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  version?: string | null;

  /**
   * URL for the Agent's documentation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'documentationUrl' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  documentationUrl?: string | null;

  /**
   * Default interaction modes supported by the Agent across all skills.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'defaultInputModes' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  defaultInputModes?: string[] | null;

  /**
   * Default output modes supported by the Agent across all skills.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'defaultOutputModes' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  defaultOutputModes?: string[] | null;

  /**
   * Collection of capability units the Agent can perform.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'skills' is nullable in 'AgentCard' for backward compatibility with existing API behavior"
  skills?: Skill[] | null;
}

/**
 * Service provider information for the Agent
 */
model ProviderInfo {
  /**
   * Organization name of the provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'organization' is nullable in 'ProviderInfo' for backward compatibility with existing API behavior"
  organization?: string | null;

  /**
   * URL of the provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'url' is nullable in 'ProviderInfo' for backward compatibility with existing API behavior"
  url?: string | null;
}

/**
 * Collection of capability units the Agent can perform
 */
model Skill {
  /**
   * Unique identifier for the skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'id' is nullable in 'Skill' for backward compatibility with existing API behavior"
  id?: string | null;

  /**
   * Human-readable name for the skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'name' is nullable in 'Skill' for backward compatibility with existing API behavior"
  name?: string | null;

  /**
   * Skill description.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'description' is nullable in 'Skill' for backward compatibility with existing API behavior"
  description?: string | null;

  /**
   * Tags describing the skill's capability category (e.g., 'cooking', 'customer support').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'tags' is nullable in 'Skill' for backward compatibility with existing API behavior"
  tags?: string[] | null;

  /**
   * Example scenarios or prompts the skill can execute (e.g., 'I need a recipe for bread').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'examples' is nullable in 'Skill' for backward compatibility with existing API behavior"
  examples?: string[] | null;

  /**
   * Input MIME types supported by the skill (if different from default).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'inputModes' is nullable in 'Skill' for backward compatibility with existing API behavior"
  inputModes?: string[] | null;

  /**
   * Output MIME types supported by the skill (if different from default).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "'outputModes' is nullable in 'Skill' for backward compatibility with existing API behavior"
  outputModes?: string[] | null;
}

/**
 * The list of cognitive services accounts operation response.
 */
model ModelCapacityListResult {
  /**
   * The link used to get the next page of ModelSkuCapacity.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts ModelSkuCapacity.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["model"])
  value?: ModelCapacityListResultValueItem[];
}

/**
 * List of managed networks of a cognitive services account.
 */
model ManagedNetworkListResult {
  /**
   * The link to the next page constructed using the continuationToken.  If null, there are no additional pages.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of managed network settings of an account. Since this list may be incomplete, the nextLink field should be used to request the next list of cognitive services accounts.
   */
  @pageItems
  value?: ManagedNetworkSettingsPropertiesBasicResource[];
}

/**
 * List of outbound rules for the managed network of a cognitive services account.
 */
model OutboundRuleListResult {
  /**
   * The link to the next page constructed using the continuationToken.  If null, there are no additional pages.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of cognitive services accounts. Since this list may be incomplete, the nextLink field should be used to request the next list of cognitive services accounts.
   */
  @pageItems
  value?: OutboundRuleBasicResource[];
}

/**
 * Managed Network Provisioning options for managed network of a cognitive services account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model 'ManagedNetworkProvisionOptions' preserved for backward compatibility with existing API surface"
model ManagedNetworkProvisionOptions {}

/**
 * The list of cognitive services RAI Blocklists.
 */
model RaiBlockListResult {
  /**
   * The link used to get the next page of RaiBlocklists.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiBlocklist.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiBlocklist[];
}

/**
 * The list of Cognitive Services RaiBlocklist Items for batch add.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model 'RaiBlocklistItemsBulkAddRequest' preserved for backward compatibility with existing API surface"
@identifiers(#["name"])
model RaiBlocklistItemsBulkAddRequest is Array<RaiBlocklistItemBulkRequest>;

/**
 * The list of cognitive services accounts operation response.
 */
model AccountListResult {
  /**
   * The link used to get the next page of accounts.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Account[];
}

/**
 * The list of cognitive services Commitment Plan Account Association operation response.
 */
model CommitmentPlanAccountAssociationListResult {
  /**
   * The link used to get the next page of Commitment Plan Account Association.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services Commitment Plan Account Association and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  value?: CommitmentPlanAccountAssociation[];
}

/**
 * The list of cognitive services accounts operation response.
 */
model CommitmentPlanListResult {
  /**
   * The link used to get the next page of CommitmentPlan.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts CommitmentPlan and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: CommitmentPlan[];
}

/**
 * The list of cognitive services accounts operation response.
 */
model DeploymentListResult {
  /**
   * The link used to get the next page of Deployment.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services accounts Deployment and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Deployment[];
}

/**
 * The list of cognitive services EncryptionScopes.
 */
model EncryptionScopeListResult {
  /**
   * The link used to get the next page of EncryptionScope.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of EncryptionScope.
   */
  @pageItems
  @identifiers(#["name"])
  value?: EncryptionScope[];
}

/**
 * The list of cognitive services projects operation response.
 */
model ProjectListResult {
  /**
   * The link used to get the next page of projects.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Cognitive Services projects and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Project[];
}

/**
 * The list of Quota Tiers response.
 */
model QuotaTierListResult {
  /**
   * The link used to get the next page of quota tiers.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Quota Tiers and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  value?: QuotaTier[];
}

/**
 * The list of Content Filters.
 */
model RaiContentFilterListResult {
  /**
   * The link used to get the next page of Content Filters.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiContentFilter.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiContentFilter[];
}

/**
 * The list of cognitive services RaiPolicies.
 */
model RaiPolicyListResult {
  /**
   * The link used to get the next page of RaiPolicy.
   */
  @nextLink
  nextLink?: string;

  /**
   * The list of RaiPolicy.
   */
  @pageItems
  @identifiers(#["name"])
  value?: RaiPolicy[];
}
@@identifiers(ResourceSkuListResult.value, #["resourceType", "name", "kind"]);

/**
 * The list of Cognitive Services RaiBlocklist Items Names.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model 'RaiBlocklistItemsBulkDeleteRequest' preserved for backward compatibility with existing API surface"
model RaiBlocklistItemsBulkDeleteRequest is Array<string>;
