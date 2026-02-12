import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private endpoint connection
 */
@parentResource(ManagedInstance)
model ManagedInstancePrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<ManagedInstancePrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstancePrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedInstancePrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<ManagedInstancePrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstancePrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<ManagedInstancePrivateEndpointConnection> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstancePrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstancePrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoint connections on a server.
   */
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateEndpointConnection>;
}

@@doc(ManagedInstancePrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(ManagedInstancePrivateEndpointConnection.properties,
  "Resource properties."
);
@@doc(ManagedInstancePrivateEndpointConnections.createOrUpdate::parameters.resource,
  ""
);
