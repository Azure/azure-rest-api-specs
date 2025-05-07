import "./NodePool.tsp";

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
@doc("Data model of Cluster.")
model Cluster {
  @doc("Gets list of node pools.")
  @visibility(Lifecycle.Read)
  nodePools: NodePool[];

  // Note: As per ARM review, it was required to change region from enum to string.
  @doc("Gets region.")
  @visibility(Lifecycle.Read)
  region: string;

  @doc("Gets user node pool count.")
  @visibility(Lifecycle.Read)
  userNodePoolCount: int32;

  @doc("Gets user node count.")
  @visibility(Lifecycle.Read)
  userNodeCount: int32;

  @doc("Gets system node pool count.")
  @visibility(Lifecycle.Read)
  systemNodePoolCount: int32;

  @doc("Gets system node count.")
  @visibility(Lifecycle.Read)
  systemNodeCount: int32;

  @doc("Gets pod count.")
  @visibility(Lifecycle.Read)
  podCount: int32;

  @doc("Gets monthly cost.")
  @visibility(Lifecycle.Read)
  monthlyCost: float32;
}
