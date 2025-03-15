import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/health.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

// alias DefaultServiceTraits = NoRepeatableRequests &
//   NoConditionalRequests &
//   NoClientRequestId;

// alias apiOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

interface HeathServiceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Get the health status of the service.")
  @route("/health")
  @get
  op getHealthStatus(
    @doc("The API version to use for this operation.")
    @query("api-version")
    apiVersion: string,
  ): GenericOkResponse<CopilotHealth>;
}

@doc("Represents a generic response.")
model GenericOkResponse<T> {
  @statusCode
  statusCode: 200;

  @doc("The response data.")
  @body
  data: T;
}
