import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Models;

@doc("Operation Response Model")
@resource("operation")
model OperationResponse {
  @doc("The operation status.")
  status: OperationStatusValue;

  @doc("The operation id.")
  @key("id")
  @visibility(Lifecycle.Update)
  id: string;

  @doc("The error message.")
  errorMessage: string[];
}
