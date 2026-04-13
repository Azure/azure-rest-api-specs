import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Playwright.Management;

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

// Proxy Resource Playwright Quota Operations ////////////////////

@doc("Operations for managing Playwright quota resources at the subscription level.")
@armResourceOperations
interface PlaywrightQuotas {
  @doc("Gets a subscription-level location-based Playwright quota resource by name.")
  get is ArmResourceRead<PlaywrightQuota>;

  @doc("Lists Playwright quota resources for a given subscription ID.")
  listBySubscription is ArmListBySubscription<PlaywrightQuota>;
}

@doc("Operations for managing Playwright workspace quota resources.")
@armResourceOperations
interface PlaywrightWorkspaceQuotas {
  @doc("Gets a Playwright workspace quota resource by name.")
  get is ArmResourceRead<PlaywrightWorkspaceQuota>;

  @doc("Lists quota resources for a given Playwright workspace.")
  listByPlaywrightWorkspace is ArmResourceListByParent<PlaywrightWorkspaceQuota>;
}
