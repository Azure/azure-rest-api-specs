import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Datadog;

interface Operations extends Azure.ResourceManager.Operations {}

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
  Provisioning,
  Active,
  Suspended,
  Unsubscribed,
}

enum LiftrResourceCategories {
  Unknown,
  MonitorLogs,
}

/**
 * Identity type
 */
enum ManagedIdentityTypes {
  SystemAssigned,
  UserAssigned,
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
enum TagAction {
  Include,
  Exclude,
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
 * Response of a list operation.
 */
model DatadogAgreementResourceListResponse
  is Azure.Core.Page<DatadogAgreementResource>;

model DatadogAgreementResource {
  /**
   * ARM id of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Name of the agreement.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Represents the properties of the resource.
   */
  properties?: DatadogAgreementProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
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

/**
 * Response of a list operation.
 */
model DatadogApiKeyListResponse is Azure.Core.Page<DatadogApiKey>;

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

model DatadogHost {
  /**
   * The name of the host.
   */
  name?: string;

  /**
   * The aliases for the host.
   */
  aliases?: string[];

  /**
   * The Datadog integrations reporting metrics for the host.
   */
  apps?: string[];

  meta?: DatadogHostMetadata;
}

model DatadogHostMetadata {
  /**
   * The agent version.
   */
  agentVersion?: string;

  installMethod?: DatadogInstallMethod;
  logsAgent?: DatadogLogsAgent;
}

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
 * Properties specific to the monitor resource.
 */
model MonitorProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Flag specifying if the resource monitoring is enabled or disabled.
   */
  monitoringStatus?: MonitoringStatus = MonitoringStatus.Enabled;

  /**
   * Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.
   */
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * Datadog organization properties
   */
  datadogOrganizationProperties?: DatadogOrganizationProperties;

  /**
   * User info
   */
  userInfo?: UserInfo;

  @visibility("read")
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * The priority of the resource.
   */
  @visibility("read")
  liftrResourcePreference?: int32;
}

/**
 * Datadog organization properties
 */
model DatadogOrganizationProperties {
  /**
   * Name of the Datadog organization.
   */
  @visibility("read")
  name?: string;

  /**
   * Id of the Datadog organization.
   */
  @visibility("read")
  id?: string;

  /**
   * The auth code used to linking to an existing datadog organization.
   */
  @visibility("create")
  linkingAuthCode?: string;

  /**
   * The client_id from an existing in exchange for an auth token to link organization.
   */
  @visibility("create")
  linkingClientId?: string;

  /**
   * The redirect uri for linking.
   */
  @visibility("create")
  redirectUri?: string;

  /**
   * Api key associated to the Datadog organization.
   */
  @visibility("create")
  apiKey?: string;

  /**
   * Application key associated to the Datadog organization.
   */
  @visibility("create")
  applicationKey?: string;

  /**
   * The Id of the Enterprise App used for Single sign on.
   */
  @visibility("create")
  enterpriseAppId?: string;
}

/**
 * User info
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

model IdentityProperties {
  /**
   * The identity ID.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Identity type
   */
  type?: ManagedIdentityTypes;
}

/**
 * The parameters for a PATCH request to a monitor resource.
 */
model DatadogMonitorResourceUpdateParameters {
  /**
   * The set of properties that can be update in a PATCH request to a monitor resource.
   */
  properties?: MonitorUpdateProperties;

  /**
   * The new tags of the monitor resource.
   */
  tags?: Record<string>;

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
}

model DatadogSetPasswordLink {
  setPasswordLink?: string;
}

/**
 * Definition of the properties for a TagRules resource.
 */
model MonitoringTagRulesProperties {
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

model DatadogSingleSignOnProperties {
  @visibility("read")
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
  @visibility("read")
  singleSignOnUrl?: string;
}
