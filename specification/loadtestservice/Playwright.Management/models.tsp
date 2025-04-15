import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Playwright.Shared";

using Azure.Core;
using Azure.ResourceManager;
using Playwright.Shared;

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

  ...WorkspaceAdditionalProperties;
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
