import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Datadog;
/**
 * Represents a paginated list of operation results.
 */
model OperationListResult {
  /**
   * The list of operations.
   */
  @pageItems
  value: OperationResult[];

  /**
   * The URL to get the next set of results, if any.
   */
  @nextLink
  nextLink?: string;
}
/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
union MonitoringStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
 */
union MarketplaceSubscriptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unsubscribed: "Unsubscribed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LiftrResourceCategories {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MonitorLogs: "MonitorLogs",
}

/**
 * Specifies the identity type of the Datadog Monitor. At this time the only allowed value is 'SystemAssigned'.
 */
union ManagedIdentityTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
union TagAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Include: "Include",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exclude: "Exclude",
}

/**
 * Various states of the SSO resource
 */
union SingleSignOnStates {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Initial: "Initial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Existing: "Existing",
}

/**
 * The operation for the patch on the resource.
 */
union Operation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AddBegin: "AddBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AddComplete: "AddComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeleteBegin: "DeleteBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeleteComplete: "DeleteComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
}

/**
 * The state of monitoring.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Response of a list operation.
 */
model DatadogAgreementResourceListResponse
  is Azure.Core.Page<DatadogAgreementResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogAgreementResource {
  /**
   * ARM id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the agreement.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Represents the properties of the resource.
   */
  properties?: DatadogAgreementProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

/**
 * Terms properties.
 */
model DatadogAgreementProperties {
  /**
   * Publisher identifier string.
   */
  publisher?: string;

  /**
   * Product identifier string.
   */
  product?: string;

  /**
   * Plan identifier string.
   */
  plan?: string;

  /**
   * Link to HTML with Microsoft and Publisher terms.
   */
  licenseTextLink?: string;

  /**
   * Link to the privacy policy of the publisher.
   */
  privacyPolicyLink?: string;

  /**
   * Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrieveDatetime?: utcDateTime;

  /**
   * Terms signature.
   */
  signature?: string;

  /**
   * If any version of the terms have been accepted, otherwise false.
   */
  accepted?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CreateResourceSupportedResponseList
  is Azure.Core.Page<CreateResourceSupportedResponse>;

/**
 * Datadog resource can be created or not.
 */
model CreateResourceSupportedResponse {
  /**
   * Represents the properties of the resource.
   */
  properties?: CreateResourceSupportedProperties;
}

/**
 * Datadog resource can be created or not properties.
 */
model CreateResourceSupportedProperties {
  /**
   * The ARM id of the subscription.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates if selected subscription supports Datadog resource creation, if not it is already being monitored for the selected organization via multi subscription feature.
   */
  @visibility(Lifecycle.Read)
  creationSupported?: boolean;
}

/**
 * Represents a Datadog Application key and its associated properties.
 */
@added(Microsoft.Datadog.Versions.v2025_11_03_preview)
model DatadogApplicationKey {
  /**
   * The user that created the Application key.
   */
  createdBy?: string;

  /**
   * The name of the Application key.
   */
  name?: string;

  /**
   * The value of the Application key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Check if the contents of this property should be kept private and add @secret"
  @visibility(Lifecycle.Read)
  key: string;
}

/**
 * Response of a list operation.
 */
model DatadogApiKeyListResponse is Azure.Core.Page<DatadogApiKey>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogApiKey {
  /**
   * The user that created the API key.
   */
  createdBy?: string;

  /**
   * The name of the API key.
   */
  name?: string;

  /**
   * The value of the API key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key: string;

  /**
   * The time of creation of the API key.
   */
  created?: string;
}

/**
 * Response of a list operation.
 */
model DatadogHostListResponse is Azure.Core.Page<DatadogHost>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogHost {
  /**
   * The name of the host.
   */
  name?: string;

  /**
   * The aliases for the host installed via the Datadog agent.
   */
  aliases?: string[];

  /**
   * The Datadog integrations reporting metrics for the host.
   */
  apps?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  meta?: DatadogHostMetadata;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogHostMetadata {
  /**
   * The agent version.
   */
  agentVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  installMethod?: DatadogInstallMethod;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  logsAgent?: DatadogLogsAgent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogInstallMethod {
  /**
   * The tool.
   */
  tool?: string;

  /**
   * The tool version.
   */
  toolVersion?: string;

  /**
   * The installer version.
   */
  installerVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogLogsAgent {
  /**
   * The transport.
   */
  transport?: string;
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

  /**
   * The location of the linked resource.
   */
  location?: string;
}

/**
 * Response of a list operation.
 */
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

/**
 * The properties of a resource currently being monitored by the Datadog monitor resource.
 */
model MonitoredResource {
  /**
   * The ARM id of the resource.
   */
  id?: string;

  /**
   * Flag indicating if resource is sending metrics to Datadog.
   */
  sendingMetrics?: boolean;

  /**
   * Reason for why the resource is sending metrics (or why it is not sending).
   */
  reasonForMetricsStatus?: string;

  /**
   * Flag indicating if resource is sending logs to Datadog.
   */
  sendingLogs?: boolean;

  /**
   * Reason for why the resource is sending logs (or why it is not sending).
   */
  reasonForLogsStatus?: string;
}

/**
 * A Microsoft.Datadog REST API operation.
 */
model OperationResult {
  /**
   * Operation name, i.e., {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider, i.e., Microsoft.Datadog.
   */
  provider?: string;

  /**
   * Type on which the operation is performed, e.g., 'monitors'.
   */
  resource?: string;

  /**
   * Operation type, e.g., read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation, e.g., 'Write monitors'.
   */
  description?: string;
}

/**
 * Response of a list operation.
 */
model DatadogMonitorResourceListResponse
  is Azure.Core.Page<DatadogMonitorResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceSku {
  /**
   * Name of the SKU in {PlanId} format. For Terraform, the only allowed value is 'Linked'.
   */
  name: string;
}

/**
 * Properties specific to the monitor resource.
 */
model MonitorProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Flag specifying if the resource monitoring is enabled or disabled.
   */
  monitoringStatus?: MonitoringStatus = MonitoringStatus.Enabled;

  /**
   * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Specify the Datadog organization name. In the case of linking to existing organizations, Id, ApiKey, and Applicationkey is required as well.
   */
  datadogOrganizationProperties?: DatadogOrganizationProperties;

  /**
   * Includes name, email and optionally, phone number. User Information can't be null.
   */
  userInfo?: UserInfo;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * The priority of the resource.
   */
  @visibility(Lifecycle.Read)
  liftrResourcePreference?: int32;

  /**
   * SRE Agent configuration to connect to MCP server of Datadog for given organization.
   */
  @identifiers(#["mcpConnectorResourceId"])
  @added(Microsoft.Datadog.Versions.v2025_11_03_preview)
  @visibility(Lifecycle.Update)
  sreAgentConfiguration?: SreAgentConfiguration[];
}

/**
 * Specify the Datadog organization name. In the case of linking to existing organizations, Id, ApiKey, and Applicationkey is required as well.
 */
model DatadogOrganizationProperties {
  /**
   * Name of the Datadog organization.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;

  /**
   * Id of the Datadog organization.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id?: string;

  /**
   * The auth code used to linking to an existing Datadog organization.
   */
  @visibility(Lifecycle.Create)
  @secret
  linkingAuthCode?: string;

  /**
   * The client_id from an existing in exchange for an auth token to link organization.
   */
  @visibility(Lifecycle.Create)
  @secret
  linkingClientId?: string;

  /**
   * The redirect URI for linking.
   */
  @visibility(Lifecycle.Create)
  redirectUri?: string;

  /**
   * Api key associated to the Datadog organization.
   */
  @visibility(Lifecycle.Create)
  @secret
  apiKey?: string;

  /**
   * Application key associated to the Datadog organization.
   */
  @visibility(Lifecycle.Create)
  @secret
  applicationKey?: string;

  /**
   * The Id of the Enterprise App used for Single sign on.
   */
  @visibility(Lifecycle.Create)
  enterpriseAppId?: string;

  /**
   * The configuration which describes the state of cloud security posture management. This collects configuration information for all resources in a subscription and track conformance to industry benchmarks.
   */
  cspm?: boolean;

  /**
   * The configuration which describes the state of resource collection. This collects configuration information for all resources in a subscription.
   */
  resourceCollection?: boolean;
}

/**
 * Response of a list operation.
 */
@added(Microsoft.Datadog.Versions.v2025_11_03_preview)
model SreAgentConfigurationListResponse
  is Azure.Core.Page<SreAgentConfiguration>;

/**
 * SRE Agent configuration to connect to MCP server of Datadog for a given organization.
 */
@added(Microsoft.Datadog.Versions.v2025_11_03_preview)
model SreAgentConfiguration {
  /**
   * The ARM resource ID of the MCP connector integrated with SRE Agent resource.
   */
  mcpConnectorResourceId: string;
}

/**
 * Includes name, email and optionally, phone number. User Information can't be null.
 */
model UserInfo {
  /**
   * Name of the user
   */
  @maxLength(50)
  name?: string;

  /**
   * Email of the user used by Datadog for contacting them if needed
   */
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  emailAddress?: string;

  /**
   * Phone number of the user used by Datadog for contacting them if needed
   */
  @maxLength(40)
  phoneNumber?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IdentityProperties {
  /**
   * The identity ID.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Specifies the identity type of the Datadog Monitor. At this time the only allowed value is 'SystemAssigned'.
   */
  type?: ManagedIdentityTypes;
}

/**
 * The parameters for a PATCH request to a monitor resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatadogMonitorResourceUpdateParameters {
  /**
   * The set of properties that can be update in a PATCH request to a monitor resource.
   */
  properties?: MonitorUpdateProperties;

  /**
   * The new tags of the monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sku?: ResourceSku;
}

/**
 * The set of properties that can be update in a PATCH request to a monitor resource.
 */
model MonitorUpdateProperties {
  /**
   * Flag specifying if the resource monitoring is enabled or disabled.
   */
  monitoringStatus?: MonitoringStatus = MonitoringStatus.Enabled;

  /**
   * The new cloud security posture management value of the monitor resource. This collects configuration information for all resources in a subscription and track conformance to industry benchmarks.
   */
  cspm?: boolean;

  /**
   * The new resource collection value of the monitor resource. This collects configuration information for all resources in a subscription.
   */
  resourceCollection?: boolean;
}

/**
 * Add or Remove connectors for SRE agents.
 */
@added(Microsoft.Datadog.Versions.v2025_11_03_preview)
union ConnectorAction {
  string,

  /**
   * Add connector actions
   */
  Add: "Add",

  /**
   * Remove connector action
   */
  Remove: "Remove",
}

/**
 * Request for adding/removing Datadog MCP connectors on SRE Agent resource.
 */
@added(Microsoft.Datadog.Versions.v2025_11_03_preview)
model SreAgentConnectorRequest {
  /**
   * The list of ARM resource ID of the MCP connector integrated with SRE Agent resource.
   */
  @identifiers(#["mcpConnectorResourceId"])
  mcpConnectorResourceIdList: SreAgentConfiguration[];

  /**
   * Add/Remove action.
   */
  action: ConnectorAction;
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
  marketplaceName?: string;

  /**
   * Marketplace Subscription Details: SaaS Subscription Status
   */
  marketplaceStatus?: string;

  /**
   * The Azure Subscription ID to which the Marketplace Subscription belongs and gets billed into.
   */
  billedAzureSubscriptionId?: string;

  /**
   * Flag specifying if the Marketplace status is subscribed or not.
   */
  subscribed?: boolean;
}

/**
 * Partner Billing details associated with the resource.
 */
model PartnerBillingEntity {
  /**
   * The Datadog Organization Id.
   */
  id?: string;

  /**
   * The Datadog Organization Name.
   */
  name?: string;

  /**
   * Link to the datadog organization page
   */
  partnerEntityUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogSetPasswordLink {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  setPasswordLink?: string;
}

/**
 * Response of a list operation.
 */
model MonitoringTagRulesListResponse is Azure.Core.Page<MonitoringTagRules>;

/**
 * Definition of the properties for a TagRules resource.
 */
model MonitoringTagRulesProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  /**
   * Set of rules for managing agents for the Monitor resource.
   */
  agentRules?: AgentRules;

  /**
   * Configuration to enable/disable auto-muting flag
   */
  automuting?: boolean;

  /**
   * Configuration to enable/disable custom metrics. If enabled, custom metrics from app insights will be sent.
   */
  customMetrics?: boolean;
}

/**
 * Set of rules for sending logs for the Monitor resource.
 */
model LogRules {
  /**
   * Flag specifying if AAD logs should be sent for the Monitor resource.
   */
  sendAadLogs?: boolean;

  /**
   * Flag specifying if Azure subscription logs should be sent for the Monitor resource.
   */
  sendSubscriptionLogs?: boolean;

  /**
   * Flag specifying if Azure resource logs should be sent for the Monitor resource.
   */
  sendResourceLogs?: boolean;

  /**
   * List of filtering tags to be used for capturing logs. This only takes effect if SendResourceLogs flag is enabled. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
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
 * Set of rules for managing agents for the Monitor resource.
 */
model AgentRules {
  /**
   * Flag specifying if agent monitoring should be enabled for the Monitor resource.
   */
  enableAgentMonitoring?: boolean;

  /**
   * List of filtering tags to be used for capturing metrics. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
   */
  filteringTags?: FilteringTag[];
}

/**
 * Response of a list operation.
 */
model DatadogSingleSignOnResourceListResponse
  is Azure.Core.Page<DatadogSingleSignOnResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DatadogSingleSignOnProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Various states of the SSO resource
   */
  singleSignOnState?: SingleSignOnStates;

  /**
   * The Id of the Enterprise App used for Single sign-on.
   */
  enterpriseAppId?: string;

  /**
   * The login URL specific to this Datadog Organization.
   */
  @visibility(Lifecycle.Read)
  singleSignOnUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MonitoredSubscriptionPropertiesList
  is Azure.Core.Page<MonitoredSubscriptionProperties>;

/**
 * The request to update subscriptions needed to be monitored by the Datadog monitor resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SubscriptionList {
  /**
   * The operation for the patch on the resource.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  operation?: Operation;

  /**
   * List of subscriptions and the state of the monitoring.
   */
  @identifiers(#[])
  monitoredSubscriptionList?: MonitoredSubscription[];
}

/**
 * The list of subscriptions and it's monitoring status by current Datadog monitor.
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
   * Definition of the properties for a TagRules resource.
   */
  tagRules?: MonitoringTagRulesProperties;
}

/**
 * Resubscribe Properties
 */
model ResubscribeProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sku?: ResourceSku;

  /**
   * Newly selected Azure Subscription Id in which the new Marketplace subscription will be created for Resubscribe
   */
  azureSubscriptionId?: string;

  /**
   * Newly selected Azure resource group in which the new Marketplace subscription will be created for Resubscribe
   */
  resourceGroup?: string;
}
