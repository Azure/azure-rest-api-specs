import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/health.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Health.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.HealthService;

alias DefaultServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is not a versioned operation"
@doc("Get the health status of the service.")
@route("/health")
@get
op getHealthStatus(): GenericOkResponse<CopilotHealth>;

@doc("Represents a generic response.")
model GenericOkResponse<T> {
  @statusCode
  statusCode: 200;

  @doc("The response data.")
  @body
  data: T;
}
