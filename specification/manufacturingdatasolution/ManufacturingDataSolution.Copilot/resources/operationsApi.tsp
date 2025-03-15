import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/operations.tsp";

using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

// alias ServiceTraits = NoRepeatableRequests &
//   NoConditionalRequests &
//   NoClientRequestId;

// alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("Get operation progress")
interface OperationApi {
  @doc("Get operation progress")
  get is apiOperations.ResourceRead<OperationResponse>;
}
