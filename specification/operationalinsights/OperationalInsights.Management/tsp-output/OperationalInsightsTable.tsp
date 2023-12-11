import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OperationalInsightsWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("Workspace data table definition.")
@parentResource(OperationalInsightsWorkspace)
model OperationalInsightsTable is ProxyResource<TableProperties> {
  @doc("The name of the table.")
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

@armResourceOperations
interface OperationalInsightsTables {
  @doc("Gets a Log Analytics workspace table.")
  get is ArmResourceRead<OperationalInsightsTable>;
  @doc("Update or Create a Log Analytics workspace table.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OperationalInsightsTable>;
  @doc("Update a Log Analytics workspace table.")
  update is ArmResourcePatchAsync<OperationalInsightsTable, TableProperties>;
  @doc("Delete a Log Analytics workspace table.")
  delete is ArmResourceDeleteAsync<OperationalInsightsTable>;
  @doc("Gets all the tables for the specified Log Analytics workspace.")
  listByWorkspace is ArmResourceListByParent<OperationalInsightsTable>;
  @doc("Migrate a Log Analytics table from support of the Data Collector API and Custom Fields features to support of Data Collection Rule-based Custom Logs.")
  migrate is ArmResourceActionSync<OperationalInsightsTable, {}, {}>;
  @doc("Cancel a log analytics workspace search results table query run.")
  cancelSearch is ArmResourceActionSync<OperationalInsightsTable, {}, {}>;
}
