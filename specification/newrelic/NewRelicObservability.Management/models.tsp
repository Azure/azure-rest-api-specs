import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace NewRelic.Observability;

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
 * Provisioning State of the Monitor resource
 */
union ProvisioningState {
  string,

  /**
   * Monitor resource creation request accepted
   */
  Accepted: "Accepted",

  /**
   * Monitor resource creation started
   */
  Creating: "Creating",

  /**
   * Monitor resource is being updated
   */
  Updating: "Updating",

  /**
   * Monitor resource deletion started
   */
  Deleting: "Deleting",

  /**
   * Monitor resource creation successful
   */
  Succeeded: "Succeeded",

  /**
   * Monitor resource creation failed
   */
  Failed: "Failed",

  /**
   * Monitor resource creation canceled
   */
  Canceled: "Canceled",

  /**
   * Monitor resource is deleted
   */
  Deleted: "Deleted",

  /**
   * Monitor resource state is unknown
   */
  NotSpecified: "NotSpecified",
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
union MonitoringStatus {
  string,

  /**
   * monitoring is enabled
   */
  Enabled: "Enabled",

  /**
   * monitoring is disabled
   */
  Disabled: "Disabled",
}

/**
 * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
 */
union MarketplaceSubscriptionStatus {
  string,

  /**
   * monitoring is enabled
   */
  Active: "Active",

  /**
   * monitoring is disabled
   */
  Suspended: "Suspended",
}

/**
 * Various states of the SSO resource
 */
union SingleSignOnStates {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initial: "Initial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disable: "Disable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Existing: "Existing",
}

/**
 * Different usage type like PAYG/COMMITTED
 */
union UsageType {
  string,

  /**
   * Usage type is PAYG
   */
  PAYG: "PAYG",

  /**
   * Usage type is COMMITTED
   */
  COMMITTED: "COMMITTED",
}

/**
 * Liftr Resource category.
 */
union LiftrResourceCategories {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MonitorLogs: "MonitorLogs",
}

/**
 * Source of Org creation
 */
union OrgCreationSource {
  string,

  /**
   * Org is created from LIFTR
   */
  LIFTR: "LIFTR",

  /**
   * Org is created from NEWRELIC
   */
  NEWRELIC: "NEWRELIC",
}

/**
 * Source of Account creation
 */
union AccountCreationSource {
  string,

  /**
   * Account is created from LIFTR
   */
  LIFTR: "LIFTR",

  /**
   * Account is created from NEWRELIC
   */
  NEWRELIC: "NEWRELIC",
}

/**
 * Billing source
 */
union BillingSource {
  string,

  /**
   * Billing source is Azure
   */
  AZURE: "AZURE",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NEWRELIC: "NEWRELIC",
}

/**
 * Indicates whether metrics are being sent.
 */
union SendMetricsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
union TagAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Include: "Include",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exclude: "Exclude",
}

/**
 * Indicates whether metrics are being sent.
 */
union SendingMetricsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether logs are being sent.
 */
union SendingLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether AAD logs are being sent.
 */
union SendAadLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether subscription logs are being sent.
 */
union SendSubscriptionLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether activity logs are being sent.
 */
union SendActivityLogsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The operation for the patch on the resource.
 */
union PatchOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddBegin: "AddBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddComplete: "AddComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteBegin: "DeleteBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteComplete: "DeleteComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
}

/**
 * The state of monitoring.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ConfigurationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  default: "default",
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
 * Response of get all accounts Operation.
 */
model AccountsListResponse is Azure.Core.Page<AccountResource>;

/**
 * The details of a account resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccountResource extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
   * Region where New Relic account is present
   */
  region?: string;
}

/**
 * Properties specific to the NewRelic Monitor resource
 */
model MonitorProperties {
  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * MonitoringStatus of the resource
   */
  @visibility(Lifecycle.Read)
  monitoringStatus?: MonitoringStatus;

  /**
   * NewRelic Organization properties of the resource
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Marketplace Subscription Id
   */
  @visibility(Lifecycle.Read)
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
   * SaaS details
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSData?: SaaSData;

  /**
   * Liftr resource category
   */
  @visibility(Lifecycle.Read)
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * Liftr resource preference. The priority of the resource.
   */
  @visibility(Lifecycle.Read)
  liftrResourcePreference?: int32;

  /**
   * Source of org creation
   */
  orgCreationSource?: OrgCreationSource;

  /**
   * Source of account creation
   */
  accountCreationSource?: AccountCreationSource;

  /**
   * State of the Azure Subscription containing the monitor resource
   */
  subscriptionState?: string;

  /**
   * Status of Azure Subscription where Marketplace SaaS is located.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSAzureSubscriptionStatus?: string;
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
   * Credential string.
   */
  @secret
  ingestionKey?: string;

  /**
   * Region where New Relic account is present
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
   * Reusable representation of an email address
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
   * Different billing cycles like Monthly/Weekly.
   */
  billingCycle?: string;

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
 * SaaS details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SaaSData {
  /**
   * SaaS resource id
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSResourceId?: string;
}

/**
 * Response of get all organizations Operation.
 */
model OrganizationsListResponse is Azure.Core.Page<OrganizationResource>;

/**
 * The details of a Organization resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OrganizationResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PlanDataResource extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The resource-specific properties for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
 * SaaS guid & PublishedId for Activate and Validate SaaS Resource
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActivateSaaSParameterRequest {
  /**
   * SaaS guid for Activate and Validate SaaS Resource
   */
  saasGuid: string;

  /**
   * Publisher Id for NewRelic resource
   */
  publisherId: string;
}

/**
 * Marketplace SaaS resource details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SaaSResourceDetailsResponse
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Id of the Marketplace SaaS Resource
   */
  saasId?: string;
}

/**
 * The type used for update operations of the NewRelicMonitorResource.
 */
model NewRelicMonitorResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The updatable properties of the NewRelicMonitorResource.
   */
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
   * SaaS details
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSData?: SaaSData;

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
   * Reusable representation of an email address
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
  @identifiers(#[])
  filteringTags?: FilteringTag[];

  /**
   * Reusable representation of an email address
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
   * Reusable representation of an email address
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
   * Reusable representation of an email address
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
   * Reusable representation of an email address
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
   * Reusable representation of an email address
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  userEmail: string;
}

/**
 * Response of a list VM Host Operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Marketplace Subscription and Organization details to which resource gets billed into.
 */
model BillingInfoResponse {
  /**
   * Marketplace Subscription details
   */
  marketplaceSaasInfo?: MarketplaceSaaSInfo;

  /**
   * Partner Billing Entity details: Organization Info
   */
  partnerBillingEntity?: PartnerBillingEntity;
}

/**
 * Marketplace SAAS Info of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MarketplaceSaaSInfo {
  /**
   * Marketplace Subscription Id. This is a GUID-formatted string.
   */
  marketplaceSubscriptionId?: string;

  /**
   * Marketplace Subscription Details: SAAS Name
   */
  marketplaceSubscriptionName?: string;

  /**
   * Marketplace Subscription Details: Resource URI
   */
  marketplaceResourceId?: string;

  /**
   * Marketplace Subscription Details: SaaS Subscription Status
   */
  marketplaceStatus?: string;

  /**
   * The Azure Subscription ID to which the Marketplace Subscription belongs and gets billed into.
   */
  billedAzureSubscriptionId?: string;

  /**
   * Publisher Id of the Marketplace offer.
   */
  publisherId?: string;

  /**
   * Offer Id of the Marketplace offer,
   */
  offerId?: string;
}

/**
 * Partner Billing details associated with the resource.
 */
model PartnerBillingEntity {
  /**
   * The New Relic Organization Id.
   */
  organizationId?: string;

  /**
   * The New Relic Organization Name.
   */
  organizationName?: string;
}

/**
 *  List of all active newrelic deployments.
 */
model ConnectedPartnerResourcesListResponse
  is Azure.Core.Page<ConnectedPartnerResourcesListFormat>;

/**
 * Connected Partner Resources List Format
 */
model ConnectedPartnerResourcesListFormat {
  /**
   * Connected Partner Resource Properties
   */
  properties?: ConnectedPartnerResourceProperties;
}

/**
 * Connected Partner Resource Properties
 */
model ConnectedPartnerResourceProperties {
  /**
   * NewRelic account name
   */
  accountName?: string;

  /**
   * NewRelic Account Id
   */
  accountId?: string;

  /**
   * The azure resource Id of the deployment.
   */
  azureResourceId?: string;

  /**
   * The location of the deployment.
   */
  location?: string;
}

/**
 * The resource-specific properties for this resource.
 */
model MonitoringTagRulesProperties {
  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  filteringTags?: FilteringTag[];
}

/**
 * The type used for update operations of the TagRule.
 */
model TagRuleUpdate {
  /**
   * The updatable properties of the TagRule.
   */
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MonitoredSubscriptionPropertiesList
  is Azure.Core.Page<MonitoredSubscriptionProperties>;

/**
 * The request to update subscriptions needed to be monitored by the NewRelic monitor resource.
 */
model SubscriptionList {
  /**
   * The operation for the patch on the resource.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  patchOperation?: PatchOperation;

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
 * The list of subscriptions and it's monitoring status by current NewRelic monitor.
 */
model MonitoredSubscription {
  /**
   * The subscriptionId to be monitored.
   */
  subscriptionId?: string;

  /**
   * The state of monitoring.
   */
  status?: Status;

  /**
   * The reason of not monitoring the subscription.
   */
  error?: string;

  /**
   * The resource-specific properties for this resource.
   */
  tagRules?: MonitoringTagRulesProperties;
}

/**
 * Response of a list operation.
 */
model LinkedResourceListResponse is Azure.Core.Page<LinkedResource>;

/**
 * The definition of a linked resource.
 */
model LinkedResource {
  /**
   * The ARM id of the linked resource.
   */
  id?: string;
}

/**
 * Response of payload to be passed while installing VM agent.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMExtensionPayload {
  /**
   * Ingestion key of the account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  ingestionKey?: string;
}

/**
 * Response of get latest linked SaaS resource operation
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LatestLinkedSaaSResponse {
  /**
   * SaaS resource id
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSResourceId?: string;

  /**
   * Flag indicating if the SaaS resource is hidden
   */
  isHiddenSaaS?: boolean;
}

/**
 * Resubscribe Properties
 */
model ResubscribeProperties {
  /**
   * Newly selected plan Id to create the new Marketplace subscription for Resubscribe
   */
  planId?: string;

  /**
   * Newly selected term Id to create the new Marketplace subscription for Resubscribe
   */
  termId?: string;

  /**
   * Newly selected Azure Subscription Id in which the new Marketplace subscription will be created for Resubscribe
   */
  subscriptionId?: string;

  /**
   * Newly selected Azure resource group in which the new Marketplace subscription will be created for Resubscribe
   */
  resourceGroup?: string;

  /**
   * Organization Id of the NewRelic Organization that needs to be resubscribed
   */
  organizationId?: string;

  /**
   * Publisher Id of the NewRelic offer that needs to be resubscribed
   */
  publisherId?: string;

  /**
   * Offer Id of the NewRelic offer that needs to be resubscribed
   */
  offerId?: string;
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

/**
 * Reusable representation of an email address
 */
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
@mediaTypeHint("application/json")
scalar email extends string;

@@identifiers(AppServicesListResponse.value, #["azureResourceId"]);
@@visibility(NewRelicMonitorResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(TagRule.properties, Lifecycle.Read, Lifecycle.Create);
