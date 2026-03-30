import "./ContainerApp.tsp";

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
@doc("Data model of Container App Environment.")
model ContainerAppEnvironment {
  @doc("Gets region.")
  @visibility(Lifecycle.Read)
  region?: string;

  @doc("Gets the workload profile type for the environment.")
  @visibility(Lifecycle.Read)
  workloadProfileType?: ACAWorkloadProfileType;

  @doc("Gets the total vCPU cores allocated to the environment.")
  @visibility(Lifecycle.Read)
  cores?: float64;

  @doc("Gets the total memory in GiB allocated to the environment.")
  @visibility(Lifecycle.Read)
  memoryInGib?: float64;

  @doc("Gets the number of container apps in this environment.")
  @visibility(Lifecycle.Read)
  numberOfContainerApps?: int32;

  @doc("Gets monthly cost.")
  @visibility(Lifecycle.Read)
  monthlyCost?: float64;

  @doc("Gets the created timestamp.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("Gets the updated timestamp.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;

  @doc("Gets list of container apps in this environment.")
  @visibility(Lifecycle.Read)
  containerApps: ContainerApp[];
}
