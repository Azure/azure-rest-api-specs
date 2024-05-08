import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureFleet;

@doc("An AzureFleet's virtualMachineScaleSet")
@parentResource(Fleet)
model VirtualMachineScaleSet {
  @doc("The name of the virtualMachineScaleSet")
  @key("virtualMachineScaleSetName")
  @segment("virtualMachineScaleSets")
  @visibility("read")
  @path
  name: string;

  @doc("""
  The compute RP resource id of the virtualMachineScaleSet 
  "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}"
  """)
  @visibility("read")
  id: string;

  @doc("The type of the virtualMachineScaleSet")
  @visibility("read")
  type?: string;

  @removed(Versions.v2024_05_01_preview)
  @doc("This represents the Provisioning State of the VMSS in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility("read")
  provisioningState: ProvisioningState;

  @added(Versions.v2024_05_01_preview)
  @doc("This represents the operationStatus of the VMSS in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility("read")
  operationStatus: ProvisioningState;

  @added(Versions.v2024_05_01_preview)
  @doc("Error Message related to the last operation that was performed on the VMSS by Azure Fleet resource.")
  @visibility("read")
  errorMessage?: string;
}

@armResourceOperations
interface VirtualMachineScaleSets {
  listByFleet is ArmResourceListByParent<VirtualMachineScaleSet>;
}
