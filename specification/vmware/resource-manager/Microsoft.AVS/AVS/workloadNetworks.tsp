namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworks {
  get is ArmResourceRead<WorkloadNetwork>;

  list is ArmResourceListByParent<
    WorkloadNetwork,
    Response = ArmResponse<ResourceList<WorkloadNetwork>>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom route retained for compatibility with API versions before the TypeSpec migration."
@added(Versions.v2026_03_01)
interface LegacyWorkloadNetworks {
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "Custom route retained for compatibility with API versions before the TypeSpec migration."
  #suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "Custom route retained for compatibility with API versions before the TypeSpec migration."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/{workloadNetworkName}")
  @doc("Get a workload network using the legacy parameterized route.")
  @get
  get(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...ApiVersionParameter,
    ...PrivateCloudNameParameter,

    @doc("Name of the workload network.")
    @path
    workloadNetworkName: string,
  ): ArmResponse<WorkloadNetwork> | ErrorResponse;
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
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkProvisioningState;
}
