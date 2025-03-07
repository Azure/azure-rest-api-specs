import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using MdsSolution.CopilotService.Common.Models;

namespace MdsSolution.CopilotService.Health.Models;

@doc("Copilot Health Response")
model CopilotHealth {
  @doc("The message.")
  message: string;

  @doc("The operation status.")
  operationStatus: OperationStatusValue;

  @doc("copilot setup info")
  copilotSetupInfo: CopilotSetupInfo;

  @doc("The error message.")
  errorMessage: string[];
}

@doc("Copilot Setup Info")
model CopilotSetupInfo {
  @doc("create ADX function job status")
  createAzureDataExplorerFunctionJobStatus: OperationStatusValue;

  @doc("register in built instruction job status")
  registerInBuiltInstructionJobStatus: OperationStatusValue;

  @doc("register in built example query job status")
  registerInbuiltExampleQueryJobStatus: OperationStatusValue;

  @doc("register in built example query job status")
  registerInBuiltAliasJobStatus: OperationStatusValue;

  @doc("register in built example query job status")
  registerAssistantViewJobStatus: OperationStatusValue;
}
