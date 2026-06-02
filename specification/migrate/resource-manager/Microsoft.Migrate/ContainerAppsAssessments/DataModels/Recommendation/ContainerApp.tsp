import "../../Enums/Enums.tsp";

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
@doc("Data model of Container App within an Azure Container Apps environment.")
model ContainerApp {
  @doc("Gets id.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Gets name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Gets the parent environment name.")
  @visibility(Lifecycle.Read)
  environmentName: string;

  @doc("Gets the workload profile type.")
  @visibility(Lifecycle.Read)
  workloadProfileType?: ContainerAppsWorkloadProfileType;

  @doc("Gets the workload profile SKU.")
  @visibility(Lifecycle.Read)
  sku?: ContainerAppsWorkloadProfileSku;

  @doc("Gets vCPU cores allocated to the container app.")
  @visibility(Lifecycle.Read)
  cores?: float64;

  @doc("Gets memory in GiB allocated to the container app.")
  @visibility(Lifecycle.Read)
  memoryInGib?: float64;

  @doc("Gets monthly cost.")
  @visibility(Lifecycle.Read)
  monthlyCost?: float64;
}
