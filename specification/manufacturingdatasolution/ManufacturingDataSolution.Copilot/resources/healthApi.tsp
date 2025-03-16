import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/health.tsp";

using Azure.Core.Foundations;
using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

@doc("Health client operations")
interface HeathServiceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @doc("Get the health status of the service.")
  @route("/health")
  @get
  getServiceHealth(
    @doc("The API version to use for this operation.")
    @query("api-version")
    apiVersion: string,
  ): CopilotHealth | ErrorResponse;
}
