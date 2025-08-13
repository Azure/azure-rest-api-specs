import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;

namespace Playwright.Management;

@doc("Operations for Playwright service management.")
interface Operations extends Azure.ResourceManager.Operations {}

@doc("Operations for managing Playwright workspace resources.")
@armResourceOperations
interface PlaywrightWorkspaces
  extends TrackedResourceOperations<
      PlaywrightWorkspace,
      PlaywrightWorkspaceProperties
    > {
  // https://github.com/Azure/azure-openapi-validator/blob/main/docs/delete-response-codes.md
  @doc("Deletes a Playwright workspace resource asynchronously.")
  delete is ArmResourceDeleteWithoutOkAsync<PlaywrightWorkspace>;
  // https://github.com/Azure/azure-openapi-validator/blob/main/docs/patch-body-parameters-schema.md
  @doc("Updates a Playwright workspace resource synchronously.")
  update is ArmCustomPatchSync<
    PlaywrightWorkspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      PlaywrightWorkspace,
      OmitDefaults<PlaywrightWorkspaceProperties>
    >
  >;
  @doc("Checks if a Playwright workspace name is available globally.")
  checkNameAvailability is checkGlobalNameAvailability;
}

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
