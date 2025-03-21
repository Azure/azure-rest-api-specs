import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.DeviceOnboarding;

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource has been accepted by the server.")
  @added(Versions.v2024_12_01_preview)
  Accepted: "Accepted",

  @doc("Resource is deleting.")
  @added(Versions.v2024_12_01_preview)
  Deleting: "Deleting",

  string,
}
