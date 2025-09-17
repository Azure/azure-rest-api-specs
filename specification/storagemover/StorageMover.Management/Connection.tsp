import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";
import "@typespec/versioning";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;

/** The Connection resource. */
@added(Versions.v2025_08_01)
@parentResource(StorageMover)
model Connection
  is Azure.ResourceManager.ProxyResource<ConnectionProperties, false> {
  ...ResourceNameParameter<
    Resource = Connection,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9_-]{0,20}"
  >;
}

@added(Versions.v2025_08_01)
@armResourceOperations
interface Connections {
  /**
   * Creates or updates a Connection resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Connection,
    Response = ArmResourceUpdatedResponse<Connection>
  >;

  /**
   * Gets a Connection resource.
   */
  get is ArmResourceRead<Connection>;

  /**
   * Lists all Connections in a Storage Mover.
   */
  list is ArmResourceListByParent<
    Connection,
    Response = ArmResponse<ConnectionList>
  >;

  /**
   * Deletes a Connection resource.
   * Returns 409 if there are active jobs using this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Connection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@doc(Connection.name, "The name of the Connection resource.");
@@doc(Connection.properties, "Connection properties.");
@@doc(Connections.createOrUpdate::parameters.resource, "");
