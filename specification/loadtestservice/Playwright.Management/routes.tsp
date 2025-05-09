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
  @doc("Get subscription quota by name.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  listBySubscription is ArmListBySubscription<QuotaResource>;
}

@armResourceOperations
interface PlaywrightWorkspacesQuotas {
  @doc("Get quota by name for a workspace.")
  get is ArmResourceRead<WorkspaceQuotaResource>;

  @doc("List quotas for a given workspace.")
  listByWorkspace is ArmResourceListByParent<WorkspaceQuotaResource>;
}
