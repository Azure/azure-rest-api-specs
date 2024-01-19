import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateEndpointConnectionDescription has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(ServicesDescription)
model PrivateEndpointConnectionDescription is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnectionDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified private endpoint connection associated with the service.")
  @operationId("PrivateEndpointConnections_Get")
  get is ArmResourceRead<PrivateEndpointConnectionDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the state of the specified private endpoint connection associated with the service.")
  @operationId("PrivateEndpointConnections_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnectionDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a private endpoint connection.")
  @operationId("PrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnectionDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all private endpoint connections for a service.")
  @operationId("PrivateEndpointConnections_ListByService")
  listByService is ArmResourceListByParent<PrivateEndpointConnectionDescription>;
}

@@projectedName(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);
