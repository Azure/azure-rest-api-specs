import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Agent compute resource specific properties. */
model AgentComputeProperties {
  /** Provisioning state of the agent compute. */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentComputeProvisioningState;
}

/** Provisioning state of the agent compute. */
@lroStatus
union AgentComputeProvisioningState {
  string,
  ResourceProvisioningState,

  /** The agent compute is being provisioned */
  InProgress: "InProgress",

  /** The agent compute provisioning succeeded */
  Succeeded: "Succeeded",

  /** The agent compute provisioning failed */
  Failed: "Failed",

  /** The agent compute provisioning was canceled */
  Canceled: "Canceled",

  /** The agent compute is being deleted */
  Deleting: "Deleting",
}
