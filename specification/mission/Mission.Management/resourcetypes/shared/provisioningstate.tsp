import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Provisioning State Type Accepted")
  Accepted: "Accepted",

  @doc("Provisioning State Type Creating")
  Creating: "Creating",

  @doc("Provisioning State Type Deleting")
  Deleting: "Deleting",

  @doc("Provisioning State Type NotSpecified")
  NotSpecified: "NotSpecified",

  @doc("Provisioning State Type Running")
  Running: "Running",

  @doc("Provisioning State Type Updating")
  Updating: "Updating",
}
