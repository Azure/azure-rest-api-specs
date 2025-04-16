import "../../Enums/Enums.tsp";

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
@doc("Data model of Node Pool.")
model NodePool {
  @doc("Gets id.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Gets name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Gets cluster name.")
  @visibility(Lifecycle.Read)
  clusterName: string;

  @doc("Gets mode.")
  @visibility(Lifecycle.Read)
  mode: NodePoolMode;

  @doc("Gets os type.")
  @visibility(Lifecycle.Read)
  osType: OSType;

  @doc("Gets arm sku name.")
  @visibility(Lifecycle.Read)
  armSkuName: string;

  @doc("Gets node count.")
  @visibility(Lifecycle.Read)
  nodeCount: int32;

  @doc("Gets pod count.")
  @visibility(Lifecycle.Read)
  podCount: int32;

  @doc("Gets monthly cost.")
  @visibility(Lifecycle.Read)
  monthlyCost: float32;

  @doc("Gets pod approximate monthly cost.")
  @visibility(Lifecycle.Read)
  podApproxMonthlyCost: float32;
}
