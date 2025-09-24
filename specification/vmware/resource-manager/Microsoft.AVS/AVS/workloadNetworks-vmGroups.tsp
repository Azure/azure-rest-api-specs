namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network VM Groups")
interface WorkloadNetworkVmGroups {
  list is ArmResourceListByParent<
    WorkloadNetworkVMGroup,
    Response = ArmResponse<ResourceList<WorkloadNetworkVMGroup, "{name}sList">>
  >;

  get is ArmResourceRead<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkVMGroup,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<WorkloadNetworkVMGroup, WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Can not change existing response codes."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "VmGroupIdParameter should be last, but it is breaking to correct it."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @doc("Delete a {name}", WorkloadNetworkVMGroup)
  @armResourceDelete(WorkloadNetworkVMGroup)
  delete(
    ...Foundations.BaseParameters<WorkloadNetworkVMGroup>,
    ...VmGroupIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@clientName(WorkloadNetworkVmGroups.create::parameters.resource,
  "workloadNetworkVMGroup"
);

@@clientName(WorkloadNetworkVmGroups.update::parameters.properties,
  "workloadNetworkVMGroup"
);

@doc("VM group status")
union VMGroupStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network VM Group provisioning state")
union WorkloadNetworkVMGroupProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX VM Group")
@parentResource(WorkloadNetwork)
model WorkloadNetworkVMGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  @doc("ID of the VM group.")
  @pattern("^[-\\w\\._]+$")
  @key("vmGroupId")
  @path
  @segment("vmGroups")
  name: string;
}

@doc("Parameter for vmGroupId")
model VmGroupIdParameter {
  @doc("ID of the VM group.")
  @pattern("^[-\\w\\._]+$")
  @path
  vmGroupId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX VM Group Properties")
model WorkloadNetworkVMGroupProperties {
  @doc("Display name of the VM group.")
  displayName?: string;

  @doc("Virtual machine members of this group.")
  members?: string[];

  @doc("VM Group status.")
  @visibility(Lifecycle.Read)
  status?: VMGroupStatusEnum;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkVMGroupProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}
