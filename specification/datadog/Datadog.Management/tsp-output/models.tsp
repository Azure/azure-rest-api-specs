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

@doc("Flag specifying if the resource monitoring is enabled or disabled.")
enum MonitoringStatus {
  Enabled,
  Disabled,
}

@doc("Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.")
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

@doc("Identity type")
enum ManagedIdentityTypes {
  SystemAssigned,
  UserAssigned,
}

@doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
enum TagAction {
  Include,
  Exclude,
}

@doc("Various states of the SSO resource")
enum SingleSignOnStates {
  Initial,
  Enable,
  Disable,
  Existing,
}

@doc("Response of a list operation.")
model DatadogAgreementResourceListResponse
  is Azure.Core.Page<DatadogAgreementResource>;

model DatadogAgreementResource {
  @doc("ARM id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Name of the agreement.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Represents the properties of the resource.")
  properties?: DatadogAgreementProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Terms properties.")
model DatadogAgreementProperties {
  @doc("Publisher identifier string.")
  publisher?: string;

  @doc("Product identifier string.")
  product?: string;

  @doc("Plan identifier string.")
  plan?: string;

  @doc("Link to HTML with Microsoft and Publisher terms.")
  licenseTextLink?: string;

  @doc("Link to the privacy policy of the publisher.")
  privacyPolicyLink?: string;

  @doc("Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrieveDatetime?: utcDateTime;

  @doc("Terms signature.")
  signature?: string;

  @doc("If any version of the terms have been accepted, otherwise false.")
  accepted?: boolean;
}

@doc("Response of a list operation.")
model DatadogApiKeyListResponse is Azure.Core.Page<DatadogApiKey>;

model DatadogApiKey {
  @doc("The user that created the API key.")
  createdBy?: string;

  @doc("The name of the API key.")
  name?: string;

  @doc("The value of the API key.")
  key: string;

  @doc("The time of creation of the API key.")
  created?: string;
}

@doc("Response of a list operation.")
model DatadogHostListResponse is Azure.Core.Page<DatadogHost>;

model DatadogHost {
  @doc("The name of the host.")
  name?: string;

  @doc("The aliases for the host.")
  aliases?: string[];

  @doc("The Datadog integrations reporting metrics for the host.")
  apps?: string[];

  meta?: DatadogHostMetadata;
}

model DatadogHostMetadata {
  @doc("The agent version.")
  agentVersion?: string;

  installMethod?: DatadogInstallMethod;
  logsAgent?: DatadogLogsAgent;
}

model DatadogInstallMethod {
  @doc("The tool.")
  tool?: string;

  @doc("The tool version.")
  toolVersion?: string;

  @doc("The installer version.")
  installerVersion?: string;
}

model DatadogLogsAgent {
  @doc("The transport.")
  transport?: string;
}

@doc("Response of a list operation.")
model LinkedResourceListResponse is Azure.Core.Page<LinkedResource>;

@doc("The definition of a linked resource.")
model LinkedResource {
  @doc("The ARM id of the linked resource.")
  id?: string;
}

@doc("Response of a list operation.")
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

@doc("The properties of a resource currently being monitored by the Datadog monitor resource.")
model MonitoredResource {
  @doc("The ARM id of the resource.")
  id?: string;

  @doc("Flag indicating if resource is sending metrics to Datadog.")
  sendingMetrics?: boolean;

  @doc("Reason for why the resource is sending metrics (or why it is not sending).")
  reasonForMetricsStatus?: string;

  @doc("Flag indicating if resource is sending logs to Datadog.")
  sendingLogs?: boolean;

  @doc("Reason for why the resource is sending logs (or why it is not sending).")
  reasonForLogsStatus?: string;
}

@doc("A Microsoft.Datadog REST API operation.")
model OperationResult {
  @doc("Operation name, i.e., {provider}/{resource}/{operation}.")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;
}

@doc("Properties specific to the monitor resource.")
model MonitorProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Flag specifying if the resource monitoring is enabled or disabled.")
  monitoringStatus?: MonitoringStatus;

  @doc("Flag specifying the Marketplace Subscription Status of the resource. If payment is not made in time, the resource will go in Suspended state.")
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  @doc("Datadog organization properties")
  datadogOrganizationProperties?: DatadogOrganizationProperties;

  @doc("User info")
  userInfo?: UserInfo;

  @visibility("read")
  liftrResourceCategory?: LiftrResourceCategories;

  @doc("The priority of the resource.")
  @visibility("read")
  liftrResourcePreference?: int32;
}

@doc("Datadog organization properties")
model DatadogOrganizationProperties {
  @doc("Name of the Datadog organization.")
  @visibility("read")
  name?: string;

  @doc("Id of the Datadog organization.")
  @visibility("read")
  id?: string;

  @doc("The auth code used to linking to an existing datadog organization.")
  @visibility("create")
  linkingAuthCode?: string;

  @doc("The client_id from an existing in exchange for an auth token to link organization.")
  @visibility("create")
  linkingClientId?: string;

  @doc("The redirect uri for linking.")
  @visibility("create")
  redirectUri?: string;

  @doc("Api key associated to the Datadog organization.")
  @visibility("create")
  apiKey?: string;

  @doc("Application key associated to the Datadog organization.")
  @visibility("create")
  applicationKey?: string;

  @doc("The Id of the Enterprise App used for Single sign on.")
  @visibility("create")
  enterpriseAppId?: string;
}

@doc("User info")
model UserInfo {
  @doc("Name of the user")
  @maxLength(50)
  name?: string;

  @doc("Email of the user used by Datadog for contacting them if needed")
  @pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
  emailAddress?: string;

  @doc("Phone number of the user used by Datadog for contacting them if needed")
  @maxLength(40)
  phoneNumber?: string;
}

model IdentityProperties {
  @doc("The identity ID.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("Identity type")
  type?: ManagedIdentityTypes;
}

@doc("The parameters for a PATCH request to a monitor resource.")
model DatadogMonitorResourceUpdateParameters {
  @doc("The set of properties that can be update in a PATCH request to a monitor resource.")
  properties?: MonitorUpdateProperties;

  @doc("The new tags of the monitor resource.")
  tags?: Record<string>;

  sku?: ResourceSku;
}

@doc("The set of properties that can be update in a PATCH request to a monitor resource.")
model MonitorUpdateProperties {
  @doc("Flag specifying if the resource monitoring is enabled or disabled.")
  monitoringStatus?: MonitoringStatus;
}

model DatadogSetPasswordLink {
  setPasswordLink?: string;
}

@doc("Definition of the properties for a TagRules resource.")
model MonitoringTagRulesProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Set of rules for sending logs for the Monitor resource.")
  logRules?: LogRules;

  @doc("Set of rules for sending metrics for the Monitor resource.")
  metricRules?: MetricRules;
}

@doc("Set of rules for sending logs for the Monitor resource.")
model LogRules {
  @doc("Flag specifying if AAD logs should be sent for the Monitor resource.")
  sendAadLogs?: boolean;

  @doc("Flag specifying if Azure subscription logs should be sent for the Monitor resource.")
  sendSubscriptionLogs?: boolean;

  @doc("Flag specifying if Azure resource logs should be sent for the Monitor resource.")
  sendResourceLogs?: boolean;

  @doc("List of filtering tags to be used for capturing logs. This only takes effect if SendResourceLogs flag is enabled. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.")
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

model DatadogSingleSignOnProperties {
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Various states of the SSO resource")
  singleSignOnState?: SingleSignOnStates;

  @doc("The Id of the Enterprise App used for Single sign-on.")
  enterpriseAppId?: string;

  @doc("The login URL specific to this Datadog Organization.")
  @visibility("read")
  singleSignOnUrl?: string;
}
