namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network VM Groups")
interface WorkloadNetworkVmGroups {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListVMGroups")
  list is ArmResourceListByParent<
    WorkloadNetworkVMGroup,
    Response = ArmResponse<ResourceList<WorkloadNetworkVMGroup, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetVMGroup")
  get is ArmResourceRead<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateVMGroup")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkVMGroup,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateVMGroup")
  @parameterVisibility
  update is ArmCustomPatchAsync<WorkloadNetworkVMGroup, WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "VmGroupIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteVMGroup")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkVMGroup>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @doc("Delete a {name}", WorkloadNetworkVMGroup)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
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
  @visibility("read")
  status?: VMGroupStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkVMGroupProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}
