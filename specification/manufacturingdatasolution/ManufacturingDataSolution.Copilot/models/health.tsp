import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

namespace MdsSolution.CopilotService.Models;

@doc("Copilot Health Response")
model CopilotHealth {
  @doc("The message.")
  message: string;

  @doc("The operation status.")
  operationStatus: OperationStatusValue;

  @doc("The error message.")
  errorMessage: string[];
}
