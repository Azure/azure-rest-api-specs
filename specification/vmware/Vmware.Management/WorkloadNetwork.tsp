import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * Workload Network
 */
@singleton("default")
@parentResource(PrivateCloud)
model WorkloadNetwork
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetwork,
    KeyName = "workloadNetwork",
    SegmentName = "workloadNetworks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkloadNetworks {
  /**
   * Get a WorkloadNetwork
   */
  get is ArmResourceRead<WorkloadNetwork>;

  /**
   * List WorkloadNetwork resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    WorkloadNetwork,
    Response = ArmResponse<WorkloadNetworkList>
  >;
}

@@doc(WorkloadNetwork.name, "");
@@doc(WorkloadNetwork.properties,
  "The resource-specific properties for this resource."
);
