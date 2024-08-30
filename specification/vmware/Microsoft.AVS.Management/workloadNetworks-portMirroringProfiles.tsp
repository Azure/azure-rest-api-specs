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
@doc("Workload Network Port Mirroring Profiles")
interface WorkloadNetworkPortMirroringProfiles {
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_ListPortMirroring")
    list is ArmResourceListByParent<
        WorkloadNetworkPortMirroring,
        Response = ArmResponse<ResourceList<WorkloadNetworkPortMirroring>>
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_GetPortMirroring")
    get is ArmResourceRead<WorkloadNetworkPortMirroring>;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @operationId("WorkloadNetworks_CreatePortMirroring")
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrUpdateAsync<
        WorkloadNetworkPortMirroring,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_UpdatePortMirroring")
    @parameterVisibility
    update is ArmCustomPatchAsync<
        WorkloadNetworkPortMirroring,
        WorkloadNetworkPortMirroring
    >;

    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PortMirroringProfileParameter should be last, but it is breaking to correct it."
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_DeletePortMirroring")
    // delete is ArmResourceDeleteAsync<WorkloadNetworkPortMirroring>;
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
    @doc("Delete a {name}", WorkloadNetworkPortMirroring)
    @delete
    @extension("x-ms-long-running-operation", true)
    @extension(
        "x-ms-long-running-operation-options",
        {
            `final-state-via`: "location",
        }
    )
    delete(
        ...BaseParameters<WorkloadNetworkPortMirroring>,
        ...PortMirroringProfileParameter,
        ...PrivateCloudNameParameter,
    ):
        | ArmDeletedResponse
        | ArmDeleteAcceptedLroResponse
        | ArmDeletedNoContentResponse
        | ErrorResponse;
}

@@encodedName(WorkloadNetworkPortMirroringProfiles.create::parameters.resource,
    "application/json",
    "workloadNetworkPortMirroring"
);
@@clientName(WorkloadNetworkPortMirroringProfiles.create::parameters.resource,
    "workloadNetworkPortMirroring"
);
@@OpenAPI.extension(WorkloadNetworkPortMirroringProfiles.create::parameters.resource,
    "x-ms-client-name",
    "workloadNetworkPortMirroring"
);

@@encodedName(WorkloadNetworkPortMirroringProfiles.update::parameters.properties,
    "application/json",
    "workloadNetworkPortMirroring"
);
@@clientName(WorkloadNetworkPortMirroringProfiles.update::parameters.properties,
    "workloadNetworkPortMirroring"
);
@@OpenAPI.extension(WorkloadNetworkPortMirroringProfiles.update::parameters.properties,
    "x-ms-client-name",
    "workloadNetworkPortMirroring"
);
