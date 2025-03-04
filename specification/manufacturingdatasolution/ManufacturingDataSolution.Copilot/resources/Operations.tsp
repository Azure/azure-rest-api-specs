import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/copilotmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.OperationStatus;

alias DefaultServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias apiOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

@doc("Operation Status")
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
  @visibility("read")
  operationStatus: OperationStatusValue;

  @doc("The operation id.")
  @key("operationId")
  @visibility("read")
  operationId: string;

  @doc("The error message.")
  @visibility("read")
  errorMessage: string[];
}

@doc("Get operation progress")
interface OperationProgress {
  @doc("Get operation progress")
  getOperationResult is apiOperations.ResourceRead<OperationResultQuery>;
}
