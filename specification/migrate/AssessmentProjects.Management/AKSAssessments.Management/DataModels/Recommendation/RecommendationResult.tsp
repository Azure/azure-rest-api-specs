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

  @doc("Gets cluster name.")
  @visibility(Lifecycle.Read)
  clusterName: string;
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
