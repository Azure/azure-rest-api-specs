import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.ComputeBulkActions;

@doc("An instant Fleet's virtual machine.")
model VirtualMachine {
  @doc("The name of the virtual machine.")
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The compute RP resource id of the virtual machine. subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("Type of the virtual machine")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("This represents the operationStatus of the virtual machine in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility(Lifecycle.Read)
  operationStatus: VMOperationStatus;

  @doc("Error information when `operationStatus` is `Failed`.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

@doc("Virtual Machine operation status values.")
union VMOperationStatus {
  string,

  @doc("Indicates that the virtual machine is either in the process of being created or is scheduled to be created.")
  Creating: "Creating",

  @doc("Indicates that the cancellation request was successful because the virtual machine had not been created yet.")
  Canceled: "Canceled",

  @doc("Indicates that the cancellation request could not be applied because the virtual machine had already been created.")
  CancelFailedStatusUnknown: "CancelFailedStatusUnknown",

  @doc("Indicates that the virtual machine operation failed.")
  Failed: "Failed",

  @doc("Indicates that the virtual machine operation completed successfully.")
  Succeeded: "Succeeded",

  @doc("Indicates that the virtual machine is being deleted.")
  Deleting: "Deleting",

  @doc("Indicates that the virtual machine operation is being cancelled.")
  Cancelling: "Cancelling",
}

@doc("The response of a virtual machine list operation.")
model VirtualMachineListResult {
  @doc("The Virtual Machine items on this page.")
  @pageItems
  value: Array<VirtualMachine>;

  @doc("The link to the next page of items.")
  @nextLink
  nextLink?: url;
}
