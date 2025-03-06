import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MdsSolution.CopilotService.Operations.Models;

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

@doc("Operation Response Model")
@resource("operation")
model OperationResultQuery {
  @doc("The operation status.")
  @visibility(Lifecycle.Read)
  status: OperationStatusValue;

  @doc("The operation id.")
  @key("operationId")
  @visibility(Lifecycle.Read)
  operationId: string;

  @doc("The error message.")
  @visibility(Lifecycle.Read)
  errorMessage: string[];
}
