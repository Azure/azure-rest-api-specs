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
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ServicesDescription)
model PrivateEndpointConnectionDescription is ProxyResource<{}> {
  /**
   * The name of the private endpoint connection associated with the Azure resource
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnectionDescriptions {
  /**
   * Gets the specified private endpoint connection associated with the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_Get")
  get is ArmResourceRead<PrivateEndpointConnectionDescription>;

  /**
   * Update the state of the specified private endpoint connection associated with the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnectionDescription>;

  /**
   * Deletes a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnectionDescription>;

  /**
   * Lists all private endpoint connections for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
