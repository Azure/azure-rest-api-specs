import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The KPI resource format.")
@parentResource(Hub)
model KpiResourceFormat is ProxyResource<KpiDefinition> {
  @doc("The name of the KPI.")
  @path
  @key("kpiName")
  @segment("kpi")
  name: string;
}

@armResourceOperations
interface KpiResourceFormats {
  @doc("Gets a KPI in the hub.")
  get is ArmResourceRead<KpiResourceFormat>;
  @doc("Creates a KPI or updates an existing KPI in the hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KpiResourceFormat>;
  @doc("Deletes a KPI in the hub.")
  delete is ArmResourceDeleteAsync<KpiResourceFormat>;
  @doc("Gets all the KPIs in the specified hub.")
  listByHub is ArmResourceListByParent<KpiResourceFormat>;
  @doc("Reprocesses the Kpi values of the specified KPI.")
  reprocess is ArmResourceActionNoContentSync<KpiResourceFormat, {}>;
}
