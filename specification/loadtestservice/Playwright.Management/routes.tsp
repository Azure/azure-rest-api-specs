import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;

namespace Playwright.Management;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface PlaywrightWorkspaces
  extends TrackedResourceOperations<
      PlaywrightWorkspace,
      PlaywrightWorkspaceProperties
    > {
  checkNameAvailability is checkGlobalNameAvailability;
}

@armResourceOperations
interface PlaywrightQuotas {
  @doc("Get subscription-level location-based Playwright quota resource by name.")
  get is ArmResourceRead<PlaywrightQuota>;

  @doc("List Playwright quota resources for a given subscription Id.")
  listBySubscription is ArmListBySubscription<PlaywrightQuota>;
}

@armResourceOperations
interface PlaywrightWorkspaceQuotas {
  @doc("Get Playwright workspace quota resource by name.")
  get is ArmResourceRead<PlaywrightWorkspaceQuota>;

  @doc("List quota resources for a given Playwright workspace resource.")
  listByPlaywrightWorkspace is ArmResourceListByParent<PlaywrightWorkspaceQuota>;
}
