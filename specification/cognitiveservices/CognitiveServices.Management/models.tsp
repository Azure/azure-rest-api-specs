import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CognitiveServices;

/**
 * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enterprise: "Enterprise",
}

/**
 * Gets the status of the cognitive services account at the time the operation was called.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ResolvingDNS: "ResolvingDNS",
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union NetworkRuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * Setting for trusted services.
 */
union ByPassSelection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureServices: "AzureServices",
}

/**
 * Enumerates the possible value of keySource for Encryption
 */
union KeySource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.CognitiveServices`: "Microsoft.CognitiveServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Whether or not public endpoint access is allowed for this account.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Multiregion routing methods.
 */
union RoutingMethods {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Priority: "Priority",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weighted: "Weighted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Performance: "Performance",
}

/**
 * The action of AbusePenalty.
 */
union AbusePenaltyAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Throttle: "Throttle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Block: "Block",
}

/**
 * Specifies what features in AI Foundry network injection applies to. Currently only supports 'agent' for agent scenarios. 'none' means no network injection.
 */
union ScenarioType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  none: "none",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agent: "agent",
}

/**
 * The reason for restriction.
 */
union ResourceSkuRestrictionsReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The unit of the metric.
 */
union UnitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BytesPerSecond: "BytesPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Milliseconds: "Milliseconds",
}

/**
 * Cognitive Services account quota usage status.
 */
union QuotaUsageStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Included: "Included",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Blocked: "Blocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InOverage: "InOverage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * Indicates whether the deprecation date is a confirmed planned end-of-life date or an estimated deprecation date. When 'Planned', the deprecation date represents a confirmed and communicated model end-of-life date. When 'Tentative', the deprecation date is an estimated timeline that may be subject to change.
 */
union DeprecationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Planned: "Planned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * Account hosting model.
 */
union HostingModel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Web: "Web",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConnectedContainer: "ConnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DisconnectedContainer: "DisconnectedContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProvisionedWeb: "ProvisionedWeb",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union DeploymentProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Deployment scale type.
 */
union DeploymentScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Manual: "Manual",
}

/**
 * Deployment model version upgrade option.
 */
union DeploymentModelVersionUpgradeOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnceNewDefaultVersionAvailable: "OnceNewDefaultVersionAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnceCurrentVersionExpired: "OnceCurrentVersionExpired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Gets the status of the resource at the time the operation was called.
 */
union CommitmentPlanProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
union EncryptionScopeProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The encryptionScope state.
 */
union EncryptionScopeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Content Filters policy type.
 */
union RaiPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserManaged: "UserManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemManaged: "SystemManaged",
}

/**
 * Rai policy mode. The enum value mapping is as below: Default = 0, Deferred=1, Blocking=2, Asynchronous_filter =3. Please use 'Asynchronous_filter' after 2025-06-01. It is the same as 'Deferred' in previous version.
 */
union RaiPolicyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Blocking: "Blocking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Asynchronous_filter: "Asynchronous_filter",
}

/**
 * Level at which content is filtered.
 */
union ContentLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
}

/**
 * Content source to apply the Content Filters.
 */
union RaiPolicyContentSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Prompt: "Prompt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completion: "Completion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreToolCall: "PreToolCall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostToolCall: "PostToolCall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreRun: "PreRun",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostRun: "PostRun",
}

/**
 * The action types to apply to the content filters
 */
union RaiActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BLOCKING: "BLOCKING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ANNOTATING: "ANNOTATING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HITL: "HITL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RETRY: "RETRY",
}

/**
 * Direction of Access Rule
 */
union NspAccessRuleDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Outbound: "Outbound",
}

/**
 * Defender for AI state on the AI resource.
 */
union DefenderForAISettingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Authentication type of the connection target
 */
union ConnectionAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UsernamePassword: "UsernamePassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAS: "SAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServicePrincipal: "ServicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccessKey: "AccessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OAuth2: "OAuth2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AAD: "AAD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DelegatedSAS: "DelegatedSAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProjectManagedIdentity: "ProjectManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccountManagedIdentity: "AccountManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserEntraToken: "UserEntraToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AgentUserImpersonation: "AgentUserImpersonation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AgenticIdentityToken: "AgenticIdentityToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AgenticUser: "AgenticUser",
}

/**
 * Category of the connection
 */
union ConnectionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PythonFeed: "PythonFeed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContainerRegistry: "ContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Git: "Git",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  S3: "S3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Snowflake: "Snowflake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureKeyVault: "AzureKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSynapseAnalytics: "AzureSynapseAnalytics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureMySqlDb: "AzureMySqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzurePostgresDb: "AzurePostgresDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ADLSGen2: "ADLSGen2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureContainerAppEnvironment: "AzureContainerAppEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Redis: "Redis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureOpenAI: "AzureOpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AIServices: "AIServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CognitiveSearch: "CognitiveSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CognitiveService: "CognitiveService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlob: "AzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageAccount: "AzureStorageAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureOneLake: "AzureOneLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDb: "CosmosDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDbMongoDbApi: "CosmosDbMongoDbApi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureDataExplorer: "AzureDataExplorer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureMariaDb: "AzureMariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureDatabricksDeltaLake: "AzureDatabricksDeltaLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSqlMi: "AzureSqlMi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureTableStorage: "AzureTableStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmazonRdsForOracle: "AmazonRdsForOracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmazonRdsForSqlServer: "AmazonRdsForSqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmazonRedshift: "AmazonRedshift",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Db2: "Db2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Drill: "Drill",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GoogleBigQuery: "GoogleBigQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Greenplum: "Greenplum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hbase: "Hbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hive: "Hive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Impala: "Impala",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Informix: "Informix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MariaDb: "MariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MicrosoftAccess: "MicrosoftAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Netezza: "Netezza",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Oracle: "Oracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Phoenix: "Phoenix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSql: "PostgreSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Presto: "Presto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapOpenHub: "SapOpenHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapBw: "SapBw",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapHana: "SapHana",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapTable: "SapTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Spark: "Spark",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlServer: "SqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sybase: "Sybase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Teradata: "Teradata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Vertica: "Vertica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pinecone: "Pinecone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Couchbase: "Couchbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoDbV2: "MongoDbV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoDbAtlas: "MongoDbAtlas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmazonS3Compatible: "AmazonS3Compatible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileServer: "FileServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FtpServer: "FtpServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GoogleCloudStorage: "GoogleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hdfs: "Hdfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OracleCloudStorage: "OracleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sftp: "Sftp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericHttp: "GenericHttp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ODataRest: "ODataRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Odbc: "Odbc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericRest: "GenericRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RemoteTool: "RemoteTool",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmazonMws: "AmazonMws",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Concur: "Concur",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dynamics: "Dynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DynamicsAx: "DynamicsAx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DynamicsCrm: "DynamicsCrm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GoogleAdWords: "GoogleAdWords",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hubspot: "Hubspot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Jira: "Jira",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Magento: "Magento",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Marketo: "Marketo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Office365: "Office365",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Eloqua: "Eloqua",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Responsys: "Responsys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OracleServiceCloud: "OracleServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PayPal: "PayPal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuickBooks: "QuickBooks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Salesforce: "Salesforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SalesforceServiceCloud: "SalesforceServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SalesforceMarketingCloud: "SalesforceMarketingCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapCloudForCustomer: "SapCloudForCustomer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapEcc: "SapEcc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServiceNow: "ServiceNow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SharePointOnlineList: "SharePointOnlineList",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Shopify: "Shopify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Square: "Square",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WebTable: "WebTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Xero: "Xero",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Zoho: "Zoho",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericContainerRegistry: "GenericContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Elasticsearch: "Elasticsearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AppInsights: "AppInsights",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AppConfig: "AppConfig",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OpenAI: "OpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Serp: "Serp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BingLLMSearch: "BingLLMSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Serverless: "Serverless",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedOnlineEndpoint: "ManagedOnlineEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ApiManagement: "ApiManagement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ModelGateway: "ModelGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GroundingWithBingSearch: "GroundingWithBingSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GroundingWithCustomSearch: "GroundingWithCustomSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MicrosoftFabric: "MicrosoftFabric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PowerPlatformEnvironment: "PowerPlatformEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RemoteA2A: "RemoteA2A",
}

/**
 * Group based on connection category
 */
union ConnectionGroup {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Azure: "Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureAI: "AzureAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoSQL: "NoSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenericProtocol: "GenericProtocol",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServicesAndApps: "ServicesAndApps",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedPERequirement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotRequired: "NotRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedPEStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CapabilityHostKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Agents: "Agents",
}

/**
 * Provisioning state of capability host.
 */
union CapabilityHostProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * Gets the tier upgrade policy for the subscription.
 */
union TierUpgradePolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnceUpgradeIsAvailable: "OnceUpgradeIsAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * Specifies whether an upgrade to the next quota tier is available.
 */
union UpgradeAvailabilityStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotAvailable: "NotAvailable",
}

/**
 * Category of a managed network Outbound Rule of a cognitive services account.
 */
union RuleCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recommended: "Recommended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserDefined: "UserDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dependency: "Dependency",
}

/**
 * Type of a managed network Outbound Rule of a cognitive services account.
 */
union RuleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Type of a managed network Outbound Rule of a cognitive services account.
 */
union RuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FQDN: "FQDN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrivateEndpoint: "PrivateEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServiceTag: "ServiceTag",
}

/**
 * Isolation mode for the managed network of a cognitive services account.
 */
union IsolationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllowInternetOutbound: "AllowInternetOutbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllowOnlyApprovedOutbound: "AllowOnlyApprovedOutbound",
}

/**
 * Status for the managed network of a cognitive services account.
 */
union ManagedNetworkStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
}

/**
 * Firewall Sku used for FQDN Rules
 */
union FirewallSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
}

/**
 * The Kind of the managed network. Users can switch from V1 to V2 for granular access controls, but cannot switch back to V1 once V2 is enabled.
 */
union ManagedNetworkKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V2: "V2",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedNetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * key name to generate (Key1|Key2)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyName {
  Key1,
  Key2,
}

/**
 * The type of restrictions.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  quotaLimit?: QuotaLimit;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restrictOutboundNetworkAccess?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowedFqdnList?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableLocalAuth?: boolean;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  endpoints?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkInjections?: NetworkInjection[];

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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["key"])
  rules?: ThrottlingRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ThrottlingRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renewalPeriod?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minCount?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dynamicThrottlingEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["path", "method"])
  matchPatterns?: RequestMatchPattern[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RequestMatchPattern {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  method?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model QuotaLimit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  count?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renewalPeriod?: float32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capabilities?: Record<string>;

  /**
   * The capabilities for finetune models.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingMeterInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  meterId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The SKU of Cognitive Services account.
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
   * The Kind of the resource.
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skuName?: string;

  /**
   * The available capacity for deployment with this model and sku.
   */
  availableCapacity?: float32;

  /**
   * The available capacity for deployment with a fine-tune version of this model and sku.
   */
  availableFinetuneCapacity?: float32;
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
   * The Kind of the resource.
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
   * The Kind of the resource.
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceTier?: ServiceTier | null;

  /**
   * The state of the deployment. Controls whether the deployment is accepting inference requests. Use 'Running' for active deployments that process requests, or 'Paused' to temporarily stop inference while preserving the deployment configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deploymentState?: DeploymentState | null;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RaiPolicyProperties {
  /**
   * Content Filters policy type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;

  /**
   * Properties of Cognitive Services RaiBlocklist Item.
   */
  properties?: RaiBlocklistItemProperties;
}

/**
 * RAI Custom Topic properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Last modified time of the custom topic.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Last modified time of the safety provider.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Cognitive Services Rai External Safety provider.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Last modified time of the safety provider.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  projectScopes?: RaiToolLabelPropertiesProjectScopesItem[];
}

/**
 * Account-level tool label definition.
 */
model RaiToolLabelPropertiesAccountScope {
  /**
   * Dictionary of label key-value pairs for the account scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labelValues?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RaiToolLabelPropertiesProjectScopesItem {
  /**
   * Project name to which this scope applies.
   */
  project: string;

  /**
   * Dictionary of label key-value pairs for the project scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RaiContentFilterProperties {
  /**
   * Name of Content Filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  createdByWorkspaceArmId?: Azure.Core.armResourceIdentifier;

  /**
   * Provides the error message if the connection fails
   */
  error?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expiryTime?: utcDateTime;

  /**
   * Group based on connection category
   */
  @visibility(Lifecycle.Read)
  group?: ConnectionGroup;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isSharedToAll?: boolean;

  /**
   * Store user metadata for this connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * Specifies how private endpoints are used with this connection: 'Required', 'NotRequired', or 'NotApplicable'.
   */
  peRequirement?: ManagedPERequirement;

  /**
   * Specifies the status of private endpoints for this connection: 'Inactive', 'Active', or 'NotApplicable'.
   */
  peStatus?: ManagedPEStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sharedUserList?: string[];

  /**
   * The connection URL to be used.
   */
  target?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionPropertiesV2BasicResourceArmPaginatedResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Capability Host.
   */
  @pageItems
  value?: CapabilityHostResource[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CapabilityHost extends ResourceBase {
  /**
   * List of AI services connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aiServicesConnections?: string[] | null;

  /**
   * Kind of this capability host.
   */
  capabilityHostKind?: CapabilityHostKind;

  /**
   * Customer subnet info to help set up this capability host.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customerSubnet?: string | null;

  /**
   * Provisioning state for the CapabilityHost.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityHostProvisioningState;

  /**
   * List of connection names from those available in the account or project to be used as a storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for Thread storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  threadStorageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for vector database (e.g. CosmosDB).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vectorStoreConnections?: string[] | null;

  /**
   * Whether public hosting environment is enabled for the capability host
   */
  enablePublicHostingEnvironment?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceBase {
  /**
   * The asset description text.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string> | null;
}

/**
 * A paginated list of Project Capability Host entities.
 */
model ProjectCapabilityHostResourceArmPaginatedResult {
  /**
   * The link to the next page of Project Capability Host objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Project Capability Host.
   */
  @pageItems
  value?: ProjectCapabilityHostResource[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProjectCapabilityHost {
  /**
   * List of AI services connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aiServicesConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for vector database (e.g. CosmosDB).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vectorStoreConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used as a storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageConnections?: string[] | null;

  /**
   * List of connection names from those available in the account or project to be used for Thread storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assignmentDate?: utcDateTime;

  /**
   * Information about the quota tier upgrade eligibility for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nextTierName?: string | null;

  /**
   * Specifies whether an upgrade to the next quota tier is available.
   */
  upgradeAvailabilityStatus?: UpgradeAvailabilityStatus;

  /**
   * The date after which the current tier will be upgraded to the next tier if the TierUpgradePolicy is "OnceUpgradeIsAvailable" (UTC).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradeApplicableDate?: utcDateTime | null;

  /**
   * Reason in case the subscription is not eligible for upgrade to the next tier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  upgradeUnavailabilityReason?: string | null;
}

/**
 * Outbound Rule for the managed network of a cognitive services account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: RuleType;

  /**
   * Error information about an outbound rule of a cognitive services account if RuleStatus is failed.
   */
  @visibility(Lifecycle.Read)
  errorInformation?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  parentRuleNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  networkId?: string;

  /**
   * Dictionary of <OutboundRule>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  egressIpAddress?: string | null;
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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedNetworkSettingsEx extends ManagedNetworkSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Application.
   */
  @pageItems
  value?: AgentApplicationResource[];
}

/**
 * Resource type representing an agentic application as a management construct.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgenticApplication extends ResourceBase {
  /**
   * The display name of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string | null;

  /**
   * The application's dedicated invocation endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baseUrl?: string | null;

  /**
   * The list of agent definitions comprising this application, returned as references to the objects under the parent project; use this to obtain a flat list of all agent-version pairs represented by this application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agents?: AgentReference[] | null;

  /**
   * The EntraId Agentic Blueprint of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentIdentityBlueprint?: AssignedIdentity | null;

  /**
   * The (default) agent instance identity of the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultInstanceIdentity?: AssignedIdentity | null;

  /**
   * Gets or sets the authorization policy associated with this agentic application instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationPolicy?: ApplicationAuthorizationPolicy | null;

  /**
   * Gets or sets the traffic routing policy for the application's deployments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model AgentReference {
  /**
   * Gets the agent's unique identifier within the organization (subscription).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentId?: string | null;

  /**
   * Gets the agent's name (unique within the project/app).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rules?: TrafficRoutingRule[] | null;
}

/**
 * Represents a rule for routing traffic to a specific deployment.
 */
model TrafficRoutingRule {
  /**
   * The identifier of this traffic routing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleId?: string | null;

  /**
   * A user-provided description for this traffic routing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * The unique identifier of the deployment to which traffic is routed by this rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: AgentReferenceResource[] | null;
}

/**
 * Agent Reference resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentReferenceResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * [Required] Additional attributes of the entity.
   */
  properties: AgentReference;
}

/**
 * A paginated list of Agent Deployment entities.
 */
model AgentDeploymentResourceArmPaginatedResult {
  /**
   * The link to the next page of Agent Deployment objects. If null, there are no additional pages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string | null;

  /**
   * An array of objects of type Agent Deployment.
   */
  @pageItems
  value?: AgentDeploymentResource[];
}

/**
 * Type representing an agent deployment as a management construct.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("deploymentType")
model AgentDeployment extends ResourceBase {
  /**
   * Gets or sets the display name of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string | null;

  /**
   * Gets or sets the unique identifier of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deploymentId?: string | null;

  /**
   * Gets or sets the current operational state of the deployment (and, intrinsically, of the comprising agents).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state?: AgentDeploymentState | null;

  /**
   * Gets or sets the supported protocol types and versions exposed by this deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocols?: AgentProtocolVersion[] | null;

  /**
   * Returns a flat list of agent:version deployed in this deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;
}

/**
 * Type modeling a reference to a version of an agent definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VersionedAgentReference extends AgentReference {
  /**
   * Gets the agent's version (unique for each agent lineage).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentVersion?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PATAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionPersonalAccessToken;

  /**
   * Authentication type of the connection target
   */
  authType: "PAT";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionPersonalAccessToken {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  pat?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedIdentityAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionManagedIdentity;

  /**
   * Authentication type of the connection target
   */
  authType: "ManagedIdentity";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionManagedIdentity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UsernamePasswordAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionUsernamePassword;

  /**
   * Authentication type of the connection target
   */
  authType: "UsernamePassword";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionUsernamePassword {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  password?: string;

  /**
   * Optional, required by connections like SalesForce for extra security in addition to UsernamePassword
   */
  @secret
  securityToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  username?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NoneAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "None";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SASAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionSharedAccessSignature;

  /**
   * Authentication type of the connection target
   */
  authType: "SAS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionSharedAccessSignature {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  key?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServicePrincipalAuthTypeConnectionProperties
  extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionServicePrincipal;

  /**
   * Authentication type of the connection target
   */
  authType: "ServicePrincipal";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionServicePrincipal {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientSecret?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessKeyAuthTypeConnectionProperties extends ConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credentials?: ConnectionAccessKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccessKey";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionAccessKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKeyId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionOAuth2 {
  /**
   * Required by Concur connection category
   */
  authUrl?: url;

  /**
   * Client id in the format of UUID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  clientId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientSecret?: string;

  /**
   * Required by GoogleAdWords connection category
   */
  @secret
  developerToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destination?: string;

  /**
   * Type of a managed network Outbound Rule of a cognitive services account.
   */
  type: "FQDN";
}

/**
 * Represents a managed agent deployment where the underlying infrastructure is managed by the platform in the deployer's subscription.
 */
model ManagedAgentDeployment extends AgentDeployment {
  /**
   * Gets or sets the type of deployment for the agent.
   */
  deploymentType: "Managed";
}

/**
 * Represents a hosted agent deployment where the underlying infrastructure is owned by the platform.
 */
model HostedAgentDeployment extends AgentDeployment {
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string | null;

  /**
   * Human-readable description of the Agent's function.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * URL address where the Agent is hosted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * Service provider information for the Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider?: ProviderInfo | null;

  /**
   * Version of the Agent (format defined by provider, e.g., '1.0.0').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;

  /**
   * URL for the Agent's documentation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  documentationUrl?: string | null;

  /**
   * Default interaction modes supported by the Agent across all skills.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultInputModes?: string[] | null;

  /**
   * Default output modes supported by the Agent across all skills.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultOutputModes?: string[] | null;

  /**
   * Collection of capability units the Agent can perform.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skills?: Skill[] | null;
}

/**
 * Service provider information for the Agent
 */
model ProviderInfo {
  /**
   * Organization name of the provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  organization?: string | null;

  /**
   * URL of the provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;
}

/**
 * Collection of capability units the Agent can perform
 */
model Skill {
  /**
   * Unique identifier for the skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string | null;

  /**
   * Human-readable name for the skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string | null;

  /**
   * Skill description.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * Tags describing the skill's capability category (e.g., 'cooking', 'customer support').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: string[] | null;

  /**
   * Example scenarios or prompts the skill can execute (e.g., 'I need a recipe for bread').
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  examples?: string[] | null;

  /**
   * Input MIME types supported by the skill (if different from default).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  inputModes?: string[] | null;

  /**
   * Output MIME types supported by the skill (if different from default).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RaiBlocklistItemsBulkDeleteRequest is Array<string>;
