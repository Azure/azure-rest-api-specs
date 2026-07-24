import "@azure-tools/typespec-azure-core";

using Azure.Core;

namespace MdsSolution.CopilotService.Common.Models;

@doc("Operation Status")
@lroStatus
union OperationStatusValue {
  @doc("The operation is Accepted.")
  Accepted: "Accepted",

  @doc("The operation is InProgress.")
  InProgress: "InProgress",

  @doc("The operation is in a transient failure state.")
  TransientFailure: "TransientFailure",

  @doc("The operation is Succeeded.")
  Succeeded: "Succeeded",

  @doc("The operation is Failed.")
  Failed: "Failed",

  @doc("The operation is Canceling.")
  Deleting: "Deleting",

  @doc("The operation is Canceled.")
  Canceled: "Canceled",

  @doc("The operation is in a permanent failure state.")
  Unknown: "Unknown",

  @doc("The operation is Skipped.")
  Skipped: "Skipped",

  string,
}
