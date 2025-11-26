import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * PrivateEndpointConnection resource.
 */
@parentResource(PrivateLinkService)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "peConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get the specific private end point connection by specific private link service in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Approve or reject private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateLinkServices_UpdatePrivateEndpointConnection")
  updatePrivateEndpointConnection is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>
  >;

  /**
   * Delete private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PrivateLinkServices_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private end point connections for a specific private link service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_ListPrivateEndpointConnections")
  listPrivateEndpointConnections is ArmResourceListByParent<
    PrivateEndpointConnection,
    Error = CloudError
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private end point connection."
);
@@doc(PrivateEndpointConnection.properties,
  "Properties of the private end point connection."
);
@@doc(PrivateEndpointConnections.updatePrivateEndpointConnection::parameters.resource,
  "Parameters supplied to approve or reject the private end point connection."
);
