import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ManagedEnvironment)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get a private endpoint connection for a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentPrivateEndpointConnections_Get")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of a private endpoint connection for a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentPrivateEndpointConnections_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a private endpoint connection for a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentPrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connections for a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentPrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The resource of private endpoint and its properties"
);
