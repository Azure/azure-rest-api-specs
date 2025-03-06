import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/operations.tsp";

using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Operations.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.OperationStatus;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("Get operation progress")
interface OperationProgress {
  @doc("Get operation progress")
  getOperationResult is apiOperations.ResourceRead<OperationResultQuery>;
}
