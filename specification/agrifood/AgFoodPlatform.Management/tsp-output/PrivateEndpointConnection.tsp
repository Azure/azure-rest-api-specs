import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FarmBeats.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AgFoodPlatform;
@doc("The Private Endpoint Connection resource.")
@parentResource(FarmBeats)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get Private endpoint connection object.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Approves or Rejects a Private endpoint connection request.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Delete Private endpoint connection request.")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  @doc("Get list of Private endpoint connections.")
  listByResource is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "Request object."
);
