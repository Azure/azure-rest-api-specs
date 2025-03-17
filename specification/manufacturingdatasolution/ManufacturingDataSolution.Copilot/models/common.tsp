import "@azure-tools/typespec-azure-core";

using Azure.Core;

namespace MdsSolution.CopilotService.Models;

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

@doc("choice of yes or no. Use this for boolean properties.")
union Choice {
  @doc("Yes")
  yes: "Yes",

  @doc("No")
  no: "No",

  string,
}

@doc("Instruction Status Enums")
union ResourceState {
  @doc("Instruction is active")
  Active: "Active",

  @doc("Instruction is inactive")
  Inactive: "Inactive",

  @doc("Extensible status type")
  string,
}
