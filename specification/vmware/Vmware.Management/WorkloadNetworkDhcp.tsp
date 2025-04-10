import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * NSX DHCP
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkDhcp
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkDhcpEntity> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkDhcp,
    KeyName = "dhcpId",
    SegmentName = "dhcpConfigurations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkDhcps {
  /**
   * Get a WorkloadNetworkDhcp
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetDhcp")
  getDhcp is ArmResourceRead<WorkloadNetworkDhcp>;

  /**
   * Create a WorkloadNetworkDhcp
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreateDhcp")
  createDhcp is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDhcp>;

  /**
   * Update a WorkloadNetworkDhcp
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdateDhcp")
  updateDhcp is ArmCustomPatchAsync<
    WorkloadNetworkDhcp,
    PatchModel = WorkloadNetworkDhcp
  >;

  /**
   * Delete a WorkloadNetworkDhcp
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDhcp")
  deleteDhcp is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkDhcp,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkDhcp resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListDhcp")
  listDhcp is ArmResourceListByParent<
    WorkloadNetworkDhcp,
    Response = ArmResponse<WorkloadNetworkDhcpList>
  >;
}

@@doc(WorkloadNetworkDhcp.name, "The ID of the DHCP configuration");
@@doc(WorkloadNetworkDhcp.properties,
  "The resource-specific properties for this resource."
);
