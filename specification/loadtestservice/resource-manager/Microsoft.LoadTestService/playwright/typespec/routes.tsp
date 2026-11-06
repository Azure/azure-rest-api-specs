import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Playwright.Management;

@doc("Operations for Playwright service management.")
interface Operations extends Azure.ResourceManager.Operations {}

// Tracked Resource PlaywrightWorkspace Operations ////////////////////

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
  @removed(Versions.v2026_11_10_preview)
  @renamedFrom(Versions.v2026_11_10_preview, "update")
  @sharedRoute
  updateSync is ArmCustomPatchSync<
    PlaywrightWorkspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      PlaywrightWorkspace,
      OmitDefaults<PlaywrightWorkspaceProperties>
    >
  >;
  @doc("Updates a Playwright workspace resource asynchronously.")
  @added(Versions.v2026_11_10_preview)
  @sharedRoute
  update is ArmCustomPatchAsync<
    PlaywrightWorkspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      PlaywrightWorkspace,
      OmitDefaults<PlaywrightWorkspacePatchProperties>
    >
  >;
  @doc("Checks if a Playwright workspace name is available globally.")
  checkNameAvailability is checkGlobalNameAvailability;
}
