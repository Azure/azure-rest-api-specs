import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** The provisioning state for any topological element in a supercomputer */
@lroStatus
union TopologicalProvisioningState {
  ResourceProvisioningState,

  /** The resource is currently being updated */
  Updating: "Updating",
}
