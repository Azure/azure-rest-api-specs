import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AzureFleet;

@doc("An AzureFleet's virtualMachineScaleSet")
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

  @doc("Type of the virtualMachineScaleSet")
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
  @doc("Error Information when `operationStatus` is `Failed`")
  @visibility("read")
  error?: ApiError;
}

@doc("The response of a VirtualMachineScaleSet list operation.")
@pagedResult
model VirtualMachineScaleSetListResult {
  @doc("The VirtualMachineScaleSet items on this page")
  @items
  value: Array<VirtualMachineScaleSet>;

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}
