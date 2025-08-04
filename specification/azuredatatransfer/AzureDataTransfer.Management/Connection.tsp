import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
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

model ArmConnectionResponse is ArmResponse<Connection>;

@armResourceOperations
interface Connections {
  /**
   * Gets connection resource.
   */
  get is ArmResourceRead<Connection>;

  /**
   * Creates or updates the connection resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Connection>;

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
    ArmConnectionResponse
  >;

  /**
   * Lists all pending remote connections that are linkable to this connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @action("listPendingConnections")
  @operationId("ListPendingConnections_List")
  list is ArmResourceActionSync<
    Connection,
    void,
    ArmResponse<ResourceListCustomResult<PendingConnection>>
  >;

  /**
   * Lists all remote flows that have not yet been linked to local flows
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @action("listPendingFlows")
  @operationId("ListPendingFlows_List")
  listPendingFlowsList is ArmResourceActionSync<
    Connection,
    void,
    ArmResponse<ResourceListCustomResult<PendingFlow>>
  >;
}

@@maxLength(Connection.name, 64);
@@minLength(Connection.name, 3);
@@doc(Connection.name,
  "The name for the connection to perform the operation on."
);
@@doc(Connection.properties, "Properties of connection");
@@doc(Connections.createOrUpdate::parameters.resource, "Connection body");
@@doc(Connections.update::parameters.properties, "Connection body");
@@doc(Connections.link::parameters.body, "Connection body");

@@clientName(Connections.createOrUpdate::parameters.resource, "connection");
@@clientName(Connections.update::parameters.properties, "connection");
@@clientName(Connections.link::parameters.body, "connection");
