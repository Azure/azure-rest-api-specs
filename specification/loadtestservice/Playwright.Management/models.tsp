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
  @doc("The workspace data plane service API URI.")
  dataplaneUri?: url;

  @doc("Controls the connection region for client workers to cloud-hosted browsers. When enabled, workers connect to browsers in the closest Azure region for lower latency. When disabled, workers connect to browsers in the Azure region where the workspace was created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("Enables the workspace to use local authentication through service access tokens for operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;

  @visibility(Lifecycle.Read)
  @doc("The workspace ID in GUID format.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  workspaceId?: string;
}

@doc("The status of the last resource operation.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource creation is in progress.")
  Creating: "Creating",

  @doc("Resource deletion is in progress.")
  Deleting: "Deleting",

  @doc("Request has been accepted for processing.")
  Accepted: "Accepted",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is enabled.")
  Enabled: "Enabled",

  @doc("The feature is disabled.")
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
  @doc("The subscription-level location-based Playwright quota free trial properties.")
  freeTrial?: FreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;
}

@doc("Subscription-level location-based Playwright quota free trial properties.")
model FreeTrialProperties {
  @visibility(Lifecycle.Read)
  @doc("The workspace ID in GUID format that has free trial enabled in the subscription.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  workspaceId: string;

  @visibility(Lifecycle.Read)
  @doc("The free trial state.")
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
  @doc("The Playwright workspace quota free trial properties.")
  freeTrial?: PlaywrightWorkspaceFreeTrialProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;
}

@doc("Playwright workspace quota free trial properties.")
model PlaywrightWorkspaceFreeTrialProperties {
  @visibility(Lifecycle.Read)
  @doc("The free trial creation timestamp in UTC.")
  createdAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The free trial expiration timestamp in UTC.")
  expiryAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The allocated limit value (e.g., allocated free execution minutes).")
  allocatedValue: int32;

  @visibility(Lifecycle.Read)
  @doc("The used value (e.g., used free execution minutes).")
  usedValue: float32;

  @visibility(Lifecycle.Read)
  @doc("The percentage of the free trial quota used.")
  @minValue(0)
  @maxValue(100)
  percentageUsed: float32;
}

@doc("Available Playwright quota types.")
union QuotaName {
  string,

  @doc("Quota for execution duration in minutes.")
  ExecutionMinutes: "ExecutionMinutes",
}

@doc("The free trial state.")
union FreeTrialState {
  string,

  @doc("The free trial is active and available for use.")
  Active: "Active",

  @doc("The free trial has expired and is no longer available.")
  Expired: "Expired",

  @doc("The free trial is not applicable for this resource.")
  NotApplicable: "NotApplicable",
}
