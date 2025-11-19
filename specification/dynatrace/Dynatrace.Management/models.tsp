import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Dynatrace.Observability;

/**
 * Indicates whether metrics are being sent.
 */
union SendingMetricsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether logs are being sent.
 */
union SendingLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The operation for the patch on the resource.
 */
union SubscriptionListOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddBegin: "AddBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddComplete: "AddComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteBegin: "DeleteBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteComplete: "DeleteComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
}

/**
 * The state of monitoring.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * Indicates whether AAD logs are being sent.
 */
union SendAadLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether subscription logs are being sent.
 */
union SendSubscriptionLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether activity logs are being sent.
 */
union SendActivityLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
union TagAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Include: "Include",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exclude: "Exclude",
}

/**
 * Provisioning state of the monitoring resource
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
}

/**
 * Install/Uninstall action.
 */
union Action {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Install: "Install",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uninstall: "Uninstall",
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
union MonitoringStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
 */
union MarketplaceSubscriptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsubscribed: "Unsubscribed",
}

/**
 * Marketplace resource autorenew flag
 */
union MarketplaceSaasAutoRenew {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Off: "Off",
}

/**
 * Various states of the SSO resource
 */
union SingleSignOnStates {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initial: "Initial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disable: "Disable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Existing: "Existing",
}

/**
 * Liftr resource category
 */
union LiftrResourceCategories {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MonitorLogs: "MonitorLogs",
}

/**
 * The kind of managed identity assigned to this resource.
 */
union ManagedIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAndUserAssigned: "SystemAndUserAssigned",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * The monitoring mode of OneAgent
 */
union MonitoringType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CLOUD_INFRASTRUCTURE: "CLOUD_INFRASTRUCTURE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FULL_STACK: "FULL_STACK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISCOVERY: "DISCOVERY",
}

/**
 * Update settings of OneAgent.
 */
union AutoUpdateSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ENABLED: "ENABLED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISABLED: "DISABLED",
}

/**
 * The current update status of OneAgent.
 */
union UpdateStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  INCOMPATIBLE: "INCOMPATIBLE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OUTDATED: "OUTDATED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SCHEDULED: "SCHEDULED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SUPPRESSED: "SUPPRESSED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UNKNOWN: "UNKNOWN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UP2DATE: "UP2DATE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UPDATE_IN_PROGRESS: "UPDATE_IN_PROGRESS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UPDATE_PENDING: "UPDATE_PENDING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UPDATE_PROBLEM: "UPDATE_PROBLEM",
}

/**
 * The availability state of OneAgent.
 */
union AvailabilityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CRASHED: "CRASHED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LOST: "LOST",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MONITORED: "MONITORED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PRE_MONITORED: "PRE_MONITORED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SHUTDOWN: "SHUTDOWN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UNEXPECTED_SHUTDOWN: "UNEXPECTED_SHUTDOWN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UNKNOWN: "UNKNOWN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UNMONITORED: "UNMONITORED",
}

/**
 * Tells whether log modules are enabled or not
 */
union LogModule {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ENABLED: "ENABLED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISABLED: "DISABLED",
}

/**
 * Indicates whether SSO is enabled or not
 */
union SSOStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Request for getting log status for given monitored resource Ids
 */
model LogStatusRequest {
  /**
   * List of azure resource Id of monitored resources for which we get the log status
   */
  monitoredResourceIds?: string[];
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MonitoredSubscriptionPropertiesList
  is Azure.Core.Page<MonitoredSubscriptionProperties>;

/**
 * The request to update subscriptions needed to be monitored by the Dynatrace monitor resource.
 */
model SubscriptionList {
  /**
   * The operation for the patch on the resource.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  operation?: SubscriptionListOperation;

  /**
   * List of subscriptions and the state of the monitoring.
   */
  @identifiers(#[])
  monitoredSubscriptionList?: MonitoredSubscription[];

  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The list of subscriptions and it's monitoring status by current Dynatrace monitor.
 */
model MonitoredSubscription {
  /**
   * The subscriptionId to be monitored.
   */
  subscriptionId: string;

  /**
   * The state of monitoring.
   */
  status?: Status;

  /**
   * The reason of not monitoring the subscription.
   */
  error?: string;

  /**
   * Properties for the Tag rules resource of a Monitor account.
   */
  tagRules?: MonitoringTagRulesProperties;
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
  @visibility(Lifecycle.Read)
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
   * If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
   */
  @identifiers(#[])
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
   * Flag specifying if metrics from Azure resources should be sent for the Monitor resource.
   */
  sendingMetrics?: SendingMetricsStatus;

  /**
   * List of filtering tags to be used for capturing metrics. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
   */
  @identifiers(#[])
  filteringTags?: FilteringTag[];
}

/**
 * Dynatrace resource can be created or not.
 */
model CreateResourceSupportedResponse {
  /**
   * Represents the properties of the resource.
   */
  @identifiers(#[])
  value?: CreateResourceSupportedProperties[];

  /**
   * The link to the next page of items
   */
  nextLink?: string;
}

/**
 * Properties related to the support for creating Dynatrace resources.
 */
model CreateResourceSupportedProperties {
  /**
   * The ARM id of the subscription.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates if selected subscription supports Dynatrace resource creation, if not it is already being monitored for the selected organization via multi subscription feature.
   */
  @visibility(Lifecycle.Read)
  creationSupported?: boolean;
}

/**
 * Response of payload to be passed while installing VM agent.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMExtensionPayload {
  /**
   * Ingestion key of the environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: if this is a value that should be kept private, mark as @secret"
  ingestionKey?: string;

  /**
   * Id of the environment created
   */
  environmentId?: string;
}

/**
 * Request for performing Dynatrace agent install/uninstall action through the Azure Dynatrace resource on the provided list of agent resources.
 */
model ManageAgentInstallationRequest {
  /**
   * The list of resources.
   */
  manageAgentInstallationList: ManageAgentList[];

  /**
   * Install/Uninstall action.
   */
  action: Action;
}

/**
 * Details of resource that has Dynatrace agent installed through the Azure Dynatrace resource.
 */
model ManageAgentList {
  /**
   * The ARM id of the resource to install/uninstall agent.
   */
  id?: string;
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
   * Marketplace resource autorenew flag
   */
  marketplaceSaasAutoRenew?: MarketplaceSaasAutoRenew;

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
  @visibility(Lifecycle.Read)
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * The priority of the resource.
   */
  @visibility(Lifecycle.Read)
  liftrResourcePreference?: int32;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * Name of the customer account / company
   */
  companyName?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "If this is a value that should be kept private, mark as @secret"
  ingestionKey?: string;

  /**
   * Ingestion endpoint used for sending logs
   */
  logsIngestionEndpoint?: string;

  /**
   * Landing URL for Dynatrace environment
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The active directory identifier of this principal.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The type of managed identity assigned to this resource.
   */
  type: ManagedIdentityType;

  /**
   * The identities assigned to this resource by the user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The updatable properties of the MonitorResource.
 */
model MonitorResourceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The set of properties that can be updated in a PATCH request to a monitor resource.
   */
  properties?: MonitorUpdateProperties;

  /**
   * The managed service identities assigned to this resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * The set of properties that can be updated in a PATCH request to a monitor resource.
 */
model MonitorUpdateProperties {
  /**
   * The new Billing plan information.
   */
  planData?: PlanData;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Request for getting connected resources count for a Marketplace Subscription Id
 */
model MarketplaceSubscriptionIdRequest {
  /**
   * Marketplace Subscription Id
   */
  marketplaceSubscriptionId: string;
}

/**
 * Response for getting Connected resources for a MP SaaS Resource
 */
model ConnectedResourcesCountResponse {
  /**
   * Count of the connected resources
   */
  connectedResourcesCount?: int64;
}

/**
 * Request for getting Marketplace SaaS resource details for a tenant Id
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MarketplaceSaaSResourceDetailsRequest {
  /**
   * Tenant Id
   */
  tenantId: string;
}

/**
 * Marketplace SaaS resource details linked to the given tenant Id
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MarketplaceSaaSResourceDetailsResponse {
  /**
   * Id of the Marketplace SaaS Resource
   */
  marketplaceSaaSResourceId?: string;

  /**
   * Id of the plan
   */
  planId?: string;

  /**
   * Marketplace subscription status
   */
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Name of the Marketplace SaaS Resource
   */
  marketplaceSaaSResourceName?: string;
}

/**
 * Response of a list VM Host Operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Request for getting metric status for given monitored resource Ids
 */
model MetricStatusRequest {
  /**
   * List of azure resource Id of monitored resources for which we get the metric status
   */
  monitoredResourceIds?: string[];
}

/**
 * Response of get metrics status operation
 */
model MetricsStatusResponse {
  /**
   * Azure resource IDs
   */
  azureResourceIds?: string[];
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
 * The billing plan properties for the upgrade plan call.
 */
model UpgradePlanRequest {
  /**
   * The new Billing plan information.
   */
  planData?: PlanData;
}

/**
 * Request for getting sso details for a user
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SSODetailsRequest {
  /**
   * user principal id of the user
   */
  userPrincipal: string;
}

/**
 * SSO details from the Dynatrace partner
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  tenantId: string;

  /**
   * user principal id of the user
   */
  userPrincipal: string;

  /**
   * Azure region in which we want to link the environment
   */
  region: string;
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
