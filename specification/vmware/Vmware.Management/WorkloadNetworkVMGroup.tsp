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
 * NSX VM Group
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkVMGroup
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkVMGroupProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkVMGroup,
    KeyName = "vmGroupId",
    SegmentName = "vmGroups",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkVMGroups {
  /**
   * Get a WorkloadNetworkVMGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetVMGroup")
  getVMGroup is ArmResourceRead<WorkloadNetworkVMGroup>;

  /**
   * Create a WorkloadNetworkVMGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreateVMGroup")
  createVMGroup is ArmResourceCreateOrReplaceAsync<WorkloadNetworkVMGroup>;

  /**
   * Update a WorkloadNetworkVMGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdateVMGroup")
  updateVMGroup is ArmCustomPatchAsync<
    WorkloadNetworkVMGroup,
    PatchModel = WorkloadNetworkVMGroup
  >;

  /**
   * Delete a WorkloadNetworkVMGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteVMGroup")
  deleteVMGroup is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkVMGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkVMGroup resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListVMGroups")
  listVMGroups is ArmResourceListByParent<
    WorkloadNetworkVMGroup,
    Response = ArmResponse<WorkloadNetworkVMGroupsList>
  >;
}

@@doc(WorkloadNetworkVMGroup.name, "ID of the VM group.");
@@doc(WorkloadNetworkVMGroup.properties,
  "The resource-specific properties for this resource."
);
