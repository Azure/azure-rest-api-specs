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
@doc("Workload Network DNS Zones")
interface WorkloadNetworkDnsZones {
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_ListDnsZones")
    list is ArmResourceListByParent<
        WorkloadNetworkDnsZone,
        Response = ArmResponse<ResourceList<
            WorkloadNetworkDnsZone,
            "{name}sList"
        >>
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_GetDnsZone")
    get is ArmResourceRead<WorkloadNetworkDnsZone>;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @operationId("WorkloadNetworks_CreateDnsZone")
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrUpdateAsync<
        WorkloadNetworkDnsZone,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_UpdateDnsZone")
    @parameterVisibility
    update is ArmCustomPatchAsync<
        WorkloadNetworkDnsZone,
        WorkloadNetworkDnsZone
    >;

    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsZoneIdParameter should be last, but it is breaking to correct it."
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_DeleteDnsZone")
    // delete is ArmResourceDeleteAsync<WorkloadNetworkDnsZone>;
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
    @doc("Delete a {name}", WorkloadNetworkDnsZone)
    @delete
    @extension("x-ms-long-running-operation", true)
    @extension(
        "x-ms-long-running-operation-options",
        {
            `final-state-via`: "location",
        }
    )
    delete(
        ...BaseParameters<WorkloadNetworkDnsZone>,
        ...DnsZoneIdParameter,
        ...PrivateCloudNameParameter,
    ):
        | ArmDeletedResponse
        | ArmDeleteAcceptedLroResponse
        | ArmDeletedNoContentResponse
        | ErrorResponse;
}

@@encodedName(WorkloadNetworkDnsZones.create::parameters.resource,
    "application/json",
    "workloadNetworkDnsZone"
);
@@clientName(WorkloadNetworkDnsZones.create::parameters.resource,
    "workloadNetworkDnsZone"
);
@@OpenAPI.extension(WorkloadNetworkDnsZones.create::parameters.resource,
    "x-ms-client-name",
    "workloadNetworkDnsZone"
);

@@encodedName(WorkloadNetworkDnsZones.update::parameters.properties,
    "application/json",
    "workloadNetworkDnsZone"
);
@@clientName(WorkloadNetworkDnsZones.update::parameters.properties,
    "workloadNetworkDnsZone"
);
@@OpenAPI.extension(WorkloadNetworkDnsZones.update::parameters.properties,
    "x-ms-client-name",
    "workloadNetworkDnsZone"
);
