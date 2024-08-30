namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkGateways {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListGateways")
  list is ArmResourceListByParent<
    WorkloadNetworkGateway,
    Response = ArmResponse<ResourceList<WorkloadNetworkGateway>>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetGateway")
  get is ArmResourceRead<WorkloadNetworkGateway>;
}
