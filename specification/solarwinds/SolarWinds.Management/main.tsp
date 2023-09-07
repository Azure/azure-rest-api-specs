import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service({
  title: "SolarWinds.Observability",
  version: "2023-08-23-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
namespace SolarWinds.Observability;

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Reusable representation of an email address")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("A Organization Resource by SolarWinds")
model SolarWindsOrganizationResource
  is TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9_-]*$")
  @segment("organizations")
  @doc("Name of the Organizations resource")
  @path
  name: string;

  ...ManagedServiceIdentity;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<SolarWindsOrganizationResource>;
  create is ArmResourceCreateOrUpdateAsync<SolarWindsOrganizationResource>;
  update is ArmCustomPatchAsync<
    SolarWindsOrganizationResource,
    SolarWindsOrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteAsync<SolarWindsOrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<SolarWindsOrganizationResource>;
  listBySubscription is ArmListBySubscription<SolarWindsOrganizationResource>;
  @post
  @doc("List the resources currently being monitored by the SolarWinds organization resource.")
  @action("listMonitoredResources")
  @armResourceAction(SolarWindsOrganizationResource)
  listMonitoredResources(
    ...ResourceInstanceParameters<SolarWindsOrganizationResource>,
  ): ArmResponse<MonitoredResourceListResponse> | ErrorResponse;

  @armResourceAction(SolarWindsOrganizationResource)
  @post
  @doc("Get metric status")
  @action("getMetricStatus")
  getMetricStatus(
    ...ResourceInstanceParameters<SolarWindsOrganizationResource>,
    ...MetricsStatusRequestParameter,
  ): ArmResponse<MetricsStatusResponse> | ErrorResponse;
}

@doc("A tag rule belonging to SolarWinds account")
@parentResource(SolarWindsOrganizationResource)
model TagRule is ProxyResource<MonitoringTagRulesProperties> {
  @key("ruleSetName")
  @segment("tagRules")
  @pattern("^[a-zA-Z0-9_-]*$")
  @doc("Name of the TagRule")
  @path
  @visibility("read")
  name: string;
}

@doc("Model for patching TagRules")
model TagsPatchModel {
  @doc("TagRule name")
  @visibility("read")
  name?: string;

  @doc("TagRule properties")
  properties?: TagRulePropertiesPatchModel;
}

@doc("Model for patching TagRule properties")
model TagRulePropertiesPatchModel {
  @doc("Set of rules for sending logs for the Monitor resource.")
  logRules?: LogRules;

  @doc("Set of rules for sending metrics for the Monitor resource.")
  metricRules?: MetricRules;
}

@armResourceOperations
interface TagRules {
  listBySolarWindsOrganizationResource is ArmResourceListByParent<TagRule>;
  get is ArmResourceRead<TagRule>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TagRule>;
  delete is ArmResourceDeleteAsync<TagRule>;
  update is ArmCustomPatchAsync<TagRule, TagsPatchModel>;
}

@doc("Properties specific to the SolarWinds Observability Organization resource")
model OrganizationProperties {
  @visibility("read")
  @doc("Provisioning State of the resource")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("MonitoringStatus of the resource")
  monitoringStatus?: MonitoringStatus;

  @doc("SW Organization properties")
  solarWindsOrganizationProperties?: SolarWindsOrganizationProperties;

  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetails;

  @doc("User details")
  userDetails?: UserDetails;

  @doc("Company Details")
  companyDetails?: CompanyDetails;

  @doc("Ingestion key")
  ingestionKey?: SecureString;

  @doc("Existing Resource Id")
  existingResourceId?: string;

  @visibility("read")
  @doc("Liftr resource category")
  liftrResourceCategory?: LiftrResourceCategories;

  @visibility("read")
  @doc("Liftr resource preference. The priority of the resource.")
  liftrResourcePreference?: int32;
}

@doc("Credential string")
@secret
scalar SecureString extends string;

@doc("Marketplace details")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId: string;

  @doc("Marketplace offer details.")
  offerDetails: OfferDetails;
}

@doc("Details of the product offering.")
model OfferDetails {
  @maxLength(50)
  @doc("Id of the product publisher.")
  publisherId: string;

  @maxLength(50)
  @doc("Id of the product offering.")
  offerId: string;

  @maxLength(50)
  @doc("Id of the product offer plan.")
  planId: string;

  @maxLength(50)
  @doc("Name of the product offer plan.")
  planName: string;

  @maxLength(25)
  @doc("Offer plan term unit.")
  termUnit?: string;

  @maxLength(50)
  @doc("Offer plan term id.")
  termId: string;
}

@doc("Properties of the SolarWinds account")
model SolarWindsOrganizationProperties {
  @doc("User id")
  userId?: string;

  @doc("SolarWinds Organization Information")
  organizationInfo?: OrganizationInfo;

  @doc("A tag rule belonging to SolarWinds account")
  tagRule?: TagRule;
}

@doc("Organization Info of the SolarWinds account")
model OrganizationInfo {
  @doc("Organization id")
  organizationId?: string;

  @doc("SolarWinds account region")
  regionId?: string;
}

@doc("User Info of SolarWinds Organization resource")
model UserDetails {
  @maxLength(50)
  @doc("User first name.")
  firstName: string;

  @maxLength(50)
  @doc("User last name.")
  lastName: string;

  @doc("User email address.")
  emailAddress: email;

  @doc("Alternate Email address")
  alternateEmail?: string;

  @doc("UPN of user")
  upn?: string;

  @doc("Address of user")
  address?: string;

  @maxLength(40)
  @doc("Phone number of the user used by for contacting them if needed")
  phoneNumber?: string;

  @doc("Country of the user")
  country?: string;
}

@doc("Provisioning State of the Monitor resource")
@lroStatus
enum ProvisioningState {
  ...Azure.ResourceManager.ResourceProvisioningState,

  @doc("Monitor resource creation request accepted")
  Accepted,

  @doc("Monitor resource creation started")
  Creating,

  @doc("Monitor resource is being updated")
  Updating,

  @doc("Monitor resource deletion started")
  Deleting,

  @doc("Monitor resource is deleted")
  Deleted,

  @doc("Monitor resource state is unknown")
  NotSpecified,
}

@doc("Flag specifying if the resource monitoring is enabled or disabled.")
enum MonitoringStatusValues {
  @doc("monitoring is enabled")
  Enabled,

  @doc("monitoring is disabled")
  Disabled,
}

@knownValues(MonitoringStatusValues)
scalar MonitoringStatus extends string;

@doc("Liftr Resource category.")
enum LiftrResourceCategoriesValues {
  @doc("Liftr Resource category is unknown")
  Unknown,

  @doc("Liftr Resource category is monitor logs")
  MonitorLogs,
}

@knownValues(LiftrResourceCategoriesValues)
scalar LiftrResourceCategories extends string;

@doc("Get Metrics Status Parameter specification.")
model MetricsStatusRequestParameter {
  @doc("The details of the get metrics status request.")
  @body
  request: MetricsStatusRequest;
}

@doc("Request of get metrics status Operation.")
model MetricsStatusRequest {
  @doc("Azure resource IDs")
  azureResourceIds?: string[];
}

@doc("Response of get metrics status Operation.")
model MetricsStatusResponse {
  @doc("Azure resource IDs")
  azureResourceIds?: string[];
}

@doc("The resource-specific properties for this resource.")
model MonitoringTagRulesProperties {
  @visibility("read")
  @doc("Provisioning State of the resource")
  provisioningState?: ProvisioningState;

  @doc("Set of rules for sending logs for the Monitor resource.")
  logRules?: LogRules;

  @doc("Set of rules for sending metrics for the Monitor resource.")
  metricRules?: MetricRules;
}

@doc("Set of rules for sending logs for the Monitor resource.")
model LogRules {
  @doc("Flag specifying if AAD logs should be sent for the Monitor resource.")
  sendAadLogs?: SendAadLogsStatus;

  @doc("Flag specifying if subscription logs should be sent for the Monitor resource.")
  sendSubscriptionLogs?: SendSubscriptionLogsStatus;

  @doc("Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.")
  sendActivityLogs?: SendActivityLogsStatus;

  @doc("List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured.\nIf only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.")
  @OpenAPI.extension("x-ms-identifiers", [])
  filteringTags?: FilteringTag[];
}

@doc("Set of rules for sending metrics for the Monitor resource.")
model MetricRules {
  @doc("Flag specifying if metrics should be sent for the Monitor resource.")
  sendMetrics?: SendMetricsStatus;

  @doc("List of filtering tags to be used for capturing metrics.")
  @OpenAPI.extension("x-ms-identifiers", [])
  filteringTags?: FilteringTag[];
}

@doc("Indicates whether AAD logs are being sent.")
enum SendAadLogsStatusValues {
  @doc("AAD logs are enabled")
  Enabled,

  @doc("AAD logs are disabled")
  Disabled,
}

@doc("Indicates whether metrics are being sent.")
enum SendMetricsStatus {
  @doc("Metrics are enabled")
  Enabled,

  @doc("Metrics are disabled")
  Disabled,
}

@knownValues(SendAadLogsStatusValues)
scalar SendAadLogsStatus extends string;

@doc("Indicates whether subscription logs are being sent.")
enum SendSubscriptionLogsStatusValues {
  @doc("subscription logs are enabled")
  Enabled,

  @doc("subscription logs are disabled")
  Disabled,
}

@knownValues(SendSubscriptionLogsStatusValues)
scalar SendSubscriptionLogsStatus extends string;

@doc("Indicates whether activity logs are being sent.")
enum SendActivityLogsStatusValues {
  @doc("Activity logs are enabled")
  Enabled,

  @doc("Activity logs are disabled")
  Disabled,
}

@knownValues(SendActivityLogsStatusValues)
scalar SendActivityLogsStatus extends string;

@doc("The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.")
model FilteringTag {
  @doc("The name (also known as the key) of the tag.")
  name?: string;

  @doc("The value of the tag.")
  value?: string;

  @doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
  action?: TagAction;
}

@doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
enum TagActionValues {
  @doc("tags are included")
  Include,

  @doc("tags are excluded")
  Exclude,
}

@knownValues(TagActionValues)
scalar TagAction extends string;

@doc("Details of resource being monitored by SolarWinds monitor resource")
model MonitoredResource {
  @doc("The ARM id of the resource.")
  id: string;

  @doc("Flag indicating if resource is sending logs to SolarWinds.")
  sendingLogs?: SendingLogsStatus;

  @doc("Reason for why the resource is sending logs (or why it is not sending).")
  reasonForLogsStatus?: string;

  @doc("Flag indicating if resource is sending metrics to SolarWinds.")
  sendingMetrics?: SendingMetricsStatus;

  @doc("Reason for why the resource is sending metrics (or why it is not sending).")
  reasonForMetricsStatus?: string;
}

@doc("Details of the company")
model CompanyDetails {
  @doc("Name of the company")
  companyName?: string;

  @doc("Address of the company")
  officeAddress?: string;

  @doc("Name of the country")
  country?: string;

  @doc("Domain name")
  domain?: string;

  @doc("Business name")
  business?: string;

  @doc("Number of employees in the company")
  numberOfEmployees?: int32;
}

@doc("Indicates whether logs are being sent.")
enum SendingLogsStatusValues {
  @doc("logs are enabled")
  Enabled,

  @doc("logs are disabled")
  Disabled,
}

@doc("Indicates whether metrics are being sent.")
enum SendingMetricsStatus {
  @doc("Metrics are enabled")
  Enabled,

  @doc("Metrics are disabled")
  Disabled,
}

@knownValues(SendingLogsStatusValues)
scalar SendingLogsStatus extends string;

@doc("List of all the resources being monitored by SolarWinds organization resource")
model MonitoredResourceListResponse
  extends Azure.Core.Page<MonitoredResource> {}

@doc("Billing source")
enum BillingSourceValues {
  @doc("Billing source is Azure")
  AZURE,
}

@knownValues(BillingSourceValues)
scalar BillingSource extends string;

// additional models for Organizations_patch

model SolarWindsOrganizationResourceUpdate
  is OptionalProperties<UpdateableProperties<OmitProperties<
    SolarWindsOrganizationResource,
    "name"
  >>> {
  /** Patchable Properties of the Organization observability resource */
  properties?: OrganizationPropertiesCustomUpdate;
}

/** Patchable Properties of the Organization observability resource */
model OrganizationPropertiesCustomUpdate {
  @doc("SW Organization properties")
  solarWindsOrganizationProperties?: SolarWindsOrganizationPropertiesUpdate;

  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetailsUpdate;

  @doc("User details")
  userDetails?: UserDetailsUpdate;

  @doc("Company Details")
  companyDetails?: CompanyDetailsUpdate;

  @doc("Existing Resource Id")
  existingResourceId?: string;
}

/** Marketplace details */
model MarketplaceDetailsUpdate {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId?: string;

  @doc("Marketplace offer details.")
  offerDetails?: OfferDetailsUpdate;
}

/** Details of the product offering */
model OfferDetailsUpdate
  is OptionalProperties<UpdateableProperties<OfferDetails>>;

/** User Info of SolarWinds Organization resource */
model UserDetailsUpdate
  is OptionalProperties<UpdateableProperties<UserDetails>>;

/** Company details of SolarWinds Organization resource */
model CompanyDetailsUpdate
  is OptionalProperties<UpdateableProperties<CompanyDetails>>;

/** Patchable properties of a solarWinds Organization */
model SolarWindsOrganizationPropertiesUpdate {
  @doc("User id")
  userId?: string;

  @doc("SolarWinds Organization Information")
  organizationInfo?: OrganizationInfo;

  @doc("A tag rule belonging to SolarWinds account")
  tagRule?: TagRuleUpdate;
}

/** The patchable Tag Rule */
model TagRuleUpdate {
  /** The patchable TagRule properties. */
  properties?: TagRulePropertiesUpdate;
}

model TagRulePropertiesUpdate
  is OptionalProperties<UpdateableProperties<MonitoringTagRulesProperties>>;
/** The patchable resource-specific properties for this resource. */
