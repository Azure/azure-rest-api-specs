import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Playwright.Management;

// Tracked Resource PlaywrightWorkspace Models ////////////////////

@doc("Playwright workspace resource.")
model PlaywrightWorkspace is TrackedResource<PlaywrightWorkspaceProperties> {
  ...ResourceNameParameter<PlaywrightWorkspace>;

  ...ManagedServiceIdentityProperty;
}

@@added(PlaywrightWorkspace.identity, Versions.v2026_02_01_preview);

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

  @added(Versions.v2026_01_01_preview)
  @doc("The URI of the Azure storage account used to store workspace artifacts, test results, and reports.")
  storageUri?: url;
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
