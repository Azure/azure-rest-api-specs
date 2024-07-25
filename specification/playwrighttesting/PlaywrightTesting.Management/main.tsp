import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace("Microsoft.AzurePlaywrightService")
@service({
  title: "Microsoft AzurePlaywrightService Management API",
})
@versioned(Versions)
@doc("Microsoft.AzurePlaywrightService Resource Provider management API.")
namespace Microsoft.AzurePlaywrightService;

@doc("Microsoft.AzurePlaywrightService Management API Versions.")
enum Versions {
  @doc("API Version 2024-08-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_08_01_preview: "2024-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("An account resource.")
model Account is TrackedResource<AccountProperties> {
  @doc("Name of account.")
  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9]{2,63}$")
  @key("accountName")
  @path
  @segment("accounts")
  name: string;
}

@doc("Account properties.")
model AccountProperties {
  @visibility("read")
  @doc("The Playwright testing dashboard URI for the account resource.")
  dashboardUri?: url;

  @doc("This property sets the connection region for Playwright client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, Playwright client workers can connect to cloud-hosted browsers. This can increase the number of parallel workers for a test run, significantly minimizing test completion durations.")
  scalableExecution?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to upload and display test results, including artifacts like traces and screenshots, in the Playwright portal. This enables faster and more efficient troubleshooting.")
  reporting?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth(through access key) for authentication of test runs.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",

  string,
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Creation in progress")
  Creating: "Creating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@armResourceOperations
interface Accounts
  extends TrackedResourceOperations<Account, AccountProperties> {
  @doc("Adds check global name availability operation, normally used if a resource name must be globally unique.")
  checkNameAvailability is checkGlobalNameAvailability;
}

@doc("The location of quota resource.")
@subscriptionResource
model Location {
  @doc("The location of quota in ARM Normalized format like eastus, southeastasia etc.")
  @key("location")
  @path
  @segment("locations")
  @visibility("query", "read", "update")
  name: string;
}

@doc("A quota resource.")
@parentResource(Location)
model Quota is ProxyResource<QuotaProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("The quota name.")
  @key("quotaName")
  @path
  @segment("quotas")
  name: QuotaNames;
}

@doc("The quota name.")
union QuotaNames {
  @doc("The quota details for scalable execution feature. When enabled, Playwright client workers can connect to cloud-hosted browsers. This can increase the number of parallel workers for a test run, significantly minimizing test completion durations.")
  ScalableExecution: "ScalableExecution",

  @doc("The quota details for reporting feature. When enabled, Playwright client will be able to upload and display test results, including artifacts like traces and screenshots, in the Playwright portal. This enables faster and more efficient troubleshooting.")
  Reporting: "Reporting",

  string,
}

@doc("Quota properties.")
model QuotaProperties {
  @doc("The free-trial quota.")
  freeTrial?: FreeTrialProperties;

  @doc("Indicates the offering type for the subscription.")
  @visibility("read")
  offeringType?: OfferingType;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The free-trial properties.")
model FreeTrialProperties {
  @doc("The playwright account id.")
  @visibility("read")
  accountId: string;

  @doc("The free-trial state.")
  @visibility("read")
  state: FreeTrialState;
}

@doc("A quota resource for an account.")
@parentResource(Account)
model AccountQuota is ProxyResource<AccountQuotaProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("The quota name.")
  @key("quotaName")
  @path
  @segment("quotas")
  name: QuotaNames;
}

@doc("Quota properties for an account.")
model AccountQuotaProperties {
  @doc("The free-trial quota.")
  freeTrial?: AccountFreeTrialProperties;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The free-trial properties for an account.")
model AccountFreeTrialProperties {
  @doc("The free-trial createdAt utcDateTime.")
  @visibility("read")
  createdAt: utcDateTime;

  @doc("The free-trial expiryAt utcDateTime.")
  @visibility("read")
  expiryAt: utcDateTime;

  @doc("The free-trial allocated limit value eg. allocated free minutes.")
  @visibility("read")
  allocatedValue: int32;

  @doc("The free-trial used value eg. used free minutes.")
  @visibility("read")
  usedValue: int32;

  @doc("The free-trial percentage used.")
  @visibility("read")
  @minValue(0)
  @maxValue(100)
  percentageUsed: float32;
}

@doc("The free-trial state.")
union FreeTrialState {
  @doc("The free-trial is Active.")
  Active: "Active",

  @doc("The free-trial is Expired.")
  Expired: "Expired",

  @doc("The free-trial is Not Eligible.")
  NotEligible: "NotEligible",

  @doc("The free-trial is Not Registered.")
  NotRegistered: "NotRegistered",

  string,
}

@doc("Offering type state.")
union OfferingType {
  @doc("The offeringType is NotApplicable.")
  NotApplicable: "NotApplicable",

  @doc("The offeringType is PrivatePreview.")
  PrivatePreview: "PrivatePreview",

  @doc("The offeringType is PublicPreview.")
  PublicPreview: "PublicPreview",

  @doc("The offeringType is GeneralAvailability.")
  GeneralAvailability: "GeneralAvailability",

  string,
}

@armResourceOperations
interface Quotas {
  @doc("Get quota by name.")
  get is ArmResourceRead<Quota>;

  @doc("List quotas for a given subscription Id.")
  listBySubscription is ArmListBySubscription<Quota>;
}

@armResourceOperations
interface AccountQuotas {
  @doc("Get quota by name for an account.")
  get is ArmResourceRead<AccountQuota>;

  @doc("List quotas for a given account.")
  listByAccount is ArmResourceListByParent<AccountQuota>;
}
