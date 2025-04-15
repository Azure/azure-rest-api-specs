import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace PlaywrightService.Management;

@doc("Playwright workspace resource.")
model PlaywrightWorkspace is TrackedResource<PlaywrightWorkspaceProperties> {
  ...ResourceNameParameter<PlaywrightWorkspace>;
  ...ResourceKindProperty;
}

@doc("Playwright workspace resource properties.")
model PlaywrightWorkspaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;

  ...WorkspaceAdditionalProperties;
}

@doc("The additional properties of a workspace.")
model WorkspaceAdditionalProperties {
  @visibility(Lifecycle.Read)
  @doc("The workspace data plane URI.")
  dataplaneUri?: url;

  @doc("This property sets the connection region for client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
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
