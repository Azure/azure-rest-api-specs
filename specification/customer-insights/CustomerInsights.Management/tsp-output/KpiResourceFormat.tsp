import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a KPI in the hub.")
  @operationId("Kpi_Get")
  get is ArmResourceRead<KpiResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a KPI or updates an existing KPI in the hub.")
  @operationId("Kpi_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KpiResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a KPI in the hub.")
  @operationId("Kpi_Delete")
  delete is ArmResourceDeleteAsync<KpiResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the KPIs in the specified hub.")
  @operationId("Kpi_ListByHub")
  listByHub is ArmResourceListByParent<KpiResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reprocesses the Kpi values of the specified KPI.")
  @operationId("Kpi_Reprocess")
  reprocess is ArmResourceActionNoContentSync<KpiResourceFormat, void>;
}

@@projectedName(KpiResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(KpiResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(KpiResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update KPI operation."
);
