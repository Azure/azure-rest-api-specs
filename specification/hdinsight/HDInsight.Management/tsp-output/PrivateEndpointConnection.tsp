import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
@doc("The private endpoint connection.")
@parentResource(Cluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specific private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Approve or reject a private endpoint connection manually.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes the specific private endpoint connection.")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists the private endpoint connections for a HDInsight cluster.")
  listByCluster is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection create or update request."
);
