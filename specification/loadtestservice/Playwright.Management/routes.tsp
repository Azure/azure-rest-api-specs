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
  // https://github.com/Azure/azure-openapi-validator/blob/main/docs/delete-response-codes.md
  delete is ArmResourceDeleteWithoutOkAsync<PlaywrightWorkspace>;
  // https://github.com/Azure/azure-openapi-validator/blob/main/docs/patch-body-parameters-schema.md
  update is ArmCustomPatchSync<
    PlaywrightWorkspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      PlaywrightWorkspace,
      OmitDefaults<PlaywrightWorkspaceProperties>
    >
  >;
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
