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

@doc("Indicates whether metrics are being sent.")
enum SendingMetricsStatus {
  Enabled,
  Disabled,
}

@doc("Indicates whether logs are being sent.")
enum SendingLogsStatus {
  Enabled,
  Disabled,
}

@doc("Flag specifying if the resource monitoring is enabled or disabled.")
enum MonitoringStatus {
  Enabled,
  Disabled,
}

@doc("Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.")
enum MarketplaceSubscriptionStatus {
  Active,
  Suspended,
}

@doc("Various states of the SSO resource")
enum SingleSignOnStates {
  Initial,
  Enable,
  Disable,
  Existing,
}

@doc("Provisioning state of the monitoring resource")
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

@doc("Liftr resource category")
enum LiftrResourceCategories {
  Unknown,
  MonitorLogs,
}

@doc("Indicates whether AAD logs are being sent.")
enum SendAadLogsStatus {
  Enabled,
  Disabled,
}

@doc("Indicates whether subscription logs are being sent.")
enum SendSubscriptionLogsStatus {
  Enabled,
  Disabled,
}

@doc("Indicates whether activity logs are being sent.")
enum SendActivityLogsStatus {
  Enabled,
  Disabled,
}

@doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
enum TagAction {
  Include,
  Exclude,
}

@doc("The monitoring mode of OneAgent")
enum MonitoringType {
  CLOUD_INFRASTRUCTURE,
  FULL_STACK,
}

@doc("Update settings of OneAgent.")
enum AutoUpdateSetting {
  ENABLED,
  DISABLED,
}

@doc("The current update status of OneAgent.")
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

@doc("The availability state of OneAgent.")
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

@doc("Tells whether log modules are enabled or not")
enum LogModule {
  ENABLED,
  DISABLED,
}

@doc("Indicates whether SSO is enabled or not")
enum SSOStatus {
  Enabled,
  Disabled,
}

@doc("Dynatrace account API Key")
model AccountInfoSecure {
  @doc("Account Id of the account this environment is linked to")
  @visibility("read")
  accountId?: string;

  @doc("API Key of the user account")
  @visibility("read")
  @secret
  apiKey?: string;

  @doc("Region in which the account is created")
  @visibility("read")
  regionId?: string;
}

@doc("List of all the resources being monitored by Dynatrace monitor resource")
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

@doc("Details of resource being monitored by Dynatrace monitor resource")
model MonitoredResource {
  @doc("The ARM id of the resource.")
  id?: string;

  @doc("Flag indicating if resource is sending metrics to Dynatrace.")
  sendingMetrics?: SendingMetricsStatus;

  @doc("Reason for why the resource is sending metrics (or why it is not sending).")
  reasonForMetricsStatus?: string;

  @doc("Flag indicating if resource is sending logs to Dynatrace.")
  sendingLogs?: SendingLogsStatus;

  @doc("Reason for why the resource is sending logs (or why it is not sending).")
  reasonForLogsStatus?: string;
}

@doc("Response of payload to be passed while installing VM agent.")
model VMExtensionPayload {
  @doc("Ingestion key of the environment")
  ingestionKey?: string;

  @doc("Id of the environment created")
  environmentId?: string;
}

@doc("Properties specific to the monitor resource.")
model MonitorProperties {
  @doc("Status of the monitor.")
  monitoringStatus?: MonitoringStatus;

  @doc("Marketplace subscription status.")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  @doc("Properties of the Dynatrace environment.")
  dynatraceEnvironmentProperties?: DynatraceEnvironmentProperties;

  @doc("User info.")
  userInfo?: UserInfo;

  @doc("Billing plan information.")
  planData?: PlanData;

  @doc("Liftr Resource category.")
  @visibility("read")
  liftrResourceCategory?: LiftrResourceCategories;

  @doc("The priority of the resource.")
  @visibility("read")
  liftrResourcePreference?: int32;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of the Dynatrace environment.")
model DynatraceEnvironmentProperties {
  @doc("User id")
  userId?: string;

  @doc("Dynatrace Account Information")
  accountInfo?: AccountInfo;

  @doc("Dynatrace Environment Information")
  environmentInfo?: EnvironmentInfo;

  @doc("The details of a Dynatrace single sign-on.")
  singleSignOnProperties?: DynatraceSingleSignOnProperties;
}

@doc("Dynatrace Account Information")
model AccountInfo {
  @doc("Account Id of the account this environment is linked to")
  accountId?: string;

  @doc("Region in which the account is created")
  regionId?: string;
}

@doc("Dynatrace Environment Information")
model EnvironmentInfo {
  @doc("Id of the environment created")
  environmentId?: string;

  @doc("Ingestion key of the environment")
  ingestionKey?: string;

  @doc("Ingestion endpoint used for sending logs")
  logsIngestionEndpoint?: string;

  @doc("Landing URL for Dynatrace environment")
  landingURL?: string;
}

@doc("The details of a Dynatrace single sign-on.")
model DynatraceSingleSignOnProperties {
  @doc("State of Single Sign On")
  singleSignOnState?: SingleSignOnStates;

  @doc("Version of the Dynatrace agent installed on the VM.")
  enterpriseAppId?: string;

  @doc("The login URL specific to this Dynatrace Environment")
  singleSignOnUrl?: string;

  @doc("array of Aad(azure active directory) domains")
  aadDomains?: string[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("User info.")
model UserInfo {
  @doc("First Name of the user")
  firstName?: string;

  @doc("Last Name of the user")
  lastName?: string;

  @doc("Email of the user used by Dynatrace for contacting them if needed")
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  emailAddress?: string;

  @doc("Phone number of the user used by Dynatrace for contacting them if needed")
  @maxLength(40)
  phoneNumber?: string;

  @doc("Country of the user")
  country?: string;
}

@doc("Billing plan information.")
model PlanData {
  @doc("different usage type like PAYG/COMMITTED. this could be enum")
  usageType?: string;

  @doc("different billing cycles like MONTHLY/WEEKLY. this could be enum")
  billingCycle?: string;

  @doc("plan id as published by Dynatrace")
  planDetails?: string;

  @doc("date when plan was applied")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;
}

@doc("The properties of the managed service identities assigned to this resource.")
model IdentityProperties {
  @doc("The Active Directory tenant id of the principal.")
  @visibility("read")
  tenantId?: string;

  @doc("The active directory identifier of this principal.")
  @visibility("read")
  principalId?: string;

  @doc("The type of managed identity assigned to this resource.")
  type: ManagedIdentityType;

  @doc("The identities assigned to this resource by the user.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
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
}

@doc("The updatable properties of the MonitorResource.")
model MonitorResourceUpdate {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("Status of the monitor.")
  monitoringStatus?: MonitoringStatus;

  @doc("Marketplace subscription status.")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  @doc("Properties of the Dynatrace environment.")
  dynatraceEnvironmentProperties?: DynatraceEnvironmentProperties;

  @doc("User info.")
  userInfo?: UserInfo;

  @doc("Billing plan information.")
  planData?: PlanData;
}

@doc("Properties for the Tag rules resource of a Monitor account.")
model MonitoringTagRulesProperties {
  @doc("Set of rules for sending logs for the Monitor resource.")
  logRules?: LogRules;

  @doc("Set of rules for sending metrics for the Monitor resource.")
  metricRules?: MetricRules;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Set of rules for sending logs for the Monitor resource.")
model LogRules {
  @doc("Flag specifying if AAD logs should be sent for the Monitor resource.")
  sendAadLogs?: SendAadLogsStatus;

  @doc("Flag specifying if subscription logs should be sent for the Monitor resource.")
  sendSubscriptionLogs?: SendSubscriptionLogsStatus;

  @doc("Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.")
  sendActivityLogs?: SendActivityLogsStatus;

  @doc("""
List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured.
If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
""")
  filteringTags?: FilteringTag[];
}

@doc("The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.")
model FilteringTag {
  @doc("The name (also known as the key) of the tag.")
  name?: string;

  @doc("The value of the tag.")
  value?: string;

  @doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
  action?: TagAction;
}

@doc("Set of rules for sending metrics for the Monitor resource.")
model MetricRules {
  @doc("List of filtering tags to be used for capturing metrics. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.")
  filteringTags?: FilteringTag[];
}

@doc("The updatable properties of the TagRule.")
model TagRuleUpdate {
  @doc("Set of rules for sending logs for the Monitor resource.")
  logRules?: LogRules;

  @doc("Set of rules for sending metrics for the Monitor resource.")
  metricRules?: MetricRules;
}

@doc("Response of a list VM Host Operation.")
model VMHostsListResponse is Azure.Core.Page<VMInfo>;

@doc("Details of VM Resource having Dynatrace OneAgent installed")
model VMInfo {
  @doc("Azure VM resource ID")
  resourceId?: string;

  @doc("Version of the Dynatrace agent installed on the VM.")
  version?: string;

  @doc("The monitoring mode of OneAgent")
  monitoringType?: MonitoringType;

  @doc("Update settings of OneAgent.")
  autoUpdateSetting?: AutoUpdateSetting;

  @doc("The current update status of OneAgent.")
  updateStatus?: UpdateStatus;

  @doc("The availability state of OneAgent.")
  availabilityState?: AvailabilityState;

  @doc("Tells whether log modules are enabled or not")
  logModule?: LogModule;

  @doc("The name of the host group")
  hostGroup?: string;

  @doc("The name of the host")
  hostName?: string;
}

@doc("Response of a list App Services Operation.")
model AppServiceListResponse is Azure.Core.Page<AppServiceInfo>;

@doc("Details of App Services having Dynatrace OneAgent installed")
model AppServiceInfo {
  @doc("App service resource ID")
  resourceId?: string;

  @doc("Version of the Dynatrace agent installed on the App Service.")
  version?: string;

  @doc("The monitoring mode of OneAgent")
  monitoringType?: MonitoringType;

  @doc("Update settings of OneAgent.")
  autoUpdateSetting?: AutoUpdateSetting;

  @doc("The current update status of OneAgent.")
  updateStatus?: UpdateStatus;

  @doc("The availability state of OneAgent.")
  availabilityState?: AvailabilityState;

  @doc("Tells whether log modules are enabled or not")
  logModule?: LogModule;

  @doc("The name of the host group")
  hostGroup?: string;

  @doc("The name of the host")
  hostName?: string;
}

@doc("Request for getting sso details for a user")
model SSODetailsRequest {
  @doc("user principal id of the user")
  userPrincipal?: string;
}

@doc("SSO details from the Dynatrace partner")
model SSODetailsResponse {
  @doc("Whether the SSO is enabled for this resource or not.")
  isSsoEnabled?: SSOStatus;

  @doc("URL for Azure AD metadata")
  metadataUrl?: string;

  @doc("The login URL specific to this Dynatrace Environment")
  singleSignOnUrl?: string;

  @doc("array of Aad(azure active directory) domains")
  aadDomains?: string[];

  @doc("Array of admin user emails.")
  adminUsers?: string[];
}

@doc("Request for getting all the linkable environments for a user")
model LinkableEnvironmentRequest {
  @doc("Tenant Id of the user in which they want to link the environment")
  tenantId?: string;

  @doc("user principal id of the user")
  userPrincipal?: string;

  @doc("Azure region in which we want to link the environment")
  region?: string;
}

@doc("Response for getting all the linkable environments")
model LinkableEnvironmentListResponse
  is Azure.Core.Page<LinkableEnvironmentResponse>;

@doc("Response for getting all the linkable environments")
model LinkableEnvironmentResponse {
  @doc("environment id for which user is an admin")
  environmentId?: string;

  @doc("Name of the environment")
  environmentName?: string;

  @doc("Billing plan information.")
  planData?: PlanData;
}
