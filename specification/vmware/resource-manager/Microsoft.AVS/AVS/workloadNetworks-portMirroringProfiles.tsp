namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network Port Mirroring Profiles")
interface WorkloadNetworkPortMirroringProfiles {
  list is ArmResourceListByParent<
    WorkloadNetworkPortMirroring,
    Response = ArmResponse<ResourceList<WorkloadNetworkPortMirroring>>
  >;

  get is ArmResourceRead<WorkloadNetworkPortMirroring>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkPortMirroring,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    WorkloadNetworkPortMirroring,
    WorkloadNetworkPortMirroring
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Can not change existing response codes."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PortMirroringProfileParameter should be last, but it is breaking to correct it."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @doc("Delete a {name}", WorkloadNetworkPortMirroring)
  @armResourceDelete(WorkloadNetworkPortMirroring)
  delete(
    ...Foundations.BaseParameters<WorkloadNetworkPortMirroring>,
    ...PortMirroringProfileParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@clientName(WorkloadNetworkPortMirroringProfiles.create::parameters.resource,
  "workloadNetworkPortMirroring"
);

@@clientName(WorkloadNetworkPortMirroringProfiles.update::parameters.properties,
  "workloadNetworkPortMirroring"
);

@doc("Port Mirroring Direction")
union PortMirroringDirectionEnum {
  string,

  @doc("is ingress")
  INGRESS: "INGRESS",

  @doc("is egress")
  EGRESS: "EGRESS",

  @doc("is bidirectional")
  BIDIRECTIONAL: "BIDIRECTIONAL",
}

@doc("Port Mirroring status")
union PortMirroringStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network Port Mirroring provisioning state")
union WorkloadNetworkPortMirroringProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("NSX Port Mirroring")
@parentResource(WorkloadNetwork)
model WorkloadNetworkPortMirroring
  is ProxyResource<WorkloadNetworkPortMirroringProperties> {
  @doc("ID of the NSX port mirroring profile.")
  @pattern("^[-\\w\\._]+$")
  @key("portMirroringId")
  @path
  @segment("portMirroringProfiles")
  name: string;
}

@doc("Parameter for portMirroringId")
model PortMirroringProfileParameter {
  @doc("ID of the NSX port mirroring profile.")
  @pattern("^[-\\w\\._]+$")
  @path
  portMirroringId: string;
}

@doc("NSX Port Mirroring Properties")
model WorkloadNetworkPortMirroringProperties {
  @doc("Display name of the port mirroring profile.")
  displayName?: string;

  @doc("Direction of port mirroring profile.")
  direction?: PortMirroringDirectionEnum;

  @doc("Source VM Group.")
  source?: string;

  @doc("Destination VM Group.")
  destination?: string;

  @doc("Port Mirroring Status.")
  @visibility(Lifecycle.Read)
  status?: PortMirroringStatusEnum;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkPortMirroringProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}
