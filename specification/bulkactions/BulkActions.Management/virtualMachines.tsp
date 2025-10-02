import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.BulkActions;

/** An instant Fleet's virtual machine. */
model VirtualMachine {
  /** The name of the virtual machine. */
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The compute RP resource id of the virtual machine. subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}
   */
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  /** Type of the virtual machine */
  @visibility(Lifecycle.Read)
  type?: string;

  /** This represents the operationStatus of the virtual machine in response to the last operation that was performed on it by Azure Fleet resource. */
  @visibility(Lifecycle.Read)
  operationStatus: VMOperationStatus;

  /** Error information when `operationStatus` is `Failed`. */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Virtual Machine operation status values. */
union VMOperationStatus {
  string,

  /** Indicates that the virtual machine is either in the process of being created or is scheduled to be created. */
  Creating: "Creating",

  /** Indicates that the cancellation request was successful because the virtual machine had not been created yet. */
  Canceled: "Canceled",

  /** Indicates that the cancellation request could not be applied because the virtual machine had already been created. */
  CancelFailedStatusUnknown: "CancelFailedStatusUnknown",

  /** Indicates that the virtual machine operation failed. */
  Failed: "Failed",

  /** Indicates that the virtual machine operation completed successfully. */
  Succeeded: "Succeeded",
}

/** The response of a virtual machine list operation. */
model VirtualMachineListResult {
  /** The Virtual Machine items on this page. */
  @pageItems
  value: Array<VirtualMachine>;

  /** The link to the next page of items. */
  @nextLink
  nextLink?: url;
}