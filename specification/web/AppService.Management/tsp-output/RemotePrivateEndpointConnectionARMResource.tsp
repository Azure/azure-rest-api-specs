import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Remote Private Endpoint Connection ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AppServiceEnvironmentResource)
@includeInapplicableMetadataInPayload(false)
model RemotePrivateEndpointConnectionARMResource extends ProxyOnlyResource {
  /**
   * Name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * RemotePrivateEndpointConnectionARMResource resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: RemotePrivateEndpointConnectionARMResourceProperties;
}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResources {
  /**
   * Description for Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ApproveOrRejectPrivateEndpointConnection")
  approveOrRejectPrivateEndpointConnection is ArmResourceCreateOrReplaceAsync<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Gets the list of private endpoints associated with a hosting environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetPrivateEndpointConnectionList")
  getPrivateEndpointConnectionList is ArmResourceListByParent<RemotePrivateEndpointConnectionARMResource>;
}

@@projectedName(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "json",
  "privateEndpointWrapper"
);
@@extension(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "x-ms-client-name",
  "privateEndpointWrapper"
);
@@doc(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  ""
);
