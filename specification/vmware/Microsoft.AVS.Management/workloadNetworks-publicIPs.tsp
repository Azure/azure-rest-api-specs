namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
interface WorkloadNetworkPublicIps {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListPublicIPs")
  list is ArmResourceListByParent<
    WorkloadNetworkPublicIP,
    Response = ArmResponse<ResourceList<WorkloadNetworkPublicIP, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetPublicIP")
  get is ArmResourceRead<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreatePublicIP")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkPublicIP,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PublicIPIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeletePublicIP")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkPublicIP>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @doc("Delete a {name}", WorkloadNetworkPublicIP)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  delete(
    ...BaseParameters<WorkloadNetworkPublicIP>,
    ...PublicIPIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@encodedName(WorkloadNetworkPublicIps.create::parameters.resource,
  "application/json",
  "workloadNetworkPublicIP"
);
@@clientName(WorkloadNetworkPublicIps.create::parameters.resource,
  "workloadNetworkPublicIP"
);
@@OpenAPI.extension(WorkloadNetworkPublicIps.create::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkPublicIP"
);
