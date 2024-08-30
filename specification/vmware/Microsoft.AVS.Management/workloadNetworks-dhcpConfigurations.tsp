namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
// @armResourceOperations
interface WorkloadNetworkDhcpConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDhcp")
  list is ArmResourceListByParent<
    WorkloadNetworkDhcp,
    Response = ArmResponse<ResourceList<WorkloadNetworkDhcp>>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DhcpIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDhcp")
  // get is ArmResourceRead<WorkloadNetworkDhcp>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @doc("Get a {name}", WorkloadNetworkDhcp)
  @get
  get(
    ...BaseParameters<WorkloadNetworkDhcp>,
    ...DhcpIdParameter,
    ...PrivateCloudNameParameter,
  ): ArmResponse<WorkloadNetworkDhcp> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDhcp")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDhcp,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDhcp")
  @parameterVisibility
  update is ArmCustomPatchAsync<WorkloadNetworkDhcp, WorkloadNetworkDhcp>;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDhcp")
  delete is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;
}

@@encodedName(WorkloadNetworkDhcpConfigurations.create::parameters.resource,
  "application/json",
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworkDhcpConfigurations.create::parameters.resource,
  "workloadNetworkDhcp"
);
@@OpenAPI.extension(WorkloadNetworkDhcpConfigurations.create::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);

@@encodedName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "application/json",
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "workloadNetworkDhcp"
);
@@OpenAPI.extension(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);

@@encodedName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "application/json",
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "workloadNetworkDhcp"
);
@@OpenAPI.extension(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);
