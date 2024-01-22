import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Dynatrace.Observability;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates whether metrics are being sent.
 */
enum SendingMetricsStatus {
  Enabled,
  Disabled,
}

/**
 * Indicates whether logs are being sent.
 */
enum SendingLogsStatus {
  Enabled,
  Disabled,
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
enum MonitoringStatus {
  Enabled,
  Disabled,
}

/**
 * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
 */
enum MarketplaceSubscriptionStatus {
  Active,
  Suspended,
}

/**
 * Various states of the SSO resource
 */
enum SingleSignOnStates {
  Initial,
  Enable,
  Disable,
  Existing,
}

/**
 * Provisioning state of the monitoring resource
 */
enum ProvisioningState {
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  NotSpecified,
}

/**
 * Liftr resource category
 */
enum LiftrResourceCategories {
  Unknown,
  MonitorLogs,
}

/**
 * Indicates whether AAD logs are being sent.
 */
enum SendAadLogsStatus {
  Enabled,
  Disabled,
}

/**
 * Indicates whether subscription logs are being sent.
 */
enum SendSubscriptionLogsStatus {
  Enabled,
  Disabled,
}

/**
 * Indicates whether activity logs are being sent.
 */
enum SendActivityLogsStatus {
  Enabled,
  Disabled,
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
enum TagAction {
  Include,
  Exclude,
}

/**
 * The monitoring mode of OneAgent
 */
enum MonitoringType {
  CLOUD_INFRASTRUCTURE,
  FULL_STACK,
}

/**
 * Update settings of OneAgent.
 */
enum AutoUpdateSetting {
  ENABLED,
  DISABLED,
}

/**
 * The current update status of OneAgent.
 */
enum UpdateStatus {
  INCOMPATIBLE,
  OUTDATED,
  SCHEDULED,
  SUPPRESSED,
  UNKNOWN,
  UP2DATE,
  UPDATE_IN_PROGRESS,
  UPDATE_PENDING,
  UPDATE_PROBLEM,
}

/**
 * The availability state of OneAgent.
 */
enum AvailabilityState {
  CRASHED,
  LOST,
  MONITORED,
  PRE_MONITORED,
  SHUTDOWN,
  UNEXPECTED_SHUTDOWN,
  UNKNOWN,
  UNMONITORED,
}

/**
 * Tells whether log modules are enabled or not
 */
enum LogModule {
  ENABLED,
  DISABLED,
}

/**
 * Indicates whether SSO is enabled or not
 */
enum SSOStatus {
  Enabled,
  Disabled,
}

/**
 * Dynatrace account API Key
 */
model AccountInfoSecure {
  /**
   * Account Id of the account this environment is linked to
   */
  @visibility("read")
  accountId?: string;

  /**
   * API Key of the user account
   */
  @visibility("read")
  @secret
  apiKey?: string;

  /**
   * Region in which the account is created
   */
  @visibility("read")
  regionId?: string;
}

/**
 * List of all the resources being monitored by Dynatrace monitor resource
 */
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

/**
 * Details of resource being monitored by Dynatrace monitor resource
 */
model MonitoredResource {
  /**
   * The ARM id of the resource.
   */
  id?: string;

  /**
   * Flag indicating if resource is sending metrics to Dynatrace.
   */
  sendingMetrics?: SendingMetricsStatus;

  /**
   * Reason for why the resource is sending metrics (or why it is not sending).
   */
  reasonForMetricsStatus?: string;

  /**
   * Flag indicating if resource is sending logs to Dynatrace.
   */
  sendingLogs?: SendingLogsStatus;

  /**
   * Reason for why the resource is sending logs (or why it is not sending).
   */
  reasonForLogsStatus?: string;
}

/**
 * Response of payload to be passed while installing VM agent.
 */
model VMExtensionPayload {
  /**
   * Ingestion key of the environment
   */
  ingestionKey?: string;

  /**
   * Id of the environment created
   */
  environmentId?: string;
}

/**
 * Properties specific to the monitor resource.
 */
model MonitorProperties {
  /**
   * Status of the monitor.
   */
  monitoringStatus?: MonitoringStatus;

  /**
   * Marketplace subscription status.
   */
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Properties of the Dynatrace environment.
   */
  dynatraceEnvironmentProperties?: DynatraceEnvironmentProperties;

  /**
   * User info.
   */
  userInfo?: UserInfo;

  /**
   * Billing plan information.
   */
  planData?: PlanData;

  /**
   * Liftr Resource category.
   */
  @visibility("read")
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * The priority of the resource.
   */
  @visibility("read")
  liftrResourcePreference?: int32;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties of the Dynatrace environment.
 */
model DynatraceEnvironmentProperties {
  /**
   * User id
   */
  userId?: string;

  /**
   * Dynatrace Account Information
   */
  accountInfo?: AccountInfo;

  /**
   * Dynatrace Environment Information
   */
  environmentInfo?: EnvironmentInfo;

  /**
   * The details of a Dynatrace single sign-on.
   */
  singleSignOnProperties?: DynatraceSingleSignOnProperties;
}

/**
 * Dynatrace Account Information
 */
model AccountInfo {
  /**
   * Account Id of the account this environment is linked to
   */
  accountId?: string;

  /**
   * Region in which the account is created
   */
  regionId?: string;
}

/**
 * Dynatrace Environment Information
 */
model EnvironmentInfo {
  /**
   * Id of the environment created
   */
  environmentId?: string;

  /**
   * Ingestion key of the environment
   */
  ingestionKey?: string;

  /**
   * Ingestion endpoint used for sending logs
   */
  logsIngestionEndpoint?: string;

  /**
   * Landing URL for Dynatrace environment
   */
  landingURL?: string;
}

/**
 * The details of a Dynatrace single sign-on.
 */
model DynatraceSingleSignOnProperties {
  /**
   * State of Single Sign On
   */
  singleSignOnState?: SingleSignOnStates;

  /**
   * Version of the Dynatrace agent installed on the VM.
   */
  enterpriseAppId?: string;

  /**
   * The login URL specific to this Dynatrace Environment
   */
  singleSignOnUrl?: string;

  /**
   * array of Aad(azure active directory) domains
   */
  aadDomains?: string[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * User info.
 */
model UserInfo {
  /**
   * First Name of the user
   */
  firstName?: string;

  /**
   * Last Name of the user
   */
  lastName?: string;

  /**
   * Email of the user used by Dynatrace for contacting them if needed
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  emailAddress?: string;

  /**
   * Phone number of the user used by Dynatrace for contacting them if needed
   */
  @maxLength(40)
  phoneNumber?: string;

  /**
   * Country of the user
   */
  country?: string;
}

/**
 * Billing plan information.
 */
model PlanData {
  /**
   * different usage type like PAYG/COMMITTED. this could be enum
   */
  usageType?: string;

  /**
   * different billing cycles like MONTHLY/WEEKLY. this could be enum
   */
  billingCycle?: string;

  /**
   * plan id as published by Dynatrace
   */
  planDetails?: string;

  /**
   * date when plan was applied
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;
}

/**
 * The properties of the managed service identities assigned to this resource.
 */
model IdentityProperties {
  /**
   * The Active Directory tenant id of the principal.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The active directory identifier of this principal.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The type of managed identity assigned to this resource.
   */
  type: ManagedIdentityType;

  /**
   * The identities assigned to this resource by the user.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
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
}

/**
 * The updatable properties of the MonitorResource.
 */
model MonitorResourceUpdate {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Status of the monitor.
   */
  monitoringStatus?: MonitoringStatus;

  /**
   * Marketplace subscription status.
   */
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Properties of the Dynatrace environment.
   */
  dynatraceEnvironmentProperties?: DynatraceEnvironmentProperties;

  /**
   * User info.
   */
  userInfo?: UserInfo;

  /**
   * Billing plan information.
   */
  planData?: PlanData;
}

/**
 * Properties for the Tag rules resource of a Monitor account.
 */
model MonitoringTagRulesProperties {
  /**
   * Set of rules for sending logs for the Monitor resource.
   */
  logRules?: LogRules;

  /**
   * Set of rules for sending metrics for the Monitor resource.
   */
  metricRules?: MetricRules;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Set of rules for sending logs for the Monitor resource.
 */
model LogRules {
  /**
   * Flag specifying if AAD logs should be sent for the Monitor resource.
   */
  sendAadLogs?: SendAadLogsStatus;

  /**
   * Flag specifying if subscription logs should be sent for the Monitor resource.
   */
  sendSubscriptionLogs?: SendSubscriptionLogsStatus;

  /**
   * Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.
   */
  sendActivityLogs?: SendActivityLogsStatus;

  /**
* List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured.
If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
*/
  filteringTags?: FilteringTag[];
}

/**
 * The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.
 */
model FilteringTag {
  /**
   * The name (also known as the key) of the tag.
   */
  name?: string;

  /**
   * The value of the tag.
   */
  value?: string;

  /**
   * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
   */
  action?: TagAction;
}

/**
 * Set of rules for sending metrics for the Monitor resource.
 */
model MetricRules {
  /**
   * List of filtering tags to be used for capturing metrics. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
   */
  filteringTags?: FilteringTag[];
}

/**
 * The updatable properties of the TagRule.
 */
model TagRuleUpdate {
  /**
   * Set of rules for sending logs for the Monitor resource.
   */
  logRules?: LogRules;

  /**
   * Set of rules for sending metrics for the Monitor resource.
   */
  metricRules?: MetricRules;
}

/**
 * Response of a list VM Host Operation.
 */
model VMHostsListResponse is Azure.Core.Page<VMInfo>;

/**
 * Details of VM Resource having Dynatrace OneAgent installed
 */
model VMInfo {
  /**
   * Azure VM resource ID
   */
  resourceId?: string;

  /**
   * Version of the Dynatrace agent installed on the VM.
   */
  version?: string;

  /**
   * The monitoring mode of OneAgent
   */
  monitoringType?: MonitoringType;

  /**
   * Update settings of OneAgent.
   */
  autoUpdateSetting?: AutoUpdateSetting;

  /**
   * The current update status of OneAgent.
   */
  updateStatus?: UpdateStatus;

  /**
   * The availability state of OneAgent.
   */
  availabilityState?: AvailabilityState;

  /**
   * Tells whether log modules are enabled or not
   */
  logModule?: LogModule;

  /**
   * The name of the host group
   */
  hostGroup?: string;

  /**
   * The name of the host
   */
  hostName?: string;
}

/**
 * Response of a list App Services Operation.
 */
model AppServiceListResponse is Azure.Core.Page<AppServiceInfo>;

/**
 * Details of App Services having Dynatrace OneAgent installed
 */
model AppServiceInfo {
  /**
   * App service resource ID
   */
  resourceId?: string;

  /**
   * Version of the Dynatrace agent installed on the App Service.
   */
  version?: string;

  /**
   * The monitoring mode of OneAgent
   */
  monitoringType?: MonitoringType;

  /**
   * Update settings of OneAgent.
   */
  autoUpdateSetting?: AutoUpdateSetting;

  /**
   * The current update status of OneAgent.
   */
  updateStatus?: UpdateStatus;

  /**
   * The availability state of OneAgent.
   */
  availabilityState?: AvailabilityState;

  /**
   * Tells whether log modules are enabled or not
   */
  logModule?: LogModule;

  /**
   * The name of the host group
   */
  hostGroup?: string;

  /**
   * The name of the host
   */
  hostName?: string;
}

/**
 * Request for getting sso details for a user
 */
model SSODetailsRequest {
  /**
   * user principal id of the user
   */
  userPrincipal?: string;
}

/**
 * SSO details from the Dynatrace partner
 */
model SSODetailsResponse {
  /**
   * Whether the SSO is enabled for this resource or not.
   */
  isSsoEnabled?: SSOStatus;

  /**
   * URL for Azure AD metadata
   */
  metadataUrl?: string;

  /**
   * The login URL specific to this Dynatrace Environment
   */
  singleSignOnUrl?: string;

  /**
   * array of Aad(azure active directory) domains
   */
  aadDomains?: string[];

  /**
   * Array of admin user emails.
   */
  adminUsers?: string[];
}

/**
 * Request for getting all the linkable environments for a user
 */
model LinkableEnvironmentRequest {
  /**
   * Tenant Id of the user in which they want to link the environment
   */
  tenantId?: string;

  /**
   * user principal id of the user
   */
  userPrincipal?: string;

  /**
   * Azure region in which we want to link the environment
   */
  region?: string;
}

/**
 * Response for getting all the linkable environments
 */
model LinkableEnvironmentListResponse
  is Azure.Core.Page<LinkableEnvironmentResponse>;

/**
 * Response for getting all the linkable environments
 */
model LinkableEnvironmentResponse {
  /**
   * environment id for which user is an admin
   */
  environmentId?: string;

  /**
   * Name of the environment
   */
  environmentName?: string;

  /**
   * Billing plan information.
   */
  planData?: PlanData;
}
