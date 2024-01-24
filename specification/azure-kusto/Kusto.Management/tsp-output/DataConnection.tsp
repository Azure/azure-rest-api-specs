import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
// FIXME: DataConnection has no properties property
/**
 * Class representing an data connection.
 */
@parentResource(Database)
model DataConnection is ProxyResource<{}> {
  /**
   * The name of the data connection.
   */
  @pattern("^.*$")
  @path
  @key("dataConnectionName")
  @segment("dataConnections")
  name: string;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: DataConnectionKind;
}

@armResourceOperations
interface DataConnections {
  /**
   * Returns a data connection.
   */
  get is ArmResourceRead<DataConnection>;

  /**
   * Creates or updates a data connection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataConnection>;

  /**
   * Updates a data connection.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<DataConnection, DataConnection>;

  /**
   * Deletes the data connection with the given name.
   */
  delete is ArmResourceDeleteAsync<DataConnection>;

  /**
   * Returns the list of data connections of the given Kusto database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataConnections_ListByDatabase")
  listByDatabase is ArmResourceListByParent<DataConnection>;
}

@@projectedName(DataConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataConnections.createOrUpdate::parameters.resource,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@projectedName(DataConnections.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataConnections.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataConnections.update::parameters.properties,
  "The data connection parameters supplied to the Update operation."
);
