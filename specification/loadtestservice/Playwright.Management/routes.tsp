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
