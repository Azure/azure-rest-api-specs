namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
interface WorkloadNetworkPublicIps {
  list is ArmResourceListByParent<
    WorkloadNetworkPublicIP,
    Response = ArmResponse<ResourceList<WorkloadNetworkPublicIP, "{name}sList">>
  >;

  get is ArmResourceRead<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkPublicIP,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Can not change existing response codes."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PublicIPIdParameter should be last, but it is breaking to correct it."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @doc("Delete a {name}", WorkloadNetworkPublicIP)
  @armResourceDelete(WorkloadNetworkPublicIP)
  delete(
    ...Foundations.BaseParameters<WorkloadNetworkPublicIP>,
    ...PublicIPIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@clientName(WorkloadNetworkPublicIps.create::parameters.resource,
  "workloadNetworkPublicIP"
);

@doc("Workload Network Public IP provisioning state")
union WorkloadNetworkPublicIPProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX Public IP Block")
@parentResource(WorkloadNetwork)
model WorkloadNetworkPublicIP
  is ProxyResource<WorkloadNetworkPublicIPProperties> {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @key("publicIPId")
  @path
  @segment("publicIPs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("Parameter for publicIPId")
model PublicIPIdParameter {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @path
  publicIPId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX Public IP Block Properties")
model WorkloadNetworkPublicIPProperties {
  @doc("Display name of the Public IP Block.")
  displayName?: string;

  @doc("Number of Public IPs requested.")
  numberOfPublicIPs?: int64;

  @doc("CIDR Block of the Public IP Block.")
  @visibility(Lifecycle.Read)
  publicIPBlock?: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkPublicIPProvisioningState;
}
