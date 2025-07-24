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

@added(Versions.v2025_07_01_preview)
@doc("An instant Fleet's virtual machine.")
model VirtualMachine {
  @doc("The name of the virtual machine.")
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  @doc("""
    The compute RP resource id of the virtual machine.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("This represents the operationStatus of the virtual machine in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility(Lifecycle.Read)
  operationStatus: VMOperationStatus;

  @doc("Error Information when `operationStatus` is `Failed`")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

@added(Versions.v2025_07_01_preview)
@doc("Virtual Machine operation status values.")
union VMOperationStatus {
  string,
 
  @doc("""
  Indicates that the virtual machine is either in the process of being created or is scheduled to be created.
  """)
  Creating: "Creating",

  @doc("""
  Indicates that the cancellation request was successful because the virtual machine had not been created yet.
  """)
  Canceled: "Canceled",

  @doc("""
  Indicates that the cancellation request could not be applied because the virtual machine had already been created.
  """)
  CancelFailedStatusUnknown: "CancelFailedStatusUnknown",

  @doc("""
  Indicates that the virtual machine operation failed.
  """)
  Failed: "Failed",

  @doc("""
  Indicates that the virtual machine operation completed successfully.
  """)
  Succeeded: "Succeeded",
}

@added(Versions.v2025_07_01_preview)
@doc("The response of a virtual machine list operation.")
@pagedResult
model VirtualMachineListResult {
  @doc("The Virtual Machine items on this page")
  @items
  value: Array<VirtualMachine>;

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}
