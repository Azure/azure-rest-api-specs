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
@doc("Remote Private Endpoint Connection ARM resource.")
@parentResource(AppServiceEnvironmentResource)
model RemotePrivateEndpointConnectionARMResource
  is ProxyResource<RemotePrivateEndpointConnectionARMResourceProperties> {
  @doc("Name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a private endpoint connection")
  @operationId("AppServiceEnvironments_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<RemotePrivateEndpointConnectionARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Approves or rejects a private endpoint connection")
  @operationId("AppServiceEnvironments_ApproveOrRejectPrivateEndpointConnection")
  approveOrRejectPrivateEndpointConnection is ArmResourceCreateOrUpdateAsync<RemotePrivateEndpointConnectionARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a private endpoint connection")
  @operationId("AppServiceEnvironments_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<RemotePrivateEndpointConnectionARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the list of private endpoints associated with a hosting environment")
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
