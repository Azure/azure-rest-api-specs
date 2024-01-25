import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Workspace data table definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(TableProperties)
model Table extends ProxyResourceBase {
  /**
   * The name of the table.
   */
  @path
  @key("tableName")
  @segment("tables")
  @visibility("read")
  name: string;

  /**
   * Table's properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: TableProperties;
}

@armResourceOperations
interface Tables {
  /**
   * Gets a Log Analytics workspace table.
   */
  get is ArmResourceRead<Table>;

  /**
   * Update or Create a Log Analytics workspace table.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a Log Analytics workspace table.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Table,
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a Log Analytics workspace table.
   */
  delete is ArmResourceDeleteAsync<
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets all the tables for the specified Log Analytics workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tables_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<Table>;

  /**
   * Migrate a Log Analytics table from support of the Data Collector API and Custom Fields features to support of Data Collection Rule-based Custom Logs.
   */
  migrate is ArmResourceActionSync<Table, void, void>;

  /**
   * Cancel a log analytics workspace search results table query run.
   */
  cancelSearch is ArmResourceActionSync<Table, void, void>;
}

@@projectedName(Tables.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Tables.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Tables.createOrUpdate::parameters.resource,
  "The parameters required to update table properties."
);
@@projectedName(Tables.update::parameters.properties, "json", "parameters");
@@extension(Tables.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Tables.update::parameters.properties,
  "The parameters required to update table properties."
);
