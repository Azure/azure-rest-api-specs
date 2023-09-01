import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Provisioning State Enum")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Provisioning State Type Accepted")
  Accepted,

  @doc("Provisioning State Type Created")
  Created,

  @doc("Provisioning State Type Creating")
  Creating,

  @doc("Provisioning State Type Deleted")
  Deleted,

  @doc("Provisioning State Type Deleting")
  Deleting,

  @doc("Provisioning State Type NotSpecified")
  NotSpecified,

  @doc("Provisioning State Type Ready")
  Ready,

  @doc("Provisioning State Type Running")
  Running,

  @doc("Provisioning State Type Updating")
  Updating,
}
