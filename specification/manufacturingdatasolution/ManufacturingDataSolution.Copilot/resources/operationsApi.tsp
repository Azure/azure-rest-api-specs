import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/operations.tsp";

using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Operation.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.OperationStatus;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("Represents a generic response.")
model GenericOkResponse<T> {
  @statusCode
  statusCode: 200;

  @doc("The response data.")
  @body
  data: T;
}

@doc("Get operation progress")
interface OperationProgress {
  @doc("Get operation progress")
  getOperationResult is apiOperations.ResourceRead<OperationResultQuery>;
}
