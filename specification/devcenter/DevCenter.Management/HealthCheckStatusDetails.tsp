import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Health Check details.")
@singleton("latest")
@parentResource(NetworkConnection)
model HealthCheckStatusDetails
  is Azure.ResourceManager.ProxyResource<HealthCheckStatusDetailsProperties> {
  ...ResourceNameParameter<
    Resource = HealthCheckStatusDetails,
    KeyName = "healthCheck",
    SegmentName = "healthChecks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HealthCheckStatusDetailsOperationGroup {
  @doc("Gets health check status details.")
  getHealthDetails is ArmResourceRead<HealthCheckStatusDetails>;

  @doc("Lists health check status details.")
  listHealthDetails is ArmResourceListByParent<
    HealthCheckStatusDetails,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = HealthCheckStatusDetailsListResult
  >;
}

@@doc(HealthCheckStatusDetails.name, "");
@@doc(HealthCheckStatusDetails.properties,
  "Health check status details properties."
);
