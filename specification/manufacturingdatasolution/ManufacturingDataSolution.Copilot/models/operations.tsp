import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using TypeSpec.Rest;
using MdsSolution.CopilotService.Common.Models;

namespace MdsSolution.CopilotService.Operation.Models;

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
