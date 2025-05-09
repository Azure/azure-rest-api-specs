import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Playwright.Management;

@doc("Playwright workspace resource.")
model PlaywrightWorkspace is TrackedResource<PlaywrightWorkspaceProperties> {
  ...ResourceNameParameter<PlaywrightWorkspace>;
}

@doc("Playwright workspace resource properties.")
model PlaywrightWorkspaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The workspace data plane URI.")
  dataplaneUri?: url;

  @doc("This property sets the connection region for client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The status of the last resource operation.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Creation in progress..")
  Creating: "Creating",

  @doc("Deletion in progress..")
  Deleting: "Deleting",

  @doc("Request accepted for processing..")
  Accepted: "Accepted",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}

@doc("A subscription quota resource.")
@parentResource(ArmLocationResource<"Subscription">)
model QuotaResource is ProxyResource<QuotaResourceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("The quota name.")
  @key("quotaBucketName")
  @path
  @segment("quotas")
  name: QuotaNames;
}

@doc("The subscription quota resource properties.")
model QuotaResourceProperties {
  @doc("The subscription quota resource free-trial properties.")
  freeTrial?: FreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The enum for quota name.")
union QuotaNames {
  string,

  @doc("The quota details for browser usage duration feature. When enabled, Playwright client workers can connect to cloud-hosted browsers. This can increase the number of parallel workers for a test run, significantly minimizing test completion durations.")
  "BrowserUsageDurationQuota",
}

@doc("The subscription quota resource free-trial properties.")
model FreeTrialProperties {
  @doc("The Playwright service workspace id.")
  @visibility(Lifecycle.Read)
  workspaceId: string;

  @doc("The free-trial state.")
  @visibility(Lifecycle.Read)
  state: FreeTrialState;
}

@doc("The free-trial state.")
union FreeTrialState {
  string,

  @doc("The free-trial is Active.")
  "Active",

  @doc("The free-trial is Expired.")
  "Expired",

  @doc("The free-trial is Not Eligible.")
  "NotEligible",

  @doc("The free-trial is Not Registered.")
  "NotRegistered",
}

@doc("A quota resource for a Playwright service workspace.")
@parentResource(PlaywrightWorkspace)
model WorkspaceQuotaResource
  is ProxyResource<WorkspaceQuotaResourceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("The Playwright service workspace quota name.")
  @key("quotaBucketName")
  @path
  @segment("quotas")
  name: QuotaNames;
}

@doc("The Playwright service workspace quota resource properties.")
model WorkspaceQuotaResourceProperties {
  @doc("The Playwright service workspace quota resource free-trial properties.")
  freeTrial?: WorkspaceFreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The Playwright service workspace quota resource free-trial properties.")
model WorkspaceFreeTrialProperties {
  @doc("The free-trial createdAt utcDateTime.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The free-trial expiryAt utcDateTime.")
  @visibility(Lifecycle.Read)
  expiryAt: utcDateTime;

  @doc("The free-trial allocated limit value eg. allocated free minutes.")
  @visibility(Lifecycle.Read)
  allocatedValue: int32;

  @doc("The free-trial used value eg. used free minutes.")
  @visibility(Lifecycle.Read)
  usedValue: float32;

  @doc("The free-trial percentage used.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  percentageUsed: float32;
}
