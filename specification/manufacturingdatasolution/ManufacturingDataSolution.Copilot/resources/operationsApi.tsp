import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/operations.tsp";

using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

@doc("Operations Service client operations")
interface OperationServiceClient {
  @doc("Get operation progress")
  get is apiOperations.ResourceRead<OperationResponse>;
}
