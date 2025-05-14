import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Playwright.Management;

// Tracked Resource PlaywrightWorkspace Models ////////////////////

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

// Proxy Resource Playwright Quota Models ////////////////////

@doc("Subscription-level location-based Playwright quota resource.")
@parentResource(SubscriptionLocationResource)
model PlaywrightQuota is ProxyResource<PlaywrightQuotaProperties> {
  ...ResourceNameParameter<PlaywrightQuota, Type = QuotaName>;
}

@doc("Subscription-level location-based Playwright quota resource properties.")
model PlaywrightQuotaProperties {
  @visibility(Lifecycle.Read)
  @doc("The subscription-level location-based Playwright quota resource free-trial properties.")
  freeTrial?: FreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;
}

@doc("Subscription-level location-based Playwright quota resource free-trial properties.")
model FreeTrialProperties {
  @visibility(Lifecycle.Read)
  @doc("Playwright workspace-id that has free-trial in the subscription.")
  workspaceId: string;

  @visibility(Lifecycle.Read)
  @doc("The free-trial state.")
  state: FreeTrialState;
}

@doc("Playwright workspace quota resource.")
@parentResource(PlaywrightWorkspace)
model PlaywrightWorkspaceQuota
  is ProxyResource<PlaywrightWorkspaceQuotaProperties> {
  ...ResourceNameParameter<
    PlaywrightWorkspaceQuota,
    KeyName = "quotaName",
    SegmentName = "quotas",
    Type = QuotaName
  >;
}

@doc("Playwright workspace quota resource properties.")
model PlaywrightWorkspaceQuotaProperties {
  @visibility(Lifecycle.Read)
  @doc("The Playwright workspace quota resource free-trial properties.")
  freeTrial?: PlaywrightWorkspaceFreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;
}

@doc("Playwright workspace quota resource resource free-trial properties.")
model PlaywrightWorkspaceFreeTrialProperties {
  @visibility(Lifecycle.Read)
  @doc("The free-trial createdAt utcDateTime.")
  createdAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The free-trial expiryAt utcDateTime.")
  expiryAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The free-trial allocated limit value eg. allocated free execution minutes.")
  allocatedValue: int32;

  @visibility(Lifecycle.Read)
  @doc("The free-trial used value eg. used free execution minutes.")
  usedValue: float32;

  @visibility(Lifecycle.Read)
  @doc("The free-trial percentage used.")
  @minValue(0)
  @maxValue(100)
  percentageUsed: float32;
}

@doc("Playwright quota names.")
union QuotaName {
  string,

  @doc("Quota for execution duration in minutes.")
  ExecutionMinutes: "ExecutionMinutes",
}

@doc("The free-trial state.")
union FreeTrialState {
  string,

  @doc("The free-trial is Active.")
  Active: "Active",

  @doc("The free-trial is Expired.")
  Expired: "Expired",

  @doc("The free-trial is Not Applicable.")
  NotApplicable: "NotApplicable",
}
