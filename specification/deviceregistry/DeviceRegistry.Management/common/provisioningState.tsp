import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  @doc("Resource provisioning has succeeded.")
  Succeeded: "Succeeded",

  @doc("Resource provisioning has failed.")
  Failed: "Failed",

  @doc("Resource provisioning has been canceled.")
  Canceled: "Canceled",

  @doc("Resource has been accepted by the server.")
  Accepted: "Accepted",

  @doc("Resource is deleting.")
  @added(Versions.v2024_07_01_preview)
  Deleting: "Deleting",

  string,
}
