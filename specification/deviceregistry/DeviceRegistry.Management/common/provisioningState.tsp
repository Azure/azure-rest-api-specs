import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource has been accepted by the server.")
  Accepted: "Accepted",

  @doc("Resource is deleting.")
  @added(Versions.v2024_09_01_preview)
  Deleting: "Deleting",

  string,
}
