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
@doc("Workload Network Dns Services")
interface WorkloadNetworkDnsServices {
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_ListDnsServices")
    list is ArmResourceListByParent<
        WorkloadNetworkDnsService,
        Response = ArmResponse<ResourceList<
            WorkloadNetworkDnsService,
            "{name}sList"
        >>
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_GetDnsService")
    get is ArmResourceRead<WorkloadNetworkDnsService>;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @operationId("WorkloadNetworks_CreateDnsService")
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrUpdateAsync<
        WorkloadNetworkDnsService,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_UpdateDnsService")
    @parameterVisibility
    update is ArmCustomPatchAsync<
        WorkloadNetworkDnsService,
        WorkloadNetworkDnsService
    >;

    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsServiceIdParameter should be last, but it is breaking to correct it."
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_DeleteDnsService")
    // delete is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
    @doc("Delete a {name}", WorkloadNetworkDnsService)
    @delete
    @extension("x-ms-long-running-operation", true)
    @extension(
        "x-ms-long-running-operation-options",
        {
            `final-state-via`: "location",
        }
    )
    delete(
        ...BaseParameters<WorkloadNetworkDnsService>,
        ...DnsServiceIdParameter,
        ...PrivateCloudNameParameter,
    ):
        | ArmDeletedResponse
        | ArmDeleteAcceptedLroResponse
        | ArmDeletedNoContentResponse
        | ErrorResponse;
}

@@encodedName(WorkloadNetworkDnsServices.create::parameters.resource,
    "application/json",
    "workloadNetworkDnsService"
);
@@clientName(WorkloadNetworkDnsServices.create::parameters.resource,
    "workloadNetworkDnsService"
);
@@OpenAPI.extension(WorkloadNetworkDnsServices.create::parameters.resource,
    "x-ms-client-name",
    "workloadNetworkDnsService"
);

@@encodedName(WorkloadNetworkDnsServices.update::parameters.properties,
    "application/json",
    "workloadNetworkDnsService"
);
@@clientName(WorkloadNetworkDnsServices.update::parameters.properties,
    "workloadNetworkDnsService"
);
@@OpenAPI.extension(WorkloadNetworkDnsServices.update::parameters.properties,
    "x-ms-client-name",
    "workloadNetworkDnsService"
);
