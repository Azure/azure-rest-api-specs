import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./connection.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_08_01_preview)
@armResourceOperations
interface Connections {
  /**
   * Get a connection.
   */
  get is ArmResourceRead<Connection>;

  /**
   * Create or update a connection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Connection>;

  /**
   * Delete a connection.
   */
  delete is ArmResourceDeleteSync<Connection>;

  /**
   * Get a list of connections.
   */
  listAll is ArmResourceListByParent<
    Connection,
    Response = ConnectionListResult
  >;
}

@@minLength(Connection.name, 1);
@@doc(Connection.name, "Name of the connection.");
@@doc(Connection.properties, "The properties of the connection.");
@@doc(
  Connections.createOrUpdate::parameters.resource,
  "Connection resource to be created or updated."
);
