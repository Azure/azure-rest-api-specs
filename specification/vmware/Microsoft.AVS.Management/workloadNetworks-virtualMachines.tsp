namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_ListVirtualMachines")
    list is ArmResourceListByParent<
        WorkloadNetworkVirtualMachine,
        Response = ArmResponse<ResourceList<
            WorkloadNetworkVirtualMachine,
            "{name}sList"
        >>
    >;

    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("WorkloadNetworks_GetVirtualMachine")
    get is ArmResourceRead<WorkloadNetworkVirtualMachine>;
}
