import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
// FIXME: WorkloadNetwork has no properties property
@doc("Workload Network")
@parentResource(PrivateCloud)
model WorkloadNetwork is ProxyResource<{}> {
  @doc("Name for the workload network in the private cloud")
  @path
  @key("workloadNetworkName")
  @segment("workloadNetworks")
  name: WorkloadNetworkName;
}

@armResourceOperations
interface WorkloadNetworks {
  @doc("Get a private cloud workload network.")
  get is ArmResourceRead<WorkloadNetwork>;
  @doc("List of workload networks in a private cloud.")
  list is ArmResourceListByParent<WorkloadNetwork>;
}
