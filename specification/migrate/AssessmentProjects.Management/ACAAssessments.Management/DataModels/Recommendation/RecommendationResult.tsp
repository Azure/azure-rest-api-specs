import "../../Enums/Enums.tsp";

namespace Microsoft.Migrate;

@doc("Data model of Recommendation Result.")
model RecommendationResult {
  @doc("Gets cores and memory request.")
  @visibility(Lifecycle.Read)
  request: ComputeResource;

  @doc("Gets cores and memory limit.")
  @visibility(Lifecycle.Read)
  limit: ComputeResource;

  @doc("Gets environment name.")
  @visibility(Lifecycle.Read)
  environmentName: string;

  @doc("Gets the workload profile type.")
  @visibility(Lifecycle.Read)
  workloadProfileType: ContainerAppsWorkloadProfileType;

  @doc("Gets the minimum number of replicas.")
  @visibility(Lifecycle.Read)
  minReplicas: int32;

  @doc("Gets the maximum number of replicas.")
  @visibility(Lifecycle.Read)
  maxReplicas: int32;
}

@doc("Data model of Cores and Memory Compute Resource.")
model ComputeResource {
  @doc("Gets cores.")
  @visibility(Lifecycle.Read)
  cores: float32;

  @doc("Gets memory.")
  @visibility(Lifecycle.Read)
  memory: float32;
}
