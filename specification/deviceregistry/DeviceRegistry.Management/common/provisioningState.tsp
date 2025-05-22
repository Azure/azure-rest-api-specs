import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource has been accepted by the server.")
  Accepted: "Accepted",
}
