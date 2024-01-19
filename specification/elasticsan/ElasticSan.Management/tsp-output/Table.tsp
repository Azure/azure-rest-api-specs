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
@doc("Workspace data table definition.")
@parentResource(Workspace)
model Table is ProxyResource<TableProperties> {
  @doc("The name of the table.")
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

@armResourceOperations
interface Tables {
  @doc("Gets a Log Analytics workspace table.")
  get is ArmResourceRead<Table>;

  @doc("Update or Create a Log Analytics workspace table.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  @doc("Update a Log Analytics workspace table.")
  update is ArmCustomPatchAsync<
    Table,
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete a Log Analytics workspace table.")
  delete is ArmResourceDeleteAsync<
    Table,
    BaseParameters<Table>,
    ArmAsyncOperationHeader
  >;

  @doc("Gets all the tables for the specified Log Analytics workspace.")
  listByWorkspace is ArmResourceListByParent<Table>;

  @doc("Migrate a Log Analytics table from support of the Data Collector API and Custom Fields features to support of Data Collection Rule-based Custom Logs.")
  migrate is ArmResourceActionSync<Table, void, void>;

  @doc("Cancel a log analytics workspace search results table query run.")
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
