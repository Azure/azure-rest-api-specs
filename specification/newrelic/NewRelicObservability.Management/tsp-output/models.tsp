import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace NewRelic.Observability;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning State of the Monitor resource
 */
enum ProvisioningState {
  /**
   * Monitor resource creation request accepted
   */
  Accepted,

  /**
   * Monitor resource creation started
   */
  Creating,

  /**
   * Monitor resource is being updated
   */
  Updating,

  /**
   * Monitor resource deletion started
   */
  Deleting,

  /**
   * Monitor resource creation successful
   */
  Succeeded,

  /**
   * Monitor resource creation failed
   */
  Failed,

  /**
   * Monitor resource creation canceled
   */
  Canceled,

  /**
   * Monitor resource is deleted
   */
  Deleted,

  /**
   * Monitor resource state is unknown
   */
  NotSpecified,
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
enum MonitoringStatus {
  /**
   * monitoring is enabled
   */
  Enabled,

  /**
   * monitoring is disabled
   */
  Disabled,
}

/**
 * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
 */
enum MarketplaceSubscriptionStatus {
  /**
   * monitoring is enabled
   */
  Active,

  /**
   * monitoring is disabled
   */
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
 * Different usage type like PAYG/COMMITTED
 */
enum UsageType {
  /**
   * Usage type is PAYG
   */
  PAYG,

  /**
   * Usage type is COMMITTED
   */
  COMMITTED,
}

/**
 * Different usage type like YEARLY/MONTHLY
 */
enum BillingCycle {
  /**
   * Billing cycle is YEARLY
   */
  YEARLY,

  /**
   * Billing cycle is MONTHLY
   */
  MONTHLY,

  /**
   * Billing cycle is WEEKLY
   */
  WEEKLY,
}

/**
 * Liftr Resource category.
 */
enum LiftrResourceCategories {
  Unknown,
  MonitorLogs,
}

/**
 * Source of Org creation
 */
enum OrgCreationSource {
  /**
   * Org is created from LIFTR
   */
  LIFTR,

  /**
   * Org is created from NEWRELIC
   */
  NEWRELIC,
}

/**
 * Source of Account creation
 */
enum AccountCreationSource {
  /**
   * Account is created from LIFTR
   */
  LIFTR,

  /**
   * Account is created from NEWRELIC
   */
  NEWRELIC,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * Billing source
 */
enum BillingSource {
  /**
   * Billing source is Azure
   */
  AZURE,

  NEWRELIC,
}

/**
 * Indicates whether metrics are being sent.
 */
enum SendMetricsStatus {
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
 * Response of get all accounts Operation.
 */
model AccountsListResponse is Azure.Core.Page<AccountResource>;

/**
 * The details of a account resource.
 */
model AccountResource extends ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility("read", "create")
  @extension("x-ms-client-flatten", true)
  properties?: AccountProperties;
}

/**
 * List of all the New relic accounts for the given user
 */
model AccountProperties {
  /**
   * organization id
   */
  organizationId?: string;

  /**
   * account id
   */
  accountId?: string;

  /**
   * account name
   */
  accountName?: string;

  /**
   * region
   */
  region?: string;
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
 * Properties specific to the NewRelic Monitor resource
 */
model MonitorProperties {
  /**
   * Provisioning State of the resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * MonitoringStatus of the resource
   */
  @visibility("read")
  monitoringStatus?: MonitoringStatus;

  /**
   * NewRelic Organization properties of the resource
   */
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Marketplace Subscription Id
   */
  @visibility("read")
  marketplaceSubscriptionId?: string;

  /**
   * MarketplaceSubscriptionStatus of the resource
   */
  newRelicAccountProperties?: NewRelicAccountProperties;

  /**
   * User Info
   */
  userInfo?: UserInfo;

  /**
   * Plan details
   */
  planData?: PlanData;

  /**
   * Liftr resource category
   */
  @visibility("read")
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * Liftr resource preference. The priority of the resource.
   */
  @visibility("read")
  liftrResourcePreference?: int32;

  /**
   * Source of org creation
   */
  orgCreationSource?: OrgCreationSource;

  /**
   * Source of account creation
   */
  accountCreationSource?: AccountCreationSource;
}

/**
 * Properties of the NewRelic account
 */
model NewRelicAccountProperties {
  /**
   * User id
   */
  userId?: string;

  /**
   * NewRelic Account Information
   */
  accountInfo?: AccountInfo;

  /**
   * NewRelic Organization Information
   */
  organizationInfo?: OrganizationInfo;

  /**
   * date when plan was applied
   */
  singleSignOnProperties?: NewRelicSingleSignOnProperties;
}

/**
 * Account Info of the NewRelic account
 */
model AccountInfo {
  /**
   * Account id
   */
  accountId?: string;

  /**
   * ingestion key of account
   */
  @secret
  ingestionKey?: string;

  /**
   * NewRelic account region
   */
  region?: string;
}

/**
 * Organization Info of the NewRelic account
 */
model OrganizationInfo {
  /**
   * Organization id
   */
  organizationId?: string;
}

/**
 * Single sign on Info of the NewRelic account
 */
model NewRelicSingleSignOnProperties {
  /**
   * Single sign-on state
   */
  singleSignOnState?: SingleSignOnStates;

  /**
   * The Id of the Enterprise App used for Single sign-on.
   */
  enterpriseAppId?: string;

  /**
   * The login URL specific to this NewRelic Organization
   */
  singleSignOnUrl?: string;

  /**
   * Provisioning state
   */
  provisioningState?: ProvisioningState;
}

/**
 * User Info of NewRelic Monitor resource
 */
model UserInfo {
  /**
   * First name
   */
  @maxLength(50)
  firstName?: string;

  /**
   * Last name
   */
  @maxLength(50)
  lastName?: string;

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  emailAddress?: string;

  /**
   * Contact phone number
   */
  @maxLength(40)
  phoneNumber?: string;

  /**
   * country if user
   */
  country?: string;
}

/**
 * Plan data of NewRelic Monitor resource
 */
model PlanData {
  /**
   * Different usage type like PAYG/COMMITTED. this could be enum
   */
  usageType?: UsageType;

  /**
   * Different billing cycles like MONTHLY/WEEKLY. this could be enum
   */
  billingCycle?: BillingCycle;

  /**
   * plan id as published by NewRelic
   */
  planDetails?: string;

  /**
   * date when plan was applied
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;
}

/**
 * Response of get all organizations Operation.
 */
model OrganizationsListResponse is Azure.Core.Page<OrganizationResource>;

/**
 * The details of a Organization resource.
 */
model OrganizationResource extends ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility("read", "create")
  @extension("x-ms-client-flatten", true)
  properties?: OrganizationProperties;
}

/**
 * Details of Organizations
 */
model OrganizationProperties {
  /**
   * organization id
   */
  organizationId?: string;

  /**
   * organization name
   */
  organizationName?: string;

  /**
   * Billing source
   */
  billingSource?: BillingSource;
}

/**
 * Response of get all plan data Operation.
 */
model PlanDataListResponse is Azure.Core.Page<PlanDataResource>;

/**
 * The details of a PlanData resource.
 */
model PlanDataResource extends ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility("read", "create")
  @extension("x-ms-client-flatten", true)
  properties?: PlanDataProperties;
}

/**
 * Plan details
 */
model PlanDataProperties {
  /**
   * Plan details
   */
  planData?: PlanData;

  /**
   * Source of org creation
   */
  orgCreationSource?: OrgCreationSource;

  /**
   * Source of account creation
   */
  accountCreationSource?: AccountCreationSource;
}

/**
 * The type used for update operations of the NewRelicMonitorResource.
 */
model NewRelicMonitorResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The updatable properties of the NewRelicMonitorResource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NewRelicMonitorResourceUpdateProperties;
}

/**
 * The updatable properties of the NewRelicMonitorResource.
 */
model NewRelicMonitorResourceUpdateProperties {
  /**
   * MarketplaceSubscriptionStatus of the resource
   */
  newRelicAccountProperties?: NewRelicAccountProperties;

  /**
   * User Info
   */
  userInfo?: UserInfo;

  /**
   * Plan details
   */
  planData?: PlanData;

  /**
   * Source of org creation
   */
  orgCreationSource?: OrgCreationSource;

  /**
   * Source of account creation
   */
  accountCreationSource?: AccountCreationSource;
}

/**
 * Request of get metrics Operation.
 */
model MetricsRequest {
  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Set of rules for sending metrics for the Monitor resource.
 */
model MetricRules {
  /**
   * Flag specifying if metrics should be sent for the Monitor resource.
   */
  sendMetrics?: SendMetricsStatus;

  /**
   * List of filtering tags to be used for capturing metrics.
   */
  filteringTags?: FilteringTag[];

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail?: string;
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
 * Request of get metrics status Operation.
 */
model MetricsStatusRequest {
  /**
   * Azure resource IDs
   */
  azureResourceIds?: string[];

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Response of get metrics status Operation.
 */
model MetricsStatusResponse {
  /**
   * Azure resource IDs
   */
  azureResourceIds?: string[];
}

/**
 * Request of a app services get Operation.
 */
model AppServicesGetRequest {
  /**
   * Azure resource IDs
   */
  azureResourceIds?: string[];

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Response of a list app services Operation.
 */
model AppServicesListResponse is Azure.Core.Page<AppServiceInfo>;

/**
 * Details of VM Resource having NewRelic OneAgent installed
 */
model AppServiceInfo {
  /**
   * Azure App service resource ID
   */
  azureResourceId?: string;

  /**
   * Version of the NewRelic agent installed on the App service.
   */
  agentVersion?: string;

  /**
   * Status of the NewRelic agent installed on the App service.
   */
  agentStatus?: string;
}

/**
 * Request of a switch billing Operation.
 */
model SwitchBillingRequest {
  /**
   * Azure resource Id
   */
  azureResourceId?: string;

  /**
   * Organization id
   */
  organizationId?: string;

  /**
   * Plan details
   */
  planData?: PlanData;

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Request of a Hosts get Operation.
 */
model HostsGetRequest {
  /**
   * VM resource IDs
   */
  vmIds?: string[];

  /**
   * User Email
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Response of a list VM Host Operation.
 */
model VMHostsListResponse is Azure.Core.Page<VMInfo>;

/**
 * Details of VM Resource having NewRelic OneAgent installed
 */
model VMInfo {
  /**
   * Azure VM resource ID
   */
  vmId?: string;

  /**
   * Version of the NewRelic agent installed on the VM.
   */
  agentVersion?: string;

  /**
   * Status of the NewRelic agent installed on the VM.
   */
  agentStatus?: string;
}

/**
 * List of all the resources being monitored by NewRelic monitor resource
 */
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

/**
 * Details of resource being monitored by NewRelic monitor resource
 */
model MonitoredResource {
  /**
   * The ARM id of the resource.
   */
  id?: string;

  /**
   * Flag indicating if resource is sending metrics to NewRelic.
   */
  sendingMetrics?: SendingMetricsStatus;

  /**
   * Reason for why the resource is sending metrics (or why it is not sending).
   */
  reasonForMetricsStatus?: string;

  /**
   * Flag indicating if resource is sending logs to NewRelic.
   */
  sendingLogs?: SendingLogsStatus;

  /**
   * Reason for why the resource is sending logs (or why it is not sending).
   */
  reasonForLogsStatus?: string;
}

/**
 * The resource-specific properties for this resource.
 */
model MonitoringTagRulesProperties {
  /**
   * Provisioning State of the resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

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
  filteringTags?: FilteringTag[];
}

/**
 * The type used for update operations of the TagRule.
 */
model TagRuleUpdate {
  /**
   * The updatable properties of the TagRule.
   */
  @extension("x-ms-client-flatten", true)
  properties?: TagRuleUpdateProperties;
}

/**
 * The updatable properties of the TagRule.
 */
model TagRuleUpdateProperties {
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
 * Response of payload to be passed while installing VM agent.
 */
model VMExtensionPayload {
  /**
   * Ingestion key of the account
   */
  ingestionKey?: string;
}

/**
 * App services Get Parameter specification.
 */
model AppServicesGetParameter {
  /**
   * The details of the app services get request.
   */
  request: AppServicesGetRequest;
}

/**
 * Switch Billing Parameter specification.
 */
model SwitchBillingParameter {
  /**
   * The details of the switch billing request.
   */
  request: SwitchBillingRequest;
}

/**
 * Host Get Parameter specification.
 */
model HostsGetParameter {
  /**
   * The details of the Hosts get request.
   */
  request: HostsGetRequest;
}

/**
 * Get Metrics Status Parameter specification.
 */
model MetricsRequestParameter {
  /**
   * The details of the get metrics status request.
   */
  request: MetricsRequest;
}

/**
 * Get Metrics Status Parameter specification.
 */
model MetricsStatusRequestParameter {
  /**
   * The details of the get metrics status request.
   */
  request: MetricsStatusRequest;
}
