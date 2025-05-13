import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./connection_models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;
/**
 * The connection resource definition.
 */
model Connection
  is Azure.ResourceManager.TrackedResource<ConnectionProperties> {
  ...ResourceNameParameter<
    Resource = Connection,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Connections {
  /**
   * Gets connection resource.
   */
  get is ArmResourceRead<Connection>;

  /**
   * Creates or updates the connection resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Connection>;

  /**
   * Updates the connection resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Prior OpenAPI2 Json spec provides the resource back in the LRO response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Connection,
    PatchModel = ConnectionsPatch,
    Response = ArmResponse<Connection> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Connection;
    })
  >;

  /**
   * Deletes the connection resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Connection>;

  /**
   * Gets connections in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Connection>;

  /**
   * Gets connections in a subscription.
   */
  listBySubscription is ArmListBySubscription<Connection>;

  /**
   * Links the connection to its pending connection.
   */
  link is ArmResourceActionAsync<
    Connection,
    ResourceBody,
    ArmResponse<Connection>
  >;

  /**
   * Lists all pending connections for a connection.
   */
  @action("listPendingConnections")
  list is ArmResourceActionSync<
    Connection,
    void,
    ArmResponse<ResourceListResult<PendingConnection>>
  >;

  /**
   * Lists all pending flows for a connection.
   */
  @action("listPendingFlows")
  listPendingFlowsList is ArmResourceActionSync<
    Connection,
    void,
    ArmResponse<ResourceListResult<PendingFlow>>
  >;
}

@@maxLength(Connection.name, 64);
@@minLength(Connection.name, 3);
@@doc(Connection.name, "The name for the connection that is to be requested.");
@@doc(Connection.properties, "Properties of connection");
@@doc(Connections.createOrUpdate::parameters.resource, "Connection body");
@@doc(Connections.update::parameters.properties, "Connection body");
@@doc(Connections.link::parameters.body, "Connection body");
