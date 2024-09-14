namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworks {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_Get")
  get is ArmResourceRead<WorkloadNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_List")
  list is ArmResourceListByParent<
    WorkloadNetwork,
    Response = ArmResponse<ResourceList<WorkloadNetwork>>
  >;
}

@doc("Workload Network")
@parentResource(PrivateCloud)
@singleton
model WorkloadNetwork is ProxyResource<WorkloadNetworkProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("Name of the global reach connection")
  @key("workloadNetworkName")
  @path
  @segment("workloadNetworks")
  name: string;
}

@doc("base Workload Network provisioning state")
union WorkloadNetworkProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("The properties of a workload network")
model WorkloadNetworkProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;
}
