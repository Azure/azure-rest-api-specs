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
@doc("The top level data export resource container.")
@parentResource(OperationalInsightsWorkspace)
model OperationalInsightsDataExport is ProxyResource<DataExportProperties> {
  @doc("The data export rule name.")
  @path
  @key("dataExportName")
  @segment("dataExports")
  name: string;
}

@armResourceOperations
interface OperationalInsightsDataExports {
  @doc("Gets a data export instance.")
  get is ArmResourceRead<OperationalInsightsDataExport>;
  @doc("Create or update a data export.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<OperationalInsightsDataExport>;
  @doc("Deletes the specified data export in a given workspace..")
  delete is ArmResourceDeleteSync<OperationalInsightsDataExport>;
  @doc("Lists the data export instances within a workspace.")
  listByWorkspace is ArmResourceListByParent<OperationalInsightsDataExport>;
}
