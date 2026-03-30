import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Sandbox group resource specific properties. */
model SandboxGroupProperties {
  /** Provisioning state of the sandbox group. */
  @visibility(Lifecycle.Read)
  provisioningState?: SandboxGroupProvisioningState;
}

/** Provisioning state of the sandbox group. */
@lroStatus
union SandboxGroupProvisioningState {
  string,
  ResourceProvisioningState,

  /** The sandbox group is being provisioned */
  InProgress: "InProgress",

  /** The sandbox group provisioning succeeded */
  Succeeded: "Succeeded",

  /** The sandbox group provisioning failed */
  Failed: "Failed",

  /** The sandbox group provisioning was canceled */
  Canceled: "Canceled",

  /** The sandbox group is being deleted */
  Deleting: "Deleting",
}
