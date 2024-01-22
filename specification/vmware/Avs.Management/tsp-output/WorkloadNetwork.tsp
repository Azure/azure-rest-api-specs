import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
// FIXME: WorkloadNetwork has no properties property
/**
 * Workload Network
 */
@parentResource(PrivateCloud)
model WorkloadNetwork is ProxyResource<{}> {
  /**
   * Name for the workload network in the private cloud
   */
  @path
  @key("workloadNetworkName")
  @segment("workloadNetworks")
  name: WorkloadNetworkName;
}

@armResourceOperations
interface WorkloadNetworks {
  /**
   * Get a private cloud workload network.
   */
  get is ArmResourceRead<WorkloadNetwork>;

  /**
   * List of workload networks in a private cloud.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_List")
  list is ArmResourceListByParent<WorkloadNetwork>;
}
